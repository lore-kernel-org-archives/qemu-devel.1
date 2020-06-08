Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E36C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E2E2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="C4isYkX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E2E2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiL1H-0006gH-MN
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jiKsy-0003Wn-DT
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:44:32 -0400
Received: from mail-eopbgr80091.outbound.protection.outlook.com
 ([40.107.8.91]:62103 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jiKsx-0007Fd-9u
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:44:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ajus1o+YfWIC820IcIMyeG9lvJZf5P2CwQEyHKACEruk+sfZ/vkCIsGSk2ctrXxvMUa4BQ0JlSwV7wupa6/aHyDcfyeJVEp7jWgSQi5dRLsp1Ui06JESTD3CoU1FnhmK3aY2yfjsHotxlyWLh4V3oK1C7SZkQDUDX4WDGAebm9sdaFtM5j8QYq1hX2BRYL5V5jnyn3VV1+JeThJtj+lQk7U8NG73n3NDSuzpGdVvCOOgzVKNV/kreN8LwkEHduIDJcQy/emgAguQ6ZbZBRn0ml83dbyM5D3y3Ox+wtGps14UIUgw2br+Itjm8Zk/52E5DW0uVLl8XwIK9CgSopN/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTM2FEi0DCTCyUiXiXAthGGDDJJBNDxBaUN9ck30WCk=;
 b=bcP5O8tl/51mQDKRujar5cmts6wFeteaWu0zXyeo20CafJudbKDoSz33GC0GSw9inG0ihj2AhN3VNVq86Q8gPUS/BtiimyzasqJronlnq2dUw8AUkzXLy4l19GTyMBIB7jOk277Crq7+nelNGGWjFO3PWubsyMRrJXBAudg+Cu818z/qbnZAgHnmgLoTPknkxWd6GBM8nureqirgAYhR//Cc6vTP50Ms6DJnd35ViA49C7lJ8tgZjPK+QfDP9EoWNNgM/WGIcjo1jxgyWan2l+ODPLY7w4T6p7cgsOpSQXXK7Tp9FweIlmaZFAVGIERwe1LnzgjbnZ23R2UkhcNPCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTM2FEi0DCTCyUiXiXAthGGDDJJBNDxBaUN9ck30WCk=;
 b=C4isYkX9Ol9QW9Anrk1sWQYX5xnnbKX/XaYAWHcP72jdt2Cd0M0trVNHVlWNo2+SqG3krhuXO67fGYKyQ6BhYeF8ZcAO5oNyrdUxVNrXSKOwKjULoT7AC6b+NFyUKwX6xyIfVTLXh/mODY496JpJgC3QDHTDwQccFL1cfoRGGUw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB3798.eurprd03.prod.outlook.com (2603:10a6:20b:1f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Mon, 8 Jun
 2020 16:44:13 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 16:44:13 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/6] linux-user: Add strace support for printing arguments
 of fallocate()
Date: Mon,  8 Jun 2020 18:43:57 +0200
Message-Id: <20200608164357.25065-7-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608164357.25065-1-filip.bozuta@syrmia.com>
References: <20200608164357.25065-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::26) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 16:44:13 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3943a50a-e9a0-4075-2ad6-08d80bcb2d0b
X-MS-TrafficTypeDiagnostic: AM6PR03MB3798:
X-Microsoft-Antispam-PRVS: <AM6PR03MB3798AB481863CE12BC3697FEEB850@AM6PR03MB3798.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVAbU/Yd2eKqWUoVGUtUHkg+oSfb4VkhtGhRNGK7MUch6rPHnREhHAuIjPjsMqIJs2BVB5jB7BcJ3FF3u3L172ZKt0oXsVuaCUjDcMo3EXW4le+yajbDiZQaJ7ZUSp4EUQfoQv1yfPy4GvUs+m/gb4hu/2Blq54byylR2WstojRfsKDyNHxGNoBixGnC1xYF83p8Oer1J5FGT7EKjh6m6GiB8uWy1a262AMkym9NCJn+cNo1WTLxC634j5KA/pvyYg64nIWlcO2jOjOun67FH2kHb6tYyUagCXPfwDXGiFh6+ggOnWALGdX1n26kNNEqX1Cy23mtk3URJ63btcooIWrHg6FqyUV/ZWfTWSkmwU8qjGS3/gzLSduuCAQSEwKOMouBB0ldIfj3pfsuuWTKyQrsZlMok6ay8YJADsWFC+dfbke/aB9BjwslX7n8zkVLFPPiHSCLBQGURx/G8FSaRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(376002)(396003)(346002)(136003)(366004)(508600001)(4326008)(8676002)(8936002)(966005)(1076003)(66556008)(6916009)(66476007)(5660300002)(66946007)(86362001)(316002)(36756003)(16526019)(26005)(2906002)(52116002)(83380400001)(2616005)(956004)(44832011)(6486002)(7696005)(186003)(6666004)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 07PQ8jdn0AgzqHzzlTIjI1HUTIPxGCYrm9cDvBplcCxZIXOUu0Cl6D5HftgxUtlyphdx5iUNwpH9SOOmxct5VuwxxAOOoroCkJSWQG2MeYbZLQTNP9fJSeNzB3d9xUSSXHsRVjz8IrxzK3Z41d+8iB/3OICxrUqFZ/H8b5IE6ocGTnGqwmf04JA2Tv0/2vX48mjO3QBATtxwEjiaolOSh8burBjqFmGKxS1hvxlLLkdcTI07EFFHoWlIvcKcYpcsbe1CD3/p7Wdq6K2fyg+VWiPk936jIDSQL8X3F4/n4EOHE3CD9Ekei5i3yXwiyjZ8LISi45L+uB0JMqc4m9Q1G45M+2jr7sqHItVmmwLs8QFQp7NLkRr+LdmROPu13P4j7NIx0PKx+traNBrnwFKzDiM26KscWLQ5KHlF+LFv7AREQNcLexSXzL2TtSDbSwpW77YQfQf/mSs9MpQApNruxOkdRABv5RrKONZphB4d/AU=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3943a50a-e9a0-4075-2ad6-08d80bcb2d0b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 16:44:13.6617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMswaa3yEt0zbu279Eh+jrBJQtNJ23QEZJzRg0T+ZJAMYo+J3tJLU+/TKCPxnMEreq0uNzIWqkKBVPlGsLxEwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3798
Received-SPF: pass client-ip=40.107.8.91; envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 12:44:17
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This patch implements strace argument printing functionality for following syscall:

    *fallocate - manipulate file space

        int fallocate(int fd, int mode, off_t offset, off_t len)
        man page: https://www.man7.org/linux/man-pages/man2/fallocate.2.html

Implementation notes:

    This syscall's second argument "mode" is composed of predefined values
    which represent flags that determine the type of operation that is
    to be performed on the file space. For that reason, a printing
    function "print_fallocate" was stated in file "strace.list". This printing
    function uses an already existing function "print_flags()" to print flags of
    the "mode" argument. These flags are stated inside an array "falloc_flags"
    that contains values of type "struct flags". These values are instantiated
    using an existing macro "FLAG_GENERIC()". Most of these flags are defined
    after kernel version 3.0 which is why they are enwrapped in an #ifdef
    directive.
    The syscall's third ant fourth argument are of type "off_t" which can
    cause variations between 32/64-bit architectures. To handle this variation,
    function "target_offset64()" was copied from file "strace.c" and used in
    "print_fallocate" to print "off_t" arguments for 32-bit architectures.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/qemu.h      | 16 ++++++++++++++++
 linux-user/strace.c    | 40 ++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list |  2 +-
 linux-user/syscall.c   | 16 ----------------
 4 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 8f938b8105..be67391ba4 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -670,6 +670,22 @@ static inline int is_error(abi_long ret)
     return (abi_ulong)ret >= (abi_ulong)(-4096);
 }
 
+#if TARGET_ABI_BITS == 32
+static inline uint64_t target_offset64(uint32_t word0, uint32_t word1)
+{
+#ifdef TARGET_WORDS_BIGENDIAN
+    return ((uint64_t)word0 << 32) | word1;
+#else
+    return ((uint64_t)word1 << 32) | word0;
+#endif
+}
+#else /* TARGET_ABI_BITS == 32 */
+static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
+{
+    return word0;
+}
+#endif /* TARGET_ABI_BITS != 32 */
+
 /**
  * preexit_cleanup: housekeeping before the guest exits
  *
diff --git a/linux-user/strace.c b/linux-user/strace.c
index cd6a2b8e3f..3ef7f80cd7 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1144,6 +1144,26 @@ UNUSED static struct flags statx_mask[] = {
     FLAG_END,
 };
 
+UNUSED static struct flags falloc_flags[] = {
+    FLAG_GENERIC(FALLOC_FL_KEEP_SIZE),
+    FLAG_GENERIC(FALLOC_FL_PUNCH_HOLE),
+#ifdef FALLOC_FL_NO_HIDE_STALE
+    FLAG_GENERIC(FALLOC_FL_NO_HIDE_STALE),
+#endif
+#ifdef FALLOC_FL_COLLAPSE_RANGE
+    FLAG_GENERIC(FALLOC_FL_COLLAPSE_RANGE),
+#endif
+#ifdef FALLOC_FL_ZERO_RANGE
+    FLAG_GENERIC(FALLOC_FL_ZERO_RANGE),
+#endif
+#ifdef FALLOC_FL_INSERT_RANGE
+    FLAG_GENERIC(FALLOC_FL_INSERT_RANGE),
+#endif
+#ifdef FALLOC_FL_UNSHARE_RANGE
+    FLAG_GENERIC(FALLOC_FL_UNSHARE_RANGE),
+#endif
+};
+
 /*
  * print_xxx utility functions.  These are used to print syscall
  * parameters in certain format.  All of these have parameter
@@ -1561,6 +1581,26 @@ print_faccessat(const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_fallocate
+static void
+print_fallocate(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_flags(falloc_flags, arg1, 0);
+#if TARGET_ABI_BITS == 32
+    print_raw_param("%" PRIu64, target_offset64(arg2, arg3), 0);
+    print_raw_param("%" PRIu64, target_offset64(arg4, arg5), 1);
+#else
+    print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
+    print_raw_param(TARGET_ABI_FMT_ld, arg3, 1);
+#endif
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_fchmodat
 static void
 print_fchmodat(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 44eb515ca4..a8d7cbe7a4 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -182,7 +182,7 @@
 { TARGET_NR_fadvise64_64, "fadvise64_64" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_fallocate
-{ TARGET_NR_fallocate, "fallocate" , NULL, NULL, NULL },
+{ TARGET_NR_fallocate, "fallocate" , NULL, print_fallocate, NULL },
 #endif
 #ifdef TARGET_NR_fanotify_init
 { TARGET_NR_fanotify_init, "fanotify_init" , NULL, NULL, NULL },
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 009bb67422..7cc5a65b4f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6608,22 +6608,6 @@ void syscall_init(void)
     }
 }
 
-#if TARGET_ABI_BITS == 32
-static inline uint64_t target_offset64(uint32_t word0, uint32_t word1)
-{
-#ifdef TARGET_WORDS_BIGENDIAN
-    return ((uint64_t)word0 << 32) | word1;
-#else
-    return ((uint64_t)word1 << 32) | word0;
-#endif
-}
-#else /* TARGET_ABI_BITS == 32 */
-static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
-{
-    return word0;
-}
-#endif /* TARGET_ABI_BITS != 32 */
-
 #ifdef TARGET_NR_truncate64
 static inline abi_long target_truncate64(void *cpu_env, const char *arg1,
                                          abi_long arg2,
-- 
2.17.1


