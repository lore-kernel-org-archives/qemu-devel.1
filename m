Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34991C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C6720771
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C6720771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k678U-0005Ev-2K
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 02:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673S-0006SD-9L
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:38 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:51863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673M-0004cI-E2
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:37 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MtObA-1kyMdC2Fhu-00un0u; Thu, 13 Aug 2020 08:49:28 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 06/14] linux-user: Add support for a group of btrfs ioctls used
 for subvolumes
Date: Thu, 13 Aug 2020 08:49:15 +0200
Message-Id: <20200813064923.263565-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200813064923.263565-1-laurent@vivier.eu>
References: <20200813064923.263565-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KoC6zAaNCDMyXjDVi2VRR7G7Yd+aqOjsoINDfQuuw6DPQPHqI/e
 tTW8xJl7DPuWE6e6ToolarjaW76ni4/dVsDYtAfrY3U8ez2Fp0gWLwmMkhR65yIgQ4aXBen
 SFz5LNsOAr+he5Pj0aKgHr6YreKiHwZoR8j5+kq7CnA5L1/wbpPYF4DtahK9IOBhITpY+78
 8OdIxCwJBmsdnJxSN9fCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oD/jXqUHFa0=:OjeV3eFivXww8CvuFfW+62
 T8IAtpesxJm2hSmRI0cNB8JdsSX+gWCGEp6TZ05JRD9zOdAdw/GIq5nLmynmRjjp+vppNbk3B
 zAxtwemiHLK7Diwp4/ObdX7LjbVtZ8Pnh5COnX3uy4LYyM2OK0WvvveCe0ahQAmJCYG8E1pSC
 FAA6HZNS4nx2389EdVv5hrE/XdL49qYGY314OLD2l7Jj0gVNHYC+ieh0lwye0Uw4FzvL+chuc
 25GLOXGFoceb3GsXBpnI2hefWOjG0QSnbwujcgSDbjmwOj3pruLZ+aQSTpJ2mUDpIBzdp/MBM
 CZTAvfm+x1ZF3PjK8fGmRDwtJ3BmeoO+X1p/4O26j18XiYp3Ar+PWbH/C5lubLRs1mOXA8O7A
 WVtZKfeMyFndfOMIwd2Jl1kK7sFitGiPQVqfe3cXMNMtZ3AwHq0SGKBYUHa8TpqmOJFxagSCd
 H9RoizKxEZf8dMjyTUs7AH0txxcfH/KyZzUeh83AMhvPj/eL4YBVMDexwRtwalbWQUPJlJupg
 D0by+YJWbXzE5bP4RfcunMlmF5eb9KCWzilgPgS7Hg8lDgl4VxQQs5oOwAMj39EoF0iBIJtIA
 D2kwRDyiBAp1RxyvM3Mc+1ZvLlg1PSnHX38G7eDfyCX1n90iFvrIh3zCicdgziBl9PyJkvX6m
 UyulwE6AktzXFUwxcGT85fiFIKumFmpO9Tp+F5/dpKiXcYvaJ1QsywsG0n/azccZ7cdsAA+7d
 uE8HOlPlxOEffBWmgsKqHpFKs0T6L+2tDRmltKBBRm31so3cCIfoTR8G9l8vUUpZKBIcFzcZA
 U9PSlx5tw1mYZ/ZpdQIW9X9Ax7gJuzyEphu1tfo9bR87sWeKwHmt6T2g6SC2+F4c6fKnUEL
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:49:30
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200803094629.21898-2-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure                  |  9 +++++++++
 linux-user/ioctls.h        | 15 +++++++++++++++
 linux-user/syscall.c       |  3 +++
 linux-user/syscall_defs.h  |  8 ++++++++
 linux-user/syscall_types.h | 28 ++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+)

diff --git a/configure b/configure
index 2acc4d1465f8..1cba4e0b80fb 100755
--- a/configure
+++ b/configure
@@ -5079,6 +5079,12 @@ if check_include sys/kcov.h ; then
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
@@ -7330,6 +7336,9 @@ fi
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
index 0713ae131162..12d14442249f 100644
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
index bbb61a59c72f..10dd53bf999b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -115,6 +115,9 @@
 #ifdef HAVE_DRM_H
 #include <libdrm/drm.h>
 #endif
+#ifdef CONFIG_BTRFS
+#include <linux/btrfs.h>
+#endif
 #include "linux_loop.h"
 #include "uname.h"
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 427a25f5bce5..5435baea38d9 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -972,6 +972,14 @@ struct target_rtc_pll_info {
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
index 3f1f0334649b..cfd8e1c7eea7 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -354,6 +354,34 @@ STRUCT(blkpg_partition,
        MK_ARRAY(TYPE_CHAR, BLKPG_DEVNAMELTH), /* devname */
        MK_ARRAY(TYPE_CHAR, BLKPG_VOLNAMELTH)) /* volname */
 
+STRUCT(btrfs_ioctl_vol_args,
+       TYPE_LONGLONG, /* fd */
+       MK_ARRAY(TYPE_CHAR, BTRFS_PATH_NAME_MAX + 1)) /* name */
+
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
+
 STRUCT(rtc_time,
        TYPE_INT, /* tm_sec */
        TYPE_INT, /* tm_min */
-- 
2.26.2


