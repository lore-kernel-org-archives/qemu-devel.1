Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0FAC433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 19:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BABD8206C0
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 19:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="qbvx18XQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABD8206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9w1s-0004La-Rj
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 15:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k9w0u-0002pa-If
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 15:50:48 -0400
Received: from mail-eopbgr80121.outbound.protection.outlook.com
 ([40.107.8.121]:48453 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k9w0s-0006Ij-7R
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 15:50:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dr7ksiLxIC04cLePbRWAVIIpqf79porneFg3NYiexoriYqWms+ZP8aZcWGKh3lQfILrFWhk2yKjO/vf+wp15LcA/vNFwc10e7BydRZAN7lPtL8mdinmdRMksL9qQLz/6C83UuhAcVuCne9nuTp+MqnZ4L9SdxfErO8gQ+LtGhx6+GkvBPYIXcfYqsKVz6yJpearUnpt6zOgajkOrUVXgVeLbVo6ARv2ert0golM3XBS9AGigS+cnZvzhbPp+LT4IP8pcvxefsBxmjG8igednYNxdMtTY7oJq38dqvpu9OwmbabEieRIY47sbC9y1meeQ3928P3rV0isv9oiTZOI68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sq9ikh12NIexe7m/rE62YCu8WlM6W3wxRmGYGQ/souU=;
 b=gtN+rsUN2Hostj8Z5FME/+ZGOBF4yc0xhajTOjK8sar/TgPqZMh6HzvjKFtUKBMjhyVuiIo0vm5jPk5xRP4KmBWMq4mt6sahYSSmiU++OAYRnt9EXFqUX8GTOs5BySIIwH17iXZVUoRbIyoBM7tiHRTGKeIt8jTsN5GY/Qjs7A6SwlMhU18R7DUcV+OsEunQoC3DkIt/52xrP04+4m9sbVeYsGzCCVeQRi79ZFmm9+5BVuQfNxsrkYqD6ZxS8YrW8gaCyrryo9Nf1s6QMJSNwigjHljcZg2wtlNxGN0vof0601xVU224/5cr+V9WT/WMHcdmEXv+jbA3rg4jnAleVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sq9ikh12NIexe7m/rE62YCu8WlM6W3wxRmGYGQ/souU=;
 b=qbvx18XQIABuubuFfXtK7nldeRGil6AX7zVq3Rdp2QsldV6WyYO9drmEU7DPjgJu8mPl6/+pRP5Wf5cBW0mler9mCKDI8JTMJHaN9PdbuMdBHB72j6LRsfCVE8siOPz2RIaFS1M6OSEFqmLWtt4mbwB4OszbmKJYpPG3+/mg0a0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB6143.eurprd03.prod.outlook.com (2603:10a6:800:131::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Sun, 23 Aug
 2020 19:50:34 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Sun, 23 Aug 2020
 19:50:34 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/8] linux-user: Add support for a group of btrfs ioctls
 used for subvolumes
Date: Sun, 23 Aug 2020 21:50:07 +0200
Message-Id: <20200823195014.116226-2-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200823195014.116226-1-Filip.Bozuta@syrmia.com>
References: <20200823195014.116226-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0172.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::16) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 LO2P265CA0172.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Sun, 23 Aug 2020 19:50:33 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7da11d1e-b4ab-4946-d4a0-08d8479dcc81
X-MS-TrafficTypeDiagnostic: VI1PR03MB6143:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB614361DC749A1791A24A9DBFEB590@VI1PR03MB6143.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rRkPxlx+wBa/XtVDRb6KmcNuRuMG1qzcoqgGzuBvYjkt+jycDcCsuP6V7YvM0GINBeKYOBOZF29Fc1EcxcEuHZhL/kTyKtCmSwPmGYvpPfcABR2Z1Kh6Gm+r/gNnHsr6QH05VaSpuxOCNPJeVBmq0gBMfGQE5kFBKyUQ+n/cGj+9WJuL7bt8ypm1Huk6EpO1kpDEwY9sOZjeuf6cViqvIHMdVu32+7VSr4s/gXyhFurbfjx2S2IKCN0ReiDdMFO0jkDGE5brG44DHtpK5B1nEy/BuYD3cUVywGeoyvV6Ac7lk0Nal68GnBnUo+pse+FOgUlgSV/55UnXb8TpwXFYl/9bhE5nbHmzxRdwq+kGswH4VZWPbuK2ETaDI6PDOQmF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(39830400003)(136003)(366004)(396003)(6916009)(8676002)(8936002)(6486002)(4326008)(66556008)(2616005)(107886003)(6666004)(66476007)(316002)(956004)(6512007)(66946007)(36756003)(54906003)(5660300002)(186003)(26005)(52116002)(6506007)(478600001)(2906002)(86362001)(69590400007)(16526019)(1076003)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: NWe65CziyPEVe31P5XW9bMdkL1ulvZgWqp5Xtygnzv6wFeDKMN5y9B8oftKos0aWchZHAnuocykVqrcokOs0rbEB5VWdRQBEWVkFnLejbyTtdRXabPidKGJNwaZP4q5CfW9KJt+2idVcOjHmQWXHdmr75KcoKGtmT1UmSwpGZGG1OYZsAjIyg91aqRhTBn4sD80fKnT1Fs8FoksB8Viln+TqUHWxbDZcV9azOj8ZUo2MWTvqReTXBkZrJ2YDwsVL+zdSxex6vAhZ4jLjoVbJAJA0yWbZ2K+gtMqtOST1YBxeqgknTN0HtZF+47z6gBW9is/0BIR45waAnmO/llXyfi+hEnWvFVde+sLNkvOA0dRLMRQH2+RnYAH4MymOufo7lchWmLIPMCskCNLMqLHLmgR2mUhFywhxQH04Cm2LMXR15sK19NKcBwmi/4qIRLoOMoozCtlJQEY2hmmcUJL7B2tQWv+BjI6GUk0ham7bgul7yHrTsAcupoqOHvA0Dwol32OY8RKl08cRQ8Hawl4fQ+EAiuGxBNHGg5RMLA1uzkqfwuRevL6mFmWNSfLzLc41bmR8OfANg4d43xxK5Hh/IL+IMQ4HEU5c5Z4hmnz5Na8kB57W6pxYU5MIVC/CvbCO9gLigXl0fc/KaRtQx+4nzw==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da11d1e-b4ab-4946-d4a0-08d8479dcc81
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2020 19:50:34.2251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZLRh5e4pCYrar0uu1qB+LTywiN/bxC4CJ6QlSJFDYg6p4cxxiZ3hcTZtF7RjhQs1P89hubiK0gGp3F6+zwZmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6143
Received-SPF: pass client-ip=40.107.8.121;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 15:50:44
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 configure                  |  9 +++++++++
 linux-user/ioctls.h        | 15 +++++++++++++++
 linux-user/syscall.c       |  3 +++
 linux-user/syscall_defs.h  |  8 ++++++++
 linux-user/syscall_types.h | 32 ++++++++++++++++++++++++++++++++
 5 files changed, 67 insertions(+)

diff --git a/configure b/configure
index 4e5fe33211..a0747fe3ab 100755
--- a/configure
+++ b/configure
@@ -4954,6 +4954,12 @@ if check_include sys/kcov.h ; then
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
@@ -6938,6 +6944,9 @@ fi
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
index 0713ae1311..12d1444224 100644
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
index 945fc25279..36777c91b0 100644
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
 #endif
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 3c261cff0e..2757956dfa 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -967,6 +967,14 @@ struct target_rtc_pll_info {
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
index 3f1f033464..db61dbc1b3 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -354,6 +354,38 @@ STRUCT(blkpg_partition,
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
2.25.1


