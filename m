Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C57C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 19:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58261206C0
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 19:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="u1tuVDTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58261206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9w4M-00011Z-MT
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 15:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k9w1A-00038l-Rh
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 15:51:04 -0400
Received: from mail-eopbgr80121.outbound.protection.outlook.com
 ([40.107.8.121]:48453 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k9w18-0006Ij-Sb
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 15:51:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0TXKWvQ6hADebqbLsTUp7IXY1iPXcm+o8DFgsdQyQB8zS6AF7g/VCrh47UJBCqspE6G+NhZ81mHCijGKKG+hocIt+9Lpqa2zvrD8Bqw/rwXvgD2Pw01PUOlhvgaVcBYwMuNgQtp0Gk4NowtELz+9n1lhO55GJ6Jcn+Sdr1Ka5ny9R/iPvDj1zVeddG4BOddSIsXnowFCtVMzBrSaUqnWvAIFuYKKR0OMSewrXCNOqxqso/Z+Kiuq1+Z9HGxkoAEl2DPwI4VnCfnrB8FYzTzRSwissSYdxGrqus0D+ZnLuaCsPl/OS6VotsOgpORdDjST3UqNcRofPoxQTuQ5IbGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEPcBqiSjmiuJAaaUjyZ2WQcK94QkZptdIPViCoLcvk=;
 b=jBd8pRI/ODD1CZss4NEv+jjoZSgJxlt4KWHJ0CXnJoZhMeIVRzvlLMw4ykUQFGdZoyarGEx/CksivZEdfq1KiBmSmoK0oM/VuWqlM09HnKkm4fBCdizAwmUsyqBZFk/V8SvVtc1raUuVaLyZimmMJyfnr40Pzy5WTMhTqgbIuNP6ZMy1+Kz95dcTFqBj3Ei1SUFOjn+msU/4g23mj/6NL5+EKYX6BsqpZvPDvMm3/NDMpoi0vPO7Mian+9OejZ/57Q/45AJqPwAkcWrodFNl2/vq8cUVwhWxcUdKgfeB0gRPkpzFY3F0md3M7glDSadHgM83KyeXsSEIZF3GrWyEJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEPcBqiSjmiuJAaaUjyZ2WQcK94QkZptdIPViCoLcvk=;
 b=u1tuVDTET+0u9hPC5BU/5ZaUBhNdGU3Owh7UlyBxaP1+sNSOsG5NNL+YBwYalHGWuo4BiZLG2Zngsdvrbjur1KG+jMiDiORCvJFoljPMw9xdhEvC7Ha0c44nzMQyrpEsKRr5aDKaalapuJIC5o2K7mI/tC6xqaAUkAThxkfeePM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB6143.eurprd03.prod.outlook.com (2603:10a6:800:131::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Sun, 23 Aug
 2020 19:50:40 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Sun, 23 Aug 2020
 19:50:40 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 8/8] linux-user: Add support for btrfs ioctls used to scrub
 a filesystem
Date: Sun, 23 Aug 2020 21:50:14 +0200
Message-Id: <20200823195014.116226-9-Filip.Bozuta@syrmia.com>
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
 15.20.3305.24 via Frontend Transport; Sun, 23 Aug 2020 19:50:39 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9eb30447-5b33-4557-ec30-08d8479dd01a
X-MS-TrafficTypeDiagnostic: VI1PR03MB6143:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB6143A1818193F3CD996D9604EB590@VI1PR03MB6143.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: THSnm0MDfswBb3JuAkZpJkVa+9a61AovFC9w3epbT/BesZXco6k3Nh6QvOMmm3QnRzKKfnyDLj86lnbih7FWMu9LznMJzFO0hEKT9QrwNHyuMgQ1hICvy3NTTZHIQKkd5ydDcyKtQbBNuyqIEbsGOePkWMl/mSUMhr092YJVEdf6xUKWyiTOtrwIOeqS8FhoB9fqCMXtfdXd7Wo67pBzU2UCdURdkeVFcQXccZwSjFecrMYvgqJTACCdIpyNN+SBFd6LBw0m6vdKXf7sTO3lvaoe+oAmGKsZgalCZVNPblJf36xu9ffn6wNcvc+aj9CVUkkNDPxjD8CYaTYCi5E7zoKW5AYBOuNTKB4XGUJpsLCkWAOULbwXk3N4cMFTV4LciAb1U0wUyomgr7/TXr1WyaX+IHkVPVeIpzxzSUOqDjyTwcY8BZgwVhsThWhQxVD3SsL1b+su/PoHQqRJCj3LLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(39830400003)(136003)(366004)(396003)(6916009)(8676002)(8936002)(6486002)(4326008)(66556008)(2616005)(107886003)(6666004)(66476007)(316002)(956004)(6512007)(66946007)(36756003)(54906003)(5660300002)(186003)(26005)(52116002)(6506007)(478600001)(2906002)(86362001)(966005)(69590400007)(16526019)(1076003)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: R/iWExMH+sp3wAh5X9W5TWJ3Mb4pi6f3n+wRDvV++4uzaK7/K2svTQGn0qHor63JB14P7/XwaHXdduLppNdlQMx+Q6WKSKlJoAn9EWMLMk8KJ6fLzH9pFMuJgE8z63q5S3C2E5RqhzMCat6D6KfDaOPrgO9C+nE/8TfuiWiN54tuuRbe0KGix87+7EN+3HiBhBupdG89i/oTn0M7l1+lKkI9Ve4xh41u1LNlJflbWRwHUjbSd/gcPRBeMt64aYJ6hSm5GWm7cddWTA3EWtnQAkZMfVMqmIOC0xkfYndTclw7QZi7EVEDd+e1S4ZdABsGK89b1csjstTgOwMkkNRdW1C1n1Dr3mTiu5YfbLxz2OPuEiBj5BRNIDgL4t3akuwEPnaiNeld8ucFS/aZAu0lF9k185zw9Gb/F/u27cP/66iIX4LMRo2QO6Ols/dDEu7j5+otUX/63fxTTCvIdZyHVlgt+aaAalGhEJtM18zCBD+YaeybFA77kxPfkBQ/knyJuZIPf9Lkju+nU9VHkWVGdPG1S7uVkuzhGcEq+zOvqyEZ5maNr31eWoeV844JLghGfk7w31cmJAAAUYxVPHyODD43+x4bGeBGvqJ34HDbgzf3mwpWvSHj23xJFCV2V3xHRcvF6YimDfFIZ/Lh3UQUXA==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb30447-5b33-4557-ec30-08d8479dd01a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2020 19:50:40.2086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U538+Nk+DFw4+/3pDKiaXY1uqmwxjF8TU9q9+lrVOVOLgIFeo7p/1BD5OZwmstPzxeiG0A59QxUlvh5LhIOzWA==
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
 linux-user/syscall_defs.h  |  3 +++
 linux-user/syscall_types.h | 29 +++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 882bfb3e88..e3bfe78774 100644
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
index 10a7f91016..969377d622 100644
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
index d9b7106a69..789723cfb9 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -421,6 +421,35 @@ STRUCT(btrfs_ioctl_ino_lookup_user_args,
        MK_ARRAY(TYPE_CHAR, BTRFS_INO_LOOKUP_USER_PATH_MAX)) /* path */
 #endif
 
+#if defined(BTRFS_IOC_SCRUB) || defined(BTRFS_IOC_SCRUB_PROGRESS)
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
+#endif
+
 #ifdef BTRFS_IOC_DEV_INFO
 STRUCT(btrfs_ioctl_dev_info_args,
        TYPE_ULONGLONG, /* devid */
-- 
2.25.1


