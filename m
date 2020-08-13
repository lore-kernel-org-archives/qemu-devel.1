Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA23C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B15E320781
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15E320781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k67Ba-0002dd-UK
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 02:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673c-0006dH-Hp
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:48 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:45471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673O-0004cX-9W
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:48 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N2VGj-1kpo2f2Rln-013toj; Thu, 13 Aug 2020 08:49:31 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 10/14] linux-user: Add support for a group of btrfs inode ioctls
Date: Thu, 13 Aug 2020 08:49:19 +0200
Message-Id: <20200813064923.263565-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200813064923.263565-1-laurent@vivier.eu>
References: <20200813064923.263565-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:M6VZirVnvZvgZh51g8Ztv66mzFUjuxN3G8P0ZyRRhJ0ugJYkCja
 FfqglNe7ycZDCHZLdD07+72oqsBUW/5MteM0GF3uABb7of1/xJOjv5xWhj/ejRERy9/SEQq
 tdRnnz9otsrI77fc56Jd419TU64b3N0h04vgiK+rg3MJxkWDpFIOO0LzSm0O/oOE+WXm5ME
 zUHZssW0rEIA+7Lv8dfjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L5v3DXt05MY=:7dxhgJ2iRcCeqMhrlqX51X
 5jf0tKbPJfkg9cdgGAI282Jh5c872y8RV4i5ozImDUX8Wu+vhWP5BFgv0zy9vEP86d4ZcoCtU
 IwKu6O5wNjfG2i3SLE04+cX5Z4XHOivHNizPEeYC5YF25/A7SoicFAFVM7jITw/BYBrsu9kL7
 L/epPekiTJVVGaiT9Euu6wSu8xpg21rAJ+D0AYdNgkFf3wkeHDnbjtnYXv6QIJY0LKP9pq0Ki
 7tLM3EcKoUmznTmiJGmOjYDTSRNSInxYqm/UC6xv8r/5TMhX3p/RYSNeEEQqfbgOhCufz6Mx9
 NUNvcIntNdVh5pORcLehf6J5kAPCNE0+U7pn+JgWB5RM78C/8hlaIWOt3bSwtB6pA2L1etEE1
 0t1tz+dkbVYj+E3Ir/ZITw8FNl8y31ytb+fx4CyBo/o30NBK5xGrkHeDBQJb461Snr/H/VUa7
 IoQUH4M48dzPV4pyiZgzXxUxciVo05xPRYT8CEkLdEJiwUaOf048803FtvR0nARGDaC+zTKAA
 ybxQITbXkOc8RMlWfxODpl1Ufd6Za/hF+9d5suQGQO013jiqLBoOzo8Sa9RWb4/tzmNrsV73J
 UP6UgQAVS7Dz9vN7zTZhLdnT4SbkJ90RDkfxovuLbmoSEdbLQFGaH2XrSjqxskP3GA6s7Vcq9
 CbOqtuHQaK1mzqprRjV73WjGylunND5SA3ITR1JxIcY9jJouon60w2+75NJ/vTj5nnCnpTdo5
 3iXoiCYmxgoFNrOYh7pwdaJncfXVDiBxm5wahNj3owG4dsSehUgRibj7h0inYcPCSVcOZAckS
 s30vr8nSD+mxM0t2nhH4puGUGocmTCveLFj4xYZW4jeWKow38Q1KWUttSShNOoOIBHd/Lny
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:49:28
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

BTRFS_IOC_INO_LOOKUP - Reading tree root id and path

    Read tree root id and path for a given file or directory.
    The name and tree root id are returned in an ioctl's third
    argument that represents a pointer to a following type:

    struct btrfs_ioctl_ino_lookup_args {
	__u64 treeid;
	__u64 objectid;
	char name[BTRFS_INO_LOOKUP_PATH_MAX];
    };

    Before calling this ioctl, field 'objectid' should be filled
    with the object id value for which the tree id and path are
    to be read. Value 'BTRFS_FIRST_FREE_OBJECTID' represents the
    object id for the first available btrfs object (directory or
    file).

BTRFS_IOC_INO_PATHS - Reading paths to all files

    Read path to all files with a certain inode number. The paths
    are returned in the ioctl's third argument which represents
    a pointer to a following type:

    struct btrfs_ioctl_ino_path_args {
	__u64				inum;		/* in */
	__u64				size;		/* in */
	__u64				reserved[4];
	/* struct btrfs_data_container	*fspath;	   out */
	__u64				fspath;		/* out */
     };

     Before calling this ioctl, the 'inum' and 'size' field should
     be filled with the aproppriate inode number and size of the
     directory where file paths should be looked for. For now, the
     paths are returned in an '__u64' (unsigned long long) value
     'fspath'.

BTRFS_IOC_LOGICAL_INO - Reading inode numbers

     Read inode numbers for files on a certain logical adress. The
     inode numbers are returned in the ioctl's third argument which
     represents a pointer to a following type:

     struct btrfs_ioctl_logical_ino_args {
	__u64				logical;	/* in */
	__u64				size;		/* in */
	__u64				reserved[3];	/* must be 0 for now */
	__u64				flags;		/* in, v2 only */
	/* struct btrfs_data_container	*inodes;	out   */
	__u64				inodes;
     };

     Before calling this ioctl, the 'logical' and 'size' field should
     be filled with the aproppriate logical adress and size of where
     the inode numbers of files should be looked for. For now, the
     inode numbers are returned in an '__u64' (unsigned long long)
     value 'inodes'.

BTRFS_IOC_LOGICAL_INO_V2 - Reading inode numbers

     Same as the above mentioned ioctl except that it allows passing
     a flags 'BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET'.

BTRFS_IOC_INO_LOOKUP_USER - Reading subvolume name and path

     Read name and path of a subvolume. The tree root id and
     path are read in an ioctl's third argument which represents a
     pointer to a following type:

     struct btrfs_ioctl_ino_lookup_user_args {
	/* in, inode number containing the subvolume of 'subvolid' */
	__u64 dirid;
	/* in */
	__u64 treeid;
	/* out, name of the subvolume of 'treeid' */
	char name[BTRFS_VOL_NAME_MAX + 1];
	/*
	 * out, constructed path from the directory with which the ioctl is
	 * called to dirid
	 */
	char path[BTRFS_INO_LOOKUP_USER_PATH_MAX];
     };

     Before calling this ioctl, the 'dirid' and 'treeid' field should
     be filled with aproppriate values which represent the inode number
     of the directory that contains the subvolume and treeid of the
     subvolume.

Implementation notes:

     All of the ioctls in this patch use structure types as third arguments.
     That is the reason why aproppriate thunk definitions were added in file
     'syscall_types.h'.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200803094629.21898-6-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        | 20 ++++++++++++++++++++
 linux-user/syscall_defs.h  |  5 +++++
 linux-user/syscall_types.h | 24 ++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 50fae1e33bc4..169f98f7a301 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -202,6 +202,10 @@
      IOCTL(BTRFS_IOC_SNAP_DESTROY, IOC_W,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
 #endif
+#ifdef BTRFS_IOC_INO_LOOKUP
+     IOCTL(BTRFS_IOC_INO_LOOKUP, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_ino_lookup_args)))
+#endif
 #ifdef BTRFS_IOC_SUBVOL_GETFLAGS
      IOCTL(BTRFS_IOC_SUBVOL_GETFLAGS, IOC_R, MK_PTR(TYPE_ULONGLONG))
 #endif
@@ -212,6 +216,14 @@
      IOCTL(BTRFS_IOC_DEV_INFO, IOC_RW,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_dev_info_args)))
 #endif
+#ifdef BTRFS_IOC_INO_PATHS
+     IOCTL(BTRFS_IOC_INO_PATHS, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_ino_path_args)))
+#endif
+#ifdef BTRFS_IOC_LOGICAL_INO
+     IOCTL(BTRFS_IOC_LOGICAL_INO, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_logical_ino_args)))
+#endif
 #ifdef BTRFS_IOC_GET_DEV_STATS
      IOCTL(BTRFS_IOC_GET_DEV_STATS, IOC_RW,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_dev_stats)))
@@ -228,10 +240,18 @@
      IOCTL(BTRFS_IOC_GET_SUPPORTED_FEATURES, IOC_R,
            MK_PTR(MK_ARRAY(MK_STRUCT(STRUCT_btrfs_ioctl_feature_flags), 3)))
 #endif
+#ifdef BTRFS_IOC_LOGICAL_INO_V2
+     IOCTL(BTRFS_IOC_LOGICAL_INO_V2, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_logical_ino_args)))
+#endif
 #ifdef BTRFS_IOC_GET_SUBVOL_INFO
      IOCTL(BTRFS_IOC_GET_SUBVOL_INFO, IOC_R,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_subvol_info_args)))
 #endif
+#ifdef BTRFS_IOC_INO_LOOKUP_USER
+     IOCTL(BTRFS_IOC_INO_LOOKUP_USER, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_ino_lookup_user_args)))
+#endif
 
 #ifdef CONFIG_USBFS
   /* USB ioctls */
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 6cc3c1f6f5ba..48ebf56d0f36 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -980,16 +980,21 @@ struct target_rtc_pll_info {
 #define TARGET_BTRFS_IOC_RM_DEV                 TARGET_IOWU(BTRFS_IOCTL_MAGIC, 11)
 #define TARGET_BTRFS_IOC_SUBVOL_CREATE          TARGET_IOWU(BTRFS_IOCTL_MAGIC, 14)
 #define TARGET_BTRFS_IOC_SNAP_DESTROY           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 15)
+#define TARGET_BTRFS_IOC_INO_LOOKUP             TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 18)
 #define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, 25,\
                                                            abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, 26,\
                                                            abi_ullong)
 #define TARGET_BTRFS_IOC_DEV_INFO               TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 30)
+#define TARGET_BTRFS_IOC_INO_PATHS              TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 35)
+#define TARGET_BTRFS_IOC_LOGICAL_INO            TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 36)
 #define TARGET_BTRFS_IOC_GET_DEV_STATS          TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 52)
 #define TARGET_BTRFS_IOC_GET_FEATURES           TARGET_IORU(BTRFS_IOCTL_MAGIC, 57)
 #define TARGET_BTRFS_IOC_SET_FEATURES           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 57)
 #define TARGET_BTRFS_IOC_GET_SUPPORTED_FEATURES TARGET_IORU(BTRFS_IOCTL_MAGIC, 57)
+#define TARGET_BTRFS_IOC_LOGICAL_INO_V2         TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 59)
 #define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IORU(BTRFS_IOCTL_MAGIC, 60)
+#define TARGET_BTRFS_IOC_INO_LOOKUP_USER        TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 62)
 
 /* usb ioctls */
 #define TARGET_USBDEVFS_CONTROL TARGET_IOWRU('U', 0)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 808f4daaf72e..6e64e6c4f57c 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -382,6 +382,30 @@ STRUCT(btrfs_ioctl_get_subvol_info_args,
        MK_STRUCT(STRUCT_btrfs_ioctl_timespec), /* rtime */
        MK_ARRAY(TYPE_ULONGLONG, 8)) /* reserved */
 
+STRUCT(btrfs_ioctl_ino_lookup_args,
+       TYPE_ULONGLONG, /* treeid */
+       TYPE_ULONGLONG, /* objectid */
+       MK_ARRAY(TYPE_CHAR, BTRFS_INO_LOOKUP_PATH_MAX)) /* name */
+
+STRUCT(btrfs_ioctl_ino_path_args,
+       TYPE_ULONGLONG, /* inum */
+       TYPE_ULONGLONG, /* size */
+       MK_ARRAY(TYPE_ULONGLONG, 4), /* reserved */
+       TYPE_ULONGLONG) /* fspath */
+
+STRUCT(btrfs_ioctl_logical_ino_args,
+       TYPE_ULONGLONG, /* logical */
+       TYPE_ULONGLONG, /* size */
+       MK_ARRAY(TYPE_ULONGLONG, 3), /* reserved */
+       TYPE_ULONGLONG, /* flags */
+       TYPE_ULONGLONG) /* inodes */
+
+STRUCT(btrfs_ioctl_ino_lookup_user_args,
+       TYPE_ULONGLONG, /* dirid */
+       TYPE_ULONGLONG, /* treeid */
+       MK_ARRAY(TYPE_CHAR, BTRFS_VOL_NAME_MAX + 1), /* name */
+       MK_ARRAY(TYPE_CHAR, BTRFS_INO_LOOKUP_USER_PATH_MAX)) /* path */
+
 STRUCT(btrfs_ioctl_dev_info_args,
        TYPE_ULONGLONG, /* devid */
        MK_ARRAY(TYPE_CHAR, BTRFS_UUID_SIZE), /* uuid */
-- 
2.26.2


