Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE42C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A1920775
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="NNqb916a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A1920775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwRfK-0002et-50
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 10:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jwRbo-0006sG-JE
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:45:08 -0400
Received: from mail-eopbgr10133.outbound.protection.outlook.com
 ([40.107.1.133]:52288 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jwRbm-0004y5-9j
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:45:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TT/OSjwutmN6Zn6o50FyaccXPMb76ij5oNDYw29LNvFregxA3luzu0AZ5+MqvZeHr4EQ2RVeUBIwF6WGF3NQcFKd6p1pMdOQgSn3Xc2yMHAHLd8Ckc/gUpEL3Cww/jVFzMPbmlc+hAWahB17bRRvbRSjr4PCRId6kkbiZXO0+im/Qwskjd4/gQkAkQYyQ6/SlYdpfJodufL8iKgdcXwzAcIbDQgsp7CkB4fBh6wTxt9B1WwEaQQReRLevd5/OFsEXL86o6PN0PcrBT13EvdeJDcwE/Z58OzgB77NwFKRmtjoVEXjTQRJ8WanbtCSGxsq6j5bYD24yFPxp0lmGkfTpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmHhL7GcvkKBxugC4VqJCDbgFore0gGYX5hVPRxUUAo=;
 b=UldkREBqCxxtSIscCdP9GQuRoJFPoyP862ueDFrPboPY6sdJ/rY3RDbtLF4NumN1qp/zEthnvKOTA6b6p3SrAKdMOHjFdVvXUh5RcWCqrzLuMijrtH2HpLve21CdD/1vzhOGg2LomTj/HIsqrz0i6DTgWKVLWPGLxtYcxQbsakT30mDm7msfD2o00r6co+rYAaRW1jUG+dstlKdIertKXcctkXwBZ0Wwk32C6KwDrvAPAJwN1jL9zcwxxrKOsvYCvajOTm3zR0cQVlaUqKvqfJVjTDnk8JcDRLsq7Vlb5+WDGpoaGwAUf+x0EfEp4CnV2VzfOyOCUa1xAA5TWQEtuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmHhL7GcvkKBxugC4VqJCDbgFore0gGYX5hVPRxUUAo=;
 b=NNqb916aqZmmTxElY1O2vIiqVX4UDl3ZvX7EcrlulvPo8/HFNJHg+ej2gXDZybcZ0q3QA3JmBfEhOFbRZvnO1310K9hESEH8sbZD2gM78NvwTQBwq0EOzguoY0HdTcL3xOio67sW/0PAG6Gd/dfc1Tgc/omQyeAGJYx2qnShxIs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB6414.eurprd03.prod.outlook.com (2603:10a6:800:19e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 17 Jul
 2020 14:44:56 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::ad93:b959:82ec:107f]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::ad93:b959:82ec:107f%3]) with mapi id 15.20.3174.027; Fri, 17 Jul 2020
 14:44:56 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] linux-user: Add support for btrfs ioctls used to
 manage quota
Date: Fri, 17 Jul 2020 16:44:34 +0200
Message-Id: <20200717144435.268166-4-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717144435.268166-1-Filip.Bozuta@syrmia.com>
References: <20200717144435.268166-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0028.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::15) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.239) by
 GV0P278CA0028.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Fri, 17 Jul 2020 14:44:55 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.239]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db264d0b-d098-4070-e0a2-08d82a5ff8e9
X-MS-TrafficTypeDiagnostic: VI1PR03MB6414:
X-Microsoft-Antispam-PRVS: <VI1PR03MB64149CE4209818A242032ACEEB7C0@VI1PR03MB6414.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0s/858gtuYDrFtof7J0GY0kdE/pbvHWQR6LPsu3UnQ2XAGEjj5k4ZbhTeQAClx42QpW3qiXWVls+FGRIw5E41FoKhILtEnUR1JcKiyvxFz/RfRQKHGXQFHAA+7SzUG4+7/vIwg6RuptbAIptcfaVJw1wQWcX3baJ87ZB5zTpv2olIHqDQTyu6HjjH8jW/S0kIkfL5K1f16iC5Q42eH2BWU51K8PSTNIBJXmz6Uz6rddmfPj8cBlTQUuLSSs0yRCCZpGGOTxP8zEALLB/2gn2Lp13wrQGebh1XMWLyCLVZPq+zYIAmKuzysImmwgCLOSdisFz746Z5Iy9y3msw4UQVke8M0dBRCwKhBeXnJPAuCncSh0FGKeLdeBw4nvpXmPp1rANEyVWLcFIc4aDMwDu+MgcmMEZVvh6k/RJsJ2mjvWXdeE7mkWrBpHJt6ysfnYUhx6Hf1xsFXn6N1R6RvdKJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(346002)(136003)(39830400003)(396003)(376002)(966005)(508600001)(15650500001)(83380400001)(66556008)(8936002)(8676002)(6512007)(2906002)(4326008)(66946007)(66476007)(5660300002)(26005)(186003)(956004)(6506007)(316002)(6666004)(86362001)(1076003)(6486002)(2616005)(36756003)(16526019)(6916009)(52116002)(69590400007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: a8vzyra4AHNKc25pTVnmDmX1L3Ry3c/ElVtdeMcLtO9i5lfooMFFiYypHDyRrCD7nLjCk7TuDN4h5+4DBoG/jmWAC85dHSc5Eo9fhuW2pLGNYP8n4druTIKpoLzb06a4T5n4QK9zNmTZjyVGBkwAsciriIJYTSbqyY24Pze3RMK0W1jBI722TFsKaQ+w4vVKtVGZaqi9sPT4fc3/G2pVBLpQ924k/0qZ8xg22RkU/QPNm+sb0XURmyXKkorIV6QzCATasnkq1xNmK2vX+jDpOy6EyDFtivH2w1mOWoxuaaw9W4Wx9h9mHZXMDsCjwb6fypieoxelg4pgCLbLT82B2GtvcjJ9jEvbZpvnX9dfhRvFx/MxXh9sJqxFDushamJ7VSbUOdohMBMKwb/jUnXE/7F+Dk6L6935y9Bbfo6uBmWJGw4COH2w+iGQpqRO9MK/OoC8nuoxhtTl+H296fy6bd6C6rD6WPuRAgRiflhnLjY=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db264d0b-d098-4070-e0a2-08d82a5ff8e9
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 14:44:56.2250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRHt1SRPf23e+Juvrfql2q00pbRvafbrg1pUmPNXrHn47pVUiRrlu3DoeP+XgN81oXTDFvai3VUrMI3IQh/bRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6414
Received-SPF: pass client-ip=40.107.1.133;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 10:44:54
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: riku.voipio@iki.fi, laurent@viver.eu
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
 linux-user/syscall_defs.h  | 14 ++++++++++++++
 linux-user/syscall_types.h | 29 +++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)

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
index f4b4fc4a20..3f771ae5d1 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -996,6 +996,20 @@ struct target_rtc_pll_info {
                                           35, struct btrfs_ioctl_ino_path_args)
 #define TARGET_BTRFS_IOC_LOGICAL_INO            TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
                                        36, struct btrfs_ioctl_logical_ino_args)
+#define TARGET_BTRFS_IOC_QUOTA_CTL              TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
+                                         40, struct btrfs_ioctl_quota_ctl_args)
+#define TARGET_BTRFS_IOC_QGROUP_ASSIGN          TARGET_IOW(BTRFS_IOCTL_MAGIC, \
+                                     41, struct btrfs_ioctl_qgroup_assign_args)
+#define TARGET_BTRFS_IOC_QGROUP_CREATE          TARGET_IOW(BTRFS_IOCTL_MAGIC, \
+                                     42, struct btrfs_ioctl_qgroup_create_args)
+#define TARGET_BTRFS_IOC_QGROUP_LIMIT           TARGET_IOR(BTRFS_IOCTL_MAGIC, \
+                                      43, struct btrfs_ioctl_qgroup_limit_args)
+#define TARGET_BTRFS_IOC_QUOTA_RESCAN           TARGET_IOW(BTRFS_IOCTL_MAGIC, \
+                                      44, struct btrfs_ioctl_quota_rescan_args)
+#define TARGET_BTRFS_IOC_QUOTA_RESCAN_STATUS    TARGET_IOR(BTRFS_IOCTL_MAGIC, \
+                                      45, struct btrfs_ioctl_quota_rescan_args)
+#define TARGET_BTRFS_IOC_QUOTA_RESCAN_WAIT      TARGET_IO(BTRFS_IOCTL_MAGIC,  \
+                                                          46)
 #define TARGET_BTRFS_IOC_GET_DEV_STATS          TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
                                           52, struct btrfs_ioctl_get_dev_stats)
 #define TARGET_BTRFS_IOC_GET_FEATURES           TARGET_IOR(BTRFS_IOCTL_MAGIC, \
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index d2f1b30ff3..b4f462b5c6 100644
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


