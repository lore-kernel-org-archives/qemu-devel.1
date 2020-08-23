Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB980C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 19:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936AD206C0
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 19:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="OCfVT4na"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936AD206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9w3H-0007as-KF
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 15:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k9w18-00032B-Jk
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 15:51:02 -0400
Received: from mail-eopbgr80121.outbound.protection.outlook.com
 ([40.107.8.121]:48453 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k9w16-0006Ij-Gu
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 15:51:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ov6Hy8skZmv7nCMBZqsE8dwTGn9v3EhMdkkL6L1Jdivf6z7slx36/ViC0SGxqHT5xbWKjD9bxBN6ReYnvWHvHIdthhsYfx97jFbIb3QhrjOeRkJGfRif6atQKoZo89KSyH6iDXiFF/AFBoK9anYkfd6sYsZuaMfcXbaJdH+UaMC4ajSOFHTRxbySEEn9BAQejhJH/OHV73V1RU89xKZN7UM/m5qr/Uli+BjkDSloGbbxYsYIuzlBfM2qYGJ/F6dQX/C2kjgz65xjc2ozEnjY5/OiOm3DYqNpM5wS0hBqrYuA2jV5YLKzuMGkKHePihZBQFhSBLg4febM1qajnxWYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZj5X/yzm2TvdUGiV7TP6l/ue08FAY3vkEO4PgDIWas=;
 b=eW8LEorYj7Lj5XcN6dCMXSvuHvoDmRGwn1W6u76fsS4JlN14pu6M3sJ5faQFMwqdmEdBSgVmgHhGLMkodvs0Cga/+Hu2YvKHsSmWssA3WsPeEdo0d7htZ3M03H1EX6yzWefYHHUXgj4qP/7PNuHRWl7xoBSD5RQA4FhMY1EZGdUQpliPEr7kOTEFGHy9E9aIaLsFgiCrqCVfOjUDk5nazH3Dsw8zvmNMdh5+Fh+joRrzWU+iTH1SFIBbdRfMmGXow5TxYZ6pr2IeihQ3eyusn5qDUKL2eB5U6GgA1ss1jh7LQAGXjcRKdI+iAe8dBMGWVBw6bTJLI6lMYEUZWn26XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZj5X/yzm2TvdUGiV7TP6l/ue08FAY3vkEO4PgDIWas=;
 b=OCfVT4natuKfbv7Jbd3QZT5MNdEp5D4vM1XnmAi485T096wWYE42USOA7abNSPovhZCdcUy7gl97M/bvKSN7W54LtwlByA9ihAm2Cqt6YQJbHkh/ZZQv9PUtP8sDdcRofwAB6GdmXm6Ar4xnl+1MU/+Az1FQOPhf/plP019p21Q=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB6143.eurprd03.prod.outlook.com (2603:10a6:800:131::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Sun, 23 Aug
 2020 19:50:39 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Sun, 23 Aug 2020
 19:50:39 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 7/8] linux-user: Add support for btrfs ioctls used to
 manage quota
Date: Sun, 23 Aug 2020 21:50:13 +0200
Message-Id: <20200823195014.116226-8-Filip.Bozuta@syrmia.com>
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
 15.20.3305.24 via Frontend Transport; Sun, 23 Aug 2020 19:50:38 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23751bda-58e9-43b9-80fb-08d8479dcf93
X-MS-TrafficTypeDiagnostic: VI1PR03MB6143:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB6143402DB41402AEC091BCD2EB590@VI1PR03MB6143.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TxeJoPLJJbJfaYl8ciCTtCVra11iC4rYWqVLYdcKLvWzHN3YOn4T6tsdjk3LqIlzGwhCbMD+cut5+KagvoRKS2nFLspZRUeGwMWeSQKJmP5Uw84rbVIZi/TnQMM1gh4ZSmN3A82nl2xvDKymOHi4TQl1eykzlgOsR3wU82rkTIgiPeAYL7HQUWzF4Y2SX1QcHRG+XQURsDKbQxl3Pr7eHxRaThOeshyAlIqCrmBzWmQa/eAU0u26qnD1vqfVDTXU3U9OP/RCCzB3WVhwgDXGcywGREnNt2tmvulYIc0jUluoNIhDAIfMXEpx5yRjtByVc67N/3uKLRVL+3YZpw8EfhFv58JduzEZmnfhggOex+UPLkiJFhxH8B5QIy4R7kPgZaWikeammot7pmWuLb/XEOu1x6DgZMkcyTA3oHUDn+zcZPYZkvNstHMpzZ7LALv8tWSAHb0aOSmV3GVWfEGJWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(39830400003)(136003)(366004)(396003)(6916009)(8676002)(15650500001)(8936002)(6486002)(4326008)(66556008)(2616005)(107886003)(6666004)(66476007)(316002)(956004)(6512007)(66946007)(36756003)(54906003)(5660300002)(186003)(26005)(52116002)(6506007)(478600001)(2906002)(86362001)(966005)(69590400007)(16526019)(1076003)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: YlkhzHDg+cp0P5eBUHyHrbYa8gLqGSssgT+fTt6vmtlGNAhreuXqvLQPyKtGk5N2UyulsKnDR9USzb1UDY1xdWNXLMuc/4q3bKeJkTFA1MYX2TO5jfaykLYhHd9wMw9r/8K9h1gM2s0R/Aft2OC0G30MDSfciL7Tl5v1zIviFzeaWELGLTkRLATaBcLgIIKi5joJ9p+LM6+nKbHI53RuFrW2DrUnsCcQlLTOmFL6W6a/k5J9HCyNyR+2vFQ+KNWkBW6evNXAI4sqsn4cGRrP4c3/lmeSJZFkjxFuUPoUvYTUdOQtDz0mxIa1aNHiCNf/mwq0U2O+W4DxGCN++HbMGj0rLtgVSZRKNHcfy59ePoxiqyjFmU2tyFKuuWSqXhr4SedODBB2UJoc4cDIRzHDETU4BO5Q433z9dELAmrWvNq/Ent7jFhrtigJwu0dSAzTpOxo37bfSSOGDwdXjnb15S905i6vcRyBfLR8tLHn7m/X7l9Wj/xrhL+SBUiOpD1/iuxifRf7XYz8St5cQoqzIPtYLyw1D+CkLdCdNQ6t8igTqalupJAK2E5z/jlD+gkmcSmftxsjuKICLaWOiteETb7zgdn4ilvetGZJARjh+LZjjJNpoa54O5OGL/qznyYxYlh1GZrfMGQ39LX4WeP7Jg==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23751bda-58e9-43b9-80fb-08d8479dcf93
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2020 19:50:39.3721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZBACjUGLrilebK5HnHWbVkLzCpu0VjVauh5PrVHPlMm+Zlm0ynEjqi3qKS1TGVRhGo9I9L5L1IK4FuIH7LTHw==
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
---
 linux-user/ioctls.h        | 27 +++++++++++++++++++++++++++
 linux-user/syscall_defs.h  |  7 +++++++
 linux-user/syscall_types.h | 29 +++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 728880b9f3..882bfb3e88 100644
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
index 1d0bfb5479..10a7f91016 100644
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
index 5566d101c2..d9b7106a69 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -454,6 +454,35 @@ STRUCT(btrfs_ioctl_get_dev_stats,
                 128 - 2 - BTRFS_DEV_STAT_VALUES_MAX)) /* unused */
 #endif
 
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


