Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89896C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5967B20674
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="aCEtzqZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5967B20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg6c7-00065Y-FP
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 09:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jg5UP-0000Ux-4W
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 07:53:53 -0400
Received: from mail-db8eur05on2098.outbound.protection.outlook.com
 ([40.107.20.98]:20705 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jg5UO-0000f1-68
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 07:53:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkyhJ/yHNtY6twerRAx2RK14DAJ8kLDlCS2R0V3gXB5212lUsVCFkWrthII5hQfWqTP22xVZQBYWqmPURgypgAULb7qCCoysO5CQmsB3IwHOQ+KQWkGXIDSBcY/CtWsQ3V3ChklSpkBrAqy1CcqdhSb4rsKxvWIkPze5viGn+LZOry7M4D9qy6R22aKbT87zFOfKmEVu3eWgYBwIgZYvnp+2KYkS71cw3Ujjg3fdpNSQWZPGL5GjpAolmLA/vFJGxuApZ9Y/IkDnwcyBW9Ux0n115lhWn0AwLngxuRXIcvoUMLaZ/3nLLjL8hkqHk3aYvMLBxqeoRNFATC74LcUWQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Acd1e1xFA/AYPEDvIYK7p2CNjbLwUHIdO8rjhtxLmMY=;
 b=d/okAP2JZwjHU8WE+BGTC4pyPKA/V2w/90g0x5UUOJuGe1EceSIEy+tmpuReUqiETh0a+2v4ksWY7soIpg4Xu33D4K5ZdQb/WyAt1LRoNJjoTXnDH7eToJDIyWYOleQEOQ1aEPY1OuvfAYt4PTXXkuTQ4KSv+ggqY7VefF1/siz9hJR7OzxMr3Q38VVBPcZHmux885ZDlBvvPFpMH08Nycw+nxZ2FhhetdhHjbTnhS18nrn+lsj+KLLnfmEFI082WIqJlrMnGKE04vHOYK0LZFGUGcA7oiaYf1ZKCJQGpytMg19TiHSoW1qElgad9sb4B111oWMZppLj1vY4hXaVOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Acd1e1xFA/AYPEDvIYK7p2CNjbLwUHIdO8rjhtxLmMY=;
 b=aCEtzqZYp8QDB9AySKfg1B3zR0M8U1h0+SxM1vL6LYrCyUdBl4MOfVetD4cYUY2x7VPaD/W8+b+zhh7SgIpiPs6ZK5ZLNOeN3GU2S11qyyOgWaH0llsykhfcDQyrg5KEt3i78ICbgouTiWAB61F0UtP21Jpq/2yEBcbVJFfZ/Pg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB4022.eurprd03.prod.outlook.com (2603:10a6:20b:22::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.22; Tue, 2 Jun
 2020 11:53:46 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::7935:50dd:e879:bca8]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::7935:50dd:e879:bca8%7]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 11:53:46 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] linux-user: Add strace support for printing arguments of
 fallocate()
Date: Tue,  2 Jun 2020 13:53:31 +0200
Message-Id: <20200602115331.1659-6-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200602115331.1659-1-filip.bozuta@syrmia.com>
References: <20200602115331.1659-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0116.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::32) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 LO2P265CA0116.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Tue, 2 Jun 2020 11:53:46 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e08af5a-896c-4fb9-3282-08d806eb9b57
X-MS-TrafficTypeDiagnostic: AM6PR03MB4022:
X-Microsoft-Antispam-PRVS: <AM6PR03MB40226F4F327B10D7ECB50A91EB8B0@AM6PR03MB4022.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BCAfmFisHOVr6HDfTBbkSx/WyanI7XEY89iSEltfknSIS7dDlN/btFh8YDUU7b0dLc4UwUoW1RTIsiLUfxF39lRBiz4ec5FBII9GGBDnPC2JZ2I5GnjJh+HhgB1jcnRidrY1b7dz6GT8aAHLaIoRv4RUeu7l4NwRrgmfJ55jxGN4UJsU4wR+vCXMNPkW/vIV487K3k8Dv0drQj4RL9ITTesbudXHn4Pp7ShfMtAQFXj5ojhebVTKGebOyRv19mHkeY65b1VvPIN/atQbU5RMQoYiBM0JBwD9WXalo+pfiOo5blTPchcghVfl4h9qbTrWiLDcsXE+CzqSpbRW9PTlH0WU6FxxvNYqn4BC/Y/zwnNwAkTA/9s+MfG8oFN7J9TMahkfmaBeVuY6gn1bJ2FeQP+tlsIU1KKTUqmo2x/O1CuH4vkV8W9QlznO7ldUCOum1/YuAanxhh4ZAZFmXDTn+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(376002)(346002)(39830400003)(136003)(396003)(966005)(44832011)(956004)(2906002)(4326008)(36756003)(2616005)(86362001)(508600001)(66556008)(66476007)(7696005)(66946007)(26005)(8676002)(52116002)(6666004)(6916009)(8936002)(316002)(1076003)(5660300002)(16526019)(83380400001)(186003)(6486002)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vC0jEyN856QGyCgi7QjPNGsCeRd9LMFGAnIbpuKH6bhFcApuQ6kn31YWyQE9SkPsLZrUP+vVCYnk35gfepWUchVTNqgoZ5BMTRoMcYbNQI2mF0tKgoqnpZt9FQ+8+rrJq3qkgHxSjG66Ogj7tuhgqOrHe/uRcAQc+lJ2MRl4rd1c+ax/fdwr9qW+/TN/EfAqMDxjkMv/yibXKIgNQF2A3+/ooiQH/+urfVQb5HtOZcyXoidHzzBErTXlhUYMKhC/po42GdiKY8Tp1zLbLf74bKG1dTbx23Z5FwiM93yn+zm2iVo8/y3jEE+gr5UNd8Ak9lT8HQElEaGrB/AAcTV1L7fZwrpZJSrivgdcwgzczF2yN+ev8sXLObGesSyxfkMUME5W7fCEGHxWcmJhdqioZIa4xNcIF07/kjt4nMSX8dC30kqGrLsIXgowmVMToh813dMT27SDIg0zWQ6+Wddy4NjItATlWTGLCe0b/vizyk0=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e08af5a-896c-4fb9-3282-08d806eb9b57
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 11:53:46.8208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pzhu4ODBQUDFT00dERWvRwd/p+UQfeTnzR2p4QDG1gGzTkUe2qNFdb2FAiSbrzhbArZ5q1Iw3RHtZ3flgJ6k6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4022
Received-SPF: pass client-ip=40.107.20.98;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 07:53:45
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
X-Mailman-Approved-At: Tue, 02 Jun 2020 09:04:50 -0400
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
 linux-user/strace.c    | 56 ++++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 542bfdeb91..3998a00bb4 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -34,6 +34,22 @@ struct syscallname {
 #define UNUSED
 #endif
 
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
 /*
  * Structure used to translate flag values into strings.  This is
  * similar that is in the actual strace tool.
@@ -1097,6 +1113,26 @@ UNUSED static struct flags statx_mask[] = {
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
@@ -1514,6 +1550,26 @@ print_faccessat(const struct syscallname *name,
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
+    print_raw_param("%ld", target_offset64(arg2, arg3), 0);
+    print_raw_param("%ld", target_offset64(arg4, arg5), 1);
+#else
+    print_raw_param("%ld", arg2, 0);
+    print_raw_param("%ld", arg3, 1);
+#endif
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_fchmodat
 static void
 print_fchmodat(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index b72f757d3f..d7458ce884 100644
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
-- 
2.17.1


