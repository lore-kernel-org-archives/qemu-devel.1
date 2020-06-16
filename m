Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1472AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:44:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB0820767
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="zBMXSqpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB0820767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl94R-0004xD-Vf
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jl90X-00076f-Es
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:39:57 -0400
Received: from mail-db8eur05on2134.outbound.protection.outlook.com
 ([40.107.20.134]:62689 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jl90V-0002xj-F6
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:39:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtQc04IA7kEfq41fesGfPl2K2W565T9hMB5eSdK4I0lijmhM12GjgGTGlQhwiqmWQdFH4t3lRObc5CvE3oAkscjC/XuBefWXQJ4omlQs4PHTm4m2oXqlN9VbWOnh7bOwWSLkq6si9rIdP9D1qG057DBLDWaTbnGq3VT+D4P0Yp6Di3qNF9bnLHITvdOMPXVkg0tj28SID+HFKmnx+6Ah0dG6ZbNxQ4Jh8o+1GiDMJjs9rmfk0A/3EqyAOvdTQdQh0q5OfwNQK0rmb/ngHhvDj3BjlfYfagqDmD+9uGb37my5IatLhWMbiHo1HdUXQGa1k83XDETn11qRAmbds86B7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiQL0LEJsy8L/HVFkhcy2wY3b8AoF1LERO0tqnpf48w=;
 b=Y25mZO16HvLQDI3k674Up2PEaLzS77/A+YmKvZ8OWuaNOKwdJ/qnMAuWBcvQDh/aGfVe/OHwep0/cMwa5p2HKObEue1/0HUvcg0MlRzHi2dw/0ICGKJ7WOghWPi1c3I5MGfQikGWgvAOFpOOVs7wKJEAblrfgJTY4flIDLVWUXFDwJvMAzRNlhiVt4NzxtcYl6XOMG/DA6TeffiCf5D3uzT9ruD3Zykv2keqzHjeHi+TixbDSjKRbejuFO4EFxPdgGZrKsIJRDuqRVfsBp7Su0UQp/WMNWvxQ1037IsYgvoXPnEfIsDHOj1b1QW/MaoAOd9YZoGC48pW9I82rqTAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiQL0LEJsy8L/HVFkhcy2wY3b8AoF1LERO0tqnpf48w=;
 b=zBMXSqpTqKlACyrX0yZYtbSIJbZ0l84PB9cucCD65n/o/yAsHsDIs894ixqM38h84qiwYesig3rMf0JSxPf+1YK6nkL1vbPtnaNF/a/wBbwLLI7n6JlQ+c6rWey+NTdiy9piUaF9oHKKPYZ3KAFDXKV+j7AYAAWQJnS2U3DH7bY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB3960.eurprd03.prod.outlook.com (2603:10a6:20b:25::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Tue, 16 Jun
 2020 10:39:43 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 10:39:43 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 6/6] linux-user: Add strace support for printing arguments
 of fallocate()
Date: Tue, 16 Jun 2020 12:39:27 +0200
Message-Id: <20200616103927.20222-7-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616103927.20222-1-filip.bozuta@syrmia.com>
References: <20200616103927.20222-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0046.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::15) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZR0P278CA0046.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Tue, 16 Jun 2020 10:39:43 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acca9bef-583f-4372-aa82-08d811e194ed
X-MS-TrafficTypeDiagnostic: AM6PR03MB3960:
X-Microsoft-Antispam-PRVS: <AM6PR03MB3960237FF3F0C8354C727319EB9D0@AM6PR03MB3960.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GEV3kX072+wTJ1MeVPoX7ByUfek5L6QTKNiveDME2qRNHtxC2UnNgALEaTEoS4NU1f3aTAe4RBFqxV/NqV+5yJ2+NRIx2WzSJ2m+7FTqp/QY5yifuqvJndGcDRAGA+YQbrLOcsL4UqpHFaUx0dbW/r6LpDka+0a92zJbFcNvVP51Xo+uGbyhf5wX96Bsnwl9EDz12vnZf0BB/oCy+eqIU5Uri7V8AQN+23InFb4qgA2H4R95OBZNgLCL9LkMkdH4zEnhla9BTbsu8CxKox0OblzAfh6hAIzOPrx7qTsfJkCs8r7F00lYWCykQbgU4UdmZyITYUzfrpxKsLm0rvKXKwzl7L5UWbwUK3PJ7nFG6/NMFiOuYJYWlOP6Uxsdk5JGys85DVgX8d3uL+Quy+0lRQyNss3na0qXT1TOJGUJcm5pywsHSkJAUW9S1Ew9TC02LhFPwQSGH2FenmLNcwvwew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(346002)(366004)(39840400004)(376002)(136003)(966005)(5660300002)(83380400001)(86362001)(508600001)(8936002)(316002)(6666004)(66476007)(6916009)(7696005)(36756003)(2616005)(52116002)(66946007)(66556008)(956004)(44832011)(26005)(1076003)(2906002)(4326008)(16526019)(6486002)(186003)(8676002)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: i88j/+rrDFLfw4PJRyI/ICYavxnsoaK+SFQtXSLK5e+X6TfSq+3UweDYLUke5RS4Nn6bPXo6eo8mkOuMKmJr0E3TKEjyFuQqpAE3KI/gV0snslheyZlgugBLwyH7HDTo6tMXuTsx2bQadagZQPSgFYNF76U2T4vXgEdEzbDrIqitIOgVOxS21MYN3wYG6btnCi/zfo46MigKvraYSCGdjEoFZK77zT8s6QtGPkmP5fGL6Ii3NnP5Y3TuA5mML/tSPfGVdQG+PFGPLXJOy+pAHQxUO5NoeQpa2ycAMupzI3nK3nX1LcFjQvC9f0+YUVVRYJ1uwvqk+t3G8opfQ71UnZrGrvW6pT9uVOIzSRiViKwKAkmLcMiEkZDuJN5a1Ip4ojqhd+RrvyeZ4uYPJmPX73BQYKxc0bX1qTvhg4czUvxvrOdv8ZaunXzq3N5u/on4gbHYViZIdsQinE08OVVaHnlJM8WxOg7RD8CCyilRavI=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acca9bef-583f-4372-aa82-08d811e194ed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 10:39:43.7922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DD7ikh0pypp7LXVLn3op/Q9X3nUYBYP8zadNpsQLSB12y4tCK9D3CFB2CVBfd4DqS246ZZLWf5OVh1s9+eV6GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3960
Received-SPF: pass client-ip=40.107.20.134;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 06:39:47
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
index f44ab0ab84..4dbed81a55 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1143,6 +1143,26 @@ UNUSED static struct flags statx_mask[] = {
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
@@ -1560,6 +1580,26 @@ print_faccessat(const struct syscallname *name,
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
index 633f43f490..10e3e4a814 100644
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


