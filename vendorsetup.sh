#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 The TWRP Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# For building with minimal manifest
export ALLOW_MISSING_DEPENDENCIES=true

DEVICE_DIR="$(gettop)/device/samsung/exynos2100"
ROOT_DIR="$(gettop)"

apply_recovery_patch() {
    local PATCH_FILE="$DEVICE_DIR/patches/0001-recovery-add-fallback-path-support-for-un-decrypted-.patch"
    local TARGET_DIR="$ROOT_DIR/bootable/recovery"

    if [ ! -f "$PATCH_FILE" ]; then
        echo "[RECOVERY PATCH] Missing patch file: $PATCH_FILE"
        return 1
    fi

    if git -C "$TARGET_DIR" apply --check "$PATCH_FILE" >/dev/null 2>&1; then
        echo "[RECOVERY PATCH] Applying patch..."
        git -C "$TARGET_DIR" apply "$PATCH_FILE"
        echo "[RECOVERY PATCH] Patch completed successfully"
    else
        echo "[RECOVERY PATCH] Patch already applied"
    fi
}

apply_recovery_patch