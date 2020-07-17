Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CD3C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2067B22CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="pgu+pQpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2067B22CB2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwR30-0007JV-Ah
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 10:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jwR0U-0003ii-Of
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:06:34 -0400
Received: from mail-eopbgr30139.outbound.protection.outlook.com
 ([40.107.3.139]:44942 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jwR0S-0005Go-HN
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:06:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyHEHoD9ZS6jLHRoRTsOXOuaQ4uXIJ2JMq+4XrUw3HfWXKFR3lDDAoe1gqRwkuOS3iuC8boBkW9fSFxrFmseS69w/MPp2CrrT5q195VXs+V+eRQv0FnkHrZWoM+w9JjhQ8u4yPy65yCRJDSk9V+k8xn9cfpQBbWfLCfgWEbzC0Ml9xF0/KwZLQkKpnsgOyTSSRfevkuKg4XPiK50zeYO3/O9bQpBejysBNUjdNn5REWbDayoQwxgSrbR47GtEQxYC5KOR+w+GQv/2CZIonXaoUcja0p2R/3ArskPm5H1Negar5ItwB0z0A3Gg56c7VSrIqdTJYXO3tIYWQzsG8JUrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLj1po+MvWLh+9CqFXHAicsK8nQbwMNcO2fPt1Ggv6g=;
 b=IaAHGjMJp2FFNKJUQpHvAGHfVX6nac1j7aIeQ3E3q+TM/mu3ggx6BNOp6z5qCkdyOEVyoAi4q/jcA93z1QWZewS0gUnuSALzilH6pYr5LlSmjv0B57t4ir8e0qkVBhmmNM7vLKc6vTl0yy4V9b4UN/s1f16W2J8GczgmKmBLB7piHSTTssykm2mr+wVcHdKjuyWb1n9KNdlIOVg6U45j5PEbharTUcFn2AifJXNmFDAOxrVsNhKNB+KhH9S3UqOTRbIgaWLm7BBWPitaoBSNjpQxxYEfGP5nCxxneRAr2DLWURxcgkvysHXgdIiugEw+ZsoBw9t+W2KA56RZybvHvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLj1po+MvWLh+9CqFXHAicsK8nQbwMNcO2fPt1Ggv6g=;
 b=pgu+pQpU76xlSZ4dHbzmTdAMD5eSALgt+aJUZrKzeIU1GRPJ7ZU8s7JYOLEzdwVSqYzBg0Om7MelR+uw62VXrk4ANBHCS3IPLOnyG//3BE+hVOYupCMIA6ldg2KJcjZxzzrUjNz5lU3Fqyaa+8UBBVFsBPEFOnh3qm407SculoI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VE1PR03MB5967.eurprd03.prod.outlook.com (2603:10a6:803:108::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 17 Jul
 2020 14:05:52 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::ad93:b959:82ec:107f]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::ad93:b959:82ec:107f%3]) with mapi id 15.20.3174.027; Fri, 17 Jul 2020
 14:05:52 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] linux-user: Add support for btrfs ioctls used to manage
 quota
Date: Fri, 17 Jul 2020 16:04:32 +0200
Message-Id: <20200717140433.265599-4-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717140433.265599-1-Filip.Bozuta@syrmia.com>
References: <20200717140433.265599-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0026.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::13) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.239) by
 GV0P278CA0026.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18 via Frontend Transport; Fri, 17 Jul 2020 14:05:51 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.239]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd13efd6-059d-4b55-c7a4-08d82a5a840f
X-MS-TrafficTypeDiagnostic: VE1PR03MB5967:
X-Microsoft-Antispam-PRVS: <VE1PR03MB596776FFC8E61A87588C4614EB7C0@VE1PR03MB5967.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dj4qiXanZIVpSTw5u0R7zTYqJySlqBPLeAxHLfM3jq4LY4Y0qIXi4f9PljdrKtLLQNTYWYqCmIOe/5M74PJXHHqa5+FlZ89zwsEpwI1nX6tPz/oHlXyPL1Gh7dw9HDaujENTfWG3JWcwyDjxY8B/D8DaOghGxyV+M2vokuqT9zhQhu2gx8oO+Guri9K+FmHyOjodReTMaBW4I0vzqYznNqTIBAtG0iT3InzdiKsqrYRsHU+t3VWJnyvmu7Z+8E4+pROxvaAUL6DT6M1qouaaHWpwnMS6fiM9euzMRvfkkI8JgIpXv//UUl60KuqLSlPWX/DrdhGmP/Jf5oRp4k6ZB3r0X1M3d2ehKQHK/+qZgWcqnTPQC6lMvJTHYTvwT/txoxMQ79PwkOsdyrZBOn5bGu37NHsPiqRrLCUV522ni4SG6Y5FRbbHI3KR/vM2Zb+4h8zyZkGUxteKrreJ2LLjpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(136003)(366004)(346002)(396003)(376002)(2906002)(1076003)(83380400001)(52116002)(8936002)(66946007)(956004)(316002)(66476007)(36756003)(66556008)(508600001)(6512007)(966005)(6916009)(6666004)(2616005)(69590400007)(15650500001)(26005)(8676002)(6486002)(6506007)(16526019)(5660300002)(4326008)(186003)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: tvXsTh+Sa4UjaKHbd/TUDVTrjB4JfeB0mHZ20F0H3PYMnzBdGVZo9dOthvBH3xrkv3sOh7XJg6bu40INWMH6NWiEK2G7CY2JEtcU7n1sF5/s6+ZciPrDwZduLuUO3M1KNC3dB8Fm0u+6ANzW13R+EBzcqst2AsHYva2lhG5qjyoUkbwP9rlfgvz1kdZaSPJF96aoCAqczx+pdqf6xQqhh/NwrldjJaRqKFlPpOqtgjbj2G3SoVSLcgL8JQnbbbVE1Yw8rMxExAIxQYExZtr3UcIdkbfVIKc9ODDQpfo6L6Um4BhVEo0YZ8AE0MLl3ChcYduJRexfxFSd6T6PxMkCpYeMCqK0A3hC2TjrsNpH9O6e6mFeKrU8e3jUBrZ14Nluo1GRsn0riwDl9uQtGUpChvOC3GDxJ2tHzHncmpi5Nbg9InkgE6dCrhrCRY3lNvjS/hLC0XND3HkHAehN5bYEYM1N5ggVypaVbS/bmn6v9TE=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd13efd6-059d-4b55-c7a4-08d82a5a840f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 14:05:52.6633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: id59SlUMZb/1znj+TiUnisOSesbaDUyxMMjTctXcrk1IA7KC74yhj6HbSUXTkMb59M9paYI+zLFd+V/IFzdS8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB5967
Received-SPF: pass client-ip=40.107.3.139;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 10:06:23
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


