Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6202BC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:08:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED3D2054F
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED3D2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kChfc-0000Eg-AE
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 07:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kCher-00070O-Bn
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:07:29 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:50495)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kChep-0000Qs-3O
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:07:28 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mna0x-1ktm6G3P5Z-00jczK; Mon, 31 Aug 2020 13:07:22 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 1/8] linux-user: Add support for a group of btrfs ioctls used
 for subvolumes
Date: Mon, 31 Aug 2020 13:07:09 +0200
Message-Id: <20200831110716.536808-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831110716.536808-1-laurent@vivier.eu>
References: <20200831110716.536808-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mDIX00i5rwNVd18k6fob77XJ0HwvkSafRmtQb1M9HWRLZ3xRHM2
 eEYWG+r8bL+dPWHwTXX1d+tA9n2JKZtfP0xGNNpjphyBBgpPjKUV0/k1hESxpLgt1wNwmpo
 Ectb3F0azKxVhiwZpouYDgoJ1vz7qujeMBMNikItzkcta9gbL1pLu7ydaAEPAZgUHq+TUop
 cG2i+ossi2tDdEq7A4IVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NC5yaROxCxo=:irvFPG5r6XdTH+xxCp234a
 B6aiQmiVAbY3xeEnPn5Ve4YZmRrynslBY7J6MQSjrnuLH1VXLMHBQqHvOGz0ZVXicjnwzGQxa
 nelJd7oxo8K0wGPzmdaBwu+B1FAwQaygwNQe/zS4LePER4CSi0GM+bHMm0kSvwfSRxzsO2aYg
 4F4go/jIhU3rw+JjwB87DwJbeVJDMif52k6ksnE4AEHCZKZbgVMybbZ/Jrdj9sTBXE7UVRcGR
 VF8559M4k0AB7UNqjaK1yfmc30/mq1PrECA6Ijt5pfz4VixP/lj3GDdziuAF932uiAJUlRSAq
 1qEVyoQkC8b9SQMVouy2fQQ81IjkoOgmTfydUEmzLU/qhs+32X+sqsRl8XZJrbuyO6gvdqZD+
 C1Kis+N/Raz/6N5aPgGzDrC5K8yGa9Ke8FLyLn9iK36u0C/RhG7q7TcvQMVQjP9uXJgA891H5
 Wd+rEL43Jf2SO+imcdZ2JnVOpkIpgnp4mpMMC80vSGHA6maMzZodMLUEFrw72qtYWQVt21pZp
 fBaXHFOFuZOoQSbPltu1IvmxITJvBvJT4byd52aX7EPiF5TlG7HI+tR3WrwimL8VgYg/I1u4+
 CqKDbS/nd1xqFV5TIiqu3xhKUeL8qwfRabGvhsrI1eLq2b4Iy3UIoRRjrMFuxUzeHI7o4dabD
 +cAtILoFfIKMY+pZitNZLEv1Qn0DjwdUY/Sp5vQWlJ52lHmDBHRnGxUr0I86Gb/HPhNvYXog0
 dmDOqHfQAlPu33MHoYvfxynfiJz8Z4SxQ9PdFstCg2GwnSZ9CJg7uSeGjYE6zz1hOYZZIjH7h
 lDiDcLikgFGiAV/qKfxySUoKiHYGJ4/BiDtfUKGa9JAERyE/FZAe1Ad/Yf1GXylanoD1lcG
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 07:07:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This patch implements functionality of following ioctls:

BTRFS_IOC_SUBVOL_CREATE - Creating a btrfs subvolume

    Create a btrfs subvolume. The subvolume is created using the ioctl's
    third argument which represents a pointer to a following structure
    type:

    struct btrfs_ioctl_vol_args {
	__s64 fd;
	char name[BTRFS_PATH_NAME_MAX + 1];
    };

    Before calling this ioctl, the fields of this structure should be filled
    with aproppriate values. The fd field represents the file descriptor
    value of the subvolume and the name field represents the subvolume
    path.

BTRFS_IOC_SUBVOL_GETFLAGS - Getting subvolume flags

    Read the flags of the btrfs subvolume. The flags are read using
    the ioctl's third argument that is a pointer of __u64 (unsigned long).
    The third argument represents a bit mask that can be composed of following
    values:
    BTRFS_SUBVOL_RDONLY           (1ULL << 1)
    BTRFS_SUBVOL_QGROUP_INHERIT   (1ULL << 2)
    BTRFS_DEVICE_SPEC_BY_ID       (1ULL << 3)
    BTRFS_SUBVOL_SPEC_BY_ID       (1ULL << 4)

BTRFS_IOC_SUBVOL_SETFLAGS - Setting subvolume flags

    Set the flags of the btrfs subvolume. The flags are set using the
    ioctl's third argument that is a pointer of __u64 (unsigned long).
    The third argument represents a bit mask that can be composed of same
    values as in the case of previous ioctl (BTRFS_IOC_SUBVOL_GETFLAGS).

BTRFS_IOC_SUBVOL_GETINFO - Getting subvolume information

    Read information about the subvolume. The subvolume information is
    returned in the ioctl's third argument which represents a pointer to
    a following structure type:

    struct btrfs_ioctl_get_subvol_info_args {
	/* Id of this subvolume */
	__u64 treeid;

	/* Name of this subvolume, used to get the real name at mount point */
	char name[BTRFS_VOL_NAME_MAX + 1];

	/*
	 * Id of the subvolume which contains this subvolume.
	 * Zero for top-level subvolume or a deleted subvolume.
	 */
	__u64 parent_id;

	/*
	 * Inode number of the directory which contains this subvolume.
	 * Zero for top-level subvolume or a deleted subvolume
	 */
	__u64 dirid;

	/* Latest transaction id of this subvolume */
	__u64 generation;

	/* Flags of this subvolume */
	__u64 flags;

	/* UUID of this subvolume */
	__u8 uuid[BTRFS_UUID_SIZE];

	/*
	 * UUID of the subvolume of which this subvolume is a snapshot.
	 * All zero for a non-snapshot subvolume.
	 */
	__u8 parent_uuid[BTRFS_UUID_SIZE];

	/*
	 * UUID of the subvolume from which this subvolume was received.
	 * All zero for non-received subvolume.
	 */
	__u8 received_uuid[BTRFS_UUID_SIZE];

	/* Transaction id indicating when change/create/send/receive happened */
	__u64 ctransid;
	__u64 otransid;
	__u64 stransid;
	__u64 rtransid;
	/* Time corresponding to c/o/s/rtransid */
	struct btrfs_ioctl_timespec ctime;
	struct btrfs_ioctl_timespec otime;
	struct btrfs_ioctl_timespec stime;
	struct btrfs_ioctl_timespec rtime;

	/* Must be zero */
	__u64 reserved[8];
     };

     All of the fields of this structure are filled after the ioctl call.

Implementation notes:

    Ioctls BTRFS_IOC_SUBVOL_CREATE and BTRFS_IOC_SUBVOL_GETINFO have structure
    types as third arguments. That is the reason why a corresponding definition
    are added in file 'linux-user/syscall_types.h'.

    The line '#include <linux/btrfs.h>' is added in file 'linux-user/syscall.c' to
    recognise preprocessor definitions for these ioctls. Since the file "linux/btrfs.h"
    was added in the kernel version 3.9, it is enwrapped in an #ifdef statement
    with parameter CONFIG_BTRFS which is defined in 'configure' if the
    header file is present.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Tested-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200823195014.116226-2-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure                  |  9 +++++++++
 linux-user/ioctls.h        | 15 +++++++++++++++
 linux-user/syscall.c       |  3 +++
 linux-user/syscall_defs.h  |  8 ++++++++
 linux-user/syscall_types.h | 32 ++++++++++++++++++++++++++++++++
 5 files changed, 67 insertions(+)

diff --git a/configure b/configure
index 6ecaff429b1b..24a6146b14c7 100755
--- a/configure
+++ b/configure
@@ -4939,6 +4939,12 @@ if check_include sys/kcov.h ; then
     kcov=yes
 fi
 
+# check for btrfs filesystem support (kernel must be 3.9+)
+btrfs=no
+if check_include linux/btrfs.h ; then
+    btrfs=yes
+fi
+
 # If we're making warnings fatal, apply this to Sphinx runs as well
 sphinx_werror=""
 if test "$werror" = "yes"; then
@@ -6918,6 +6924,9 @@ fi
 if test "$kcov" = "yes" ; then
   echo "CONFIG_KCOV=y" >> $config_host_mak
 fi
+if test "$btrfs" = "yes" ; then
+  echo "CONFIG_BTRFS=y" >> $config_host_mak
+fi
 if test "$inotify" = "yes" ; then
   echo "CONFIG_INOTIFY=y" >> $config_host_mak
 fi
diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index e2fc09b5a5ee..bf89b96d27b0 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -174,6 +174,21 @@
      IOCTL(FS_IOC32_GETVERSION, IOC_R, MK_PTR(TYPE_INT))
      IOCTL(FS_IOC32_SETVERSION, IOC_W, MK_PTR(TYPE_INT))
 
+#ifdef BTRFS_IOC_SUBVOL_CREATE
+     IOCTL(BTRFS_IOC_SUBVOL_CREATE, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
+#endif
+#ifdef BTRFS_IOC_SUBVOL_GETFLAGS
+     IOCTL(BTRFS_IOC_SUBVOL_GETFLAGS, IOC_R, MK_PTR(TYPE_ULONGLONG))
+#endif
+#ifdef BTRFS_IOC_SUBVOL_SETFLAGS
+     IOCTL(BTRFS_IOC_SUBVOL_SETFLAGS, IOC_W, MK_PTR(TYPE_ULONGLONG))
+#endif
+#ifdef BTRFS_IOC_GET_SUBVOL_INFO
+     IOCTL(BTRFS_IOC_GET_SUBVOL_INFO, IOC_R,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_subvol_info_args)))
+#endif
+
 #ifdef CONFIG_USBFS
   /* USB ioctls */
   IOCTL(USBDEVFS_CONTROL, IOC_RW,
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d14d849a720c..93da3b972852 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -112,6 +112,9 @@
 #include <linux/if_alg.h>
 #include <linux/rtc.h>
 #include <sound/asound.h>
+#ifdef CONFIG_BTRFS
+#include <linux/btrfs.h>
+#endif
 #ifdef HAVE_DRM_H
 #include <libdrm/drm.h>
 #include <libdrm/i915_drm.h>
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 9d07991176b8..cae79f8492e1 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1005,6 +1005,14 @@ struct target_rtc_pll_info {
 #define TARGET_FS_IOC32_GETVERSION TARGET_IOR('v', 1, int)
 #define TARGET_FS_IOC32_SETVERSION TARGET_IOW('v', 2, int)
 
+/* btrfs ioctls */
+#define TARGET_BTRFS_IOC_SUBVOL_CREATE          TARGET_IOWU(BTRFS_IOCTL_MAGIC, 14)
+#define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, 25,\
+                                                           abi_ullong)
+#define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, 26,\
+                                                           abi_ullong)
+#define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IORU(BTRFS_IOCTL_MAGIC, 60)
+
 /* usb ioctls */
 #define TARGET_USBDEVFS_CONTROL TARGET_IOWRU('U', 0)
 #define TARGET_USBDEVFS_BULK TARGET_IOWRU('U', 2)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 12bf3484e2bd..0ce58d77727c 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -358,6 +358,38 @@ STRUCT(blkpg_partition,
        MK_ARRAY(TYPE_CHAR, BLKPG_DEVNAMELTH), /* devname */
        MK_ARRAY(TYPE_CHAR, BLKPG_VOLNAMELTH)) /* volname */
 
+#ifdef BTRFS_IOC_SUBVOL_CREATE
+STRUCT(btrfs_ioctl_vol_args,
+       TYPE_LONGLONG, /* fd */
+       MK_ARRAY(TYPE_CHAR, BTRFS_PATH_NAME_MAX + 1)) /* name */
+#endif
+
+#ifdef BTRFS_IOC_GET_SUBVOL_INFO
+STRUCT(btrfs_ioctl_timespec,
+       TYPE_ULONGLONG, /* sec */
+       TYPE_INT) /* nsec */
+
+STRUCT(btrfs_ioctl_get_subvol_info_args,
+       TYPE_ULONGLONG, /* treeid */
+       MK_ARRAY(TYPE_CHAR, BTRFS_VOL_NAME_MAX + 1),
+       TYPE_ULONGLONG, /* parentid */
+       TYPE_ULONGLONG, /* dirid */
+       TYPE_ULONGLONG, /* generation */
+       TYPE_ULONGLONG, /* flags */
+       MK_ARRAY(TYPE_CHAR, BTRFS_UUID_SIZE), /* uuid */
+       MK_ARRAY(TYPE_CHAR, BTRFS_UUID_SIZE), /* parent_uuid */
+       MK_ARRAY(TYPE_CHAR, BTRFS_UUID_SIZE), /* received_uuid */
+       TYPE_ULONGLONG, /* ctransid */
+       TYPE_ULONGLONG, /* otransid */
+       TYPE_ULONGLONG, /* stransid */
+       TYPE_ULONGLONG, /* rtransid */
+       MK_STRUCT(STRUCT_btrfs_ioctl_timespec), /* ctime */
+       MK_STRUCT(STRUCT_btrfs_ioctl_timespec), /* otime */
+       MK_STRUCT(STRUCT_btrfs_ioctl_timespec), /* stime */
+       MK_STRUCT(STRUCT_btrfs_ioctl_timespec), /* rtime */
+       MK_ARRAY(TYPE_ULONGLONG, 8)) /* reserved */
+#endif
+
 STRUCT(rtc_time,
        TYPE_INT, /* tm_sec */
        TYPE_INT, /* tm_min */
-- 
2.26.2


