Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F792C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0857D20734
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="wg+yxnMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0857D20734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwRdl-0000XV-99
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 10:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jwRbi-0006ii-J8
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:45:02 -0400
Received: from mail-am6eur05on2136.outbound.protection.outlook.com
 ([40.107.22.136]:50880 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jwRbf-0004yI-Tj
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:45:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYRydbkqDYCErDgEg1ZGwqc5Du6IqIF1Ll30mwbpnvvqo/5oSTLASS9RcEQ41Kv/zgklhUnSwTFT9tZiQF9JzdBsd2LvIkualrtSZW3+OGdUDCFCQgT3kUOugm9C/QcmYuJJK/lMGyNXN770OpM1EVEF2oXfud2ccIXw4R6rwdzb9Sr0wybIywIaScjK8r0gTH380B7kVvAAiuM3DqcIvDfD5YkSDXyQTb05lyVd+Iqke/WACie+54DOqglfciysZTqkOSVgQsqxPyCzG0+WN3r9us1oclDkTxDAuUmSf+mqHulu88NhosDBwGZJo4EWcrKbsXM52pUS5SBxHc3WWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekTjZGCC4scdn4+xd+1rHdafnPeY7H44TRMCOIobEGc=;
 b=DusV7S0eTfsJwXqYCy6NhpxsHjb6NujqiIk8aR4Csph2PgCUMv0udXyghBtyH361pBQfU5w7jYK2n2RgE9e3nhaK+itzhSJT5bqLKI13Coxy3a7l3stp1XnyTSvWzEWhNNXjQWanudxuEZuEi6DUrNBYNvQGRSzTlQAhbEvf5pkX31qBPqAFMVdCsScgeknlbGlfIISOgyclNzBhdRoxkZCp3bJ41V+w9t2ToBLdQDHZ4v10/hKr0sNTydCtceLqmojUmjZYnmXi5NjVanL9VyZcmLZukB8GxzHn+ljxwtcVcg7v6L8m1fX+Qvpl8RTVVjeR9SzoO7cnRHsIzszqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekTjZGCC4scdn4+xd+1rHdafnPeY7H44TRMCOIobEGc=;
 b=wg+yxnMrsSFeECxsy1VKlySazqW7KJNLmVSgRbAXEq0zNJXVyaBeoqwbSUMVhdzLsKu8W6ZQd30dqk/7UnrpAqIzIa6iv56UCflKkNb5NdWlXm6XH9cx52IryNz30EcocPfwjJLHiDSrkpcGo0vk9q9FTlVuTt4vpv8MFanko5o=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR0302MB3470.eurprd03.prod.outlook.com (2603:10a6:803:1f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Fri, 17 Jul
 2020 14:44:57 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::ad93:b959:82ec:107f]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::ad93:b959:82ec:107f%3]) with mapi id 15.20.3174.027; Fri, 17 Jul 2020
 14:44:57 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] linux-user: Add support for btrfs ioctls used to scrub
 a filesystem
Date: Fri, 17 Jul 2020 16:44:35 +0200
Message-Id: <20200717144435.268166-5-Filip.Bozuta@syrmia.com>
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
 15.20.3195.17 via Frontend Transport; Fri, 17 Jul 2020 14:44:56 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.239]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6108ee74-cc35-4460-6e82-08d82a5ff973
X-MS-TrafficTypeDiagnostic: VI1PR0302MB3470:
X-Microsoft-Antispam-PRVS: <VI1PR0302MB347046C4014E82867CF2924FEB7C0@VI1PR0302MB3470.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1buKHaaJbe9hrTzjJEVpSCBGxGbEzos1en2lYQ0x/KTbRbFjfLSWQ+msraB9taQSOmTkEH7I6yeAG31cQXTa8ff6PtgCpqSUujz1SeKMa/m/9B4yl3z4O69MY+aOEfNCeIz/Qmt83rE+UpYCG3gzS6sskD6Mskpnc7uxm6PBP3XRwP6ARTPXxbqQHUvmMc55Sy2nDyPcWEATdfxDbkLLVQS1Mo2h38/xFFwFlXzFX2rlnA1gZlQPvHqILWr4TU074UhHd0o8pat2buQZOFHsWfLPzLpKGuNqCUWwy+WyhlUXM1RdrsQU32syK+G5XMFn1jVPJoRxm4EEv1GiFpBrCMDWawPYIROHeiRQCTbhasYVGSS/1cR9nRW6qilO0YCrZe3mePuiknr87L7VclQVWp4UK++IUW2tenkj9Fu+CQFfGbsnJ0fBKNaS34DzANcnR4WsyO/M9yE2rqCakDkwow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(396003)(39830400003)(366004)(346002)(136003)(956004)(5660300002)(83380400001)(8936002)(66476007)(316002)(1076003)(66556008)(69590400007)(6666004)(66946007)(52116002)(8676002)(6506007)(186003)(966005)(6916009)(2616005)(36756003)(2906002)(4326008)(26005)(16526019)(6486002)(6512007)(86362001)(508600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 2sqmxvC3F0Z2k3TwTZlmYQ4xYfMsH1FHx8T6ONr1u3b2Zwx9kOhdVdHxMDntydhbfLFRXEJKwWZTvFZlJH7cLyBSWAzz8nqMZGz3BmSk7FE3ZDbeGW1HTbEOUIxtgjCUK4t6wFEn+NUoJNU5dpLEztxsmNuKgBIMUjlw+tX1MJmgOgTZa+GSxVC2fZhDZjCxUpuWPohccD87d+yds0Y3Alm+bbLZbFdRUa0jLxUrMbwlppeDtl8lsERg5RANC1AJsxx8xMiabI4TRYfO4Yd6fBFGonPHVw2OXPlCJW+ALmLIOZTyZ+MFA0ItvKiPL68OloD20lRYAZYR9erFW/kme2C5f3SEUv92e8JldTvjg9dTVSZvcGvl9SMBE5SZ6GEhz+UACmu3zD3o8RjChStFAdIPj3uka8wum57Wfp/5SAIairLGA9PSx7CjHGzYB2pxbC6jXLbdqzTdQp+OTNgBv7zEhGKeE3pL5vVCkIpxaUg=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6108ee74-cc35-4460-6e82-08d82a5ff973
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 14:44:57.0515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AJmqP1udCh2iHCIF4qa3q9ArkqoETbAh3ZGRwRLTkAYMRHVpzBypvZjQe+WpNzacayTdNixITrwKBv4E3SilQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0302MB3470
Received-SPF: pass client-ip=40.107.22.136;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 10:44:57
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

BTRFS_IOC_SCRUB - Starting a btrfs filesystem scrub

    Start a btrfs filesystem scrub. The third ioctls argument
    is a pointer to a following type:

    struct btrfs_ioctl_scrub_args {
	__u64 devid;				/* in */
	__u64 start;				/* in */
	__u64 end;				/* in */
	__u64 flags;				/* in */
	struct btrfs_scrub_progress progress;	/* out */
	/* pad to 1k */
	__u64 unused[(1024-32-sizeof(struct btrfs_scrub_progress))/8];
    };

    Before calling this ioctl, field 'devid' should be filled
    with value that represents the device id of the btrfs filesystem
    for which the scrub is to be started.

BTRFS_IOC_SCRUB_CANCEL - Canceling scrub of a btrfs filesystem

    Cancel a btrfs filesystem scrub if it is running. The third
    ioctls argument is ignored.

BTRFS_IOC_SCRUB_PROGRESS - Getting status of a running scrub

    Read the status of a running btrfs filesystem scrub. The third
    ioctls argument is a pointer to the above mentioned
    'struct btrfs_ioctl_scrub_args'. Similarly as with 'BTRFS_IOC_SCRUB',
    the 'devid' field should be filled with value that represents the
    id of the btrfs device for which the scrub has started. The status
    of a running scrub is returned in the field 'progress' which is
    of type 'struct btrfs_scrub_progress' and its definition can be
    found at:
    https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/btrfs.h#L150

Implementation nots:

    Ioctls in this patch use type 'struct btrfs_ioctl_scrub_args' as their
    third argument. That is the reason why an aproppriate thunk type
    definition is added in file 'syscall_types.h'.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/ioctls.h        | 11 +++++++++++
 linux-user/syscall_defs.h  |  6 ++++++
 linux-user/syscall_types.h | 26 ++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 8665f504bf..bf80615438 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -215,6 +215,17 @@
 #ifdef BTRFS_IOC_SUBVOL_SETFLAGS
      IOCTL(BTRFS_IOC_SUBVOL_SETFLAGS, IOC_W, MK_PTR(TYPE_ULONGLONG))
 #endif
+#ifdef BTRFS_IOC_SCRUB
+     IOCTL(BTRFS_IOC_SCRUB, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_scrub_args)))
+#endif
+#ifdef BTRFS_IOC_SCRUB_CANCEL
+     IOCTL(BTRFS_IOC_SCRUB_CANCEL, 0, TYPE_NULL)
+#endif
+#ifdef BTRFS_IOC_SCRUB_PROGRESS
+     IOCTL(BTRFS_IOC_SCRUB_PROGRESS, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_scrub_args)))
+#endif
 #ifdef BTRFS_IOC_DEV_INFO
      IOCTL(BTRFS_IOC_DEV_INFO, IOC_RW,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_dev_info_args)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 3f771ae5d1..589ec3e9b0 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -990,6 +990,12 @@ struct target_rtc_pll_info {
                                                            25, abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, \
                                                            26, abi_ullong)
+#define TARGET_BTRFS_IOC_SCRUB                  TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
+                                             27, struct btrfs_ioctl_scrub_args)
+#define TARGET_BTRFS_IOC_SCRUB_CANCEL           TARGET_IO(BTRFS_IOCTL_MAGIC,  \
+                                                          28)
+#define TARGET_BTRFS_IOC_SCRUB_PROGRESS         TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
+                                             29, struct btrfs_ioctl_scrub_args)
 #define TARGET_BTRFS_IOC_DEV_INFO               TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
                                           30, struct btrfs_ioctl_dev_info_args)
 #define TARGET_BTRFS_IOC_INO_PATHS              TARGET_IOWR(BTRFS_IOCTL_MAGIC,\
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index b4f462b5c6..345193270c 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -373,6 +373,32 @@ STRUCT(btrfs_ioctl_ino_lookup_user_args,
        MK_ARRAY(TYPE_CHAR, BTRFS_VOL_NAME_MAX + 1), /* name */
        MK_ARRAY(TYPE_CHAR, BTRFS_INO_LOOKUP_USER_PATH_MAX)) /* path */
 
+STRUCT(btrfs_scrub_progress,
+       TYPE_ULONGLONG, /* data_extents_scrubbed */
+       TYPE_ULONGLONG, /* tree_extents_scrubbed */
+       TYPE_ULONGLONG, /* data_bytes_scrubbed */
+       TYPE_ULONGLONG, /* tree_bytes_scrubbed */
+       TYPE_ULONGLONG, /* read_errors */
+       TYPE_ULONGLONG, /* csum_errors */
+       TYPE_ULONGLONG, /* verify_errors */
+       TYPE_ULONGLONG, /* no_csum */
+       TYPE_ULONGLONG, /* csum_discards */
+       TYPE_ULONGLONG, /* super_errors */
+       TYPE_ULONGLONG, /* malloc_errors */
+       TYPE_ULONGLONG, /* uncorrectable_errors */
+       TYPE_ULONGLONG, /* corrected_er */
+       TYPE_ULONGLONG, /* last_physical */
+       TYPE_ULONGLONG) /* unverified_errors */
+
+STRUCT(btrfs_ioctl_scrub_args,
+  TYPE_ULONGLONG, /* devid */
+  TYPE_ULONGLONG, /* start */
+  TYPE_ULONGLONG, /* end */
+  TYPE_ULONGLONG, /* flags */
+  MK_STRUCT(STRUCT_btrfs_scrub_progress), /* progress */
+  MK_ARRAY(TYPE_ULONGLONG,
+           (1024 - 32 - sizeof(struct btrfs_scrub_progress)) / 8)) /* unused */
+
 STRUCT(btrfs_ioctl_dev_info_args,
        TYPE_ULONGLONG, /* devid */
        MK_ARRAY(TYPE_CHAR, BTRFS_UUID_SIZE), /* uuid */
-- 
2.25.1


