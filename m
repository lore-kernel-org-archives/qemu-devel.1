Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17E3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:55:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B290220781
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B290220781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6791-0006TV-0q
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 02:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673W-0006WY-8K
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:43 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:48395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673O-0004ca-9s
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:41 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mleo0-1kWt592TY2-00inWi; Thu, 13 Aug 2020 08:49:29 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 08/14] linux-user: Add support for btrfs ioctls used to
 manipulate with devices
Date: Thu, 13 Aug 2020 08:49:17 +0200
Message-Id: <20200813064923.263565-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200813064923.263565-1-laurent@vivier.eu>
References: <20200813064923.263565-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hqTxDPynkogFLZ5+5CvGqKbiyz4EjOYjOCaoXUzNP+YP8MnXBIj
 J5yj8gG5OgcSA7p5P3uIuuymbse2uX0W8MNiiDF8vJVKIKAMOA+kOp/SkMNxMRFWNH17ldE
 etEmNWYx7Nxzqd/xFqw6t11Y7p7RoWF8IBVQ/6qNakLY5T8+UXoiVtey9ZOKQaR8LOoH6Dt
 yBBizren36n5ARpfZNZGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vyBkMHAxbtc=:pPWEZCHYOl9SmEwk4fNToP
 N5/zKy19Z2SkTnNbLmSqQ5sUYBoX/1g+AxSjPULFCMJtEm6CugZyxKnEjK15P4AqZrJN0rXRN
 6Z9ZdZoR2oyLJWYzJWyttmPLOxdHpwnTMfYvR1D7xMT2d8hKzyUK5ZC22p36rU6gXLIqNCT1X
 rMwo1GWgq+mk3pAzbVVyqDwDvTkUJOV5dy0N6Qw3dtb/KhZqwPVDt3J2eYo3rQIDA+DFu3+Qb
 b+Q7LVuKloyu/VfgyziShU09D3M2nFdsAlPBEUpCWRY1lHeb5AXbyDytAsEZr5NFQxSC+N4ps
 NZ8YExCicG+MXQAAkyDFHKgoElsu07zhUYoVSs6tjpv9QqdvRQBBWU7Iqq85lSDciuzj0577n
 mLyDJdItOtyphk6/1rrXmLAZAsE6TTrOEUezqVQ602gry3Q2BIXY4ZUcEhwP1b/1wCFAzqr+G
 gg4cAtk8bFid9plav6t8FsKIFLR724xd4L8NxgV7PsO4H7wDi7/ybt2xHVmoulAu+tOu6I+sY
 WJ4GGVaAPyHwF6ZffTlQsc7NKRtc0oUqxOwkVxxt1Vsbmsc6QETum12cmvyRrt04vuREO3M4Y
 9cwE6yr5aIEEmi6UtSoHvQRzjS70i7iKlbNq+RmJVF9MVRJLP7Tj5jYU39URnN8i/YHGcqJC9
 w4z4yN464YxXCWQCSKsdPSg00u6xuMlyE+HYaCMDSEi97QMsHXs1rZVGqAQLiWCR5HgvRnpR0
 F7Yu+NUfN+eO4XZoMsHyR6XTHS2DtSJlE76qb3Cat1AelO7cnLu63I0jcavKL1lZCe7VC/wE8
 a7BfHyYfCANXP6NXpFYpkogZAIl2xNCYxPpyAEiIEWl/K39agcimrpyrxvOY89ahzQ5eVuY
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:49:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This patch implements functionality for following ioctls:

BTRFS_IOC_SCAN_DEV - Scanning device for a btrfs filesystem

    Scan a device for a btrfs filesystem. The device that is to
    be scanned is passed in the ioctl's third argument which
    represents a pointer to a 'struct ioc_vol_args' (which was
    mentioned in a previous patch). Before calling this ioctl,
    the name field of this structure should be filled with the
    aproppriate name value which represents a path for the device.
    If the device contains a btrfs filesystem, the ioctl returns 0,
    otherwise a negative value is returned.

BTRFS_IOC_ADD_DEV - Adding a device to a btrfs filesystem

    Add a device to a btrfs filesystem. The device that is to be
    added is passed in the ioctl's third argument which represents
    a pointer to a 'struct ioc_vol_args' (which was mentioned in
    a previous patch). Before calling this ioctl, the name field of
    this structure should be filled with the aproppriate name value
    which represents a path for the device.

BTRFS_IOC_RM_DEV - Removing a device from a btrfs filesystem

    Remove a device from a btrfs filesystem. The device that is to be
    removed is passed in the ioctl's third argument which represents
    a pointer to a 'struct ioc_vol_args' (which was mentioned in
    a previous patch). Before calling this ioctl, the name field of
    this structure should be filled with the aproppriate name value
    which represents a path for the device.

BTRFS_IOC_DEV_INFO - Getting information about a device

    Obtain information for device in a btrfs filesystem. The information
    is gathered in the ioctl's third argument which represents a pointer
    to a following structure type:

    struct btrfs_ioctl_dev_info_args {
	__u64 devid;				/* in/out */
	__u8 uuid[BTRFS_UUID_SIZE];		/* in/out */
	__u64 bytes_used;			/* out */
	__u64 total_bytes;			/* out */
	__u64 unused[379];			/* pad to 4k */
	__u8 path[BTRFS_DEVICE_PATH_NAME_MAX];	/* out */
    };

    Before calling this ioctl, field "devid" should be set with the id value
    for the device for which the information is to be obtained. If this field
    is not aproppriately set, the errno ENODEV ("No such device") is returned.

BTRFS_IOC_GET_DEV_STATS - Getting device statistics

    Obtain stats informatin for device in a btrfs filesystem. The information
    is gathered in the ioctl's third argument which represents a pointer to
    a following structure type:

    struct btrfs_ioctl_get_dev_stats {
	__u64 devid;				/* in */
	__u64 nr_items;				/* in/out */
	__u64 flags;				/* in/out */

	/* out values: */
	__u64 values[BTRFS_DEV_STAT_VALUES_MAX];

	/*
	 * This pads the struct to 1032 bytes. It was originally meant to pad to
	 * 1024 bytes, but when adding the flags field, the padding calculation
	 * was not adjusted.
	 */
	__u64 unused[128 - 2 - BTRFS_DEV_STAT_VALUES_MAX];
    };

    Before calling this ioctl, field "devid" should be set with the id value
    for the device for which the information is to be obtained. If this field
    is not aproppriately set, the errno ENODEV ("No such device") is returned.

BTRFS_IOC_FORGET_DEV - Remove unmounted devices

    Search and remove all stale devices (devices which are not mounted).
    The third ioctl argument is a pointer to a 'struct btrfs_ioctl_vol_args'.
    The ioctl call will release all unmounted devices which match the path
    which is specified in the "name" field of the structure. If an empty
    path ("") is specified, all unmounted devices will be released.

Implementation notes:

    Ioctls BTRFS_IOC_DEV_INFO and BTRFS_IOC_GET_DEV_STATS use types
    'struct btrfs_ioctl_dev_info_args' and ' struct btrfs_ioctl_get_dev_stats'
    as third argument types. That is the reason why corresponding structure
    definitions were added in file 'linux-user/syscall_types.h'.
    Since the thunk type for 'struct ioc_vol_args' was already added in a
    previous patch, the rest of the implementation was straightforward.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200803094629.21898-4-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        | 24 ++++++++++++++++++++++++
 linux-user/syscall_defs.h  |  6 ++++++
 linux-user/syscall_types.h | 16 ++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index f33a99f8b642..55a6cbeca515 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -178,6 +178,22 @@
      IOCTL(BTRFS_IOC_SNAP_CREATE, IOC_W,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
 #endif
+#ifdef BTRFS_IOC_SCAN_DEV
+     IOCTL(BTRFS_IOC_SCAN_DEV, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
+#endif
+#ifdef BTRFS_IOC_FORGET_DEV
+     IOCTL(BTRFS_IOC_FORGET_DEV, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
+#endif
+#ifdef BTRFS_IOC_ADD_DEV
+     IOCTL(BTRFS_IOC_ADD_DEV, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
+#endif
+#ifdef BTRFS_IOC_RM_DEV
+     IOCTL(BTRFS_IOC_RM_DEV, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
+#endif
 #ifdef BTRFS_IOC_SUBVOL_CREATE
      IOCTL(BTRFS_IOC_SUBVOL_CREATE, IOC_W,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
@@ -192,6 +208,14 @@
 #ifdef BTRFS_IOC_SUBVOL_SETFLAGS
      IOCTL(BTRFS_IOC_SUBVOL_SETFLAGS, IOC_W, MK_PTR(TYPE_ULONGLONG))
 #endif
+#ifdef BTRFS_IOC_DEV_INFO
+     IOCTL(BTRFS_IOC_DEV_INFO, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_dev_info_args)))
+#endif
+#ifdef BTRFS_IOC_GET_DEV_STATS
+     IOCTL(BTRFS_IOC_GET_DEV_STATS, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_dev_stats)))
+#endif
 #ifdef BTRFS_IOC_GET_SUBVOL_INFO
      IOCTL(BTRFS_IOC_GET_SUBVOL_INFO, IOC_R,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_subvol_info_args)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index e514cb6916ed..f9f94c9c08cc 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -974,12 +974,18 @@ struct target_rtc_pll_info {
 
 /* btrfs ioctls */
 #define TARGET_BTRFS_IOC_SNAP_CREATE            TARGET_IOWU(BTRFS_IOCTL_MAGIC, 1)
+#define TARGET_BTRFS_IOC_SCAN_DEV               TARGET_IOWU(BTRFS_IOCTL_MAGIC, 4)
+#define TARGET_BTRFS_IOC_FORGET_DEV             TARGET_IOWU(BTRFS_IOCTL_MAGIC, 5)
+#define TARGET_BTRFS_IOC_ADD_DEV                TARGET_IOWU(BTRFS_IOCTL_MAGIC, 10)
+#define TARGET_BTRFS_IOC_RM_DEV                 TARGET_IOWU(BTRFS_IOCTL_MAGIC, 11)
 #define TARGET_BTRFS_IOC_SUBVOL_CREATE          TARGET_IOWU(BTRFS_IOCTL_MAGIC, 14)
 #define TARGET_BTRFS_IOC_SNAP_DESTROY           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 15)
 #define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, 25,\
                                                            abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, 26,\
                                                            abi_ullong)
+#define TARGET_BTRFS_IOC_DEV_INFO               TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 30)
+#define TARGET_BTRFS_IOC_GET_DEV_STATS          TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 52)
 #define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IORU(BTRFS_IOCTL_MAGIC, 60)
 
 /* usb ioctls */
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index cfd8e1c7eea7..35f94cdfc8ba 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -382,6 +382,22 @@ STRUCT(btrfs_ioctl_get_subvol_info_args,
        MK_STRUCT(STRUCT_btrfs_ioctl_timespec), /* rtime */
        MK_ARRAY(TYPE_ULONGLONG, 8)) /* reserved */
 
+STRUCT(btrfs_ioctl_dev_info_args,
+       TYPE_ULONGLONG, /* devid */
+       MK_ARRAY(TYPE_CHAR, BTRFS_UUID_SIZE), /* uuid */
+       TYPE_ULONGLONG, /* bytes_used */
+       TYPE_ULONGLONG, /* total_bytes */
+       MK_ARRAY(TYPE_ULONGLONG, 379), /* unused */
+       MK_ARRAY(TYPE_CHAR, BTRFS_DEVICE_PATH_NAME_MAX)) /* path */
+
+STRUCT(btrfs_ioctl_get_dev_stats,
+       TYPE_ULONGLONG, /* devid */
+       TYPE_ULONGLONG, /* nr_items */
+       TYPE_ULONGLONG, /* flags */
+       MK_ARRAY(TYPE_ULONGLONG, BTRFS_DEV_STAT_VALUES_MAX), /* values */
+       MK_ARRAY(TYPE_ULONGLONG,
+                128 - 2 - BTRFS_DEV_STAT_VALUES_MAX)) /* unused */
+
 STRUCT(rtc_time,
        TYPE_INT, /* tm_sec */
        TYPE_INT, /* tm_min */
-- 
2.26.2


