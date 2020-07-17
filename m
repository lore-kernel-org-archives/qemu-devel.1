Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F53FC433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D59B22CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="AJjygrVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D59B22CB2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwR20-0005sF-Bz
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 10:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jwR0X-0003mP-1t
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:06:37 -0400
Received: from mail-eopbgr30139.outbound.protection.outlook.com
 ([40.107.3.139]:44942 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jwR0V-0005Go-0h
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:06:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+v7KbKs1t54Z8Fi5R28hbzav0I77OKZnNAb3eQpvuoMfYeEb7u6n66u4jYelKpzy/Md4x0gmXlfPBqH748DJNzyLwqRZPw7jNyaciIkv8v9qTpyFgLVMxLpffbWV1yrOltBBp/S9oMepjuHyTxC0XOd062ZhyS9HkgRxl9fwRhmXNfUF7Gs/VVoPWX6aJBttydLUJXfbh4SVJxTPz9AQ4vtpO2Iwyw7XLU4/r9Db3wixZHQuXgvJUtv2Pgtf0qhzU5/GcSpwroh6nus+TJjtXgljUlIaxNDiaet9GeWWntvWFMxFSlkd569/Sm3Fdd7iem5wPnkh1BwImNuXdJY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9clEL/O0844nZQX3IJo0VtWAlrD9+k1XC4mmrpF8pRw=;
 b=MNAP1FBfUK0Gp8G7avYFqkFPxw/G/8GlJZNPF5b+qWf81UpIjrXp34C6Em/dxFh3vIm4J5vwDfdl/clqTwfaj+b8+/GZvT/1oIVH10VBSb4lYp8+JHAORJKga862aVtlxbp3W0Ozu1JYXof8sKW8qYbHDOIBHtx1z6J87x6vufTQ+/GZ72avK2kNpNUiXLwNhd9q7yheS3xiHHHLexM4L5d4mTmU3brk3JeEVrraEmJks9rRZeISkIeeUey+xMGjaEEb1odNmijoKI69rMkVDuYB57Yzx+0VWZVoxPzLJwXaPXlWGuz+JGwGDuyWZ8QWszZmZEx7pGQ1pnOAcVmTcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9clEL/O0844nZQX3IJo0VtWAlrD9+k1XC4mmrpF8pRw=;
 b=AJjygrVf1HIHOxYe1xUSCoS02V7IVlU2TIzi8028vMqIDrL0EydlU7st6xC1cTGc7+4psebOm5eulaYreCPcNw3apJ3b749yi4/fmWVaFGNksz1zeozy5RXob8YReaW632oGeI/NAaFfQsbjlp/6dFbEAKuerXCqkLdshel/uTA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VE1PR03MB5967.eurprd03.prod.outlook.com (2603:10a6:803:108::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 17 Jul
 2020 14:05:53 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::ad93:b959:82ec:107f]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::ad93:b959:82ec:107f%3]) with mapi id 15.20.3174.027; Fri, 17 Jul 2020
 14:05:53 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] linux-user: Add support for btrfs ioctls used to scrub a
 filesystem
Date: Fri, 17 Jul 2020 16:04:33 +0200
Message-Id: <20200717140433.265599-5-Filip.Bozuta@syrmia.com>
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
 15.20.3195.18 via Frontend Transport; Fri, 17 Jul 2020 14:05:52 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.239]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff3270af-eeb7-4536-7e73-08d82a5a84bb
X-MS-TrafficTypeDiagnostic: VE1PR03MB5967:
X-Microsoft-Antispam-PRVS: <VE1PR03MB596705DB2FB9FB6E35286641EB7C0@VE1PR03MB5967.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SgwZXRY0jG3rh6hTkHiQHpVamP39grZM5j4S4NngOHi936vyz7k/YxKB5fVSHN1l1FkjMTmO06IZHhq+mMQONOtZu9vvqsxozm/jTa8jyOwtXujUCvqIYDYyg/tVtbkiBdapZtEL8MOo6K9rTIZ+AUCZ8CxWHkkIpR3Gq7xzobTGt/QnpbQcm3+fmFhs5jqufh0P5tw6rYBF9ZD4mbaK3U/Luv9yESOhoggiqF/aMtVj/+oHw3mNDUeVCI2QZBWRyGLwZSZuaxWugcGDRMDs5Rb5gxleDekKLzkB4H+ewGi83G5OGtKNbf+tn1uQqUmHP3t1v0m+MPFuLfKmfBjO4zOv1Nzd6x06C6zRnLtdMxPlbXHZTz+UqnyQUrBXQyVHUbTx0TCTeCrLc/S3/P4Grjs/3ubrYsFu/G/zOYEhLy1AiAZPFBiaijvvNv3t0Xj2vGFb2Ur9yW91OVViS3SfRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(136003)(366004)(346002)(396003)(376002)(2906002)(1076003)(83380400001)(52116002)(8936002)(66946007)(956004)(316002)(66476007)(36756003)(66556008)(508600001)(6512007)(966005)(6916009)(6666004)(2616005)(69590400007)(26005)(8676002)(6486002)(6506007)(16526019)(5660300002)(4326008)(186003)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: t+OyCi5Pb1Q9EOtS5gSfG6mg+Lbrc9DKFoXeSOLbu4xLRjpaGUY1A+kIOlqZp+8ONgeV1Z1WyQdC0sKLrG8skQkjbzxjoIgcc7S1g/sZH0EZVoCEV05MW1gY69ZKbvqJMa4/jsdj7vCnxfJpquXVBiOGAczwXSli8d2jxP2lBhXl45xZt1eS/ZBvpmtldtnp4a3zBGLcG0mwPP9dPivlizth1xbg8As6GW98F3LCbJRkEnHlcKxv3g48fzISR6QuiaWy0ZGaXLr+LZbsw6nCNHI1L30BuCfi1G8H1zbVvMx5Zz3UYsnBH/ws//s7yrMedoqnTPK0mw3AitugSFEWBZbDBx531RDv8mDUbeCCNLgFiEJKUIGAo+1gLQJyKOTTJmbR9vQH4pnexFWOqKjK6I79dBnxUhsvKr3GWVt+fnyumMOYzlzLveXH63HxzLiiKO5mvNsT2EcnhpJ5RXhTph2Ii6PXBZckLwZXLnu9IUY=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3270af-eeb7-4536-7e73-08d82a5a84bb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 14:05:53.7607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyM+iDDS2bzc6909WSXA72EdUEwSL3Q+C8a57WfGs5IMp6jrSJ2SYBLKD2lvwubYzrmhApbn0hKigaQKU0BGBg==
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


