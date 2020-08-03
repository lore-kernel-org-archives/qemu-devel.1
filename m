Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD98C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE10E20738
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="WDqIH1ji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE10E20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2X6D-0000to-N7
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 05:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k2X3l-0004FM-DW
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:47:09 -0400
Received: from mail-eopbgr10121.outbound.protection.outlook.com
 ([40.107.1.121]:11844 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k2X3j-0008SR-JZ
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:47:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNXmVyc9q9axkvvtutY533PaP5GjGjP5GyplkrTSIv+Vp3XlJAVs0/WKSgpw4FL5c/kQd5dXUhgMVhioBtmViNegV5nC7Hr6cET1Ip1pOUYqUbMYahq3nOKk7hc0U/2VpNPapl1FOPepzkluuJBl3qsqpMkCSHZ5XuEvktQG+252KhmmWOenG3zhh+ybuNzRRDFKag5p6MPw9Z+V22/DssRMq4Umkaw2yajyYwE6rT8+xlRuigskvTysyaeKDXKff4JoIzwqRT5YcoXC4OAqESYpFfrknA5rFFQ6GmaOuho+I/SFR5xIdGJ+6pm5JqDrvO9T4SYjjKQlOehGCjpJIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSPQ2FLhYcVtwwKDZbefsDfQE77C24tJp1oUbO1+OTA=;
 b=CCHYjVHIrsBNLJoJ5VldqXKdI0lt51A5tlqP0Ns1nJ4R75BKmUDpfjrZHnoA26LRwIPkPvSDMLvW9SQiXOWEJxnCn/Jq1dZLwT+GpTFbQeHNyQAsn3MhA8lJkxSin5ObwLIpgCad8R1TbGkVxqkMZ/0rSQMcgqKoBBUMQqMxS9lWRGY/Uv+6h/ISXXtdOqVSDZQQHs14nOeNyurTVTXr3EgK6VtsgA7VHedeIAlmldypaLoL7bHkhTjn5Scz6DeG6W2Zqre41homTNCrQgGV6emYn6r/Zf1jZ8fNbXiZNl23R5ear6GHUtTcNNRGTnw5TMPVSE8xu2FN758q1wGaeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSPQ2FLhYcVtwwKDZbefsDfQE77C24tJp1oUbO1+OTA=;
 b=WDqIH1jiQ7O3xqVOKSVcCH+WxoINvQ3iYuairWoLvb2CquXOzDG+RX5MFaPswzBDYyf71XmmCOMEBwjPF4jKnx04vkQZc813g2iUuGcK3H+L3q4TDNuYfnYX+iRXsUrxEqM8v2c2JPCMcXyTMPoqB0gUl2caI18ML/ekUKjcBHc=
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
Subject: [PATCH v2 8/8] linux-user: Add support for btrfs ioctls used to scrub
 a filesystem
Date: Mon,  3 Aug 2020 11:46:29 +0200
Message-Id: <20200803094629.21898-9-Filip.Bozuta@syrmia.com>
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
 15.20.3239.19 via Frontend Transport; Mon, 3 Aug 2020 09:46:50 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.238]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7342bd56-3838-4b66-9cd8-08d837922572
X-MS-TrafficTypeDiagnostic: AM6PR03MB5457:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB5457D7FAC4F0305D684A714CEB4D0@AM6PR03MB5457.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mG0tN+IOYZpibfNpUoFqhTReeYlHZFTABY56fwuuzUu/H19wgW/jnLSPSsfqjHpmPs/V3gE98rzDWfnpfYYYV2xK+cU7pJ4qerOXBXxR2yfd9EXI6EhSww5mxpS12sjDGevSwdRRkshzrrqOrjhIFI038AZnMKhKhLf+lXa80U6NcGugGQRNfWsDNYKuq1s3Qh3j+SV9GA+HfLHV+ujKg5g69L3aU5+FPRwCHfM+kbXE5h1dEoWBF/dg/rMnHPDl1bcRCf3w691ly9KS/I8BL/4Ke0b78ASQXMAZION6hwTip/JOFL3xbrauUrv8CNtOOS5Wcmriqqdb7Su7dyxJvPgQQVsXFhOKjJBnD6SeRpbztD8qT1C3V2S8yS1zLdkRtEATGBeM0kdkVGHu3rztKpgUh8lH9LATRC4mnEsfyepim88DhvXvM6OhzFIT/zGCFli8JTIp0dKN8IExZLZNZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(376002)(39830400003)(346002)(136003)(366004)(66946007)(6486002)(6512007)(6506007)(66556008)(66476007)(1076003)(6916009)(86362001)(186003)(8676002)(2906002)(316002)(26005)(69590400007)(8936002)(16526019)(36756003)(107886003)(956004)(2616005)(52116002)(83380400001)(54906003)(966005)(6666004)(4326008)(5660300002)(508600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qP3qBFvYFl9sCshxw2DknwQfRF0lJE2BsH1unXQJF18YywXiy4CXc8ZDmVdIH4uDBqK4Xaeo7XKRs5E7now/qUoA5l/ukj63D6OGSAreSXp93TrZJBHQGaw4c0K6Vh2jvnK7EFJrHmKPk5IDXrS/HVr3WXdR/4VgyC0u3DhdNlIwAMO45gIQQZnbe8G8C8Ga1QjigtqB+vlD0TS/cA2iY92EbCE0jN53wqb3MWOOLF2nW7OuyODKWZlsZbM+FYJORLdn+Mkt3o4iaZryopZrIAUgf/6vdbSmAsFiSBuX+cKxK2jU8h9JBfGWGa5bilYejyn9A29uTlipWPypotmUiUr8ZuZOdUkGMxnYOnc4UxzD/oqXuYV1x+vRe1LARTMNzh3o+nUMfZy/6NKfaP9idOb7sIhuETA89FOUR+DeOSTE4jDE5mPLPmGOwbqBo757RoF1Fb+D+szBBUqUX//cbXA5HN1GDqHrxjqBA2CulFXOMkTQWnAHNAGO7qEF7gyvEsFW1G7NoNRVWnZcIJXUPoQcqHGUG9kUmEVe/DnAd87CCY1o2YxxHPWTgrX6aKj1w2Db0imyzcFb1e++kALSaovHCCPcJLG25tleqEh/SnEWpr3XcYoHbuzDxibERIh1bSLEPE0u2lodKGF+VPI5Gg==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7342bd56-3838-4b66-9cd8-08d837922572
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2020 09:46:50.7745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVPje5e0uqAMKghN0nU+shdh/9IlQW98J8bcmErvRiU9RzT4jEgOAec+ed6ZYv1r7/1AHH/5Z+w7gBAa4QLOuQ==
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        | 11 +++++++++++
 linux-user/syscall_defs.h  |  3 +++
 linux-user/syscall_types.h | 27 +++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

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
index 1b1b2c2d96..83c291f2d3 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -982,6 +982,9 @@ struct target_rtc_pll_info {
                                                            abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, 26,\
                                                            abi_ullong)
+#define TARGET_BTRFS_IOC_SCRUB                  TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 27)
+#define TARGET_BTRFS_IOC_SCRUB_CANCEL           TARGET_IO(BTRFS_IOCTL_MAGIC, 28)
+#define TARGET_BTRFS_IOC_SCRUB_PROGRESS         TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 29)
 #define TARGET_BTRFS_IOC_DEV_INFO               TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 30)
 #define TARGET_BTRFS_IOC_INO_PATHS              TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 35)
 #define TARGET_BTRFS_IOC_LOGICAL_INO            TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 36)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 2f5bad808e..fd6a91a309 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -373,6 +373,33 @@ STRUCT(btrfs_ioctl_ino_lookup_user_args,
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
+       TYPE_ULONGLONG, /* devid */
+       TYPE_ULONGLONG, /* start */
+       TYPE_ULONGLONG, /* end */
+       TYPE_ULONGLONG, /* flags */
+       MK_STRUCT(STRUCT_btrfs_scrub_progress), /* progress */
+       MK_ARRAY(TYPE_ULONGLONG,
+                (1024 - 32 -
+                 sizeof(struct btrfs_scrub_progress)) / 8)) /* unused */
+
 STRUCT(btrfs_ioctl_dev_info_args,
        TYPE_ULONGLONG, /* devid */
        MK_ARRAY(TYPE_CHAR, BTRFS_UUID_SIZE), /* uuid */
-- 
2.25.1


