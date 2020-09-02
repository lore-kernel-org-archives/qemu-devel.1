Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82435C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:31:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5220220773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5220220773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDcDX-0002cB-BC
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 19:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kDc9p-0003us-D5
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 19:27:13 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:37915)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kDc9n-0004r6-20
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 19:27:13 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M9WqY-1kAKuE2pca-005b1A; Thu, 03 Sep 2020 01:27:06 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 6/9] linux-user: Add support for a group of btrfs inode ioctls
Date: Thu,  3 Sep 2020 01:26:58 +0200
Message-Id: <20200902232701.13299-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902232701.13299-1-laurent@vivier.eu>
References: <20200902232701.13299-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ERNIEgF5CXCBUaQEdWuhxAi1s2XDdAZJ5JYPcuhOgS3kn3xdOsZ
 /2OFvu+FWfqu0MHkCCRQKoZSTgQWB6uMVQVmw/Zxr1LuYNCebkhgwC6W83Dx6848UneDY7S
 5uDQsAfRtdNXToGU4Z4fOwwvYvTJRM1mlKtYLtkndtxLoicutV+oTedsXbvAV+mwtoG4frf
 hFugvyO/8KRGjtolKbfww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mamx94tut8Y=:0dBZRAUJZCDXlL5unGBl/C
 AjM7P/DZK0ApttDaGqt0NPQ2Z1oBftJKZJAqwjMOmohV1sND6KSF+keiPVjOcoiacHp3kNujO
 hdDY3e7f0qfQbTCPsd36qTJJ40T19r/KoMSQsBtFoZFs0QLu2G8tfRXIG8HfQBXwzH6npdgdL
 YEGgxk5hzCk6jA9/AFSZ6vQzmbsQLyFo3qb3BOLXP0dy9ZD8kPFUBX29I0irK0LzOBw2R0VUE
 8zJnc3TlG+toyqTGpQFAoYn/BUjdY9oNkMfrvKHszHLj991P5tLskIrVI2axQ08lFMRuGBlus
 kgGnri/4S8LPCudh/3ClyY+9hPB6T0w+p+Q3Ew3YBwI7wf6CS+1nbd8OR7mjNBiNQDjB4ATAA
 ZXeJ4t5Jva+Awvmlc9iO+q6qW/Bn7sJo3voJ59Q5Zo+yXgyjn79BzlkZhSAyPdmDT0oYERqXO
 a8Qol81ZKYu8fTGMVOX4NVAcKZegMUb0D36Ck0cetvI16hKl/UrIKuzFIhSbUFFEmP791qfBm
 LlOvmwvwp3sHSDLmpGeJxZzVXaPn6h4gt9xELzjLdfKY02yiIUERIIuH/EwLwowG7MxRiESay
 FVStqAqCebc3f8enmMn9zp9YqldIiAlLqCABRNpQa7xnZsfnvHMA/u4Oyy9YYppfG8EOtpBYH
 E5TxWl5MwJ9dfboho+wvYV0QRFPvVIPl7qwx0pnAIxU3farJFwnPYVuURlU8uTXJ8PkZoPctj
 TJMgELP0OST51CE65HtKb83T6884lIeEAenfXIt9JMNfOkCMoRnhvUatGrivQunIVRRbvzGQS
 vKYVNB591NMJYXXdkv2gIQggE3+nmGpcElbJFpQOwKII2yCilGwlznfjRQh1nRiO58/irsA
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 19:27:08
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
Tested-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200823195014.116226-6-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        | 20 ++++++++++++++++++++
 linux-user/syscall_defs.h  |  5 +++++
 linux-user/syscall_types.h | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 11d7361848dd..23807513eed1 100644
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
index f70138979704..4929121956c6 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1013,16 +1013,21 @@ struct target_rtc_pll_info {
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
index eba0c43d4493..dab2c16bcac7 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -393,6 +393,38 @@ STRUCT(btrfs_ioctl_get_subvol_info_args,
        MK_ARRAY(TYPE_ULONGLONG, 8)) /* reserved */
 #endif
 
+#ifdef BTRFS_IOC_INO_LOOKUP
+STRUCT(btrfs_ioctl_ino_lookup_args,
+       TYPE_ULONGLONG, /* treeid */
+       TYPE_ULONGLONG, /* objectid */
+       MK_ARRAY(TYPE_CHAR, BTRFS_INO_LOOKUP_PATH_MAX)) /* name */
+#endif
+
+#ifdef BTRFS_IOC_INO_PATHS
+STRUCT(btrfs_ioctl_ino_path_args,
+       TYPE_ULONGLONG, /* inum */
+       TYPE_ULONGLONG, /* size */
+       MK_ARRAY(TYPE_ULONGLONG, 4), /* reserved */
+       TYPE_ULONGLONG) /* fspath */
+#endif
+
+#if defined(BTRFS_IOC_LOGICAL_INO) || defined(BTRFS_IOC_LOGICAL_INO_V2)
+STRUCT(btrfs_ioctl_logical_ino_args,
+       TYPE_ULONGLONG, /* logical */
+       TYPE_ULONGLONG, /* size */
+       MK_ARRAY(TYPE_ULONGLONG, 3), /* reserved */
+       TYPE_ULONGLONG, /* flags */
+       TYPE_ULONGLONG) /* inodes */
+#endif
+
+#ifdef BTRFS_IOC_INO_LOOKUP_USER
+STRUCT(btrfs_ioctl_ino_lookup_user_args,
+       TYPE_ULONGLONG, /* dirid */
+       TYPE_ULONGLONG, /* treeid */
+       MK_ARRAY(TYPE_CHAR, BTRFS_VOL_NAME_MAX + 1), /* name */
+       MK_ARRAY(TYPE_CHAR, BTRFS_INO_LOOKUP_USER_PATH_MAX)) /* path */
+#endif
+
 #ifdef BTRFS_IOC_DEV_INFO
 STRUCT(btrfs_ioctl_dev_info_args,
        TYPE_ULONGLONG, /* devid */
-- 
2.26.2


