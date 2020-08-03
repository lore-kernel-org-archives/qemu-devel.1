Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8E2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A949A20738
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="ILNClymh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A949A20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2X4T-0005Oy-LP
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 05:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k2X3W-0003jk-2v
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:46:54 -0400
Received: from mail-eopbgr10121.outbound.protection.outlook.com
 ([40.107.1.121]:11844 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k2X3T-0008SR-DQ
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:46:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvYaFA6WsZ6FKY5BUVlaLn4ybVOPFGk82fzFtDBTb/UGxCoItSQ0RqX+C4rHXkWJEW1YdCLfQWr8DesTTaChSPWxDLn4bYkUm6GSpZC6r4etAMrCXhHNxcrGfC/6EjqL8dSqkPvg5qP/BU7tShNXX5h+C0wSfKL/SNcSoQ2bcdTiIaoj3/D1fo2K3kqGv5iljItpUhxn48y//grgNhwAj4nG5OQ7L1UmjhPXiPwmvvPxjqQcpyPfGY5/nYCtOUBqajulFtuE7sGGEDa5LWax8ExlB7RIucV4ODF9d6Monj8qrLZjdxt+gQ0rghR4D0+1VhWS6/i2D3k+xNBS+PI8pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyaRN+/0hy3k5uK9C2+MFZPFoiKjoCBM5lVwqYoarlQ=;
 b=oVso5aIdiN5EfDEdg7+mGubUdOFkSiO7TsZm7qg3QkH/i6y9bYr5E5WNZGKME0/RACFP7F9BclB1LrhCqcqiT4RZz8h4hGkNmXb6lvbFhdHRc3hrVXD3IE6+0oGMyG2GOiYqy8SCi7/TgeW4fwjwz6aA7dxuOP5lFrQlbC9HQXcmsqAtrSEMLNco7Ft4DVYJ3PeBTrmtC9Pq6GuZTmjUmm+Fp9FZAn5RftCw4ixvGX28+Q3KmCfHhjeKCZNb8mE/EEyPmayKIJJ5BwXi9sWUm/wDg/scM4F+nW/xlWXcdc7XAzPh4PbBgUBENDzhi/Cb3FuVk/7BBq5xfJsloodDpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyaRN+/0hy3k5uK9C2+MFZPFoiKjoCBM5lVwqYoarlQ=;
 b=ILNClymhoa0z7UpYuQ+lXB/CTQdkof3aEWt99bCvlxODmWs8NmCoXG855KEOl2IBZGuxFf3TwZCfBm3ebm56dmCFdrwT6ZZ+XVb2h+WjrxC3uFKMOMtcDp1cWIE9jH3sgbKptv3ZbFCWV4PjZYcW9yNQq0gSMU3N+Bx86LRbcE8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5457.eurprd03.prod.outlook.com (2603:10a6:20b:cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Mon, 3 Aug
 2020 09:46:45 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 09:46:45 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/8] linux-user: Add support for a group of btrfs ioctls
 used for subvolumes
Date: Mon,  3 Aug 2020 11:46:22 +0200
Message-Id: <20200803094629.21898-2-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803094629.21898-1-Filip.Bozuta@syrmia.com>
References: <20200803094629.21898-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0051.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::20) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.238) by
 GV0P278CA0051.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:29::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.19 via Frontend Transport; Mon, 3 Aug 2020 09:46:44 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.238]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd89add5-9ff5-4a62-9ff5-08d837922206
X-MS-TrafficTypeDiagnostic: AM6PR03MB5457:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB5457DF41D67790F2BAD205EBEB4D0@AM6PR03MB5457.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WNpSp159FO2N5W4caPhDehKTva0PfplazxzaCcFMvfqgXBNc+AbrPYaayjL7i0MFv6HgoUvkfKv4AUlQ9MKk0Y/N7+LP8ioOWysvlfx0rSxbrkiE0zAtYe3Y/ghjwm54wDiyQ1vUEv+4I9rbm8ZxNYY33bsT0S9jAtdWDI0VF0m3g3LCFIXFwXZu959czlFOga080yMys4v0i9s4zW46ID0f7/LyFNwyve5aQqg1j3qxmupBNKarAS8+IEhwhkqzJ2jzNq8ksf2KmABZJvgSaRUMUgt2zdPtr+3v5pDZyblu/l7SF1zgnf5nWMXn5RIr1uNEt9146KD40K3tlGjrCynw329CAzUs59V05y49Ksi2mj5NoToYlXL+7DwyKz+i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(376002)(39830400003)(346002)(136003)(366004)(66946007)(6486002)(6512007)(6506007)(66556008)(66476007)(1076003)(6916009)(86362001)(186003)(8676002)(2906002)(316002)(26005)(69590400007)(8936002)(16526019)(36756003)(107886003)(956004)(2616005)(52116002)(83380400001)(54906003)(6666004)(4326008)(5660300002)(508600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zmWpcHGZki1Shw/rNJsnYZ+XIn6fS5DKDvVRGynnIfsHbVe0Kx8XUm1NG0CqxzovgjzQoXI2twSu4C24qL/c+MD6kmHmmSaTrUSnUoQiIck6MhyBPyF91odXGRZJXKGXQ3QwyLk/uvpqNOz/uifkevz8N7LZDN7L4mdXNG3v8ChaDBRlLfTjWPCQYd2q2C+RQbzUyA06up5XrDezCFc/4+pn2U5Yc/p6Mu/vcfgNNZ7I08hJgfWIKQTnX8zkKUBtXvVDW9ST4qU3umbV9rZ/kL3xvjMosOmZOdpA19ChEymrRLnOd4kddxonXWqyyUvfadkThVRcbRABQKM7n6YSIBe+mj5csybLC4+q5cRkMS3n//nm5HxdJM3bIzdkpCgmXsKHEUmDWwywnquO85Sh9gYh9Gru0XFAbzWcxWslxYszT4bV7Kc+oDxGCYjWciWdC7NsRP7jLUosRw4yydsguN452TNz//VphMYwatbbMlkA/AZZtsTjkobVl7C70hQPX2ETQwG/5pPlBseApDwswwMU3/6G0aavrTH1lUCtv/bHBh2hjmyiraQ7cVpfxWd6zO/lPuEllJRk2oy0dzLdg7izpblOMMRsb4vt8LBe+o7Yt+uy/9ln6xHnVB41hnowJvcM1xdKckES9a+AlGaJuA==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd89add5-9ff5-4a62-9ff5-08d837922206
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2020 09:46:45.0896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: suBPzv686qy8SIpq5TCfScoenr1lI8SAUqmNHxHUzxAL9UYGosrqXxK6V1c0kXd3W+ymbslGNOrXZqOF4l+VSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5457
Received-SPF: pass client-ip=40.107.1.121;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 05:46:49
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 configure                  |  9 +++++++++
 linux-user/ioctls.h        | 15 +++++++++++++++
 linux-user/syscall.c       |  3 +++
 linux-user/syscall_defs.h  |  8 ++++++++
 linux-user/syscall_types.h | 28 ++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+)

diff --git a/configure b/configure
index b969dee675..8b3b214031 100755
--- a/configure
+++ b/configure
@@ -4945,6 +4945,12 @@ if check_include sys/kcov.h ; then
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
@@ -7057,6 +7063,9 @@ fi
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
index 0defa1d8c1..544184ff95 100644
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
index 05f03919ff..4a65b28999 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -112,6 +112,9 @@
 #include <linux/if_alg.h>
 #include <linux/rtc.h>
 #include <sound/asound.h>
+#ifdef CONFIG_BTRFS
+#include <linux/btrfs.h>
+#endif
 #include "linux_loop.h"
 #include "uname.h"
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 152ec637cb..67a3c110b6 100644
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
index 4e12c1661e..75ce6482ea 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -321,6 +321,34 @@ STRUCT(blkpg_partition,
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
2.25.1


