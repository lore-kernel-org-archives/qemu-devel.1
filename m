Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1651C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D9A8206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="E2p3b/fb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9A8206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPVL-0005l2-MM
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 11:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jjPUL-0004Um-L2
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 11:51:33 -0400
Received: from mail-eopbgr60103.outbound.protection.outlook.com
 ([40.107.6.103]:37760 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jjPUI-0005xt-O0
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 11:51:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyEaY+x26qAQYz1R2X5jUsrL9TBHEECsZWFJnPVExwjQ7vFo1OdSzpl3eVZ364608cNb/sDhq6h/gG2Aqoig+1PNzRIzTf3s6/RpTmj13Xhv8wdaULiCDzck6HLu/zXE+N9P6iBMfVVu7UnKErS0hIzUAd72YUCKvVTkY8vWpyS3HJSKqMf0ygepq9NecjtzRqHLYugy9D3bIrtM+m+crbT3MW39r2/UrcKhlEHM0p0HJ/aJvOFgGk4RK7/TcpR58bcco3Tr4izeMyVmvY85iHWt+oTn5kTIpLOYLW5P+NE3KkYZDNgvRTaWFEMtKCQIm77B2So/O7D8C+TGrwiJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mJJDj45l7kJQ/nSdhCJPa7Sj5e+iEDYbZsLEg0OSKo=;
 b=H0Y8hm2Ni2ZfW9hwSTv1ue8bZe8QcuVejLkgjID5KY5I6eVDRZ6QREBuX9xWJJF88mlLFi1RpY5N3q7+2Z0fyCHs+tabMbLv2yvQPvHAxVi0cIPsdL7XhEUNPoSI9HuO18Y/eSdUpJi8RgTF4HfEPrx5RKPhzzTD402bRGmj05LcCPF+qiXnAdzLG/6ojtbSamMPmj35EHavkcY1wf3ZDr3bQvYi7hXhY4AxKHrF6f1TogryYJElB4kRDLNZFIpR06YhAF9BG18k7cM7trG+aJB2/KUKs1CpD5igYPjr2KR+UrliLwfuo82DoX4g6QWQJhXLLkXKgP1TetRwqMTj6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mJJDj45l7kJQ/nSdhCJPa7Sj5e+iEDYbZsLEg0OSKo=;
 b=E2p3b/fbgpNhu4AD08kPDjqQ7OfWlNfYR44A38Tfsjp8jgmxQngHBBgh9h7qlgV17A2T2s5VHcaT1kiRRl66mPGXz9CSrLpURVPo+GaVSCQFdrncA8lBtK3kRHuM9qPfT20he3k5ZqWMZigHvvXCmXXv79Py0pJNNqwuquU562o=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB6008.eurprd03.prod.outlook.com (2603:10a6:20b:ed::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Thu, 11 Jun
 2020 15:51:23 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 15:51:23 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/6] linux-user: Extend strace support to enable argument
 printing after syscall execution
Date: Thu, 11 Jun 2020 17:51:04 +0200
Message-Id: <20200611155109.3648-2-filip.bozuta@syrmia.com>
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
 15.20.3088.21 via Frontend Transport; Thu, 11 Jun 2020 15:51:22 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62a33594-1eaf-43c6-538c-08d80e1f4a7e
X-MS-TrafficTypeDiagnostic: AM6PR03MB6008:
X-Microsoft-Antispam-PRVS: <AM6PR03MB600876ECA08EB417A91583C6EB800@AM6PR03MB6008.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 30bKeJhbzKVj6qqSglOwdvPQvuXvvc3ZCxfaW+tkC13x0/EXwZq27uvo2sdM2j4KLz3mK77MpxT/kgwz0vEqS01LcF0Nkvkg3WjDRLbU9XwpJGQUmqXdt14fY1DTo+4aPbPhn1S3+3JtSH+NReUSzO+moiqV1xjS0qPVJKOH2hoH5dHvg+/zwe0D+W/0YKMDgd+cIL+qtpLYXxtoFjd0sW54KtqI/YwKKZBS5ZlpqCQV3OX4dhzug3B3M1HTVvsXRi6YRrKHJdPXPq4R2Nk2lylFKl6S+SvB7F47WxDrJ+JI2bTinN8+weJbnV9rxhn9h1teTA+d9ZtIu0gZZQ/KtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(376002)(346002)(136003)(39830400003)(396003)(508600001)(7696005)(52116002)(316002)(83380400001)(8936002)(8676002)(956004)(2906002)(6916009)(6486002)(2616005)(4326008)(36756003)(186003)(44832011)(6666004)(16526019)(5660300002)(1076003)(86362001)(66556008)(66476007)(66946007)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: a6b+OSsI7hMlcebcb/ON9SrN+ujLAcpYkO/2S1S0bkcVKU/Ca6Hi3kb3JULjsVSk1Bm557seA4TyU22qYDeVlJhQCXYxOapkQM4ZnwGj3MLixdtQjIu86BpTctSfdkF4QnqVsEsvxKhZe2nz697fBHAP4YST6Z8q3egjzjDRV22hgicbeTtXmA83AtiP1JDn3EiiN1JNeN4cqZmR1Omklu2t5zrQX6T+VI5JYJoQ/R5WTdf6JXdQztYK7KYC0LuaQuuoPhDlVNAB1sIRNWxGHq5YXN5SYkRicBv2i+mCN557kJmmXP5sdpcI/pF7d8ozcieQmUYqLVg+hiDcIopD0+x2wpExbI1W8lXvZq+PgGOtWz2p6+qwnxcDtLeKI5Ii8VQaGlmhOpk1F4LNhV9VKzUfPvfxoQ6Vtj/vvZFYqzyzMp8F/mZatAf2LFc4da7wPDimmQDYsbvyEQMbOPAS03OMts+ShcgHSH2JLPfP4cM=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a33594-1eaf-43c6-538c-08d80e1f4a7e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 15:51:23.0762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YzMVuWvxfyRq54g/MKUOjNqJN72YPh0NXuPLmFEdyqrflnwN2UiAIfCV8c+W0MWBuQPW8/m6Z8FT0zHsBm75yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB6008
Received-SPF: pass client-ip=40.107.6.103;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 11:51:27
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

    Structure "struct syscallname" in file "strace.c" is used for "-strace"
    to print arguments and return values of syscalls. The last field of
    this structure "result" represents the calling function that prints the
    return values. This field was extended in this patch so that this functions
    takes all syscalls arguments beside the return value. In this way, it enables
    "-strace" to print arguments of syscalls that have changed after the syscall
    execution. This extension will be useful as there are many syscalls that
    return values inside their arguments (i.e. listxattr() that returns the list
    of extended attributes inside the "list" argument).

Implementation notes:

    Since there are already three existing "print_syscall_ret*" functions inside
    "strace.c" ("print_syscall_ret_addr()", "print_syscall_ret_adjtimex()",
    "print_syscall_ret_newselect()"), they were changed to have all syscall arguments
    beside the return value. This was done so that these functions don't cause build
    errors (even though syscall arguments are not used in these functions).
    There is code repetition in these functions for checking the return value
    and printing the approppriate error message (this code is also located in
    print_syscall_ret() at the end of "strace.c"). That is the reason why a generic
    function SYSCALL_RET_ERR() was added for this code and put inside these
    functions.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/qemu.h    |  4 ++-
 linux-user/strace.c  | 71 ++++++++++++++++++++++++++------------------
 linux-user/syscall.c |  2 +-
 3 files changed, 46 insertions(+), 31 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index ce902f5132..8f938b8105 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -383,7 +383,9 @@ int host_to_target_waitstatus(int status);
 void print_syscall(int num,
                    abi_long arg1, abi_long arg2, abi_long arg3,
                    abi_long arg4, abi_long arg5, abi_long arg6);
-void print_syscall_ret(int num, abi_long arg1);
+void print_syscall_ret(int num, abi_long ret,
+                       abi_long arg1, abi_long arg2, abi_long arg3,
+                       abi_long arg4, abi_long arg5, abi_long arg6);
 /**
  * print_taken_signal:
  * @target_signum: target signal being taken
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 0d9095c674..8678a2aeac 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -19,7 +19,9 @@ struct syscallname {
     void (*call)(const struct syscallname *,
                  abi_long, abi_long, abi_long,
                  abi_long, abi_long, abi_long);
-    void (*result)(const struct syscallname *, abi_long);
+    void (*result)(const struct syscallname *, abi_long,
+                   abi_long, abi_long, abi_long,
+                   abi_long, abi_long, abi_long);
 };
 
 #ifdef __GNUC__
@@ -735,18 +737,29 @@ print_ipc(const struct syscallname *name,
  * Variants for the return value output function
  */
 
+#define SYSCALL_RET_ERR(ret, errstr)            \
+{                                               \
+    qemu_log(" = ");                            \
+    if (ret < 0) {                              \
+        qemu_log("-1 errno=%d", errno);         \
+        errstr = target_strerror(-ret);         \
+        if (errstr) {                           \
+            qemu_log(" (%s)", errstr);          \
+        }                                       \
+    }                                           \
+}
+
 static void
-print_syscall_ret_addr(const struct syscallname *name, abi_long ret)
+print_syscall_ret_addr(const struct syscallname *name, abi_long ret,
+                       abi_long arg0, abi_long arg1, abi_long arg2,
+                       abi_long arg3, abi_long arg4, abi_long arg5)
 {
     const char *errstr = NULL;
 
-    if (ret < 0) {
-        errstr = target_strerror(-ret);
-    }
-    if (errstr) {
-        qemu_log(" = -1 errno=%d (%s)\n", (int)-ret, errstr);
-    } else {
-        qemu_log(" = 0x" TARGET_ABI_FMT_lx "\n", ret);
+    SYSCALL_RET_ERR(ret, errstr);
+
+    if (ret >= 0) {
+        qemu_log("0x" TARGET_ABI_FMT_lx "\n", ret);
     }
 }
 
@@ -760,7 +773,9 @@ print_syscall_ret_raw(struct syscallname *name, abi_long ret)
 
 #ifdef TARGET_NR__newselect
 static void
-print_syscall_ret_newselect(const struct syscallname *name, abi_long ret)
+print_syscall_ret_newselect(const struct syscallname *name, abi_long ret,
+                            abi_long arg0, abi_long arg1, abi_long arg2,
+                            abi_long arg3, abi_long arg4, abi_long arg5)
 {
     qemu_log(" = 0x" TARGET_ABI_FMT_lx " (", ret);
     print_fdset(newselect_arg1,newselect_arg2);
@@ -783,18 +798,15 @@ print_syscall_ret_newselect(const struct syscallname *name, abi_long ret)
 #define TARGET_TIME_ERROR    5   /* clock not synchronized */
 #ifdef TARGET_NR_adjtimex
 static void
-print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret)
+print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret,
+                           abi_long arg0, abi_long arg1, abi_long arg2,
+                           abi_long arg3, abi_long arg4, abi_long arg5)
 {
     const char *errstr = NULL;
 
-    qemu_log(" = ");
-    if (ret < 0) {
-        qemu_log("-1 errno=%d", errno);
-        errstr = target_strerror(-ret);
-        if (errstr) {
-            qemu_log(" (%s)", errstr);
-        }
-    } else {
+    SYSCALL_RET_ERR(ret, errstr);
+
+    if (ret >= 0) {
         qemu_log(TARGET_ABI_FMT_ld, ret);
         switch (ret) {
         case TARGET_TIME_OK:
@@ -2847,7 +2859,9 @@ print_syscall(int num,
 
 
 void
-print_syscall_ret(int num, abi_long ret)
+print_syscall_ret(int num, abi_long ret,
+                  abi_long arg1, abi_long arg2, abi_long arg3,
+                  abi_long arg4, abi_long arg5, abi_long arg6)
 {
     int i;
     const char *errstr = NULL;
@@ -2855,17 +2869,16 @@ print_syscall_ret(int num, abi_long ret)
     for(i=0;i<nsyscalls;i++)
         if( scnames[i].nr == num ) {
             if( scnames[i].result != NULL ) {
-                scnames[i].result(&scnames[i], ret);
+                scnames[i].result(&scnames[i], ret,
+                                  arg1, arg2, arg3,
+                                  arg4, arg5, arg6);
             } else {
-                if (ret < 0) {
-                    errstr = target_strerror(-ret);
-                }
-                if (errstr) {
-                    qemu_log(" = -1 errno=" TARGET_ABI_FMT_ld " (%s)\n",
-                             -ret, errstr);
-                } else {
-                    qemu_log(" = " TARGET_ABI_FMT_ld "\n", ret);
+                SYSCALL_RET_ERR(ret, errstr);
+
+                if (ret >= 0) {
+                    qemu_log(TARGET_ABI_FMT_ld, ret);
                 }
+                qemu_log("\n");
             }
             break;
         }
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff..009bb67422 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12441,7 +12441,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                       arg5, arg6, arg7, arg8);
 
     if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
-        print_syscall_ret(num, ret);
+        print_syscall_ret(num, ret, arg1, arg2, arg3, arg4, arg5, arg6);
     }
 
     record_syscall_return(cpu, num, ret);
-- 
2.17.1


