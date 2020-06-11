Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE0FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B44E6206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="CalH6y+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44E6206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPZM-0002Em-V9
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 11:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jjPV1-0005aR-NX
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 11:52:15 -0400
Received: from mail-eopbgr60094.outbound.protection.outlook.com
 ([40.107.6.94]:37766 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jjPUz-00068R-J3
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 11:52:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awl0Br0IZyqjN9cjjxEGfCaDKSHYHJLlz8hrIg7er90dnao8WFqKKlzpwOILMj0qCm0Uzf+CPy1/LK1AUrPqaYb5sSGKA6sNW/jkkRPyrjGJlLKi6nhrPQEAy833Ht8rJ04yz+T+zgSgJQArRlYh/JIbzNfIBcHTnWXF4czHOa9aAVv7+ckAlqVzN2CAB2cGjAAO3fLdZhAIl0o9L11IypUiNx9HYU/DiL/CRv75n2OtZ2KLRGJ7Rh3bgOeong6epUh9ziM5eeYmssMejfS5i0JFJBF4qyaIRoUMmFMfCBemXCjM9h76BFK9m7wrlQcCZSqN97RpdBG1Q3UxuLVZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OVMzrXMGnIAEA5NqHkQ8tKzo3Ds1FwZ3f+KSepE1dg=;
 b=dtan0Tz846It9gY6XnkIaTF5cUjZefI24kibRNDw+YJkRknrsy/PqOi5DcFyjRm9DML8gQWWaCEf1HZm64ZjlplSGXSQQqjJu8yvBSgM+W8ZngXiFvgJncOi9+Kyxk71+p5hdAOinmf2ox/YXMr2SHAS7zemzd3yrxW144zNuRYROTI7i9BGI97Usa/wfNMQE+EhVXbjv+Yu3YbQz+SfNJstNTT0R/Pq7DOSp00xaPBbuEDZDmr8vxkPG1IZAFSwDHHMhZUYkJx4N+asSAaqIeDkiHGiis6wJD/ot1dOZ+EcAzWKg3id3eKXd2ifw8DHncEKjqtKSWBDYvR7MAKG9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OVMzrXMGnIAEA5NqHkQ8tKzo3Ds1FwZ3f+KSepE1dg=;
 b=CalH6y+P5+hQfEcTzbyb+WZpJmm5m0n/m+7+Rs+NaIUQbEbi8yk+WDFbqYxF7k9sXlO+RP4GgxLMR3a8ebijp1zQ5ugiDGez7n3IXEuMZzNJyWMqi0L1WC4cgpwOptZAlg+i/JO17FfAMwUqLCMl6Ty6AbAn26WI/B9qzMil870=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB6008.eurprd03.prod.outlook.com (2603:10a6:20b:ed::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Thu, 11 Jun
 2020 15:51:25 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 15:51:25 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/6] linux-user: Add strace support for printing arguments
 of fallocate()
Date: Thu, 11 Jun 2020 17:51:09 +0200
Message-Id: <20200611155109.3648-7-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200611155109.3648-1-filip.bozuta@syrmia.com>
References: <20200611155109.3648-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0031.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::18) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZR0P278CA0031.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21 via Frontend Transport; Thu, 11 Jun 2020 15:51:25 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 155b97cd-7d53-4400-6844-08d80e1f4be4
X-MS-TrafficTypeDiagnostic: AM6PR03MB6008:
X-Microsoft-Antispam-PRVS: <AM6PR03MB600890F1E8B3FA034B08D690EB800@AM6PR03MB6008.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: diy4jJk+5U43oobmMbXo1P8LFH+3GTRgnbA8UxOO9oY6hwDV3c8yBGFtndvDbKJE5jfaUvggSSaIYV9YNvppR8ZiRgMcfXBpO5MGpOrxqVTEGaiOZM8QpBy66UDhWXyJ7iXKgGKFIuXmyc4uSBF0o+JEsudmsW0cgqXKN6ZbdwRBDye0Gi/lhwklIAjM3Tu+hTlg2JcaM6xrmHZ+sKdqW5y91NVyja0q4Jvza7PRcmzT7+23A1tlU5fWYdkyhRbJKzNB3dfhCVhgMu7/3xA6n9e7sRH9u8sBw137kHM3nVgaP/k48ooyoFJklkPalB0mUXtac/pcrMD4pfDenqBVvR8vuZaIeNBC6L3U6+/iyQzqu0ifiaVcmld+JD537EW6mH8zYioG/D8oIz0nd90VltOabsjhZPu/ezruQB9f3NPUspfLH2gTkb3ayTDMqVsu53FZIvXshwI1aRhQtzL0Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(376002)(346002)(136003)(39830400003)(396003)(508600001)(7696005)(966005)(52116002)(316002)(83380400001)(8936002)(8676002)(956004)(2906002)(6916009)(6486002)(2616005)(4326008)(36756003)(186003)(44832011)(6666004)(16526019)(5660300002)(1076003)(86362001)(66556008)(66476007)(66946007)(26005)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: t6rUWnRG/Xq855VzFWuAn6EgtUKlBz7E/EbCtu3XVmneVt4i5Y3Yd3Q3VaPod77vu+TwPobv8J8FG21SQEYnWCFqWzu66VoJiadUW/e588WhUoWBLpWb+YfHkr5bHFEzMiRoLw0lBUsOW0R0HbWpz9Q0I8acbkEjvCM1PCJJYL1d/arcjq+4TIlVeURKCdi56OpUs3cEpO7yRvINXV8MuovjHq7siFyD/r5fwj2J8jhsZ7on4pdqLMS7BC4vN7HS4ZgkVpasD2l0Ol2dwdXjoqCZI+jOc8F4eetqgYFvoygbU8nOPlp/Zy1LxVkwz0iYqTo+G+Amek+Bwf0rp5OhmBec9ZrtpnxKK0yXe3UlOSwTnN/Hf8Sd7PkUZHSubtr3NxnW+JHs29A5UH26HPMUrkUX5OpTd/8GJCGzf6Vc8yC8qOzIhv1f5JP4JEgcD4J9tMZyVN5QDu0W2uPVbtVWm3IWUdoXlRNJGAPu3a7biTk=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 155b97cd-7d53-4400-6844-08d80e1f4be4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 15:51:25.4219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dhYX+JBJGAwLtG4zblfGoWhjeb6M5wDm8weUSwPCARA6RH4f5vOlm5YUOTKwAVGLoZ3h/uANmCARRkQk4yRkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB6008
Received-SPF: pass client-ip=40.107.6.94; envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 11:52:12
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
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
index 40c17f7abe..5f370256e3 100644
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
index 552184098c..05bb91acc6 100644
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


