Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3049C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BBAA2076B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="xL2+5TS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBAA2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5XQx-00056O-HV
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 12:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k5XPj-0003ni-Ac
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:46:15 -0400
Received: from mail-eopbgr50105.outbound.protection.outlook.com
 ([40.107.5.105]:15741 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k5XPh-0002xQ-Ff
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:46:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMO3eAVm7UF7H6b2KDFkXCqUXahwTkSn2q+n71qXVtOEsbqe79UtI8+hcxksK8wLp4kLlH9vcftAX0FXKmPLw2eNNgVZuecgbSTkR1FC/03At+p1fDQ6V+OE7qSFvwdjF4YVf1VSBnfNvFTYPRX0l06g4SZLhIFPEshwfdvvWlpoaRhkIsB9Qjc+s2Nxtco4Pe+wAE7xdp62QzgK+q6VHvciQRLOP6EiYNC43whdHI3IVvTJEXbYIMXjHvQC0WIOdo59kKgFbUJn386t6Xp27xe6xmVDDDstWTc/P/yYIOODKDgeD8rtPA5QuW0D0mmBbrNcCHeTJUiMSVE9Jf5RFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVAJorsml/0OXlxkEkuRvBk/Ii5+nXBGPfsPBLt1KRQ=;
 b=mDQoLpdpYIedWAG0x/VHhlIUPPMIg/wYJLx2aFNj4yQjJKSG+7HwZwibMqiWAYrakcYqtB6mu/JIdCQ2GivLaINDKh5RX/J2YTf/EjhybT7xbMqJBgzSycIdsnm6gDt4lhd8DjA6DC5dlx1XAbbce23uvGRviaoFHxal0fChcSTm8A6yxWP/gIPnsGFm1OOaowwhK6eA+4Kn52k2mIXCWwr9z9jigBRU7xVWmOxY6h/legjoGKAOWt486PuDspN9LOiyGRm5VDzvahKbpafP/OALmbsxhuX/u2PxDM1W0etCP37Nqs+xRR5c18NBNjd7+qbtkLjvWRYtpna+o0nrjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVAJorsml/0OXlxkEkuRvBk/Ii5+nXBGPfsPBLt1KRQ=;
 b=xL2+5TS8bZMrJW8DrzfoD5y6MTbIy2b0/DzaqP8oEjTgWgFeUQfvhayQh8zgHVjof5BoGoyYw209U5K8+Vyj31ZFl/ieaR070xVpoa4vbcGpkG+Q6gFg1Mk3GZeliM7Iv33y9xF26Enh5XHfDHbel+taipu2+sUYGuanIfKQks0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB3662.eurprd03.prod.outlook.com (2603:10a6:803:3a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Tue, 11 Aug
 2020 16:46:08 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 16:46:08 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/5] linux-user: Add strace support for printing arguments
 of truncate()/ftruncate() and getsid()
Date: Tue, 11 Aug 2020 18:45:50 +0200
Message-Id: <20200811164553.27713-3-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200811164553.27713-1-Filip.Bozuta@syrmia.com>
References: <20200811164553.27713-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::13) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 LO3P123CA0008.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:ba::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.16 via Frontend Transport; Tue, 11 Aug 2020 16:46:07 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c079c073-1bc7-4214-acca-08d83e160bfd
X-MS-TrafficTypeDiagnostic: VI1PR03MB3662:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB36627C2B361377850CA723CBEB450@VI1PR03MB3662.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ltm1l0jKi1v6h+kgXBVndvnPYumMnG7JzSaaqka4Uw0yXISufSyeVMAzeOgI9sSZbj3CFs5RjXSnNRFNkOWVcAo6ke9cWrT+BMEJP6hnCIRSrAhF1yfYz+4G35Y+aPfap/VaRoD5vCAcO5ZrY4yUvi04ShyLgTt1R4RzaalQdQDLygslmBRyLW5D9J0Oo6wGIIpUOe7GFDN5c665Thltbq4IPlwbzy4MDNupGM7q8fOzm1d1a/cW2NtYvek+liTPASqt1FNEefJOrzg+FxRxBNAs64mcg9r1r6F2HLwfByWh8SVGYsavMdjL9tnG/cmj3xa7VLjCF6U5+IzuDvhdfU6AJRx39z9uQXAj4vCxiukdQJ0HeQozdlvDDI1fv01f9GGicVXbFtODV94LDbjbVJoyyZftHpX0yNzs57qfCL6AMReCROFSV3dxZnrhRznwCjjUm/O/bTmWLbL5Ncp/xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(376002)(396003)(366004)(39830400003)(136003)(956004)(2906002)(508600001)(6512007)(186003)(52116002)(16526019)(66556008)(66946007)(26005)(83380400001)(6666004)(1076003)(66476007)(6506007)(86362001)(54906003)(8936002)(4326008)(107886003)(966005)(36756003)(316002)(6916009)(5660300002)(8676002)(6486002)(69590400007)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 5a+QNlZm+RGKW1lGmuDo2etAo2NLmq3pcYOZ/mdQtXhqBPqgFTZ4JpuCrdB3eXK9wb/oTQ0hYsqcXqVtYPz/ot5qW4Rz4tZI8I5iUw6i6R8WAvjsaTepJmokH+Cgcqi8/RH3C0cB/FbzuIHRKtTl/q00tLd+aNVZZaBCOALdfXf++aXE0f/jUwlrtZNHRRAf8InNRoQm69+4yzChYb3RnJIDHbDtOIiIpHTPauetoSppF9IAATb9cnq/Xj/sCQA9S0lU84ArnMMzhKZFP1Xiqmu/AGtwoEHGfYuFlN37Hdn7faXFS1ImDnM3bLaOVzCQOG9TOjmllCgWSHF2/UYxJq6T5Kd/QD++/8i8kXIU23a+rWdgWm7fltjOvDpVZnz87VgUXF+k+xnZkr4KFpqcKopCL9HV16dwT298E03KqcrraQyUg4jzkK4zrqswB7o+8CAVdRJ/vDBWoCFviy+jtpAaJMv9oxAOZVN/jremHj7LafMeMfeo+guWB0CU4K7fNR0CViqeCqAJPc0pgohz/Lm2werB+3qLYrrYHMWFBGVziO6O6NLnfRLhANU5rnVUinAfA5EzChwpq9Dv2o53hzy4D01/DGdLzSzdxDGh4B3OZyR1oPMS2a1TLujzAKmHbAxC+0A/q1PLjAcKwLLSww==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c079c073-1bc7-4214-acca-08d83e160bfd
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 16:46:08.6490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nCsfyiLTb8jPxsaY2+kWWFtbXHFR9VU1tB05fHhqNMFgz7EMTx7P9dEorhpVnt3QEpcbWUQLFvM20XKBrIqyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB3662
Received-SPF: pass client-ip=40.107.5.105;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 12:46:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implements strace argument printing functionality for following syscalls:

    * truncate, ftruncate - truncate a file to a specified length

        int truncate/truncate64(const char *path, off_t length)
        int ftruncate/ftruncate64(int fd, off_t length)
        man page: https://man7.org/linux/man-pages/man2/truncate.2.html

    * getsid - get session ID

        pid_t getsid(pid_t pid)
        man page: https://man7.org/linux/man-pages/man2/getsid.2.html

Implementation notes:

    Syscalls truncate/truncate64 take string argument types and thus a
    separate print function "print_truncate/print_truncate64" is stated in
    file "strace.list". This function is defined and implemented in "strace.c"
    by using an existing function used to print string arguments: "print_string()".
    For syscall ftruncate64, a separate printing function was also stated in
    "strace.c" as it requires a special kind of handling.
    The other syscalls have only primitive argument types, so the rest of the
    implementation was handled by stating an appropriate printing format in file
    "strace.list".
    Function "regpairs_aligned()" was cut & pasted from "syscall.c" to "qemu.h"
    as it is used by functions "print_truncate64()" and "print_ftruncate64()"
    to print the offset arguments of "truncate64()" and "ftruncate64()".

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/qemu.h      | 35 +++++++++++++++++++++++++++++++
 linux-user/strace.c    | 47 ++++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list | 10 ++++-----
 linux-user/syscall.c   | 32 ----------------------------
 4 files changed, 87 insertions(+), 37 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 63ddfe86fd..f431805e57 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -706,6 +706,41 @@ static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
 }
 #endif /* TARGET_ABI_BITS != 32 */
 
+
+/* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
+#ifdef TARGET_ARM
+static inline int regpairs_aligned(void *cpu_env, int num)
+{
+    return ((((CPUARMState *)cpu_env)->eabi) == 1) ;
+}
+#elif defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
+static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
+#elif defined(TARGET_PPC) && !defined(TARGET_PPC64)
+/*
+ * SysV AVI for PPC32 expects 64bit parameters to be passed on odd/even pairs
+ * of registers which translates to the same as ARM/MIPS, because we start with
+ * r3 as arg1
+ */
+static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
+#elif defined(TARGET_SH4)
+/* SH4 doesn't align register pairs, except for p{read,write}64 */
+static inline int regpairs_aligned(void *cpu_env, int num)
+{
+    switch (num) {
+    case TARGET_NR_pread64:
+    case TARGET_NR_pwrite64:
+        return 1;
+
+    default:
+        return 0;
+    }
+}
+#elif defined(TARGET_XTENSA)
+static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
+#else
+static inline int regpairs_aligned(void *cpu_env, int num) { return 0; }
+#endif
+
 /**
  * preexit_cleanup: housekeeping before the guest exits
  *
diff --git a/linux-user/strace.c b/linux-user/strace.c
index f0624b6206..7dc239b9f1 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1958,6 +1958,53 @@ print_lseek(void *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_truncate
+static void
+print_truncate(void *cpu_env, const struct syscallname *name,
+               abi_long arg0, abi_long arg1, abi_long arg2,
+               abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 0);
+    print_raw_param(TARGET_ABI_FMT_ld, arg1, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
+#ifdef TARGET_NR_truncate64
+static void
+print_truncate64(void *cpu_env, const struct syscallname *name,
+                 abi_long arg0, abi_long arg1, abi_long arg2,
+                 abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 0);
+    if (regpairs_aligned(cpu_env, TARGET_NR_truncate64)) {
+        arg1 = arg2;
+        arg2 = arg3;
+    }
+    print_raw_param("%" PRIu64, target_offset64(arg1, arg2), 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
+#ifdef TARGET_NR_ftruncate64
+static void
+print_ftruncate64(void *cpu_env, const struct syscallname *name,
+                  abi_long arg0, abi_long arg1, abi_long arg2,
+                  abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    if (regpairs_aligned(cpu_env, TARGET_NR_ftruncate64)) {
+        arg1 = arg2;
+        arg2 = arg3;
+    }
+    print_raw_param("%" PRIu64, target_offset64(arg1, arg2), 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #if defined(TARGET_NR_socket)
 static void
 print_socket(void *cpu_env, const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index a04706a524..8e5303d035 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -258,10 +258,10 @@
 { TARGET_NR_ftime, "ftime" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_ftruncate
-{ TARGET_NR_ftruncate, "ftruncate" , NULL, NULL, NULL },
+{ TARGET_NR_ftruncate, "ftruncate" , "%s(%d," TARGET_ABI_FMT_ld ")", NULL, NULL },
 #endif
 #ifdef TARGET_NR_ftruncate64
-{ TARGET_NR_ftruncate64, "ftruncate64" , NULL, NULL, NULL },
+{ TARGET_NR_ftruncate64, "ftruncate64" , NULL, print_ftruncate64, NULL },
 #endif
 #ifdef TARGET_NR_futex
 { TARGET_NR_futex, "futex" , NULL, print_futex, NULL },
@@ -372,7 +372,7 @@
 { TARGET_NR_getrusage, "getrusage" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_getsid
-{ TARGET_NR_getsid, "getsid" , NULL, NULL, NULL },
+{ TARGET_NR_getsid, "getsid" , "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_getsockname
 { TARGET_NR_getsockname, "getsockname" , NULL, NULL, NULL },
@@ -1535,10 +1535,10 @@
 { TARGET_NR_tkill, "tkill" , NULL, print_tkill, NULL },
 #endif
 #ifdef TARGET_NR_truncate
-{ TARGET_NR_truncate, "truncate" , NULL, NULL, NULL },
+{ TARGET_NR_truncate, "truncate" , NULL, print_truncate, NULL },
 #endif
 #ifdef TARGET_NR_truncate64
-{ TARGET_NR_truncate64, "truncate64" , NULL, NULL, NULL },
+{ TARGET_NR_truncate64, "truncate64" , NULL, print_truncate64, NULL },
 #endif
 #ifdef TARGET_NR_tuxcall
 { TARGET_NR_tuxcall, "tuxcall" , NULL, NULL, NULL },
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index cc76ac61ba..1517096a9b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -501,38 +501,6 @@ static inline int next_free_host_timer(void)
 }
 #endif
 
-/* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
-#ifdef TARGET_ARM
-static inline int regpairs_aligned(void *cpu_env, int num)
-{
-    return ((((CPUARMState *)cpu_env)->eabi) == 1) ;
-}
-#elif defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
-#elif defined(TARGET_PPC) && !defined(TARGET_PPC64)
-/* SysV AVI for PPC32 expects 64bit parameters to be passed on odd/even pairs
- * of registers which translates to the same as ARM/MIPS, because we start with
- * r3 as arg1 */
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
-#elif defined(TARGET_SH4)
-/* SH4 doesn't align register pairs, except for p{read,write}64 */
-static inline int regpairs_aligned(void *cpu_env, int num)
-{
-    switch (num) {
-    case TARGET_NR_pread64:
-    case TARGET_NR_pwrite64:
-        return 1;
-
-    default:
-        return 0;
-    }
-}
-#elif defined(TARGET_XTENSA)
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
-#else
-static inline int regpairs_aligned(void *cpu_env, int num) { return 0; }
-#endif
-
 #define ERRNO_TABLE_SIZE 1200
 
 /* target_to_host_errno_table[] is initialized from
-- 
2.25.1


