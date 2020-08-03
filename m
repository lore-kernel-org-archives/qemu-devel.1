Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B821C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:50:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD8D20672
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="VWM+WPSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD8D20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2X74-0002Sq-QB
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 05:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k2X3j-0004A5-8z
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:47:07 -0400
Received: from mail-eopbgr10121.outbound.protection.outlook.com
 ([40.107.1.121]:11844 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k2X3h-0008SR-74
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:47:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F99uyOTnYs/LIFJFoENXza6Ir4wgxtkFjSlqKfQaUzPIBGft0FeQYVOMJjEBsx6UFIi5kbe65jouiQS5c7yVg01iPBaIKaVIdSoA6EPdmjh+UW3DvnWja6RZZalLLj5PQ28TlZMfZVw7a6IU2k2kt7uhwnLG9bK9N8sTI99Ex0NTOoDhs6TH4a2gw8OttfWT8Jcr+OHm0aYPhxZTO/XogtQknUNv8Z+fE4IzJjhd35Kr91lxN2hGBJXP0KwVWLBDtyry3kBvrz5OQmQozMI0bB5zhatlUXUVP9ky1CBTsG1H7ERg9vVxyQYTUDgTjfgSKoDPAeLwKO8jetoyn+sl3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhS1NpwTJxUYP9y/CkbfwRbqip7kOfnpZQJI9dp1vrg=;
 b=WhUIATZlE+suxN3ZV5UN/k+LEHoSdnk6WGrXvsDqhij8g0uQZO5reO1L430paKJyaqzk9pxVM9Friaf6I/48WjVPvhM9oymnMNXrNaxGe6/6TCDtlJeWZmEacxybOmQ0lUCnv3Zo4ruYllqmrA0AjZ8W9v8POxdNtOokOMbqNLgxtMvELMGUCYrM8FGgWDsR110aEQ+IitNkFho4HtyKna64ejqUqWQV7yH48UqFitRpSpGSpVoMhb2Ph6M47rf2mlZqy1oBl41nZRNYpV13RDvb6G0eTV7eNbeMFCWGqPQlRiv3GAIz+pW3Ae/uOukMqj69JMsn9Ttji/oeTSdzuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhS1NpwTJxUYP9y/CkbfwRbqip7kOfnpZQJI9dp1vrg=;
 b=VWM+WPSosrS8OctS2LqtfVnDf2wOKcXIQcNJ53gvF5PM1zqEpzvbuhQBEVVv4mTrUJkr6nWUCz3f6n5Em1uZQIjt+xmGzCYCg1Mln95Sl6TRc6PGa7lxHtKMykywUUMVZXVPr/UUR1r8xL0Fgh0y/cUd6hOkdq7XsrLNL8PsVg8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5457.eurprd03.prod.outlook.com (2603:10a6:20b:cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Mon, 3 Aug
 2020 09:46:50 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 09:46:50 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 7/8] linux-user: Add support for btrfs ioctls used to
 manage quota
Date: Mon,  3 Aug 2020 11:46:28 +0200
Message-Id: <20200803094629.21898-8-Filip.Bozuta@syrmia.com>
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
 15.20.3239.19 via Frontend Transport; Mon, 3 Aug 2020 09:46:49 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.238]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44e1ef88-e9c6-4560-5b2b-08d8379224f2
X-MS-TrafficTypeDiagnostic: AM6PR03MB5457:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB5457256398832E3430B4D0D6EB4D0@AM6PR03MB5457.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wcT1GxrivVBHbGWCLQe8XNTSQ2bRIL6Cs+bC47vpsqjCvf1OuPV1HiwH2wmy+iyy32oqcOLtolhsHdjAM1Pc/CdD/NSvbSRkenwD+B/GjbSCi7DkPzjVEUKXjZpV1ufHDDD/Zq8hp0bY1kbXo2X/aujZe97FBSIWTIqNhCvVpFKofuRfMmYIPQOBm8nV2cKosWNFOHtTWce9kPbWDIpuE7Ahezw9WO/rm5SwRBCGMOYyIZmoLfQQ7EIUnDT5CQXjRm6kr1HqJxz9/LjsXfbQ+6tZfImvtzav9DlWUEPOsbJ/Fuo6xgX8W6q4oojrWHptF8hWLNbmSRvMjIGYjDma3Y2XWSlvcZkUx3RKUnIY9rmMDLmcBsGtSGH7SC+ax4+cgO1tLNyL0J3gRLBTTiBp6uSG975H1YYbP41lFukK08hNrPLg/BVl+f/6cIPl1sN2WxTPJBJRhWX6xnNjwBiomg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(376002)(39830400003)(346002)(136003)(366004)(66946007)(6486002)(6512007)(6506007)(66556008)(66476007)(1076003)(6916009)(86362001)(186003)(8676002)(2906002)(316002)(26005)(15650500001)(69590400007)(8936002)(16526019)(36756003)(107886003)(956004)(2616005)(52116002)(83380400001)(54906003)(966005)(6666004)(4326008)(5660300002)(508600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: dlXAw9RoGnMeOAlL+pPmclPvpavSU4onWCIr7CepZGe9mUzC0o2hoCSSqdNzSn3QMnvm6KU+d/R4fKjCUHg4XllDsFX1Zf5OpOBlvF18zepPq/O5f4QbnxyIFbiLxUNqNkJ8VHo/euv33EpKnFcEdVMAtEEjyn/DM2w4pNspQ5jg5l6swO4AECDKyT99pAJFuH5576OiOV6Da87JofZQ1mxHti6e7Rb+FPl0/CiIhSGyt/+NDrMiX4bOSdO5Aw4/X5F3tOXloI/YZpUN7faOaQaZiyOp3gL4a+j4xMRvMajoUvL0JiIeJ/fElx0r7G3pCYp4xhQhuDigHj7Szo6yyizeVY95/CPt99brY5rrnEevJ1fepklOPV68w+C1xx1aqMXHPt085EKtBcMT7LhDyY3jgzzn7cJb79DVqhd260r5yEqHGP/OVCDhtyFfmG4RJsp9DS0eM6dCN+KkyyNyJ6cQ1AbuECmoJT32s3Y8OHuTvHlWyXwgCW8bvWJRrpQVEo/c17I92tpFOdWRkbgv9c/F5sx9K21qiYKa9Sm3Z4bx38VbHQwnWX9x/pDD/NsQtS7ENyxDsv4MrAhNaNKks0M21N1g7GfaE3Hiqh3au/Paw8okgPkY+aHM/T89Ifq0KbjrXGvbrlgp7vzj+zirCA==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e1ef88-e9c6-4560-5b2b-08d8379224f2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2020 09:46:49.9180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9YWidtC1XIwdEnar4XkirQaMz0HxLGXTlFIQZxrE59S2Sg7dp5JQetPUhxtJY3HzxAxOZQSmQqb2a5Ad8spCg==
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

This patch implements functionality for following ioctls:

BTRFS_IOC_QUOTA_CTL - Enabling/Disabling quota support

    Enable or disable quota support for a btrfs filesystem. Quota
    support is enabled or disabled using the ioctls third argument
    which represents a pointer to a following type:

    struct btrfs_ioctl_quota_ctl_args {
	__u64 cmd;
	__u64 status;
    };

    Before calling this ioctl, the 'cmd' field should be filled
    with one of the values 'BTRFS_QUOTA_CTL_ENABLE' (enabling quota)
    'BTRFS_QUOTA_CTL_DISABLE' (disabling quota).

BTRFS_IOC_QGROUP_CREATE - Creating/Removing a subvolume quota group

    Create or remove a subvolume quota group. The subvolume quota
    group is created or removed using the ioctl's third argument which
    represents a pointer to a following type:

    struct btrfs_ioctl_qgroup_create_args {
	__u64 create;
	__u64 qgroupid;
    };

    Before calling this ioctl, the 'create' field should be filled
    with the aproppriate value depending on if the user wants to
    create or remove a quota group (0 for removing, everything else
    for creating). Also, the 'qgroupid' field should be filled with
    the value for the quota group id that is to be created.

BTRFS_IOC_QGROUP_ASSIGN - Asigning or removing a quota group as child group

    Asign or remove a quota group as child quota group of another
    group in the btrfs filesystem. The asignment is done using the
    ioctl's third argument which represents a pointert to a following type:

    struct btrfs_ioctl_qgroup_assign_args {
	__u64 assign;
	__u64 src;
	__u64 dst;
    };

    Before calling this ioctl, the 'assign' field should be filled with
    the aproppriate value depending on if the user wants to asign or remove
    a quota group as a child quota group of another group (0 for removing,
    everythin else for asigning). Also, the 'src' and 'dst' fields should
    be filled with the aproppriate quota group id values depending on which
    quota group needs to asigned or removed as child quota group of another
    group ('src' gets asigned or removed as child group of 'dst').

BTRFS_IOC_QGROUP_LIMIT - Limiting the size of a quota group

    Limit the size of a quota group. The size of the quota group is limited
    with the ioctls third argument which represents a pointer to a following
    type:

    struct btrfs_ioctl_qgroup_limit_args {
	__u64	qgroupid;
	struct btrfs_qgroup_limit lim;
    };

    Before calling this ioctl, the 'qgroup' id field should be filled with
    aproppriate value of the quota group id for which the size is to be
    limited. The second field is of following type:

    struct btrfs_qgroup_limit {
	__u64	flags;
	__u64	max_rfer;
	__u64	max_excl;
	__u64	rsv_rfer;
	__u64	rsv_excl;
    };

    The 'max_rfer' field should be filled with the size to which the quota
    group should be limited. The 'flags' field can be used for passing
    additional options and can have values which can be found on:
    https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/btrfs.h#L67

BTRFS_IOC_QUOTA_RESCAN_STATUS - Checking status of running rescan operation

    Check status of a running rescan operation. The status is checked using
    the ioctl's third argument which represents a pointer to a following type:

    struct btrfs_ioctl_quota_rescan_args {
        __u64   flags;
        __u64   progress;
        __u64   reserved[6];
    };

    If there is a rescan operation running, 'flags' field is set to 1, and
    'progress' field is set to aproppriate value which represents the progress
    of the operation.

BTRFS_IOC_QUOTA_RESCAN - Starting a rescan operation

    Start ar rescan operation to Trash all quota groups and scan the metadata
    again with the current config. Before calling this ioctl,
    BTRFS_IOC_QUOTA_RESCAN_STATUS sould be run to check if there is already a
    rescan operation runing. After that ioctl call, the received
    'struct btrfs_ioctl_quota_rescan_args' should be than passed as this ioctls
    third argument.

BTRFS_IOC_QUOTA_RESCAN_WAIT - Waiting for a rescan operation to finish

    Wait until a rescan operation is finished (if there is a rescan operation
    running). The third ioctls argument is ignored.

Implementation notes:

    Almost all of the ioctls in this patch use structure types as third arguments.
    That is the reason why aproppriate thunk definitions were added in file
    'syscall_types.h'.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        | 27 +++++++++++++++++++++++++++
 linux-user/syscall_defs.h  |  7 +++++++
 linux-user/syscall_types.h | 29 +++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 2c553103e6..8665f504bf 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -227,6 +227,33 @@
      IOCTL(BTRFS_IOC_LOGICAL_INO, IOC_RW,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_logical_ino_args)))
 #endif
+#ifdef BTRFS_IOC_QUOTA_CTL
+     IOCTL(BTRFS_IOC_QUOTA_CTL, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_quota_ctl_args)))
+#endif
+#ifdef BTRFS_IOC_QGROUP_ASSIGN
+     IOCTL(BTRFS_IOC_QGROUP_ASSIGN, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_qgroup_assign_args)))
+#endif
+#ifdef BTRFS_IOC_QGROUP_CREATE
+     IOCTL(BTRFS_IOC_QGROUP_CREATE, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_qgroup_create_args)))
+#endif
+#ifdef BTRFS_IOC_QGROUP_LIMIT
+     IOCTL(BTRFS_IOC_QGROUP_LIMIT, IOC_R,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_qgroup_limit_args)))
+#endif
+#ifdef BTRFS_IOC_QUOTA_RESCAN
+     IOCTL(BTRFS_IOC_QUOTA_RESCAN, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_quota_rescan_args)))
+#endif
+#ifdef BTRFS_IOC_QUOTA_RESCAN_STATUS
+     IOCTL(BTRFS_IOC_QUOTA_RESCAN_STATUS, IOC_R,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_quota_rescan_args)))
+#endif
+#ifdef BTRFS_IOC_QUOTA_RESCAN_WAIT
+     IOCTL(BTRFS_IOC_QUOTA_RESCAN_WAIT, 0, TYPE_NULL)
+#endif
 #ifdef BTRFS_IOC_GET_DEV_STATS
      IOCTL(BTRFS_IOC_GET_DEV_STATS, IOC_RW,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_dev_stats)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index f1718ac521..1b1b2c2d96 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -985,6 +985,13 @@ struct target_rtc_pll_info {
 #define TARGET_BTRFS_IOC_DEV_INFO               TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 30)
 #define TARGET_BTRFS_IOC_INO_PATHS              TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 35)
 #define TARGET_BTRFS_IOC_LOGICAL_INO            TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 36)
+#define TARGET_BTRFS_IOC_QUOTA_CTL              TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 40)
+#define TARGET_BTRFS_IOC_QGROUP_ASSIGN          TARGET_IOWU(BTRFS_IOCTL_MAGIC, 41)
+#define TARGET_BTRFS_IOC_QGROUP_CREATE          TARGET_IOWU(BTRFS_IOCTL_MAGIC, 42)
+#define TARGET_BTRFS_IOC_QGROUP_LIMIT           TARGET_IORU(BTRFS_IOCTL_MAGIC, 43)
+#define TARGET_BTRFS_IOC_QUOTA_RESCAN           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 44)
+#define TARGET_BTRFS_IOC_QUOTA_RESCAN_STATUS    TARGET_IORU(BTRFS_IOCTL_MAGIC, 45)
+#define TARGET_BTRFS_IOC_QUOTA_RESCAN_WAIT      TARGET_IO(BTRFS_IOCTL_MAGIC, 46)
 #define TARGET_BTRFS_IOC_GET_DEV_STATS          TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 52)
 #define TARGET_BTRFS_IOC_GET_FEATURES           TARGET_IORU(BTRFS_IOCTL_MAGIC, 57)
 #define TARGET_BTRFS_IOC_SET_FEATURES           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 57)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 6bac8f46bb..2f5bad808e 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -400,6 +400,35 @@ STRUCT(btrfs_ioctl_get_dev_stats,
        MK_ARRAY(TYPE_ULONGLONG,
                 128 - 2 - BTRFS_DEV_STAT_VALUES_MAX)) /* unused */
 
+STRUCT(btrfs_ioctl_quota_ctl_args,
+       TYPE_ULONGLONG, /* cmd */
+       TYPE_ULONGLONG) /* status */
+
+STRUCT(btrfs_ioctl_quota_rescan_args,
+       TYPE_ULONGLONG, /* flags */
+       TYPE_ULONGLONG, /* progress */
+       MK_ARRAY(TYPE_ULONGLONG, 6)) /* reserved */
+
+STRUCT(btrfs_ioctl_qgroup_assign_args,
+       TYPE_ULONGLONG, /* assign */
+       TYPE_ULONGLONG, /* src */
+       TYPE_ULONGLONG) /* dst */
+
+STRUCT(btrfs_ioctl_qgroup_create_args,
+       TYPE_ULONGLONG, /* create */
+       TYPE_ULONGLONG) /* qgroupid */
+
+STRUCT(btrfs_qgroup_limit,
+       TYPE_ULONGLONG, /* flags */
+       TYPE_ULONGLONG, /* max_rfer */
+       TYPE_ULONGLONG, /* max_excl */
+       TYPE_ULONGLONG, /* rsv_rfer */
+       TYPE_ULONGLONG) /* rsv_excl */
+
+STRUCT(btrfs_ioctl_qgroup_limit_args,
+       TYPE_ULONGLONG, /* qgroupid */
+       MK_STRUCT(STRUCT_btrfs_qgroup_limit)) /* lim */
+
 STRUCT(btrfs_ioctl_feature_flags,
        TYPE_ULONGLONG, /* compat_flags */
        TYPE_ULONGLONG, /* compat_ro_flags */
-- 
2.25.1


