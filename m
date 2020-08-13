Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A6BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBAA920838
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBAA920838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k67Aq-00015U-27
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 02:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673b-0006aF-GB
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:47 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:37185)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673O-0004ch-95
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:45 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MeTHG-1ke4tT2afM-00aW4U; Thu, 13 Aug 2020 08:49:31 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 11/14] linux-user: Add support for two btrfs ioctls used for
 subvolume
Date: Thu, 13 Aug 2020 08:49:20 +0200
Message-Id: <20200813064923.263565-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200813064923.263565-1-laurent@vivier.eu>
References: <20200813064923.263565-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YTHbNury7aNAxG8cTwPbNnm4lFterGWtBVcfpph2bCr/7AVKirq
 /6gK/bd/v5kWNgvlmlZRyiPMbWmSotK3d3KMZJYudz76XPjwXdF2caGC36MiMn6lrwlAGKd
 cmsQOfXd6b58XFLaTOZz/Z2eNNZpU8lAB/3ITIFIdtVM5Eb8Zkxr55PbV3XMMlk1Xn/tSLR
 VkutFLW19YPm46WK6q9Wg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WeJMt6sJNpc=:DadDqg5aR0UWP/FZBQ9XZ3
 iyEGFiW4LzXhMOVQrs1zF0S2DQFt/AFTi4RMoYN9f8hNukiT9QXHeT1+ehPsiOawV6HFyEStL
 eu7dd5FfgCiqvMm3/qXzlQRPgwVjR8CWOWlxQz6sASRTL+36CPjyMIdxEH/VdvTR7Je62G4Nm
 Q3SHizs28uOUDTdLfp4h9uWkgC5OJh1fUhOin41aA3qDuAdySUh2yrYg0nqjGAxkZU1d1hcgh
 ZBgBuJjg7d518s3zSqRD9nv3b5go8AKpOu6j7AnegcwW4ze1InnBqTSMXZB9cChlBdOzrUaF/
 fAXOVuPlAFPmo+2L4DaYijHf1nFgm3D4hsG8JQCwrmm+YxqYxBX6Zv1dXbqKPtKzmk6dEEdVJ
 iJ58cWtsbEcaWJ5RFInnHHWhyfBaR7Fgu+vwCiBYrR40FCXC7Z0XReIfXgfzKhK+3zTud8TLA
 wKcBfGkRzIxQbDgTCEMpKaaRJca6gBi05N1ZXGbU7EfLc0k59p57WdWBF6kr6mkFOLhXqRgwO
 71sb01DK3hobOoZC0yUADt6Lf0y/7rZ0xpEob992Nih0WjSftBPCPSoa7+xgcmMUORg/Jicjt
 rN2ajWxHct0GTowN1b/BtV/59qFiLQNv1ge2fa3ii2iGYEVOdCvggkfCENTgWHqeT32MnwNR0
 OYBCeeLUaV5X6IAX4s6aM3JjYWn0tYEcrnnUwyIbBg0bhUgy+gurVajaj1TAG5SvAeWtcFqZG
 kKJS/6uMOZq1yz1eEaaqfixMJfBMZtjIirEaBMonz9DUxkYHHvMBkcjc/sO7UzIIzoaYRp6sf
 N0ymn59M9TXzQiU7VGJ4C1AJ0bI47MAHNJ4cbYxhoXxezrSvlNYbksUBA4jrH6U0NnBF+b6
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

This patch implements functionality for following ioctl:

BTRFS_IOC_DEFAULT_SUBVOL - Setting a default subvolume

    Set a default subvolume for a btrfs filesystem. The third
    ioctl's argument is a '__u64' (unsigned long long) which
    represents the id of a subvolume that is to be set as
    the default.

BTRFS_IOC_GET_SUBVOL_ROOTREF - Getting tree and directory id of subvolumes

    Read tree and directory id of subvolumes from a btrfs
    filesystem. The tree and directory id's are returned in the
    ioctl's third argument which represents a pointer to a
    following type:

    struct btrfs_ioctl_get_subvol_rootref_args {
		/* in/out, minimum id of rootref's treeid to be searched */
		__u64 min_treeid;

		/* out */
		struct {
			__u64 treeid;
			__u64 dirid;
		} rootref[BTRFS_MAX_ROOTREF_BUFFER_NUM];

		/* out, number of found items */
		__u8 num_items;
		__u8 align[7];
     };

     Before calling this ioctl, 'min_treeid' field should be filled
     with value that represent the minimum value for the tree id.

Implementation notes:

    Ioctl BTRFS_IOC_GET_SUBVOL_ROOTREF uses the above mentioned structure
    type as third argument. That is the reason why a aproppriate thunk
    structure definition is added in file 'syscall_types.h'.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200803094629.21898-7-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        |  7 +++++++
 linux-user/syscall_defs.h  |  3 +++
 linux-user/syscall_types.h | 11 +++++++++++
 3 files changed, 21 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 169f98f7a301..728880b9f37b 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -206,6 +206,9 @@
      IOCTL(BTRFS_IOC_INO_LOOKUP, IOC_RW,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_ino_lookup_args)))
 #endif
+#ifdef BTRFS_IOC_DEFAULT_SUBVOL
+     IOCTL(BTRFS_IOC_DEFAULT_SUBVOL, IOC_W, MK_PTR(TYPE_ULONGLONG))
+#endif
 #ifdef BTRFS_IOC_SUBVOL_GETFLAGS
      IOCTL(BTRFS_IOC_SUBVOL_GETFLAGS, IOC_R, MK_PTR(TYPE_ULONGLONG))
 #endif
@@ -248,6 +251,10 @@
      IOCTL(BTRFS_IOC_GET_SUBVOL_INFO, IOC_R,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_subvol_info_args)))
 #endif
+#ifdef BTRFS_IOC_GET_SUBVOL_ROOTREF
+     IOCTL(BTRFS_IOC_GET_SUBVOL_ROOTREF, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_subvol_rootref_args)))
+#endif
 #ifdef BTRFS_IOC_INO_LOOKUP_USER
      IOCTL(BTRFS_IOC_INO_LOOKUP_USER, IOC_RW,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_ino_lookup_user_args)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 48ebf56d0f36..b025032626a3 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -981,6 +981,8 @@ struct target_rtc_pll_info {
 #define TARGET_BTRFS_IOC_SUBVOL_CREATE          TARGET_IOWU(BTRFS_IOCTL_MAGIC, 14)
 #define TARGET_BTRFS_IOC_SNAP_DESTROY           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 15)
 #define TARGET_BTRFS_IOC_INO_LOOKUP             TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 18)
+#define TARGET_BTRFS_IOC_DEFAULT_SUBVOL         TARGET_IOW(BTRFS_IOCTL_MAGIC, 19,\
+                                                           abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, 25,\
                                                            abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, 26,\
@@ -994,6 +996,7 @@ struct target_rtc_pll_info {
 #define TARGET_BTRFS_IOC_GET_SUPPORTED_FEATURES TARGET_IORU(BTRFS_IOCTL_MAGIC, 57)
 #define TARGET_BTRFS_IOC_LOGICAL_INO_V2         TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 59)
 #define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IORU(BTRFS_IOCTL_MAGIC, 60)
+#define TARGET_BTRFS_IOC_GET_SUBVOL_ROOTREF     TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 61)
 #define TARGET_BTRFS_IOC_INO_LOOKUP_USER        TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 62)
 
 /* usb ioctls */
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 6e64e6c4f57c..851010c78104 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -414,6 +414,17 @@ STRUCT(btrfs_ioctl_dev_info_args,
        MK_ARRAY(TYPE_ULONGLONG, 379), /* unused */
        MK_ARRAY(TYPE_CHAR, BTRFS_DEVICE_PATH_NAME_MAX)) /* path */
 
+STRUCT(rootref,
+       TYPE_ULONGLONG, /* treeid */
+       TYPE_ULONGLONG) /* dirid */
+
+STRUCT(btrfs_ioctl_get_subvol_rootref_args,
+       TYPE_ULONGLONG, /* min_treeid */
+       MK_ARRAY(MK_STRUCT(STRUCT_rootref),
+                BTRFS_MAX_ROOTREF_BUFFER_NUM), /* rootref */
+       TYPE_CHAR, /* num_items */
+       MK_ARRAY(TYPE_CHAR, 7)) /* align */
+
 STRUCT(btrfs_ioctl_get_dev_stats,
        TYPE_ULONGLONG, /* devid */
        TYPE_ULONGLONG, /* nr_items */
-- 
2.26.2


