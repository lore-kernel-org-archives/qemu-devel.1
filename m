Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE7CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96F6F20732
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="Oix284gR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F6F20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGEZ-0000Fc-Rd
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jmGDY-0006wg-C0
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:34:00 -0400
Received: from mail-eopbgr00110.outbound.protection.outlook.com
 ([40.107.0.110]:51142 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jmGDS-0003z4-9z
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:34:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTMJZkcNSV6urbsfkDU2slb5dNAxOvswF/kIHVKCcCt6rbgTNZ62pI1G68H7/Vq+vEnkjyOUsrl+2p4ZSzzxUMsXT8RqfCz3aaZvk7jaGHmy01aOcUxlBh5ZsAGPhXXXZy8HoR627pXEGaqZj00OVeNdvnmk3Y1kXak7z5p53naJJvp9PWx7kdEqYFsKEwatJmKnkq5htl1CIh/udhYj7VSYlfkG4b1t2ifah53KUYrkrqO7hDrhVb2wwGm32j32AAUhN1bODSiN+DrdtKkgZUU1Jahvyig44s7W3XFLdCDIFPKAZTALS/xEVlVemL4RV+sCOetUMcJMRDGKBGuNRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmnpLgk7qnIxuFu5ckEsL5ZBIzJNQyL0wv7TpK+aRbw=;
 b=SpUYv7kpQtmP7bmmo48cKCmyk0OF/oh8ykg80ZsKgUBFt0VTPkA/rsm+jOIwSXL82d9QrxgU6oLT253rveH4jiStVEqWI0qJQa8zoBfZtOOrssioyJusaXY1d2Dz7OtgmUFrnT9B1jw46IDY17MIkMy9xFF/qeObOv0Cluqwxh2isknFrU0GBcUk3oSxK9bw4mLELdc7HuRF+s6XgiUYjf+9ILQtJoU111R2HOWxshVD1m0yxyL+ytqspKP5h8FYaC8XVj7mRQFl0yQliL3q4lkb+FjFsiasi6ujuzEfgEC1gUwSKTYGjsQoMHwuhxLY3wxETi/BxkSQn6BuZNAirQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmnpLgk7qnIxuFu5ckEsL5ZBIzJNQyL0wv7TpK+aRbw=;
 b=Oix284gR1EmmLT2bSRuA81srRVKjo1sXdE0TMwHU+Iyu2KD8IGdh6zED09QEecjaW+GbiSnkHh7yNdryzZfqc7xwIh3Psr4kAH773qyHF1i1fQv/GIMb5SpF7gOu6hH2rPQkiUB5512Sd7vpv5eMLQRjJ0/+fdP0NOO4C+hXPp0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5315.eurprd03.prod.outlook.com (2603:10a6:20b:d1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 12:33:45 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 12:33:45 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 1/6] linux-user: Extend strace support to enable argument
 printing after syscall execution
Date: Fri, 19 Jun 2020 14:33:26 +0200
Message-Id: <20200619123331.17387-2-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619123331.17387-1-filip.bozuta@syrmia.com>
References: <20200619123331.17387-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0023.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::10) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZR0P278CA0023.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Fri, 19 Jun 2020 12:33:44 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6129f82a-76e4-48bc-fe6f-08d8144d01c6
X-MS-TrafficTypeDiagnostic: AM6PR03MB5315:
X-Microsoft-Antispam-PRVS: <AM6PR03MB5315A0E16F249DDB0D4890F1EB980@AM6PR03MB5315.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q3p/MjGYBcmAHcPqBbr+uIrYKa2nUl+kJLygqLT1NxGKj/1Umf7zvk9cXHzgHdVkAyrbsvV1x3NpEbb494iAJE0i+zJxiTu4kLUbGvCnBBFDbCsXcNIuC8Cif3NXavtUWoV0e0xgYEod+5Ya0zUXcL8uDVZhPwRoN7/dhhvsGU2A7ZiV/sTNpW5kfP28p91eXDfMItNdMps2nnN1DdIVI4SPqFEVEi6h2T8N/Vti9BuvjIk0J3az3KORo6fw24SPq6wrdo/MritWXf90BbShgzdmKZKEJDEPQNEJbH6JRQnTMyBbn4ihpc6j+pjI2XFdrAngU0/sNZSvf6JYw7dQsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(366004)(376002)(136003)(39830400003)(396003)(7696005)(52116002)(4326008)(186003)(36756003)(6916009)(2616005)(26005)(16526019)(66946007)(66476007)(316002)(956004)(66556008)(1076003)(83380400001)(2906002)(508600001)(6486002)(5660300002)(6666004)(8936002)(86362001)(44832011)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: mxfibeStqlkugSOQJGy1xOapmsVN8D4/2RBYeuAS3JiWhcCi6RuHeOv30QR741v0Z5E8KOSAfhY7U8T4lRsEZ3XRzBEU8FrBoKG+SprlbgQcT0mUAxVP5lmDI7QG1kejLBG9BYD4zdiu6dtmxo0DjsC2K4YsCcOgpz8Q1kLv0hDiTTH2/3G8TgXhPA+AnHS/dqtQNjZ1LXAH+UNM6C/buWL6ix3UTdJgkrC5Zu4x8uO+OYHdluXoABAJZvQLf5Yz/t8PmdmKcsQZckue3F4pbRIWLZ11+oCa8WeyVhUCLVGax0BZUwEAnRAicN1peE8/PFYAM0Owo2U8jdrpgHFgm0U8ie1n/+Hz39A/F058wIVZ1fyAR0LI3uJSTrDo4THouy0E58m98qS3nwYQPNxflfMerTgPlVClUQex/hf2smiCwWSlLlGo/oiWzqYrCSsl24EIu2CKrMaiUdZK3kPkZuATOkvGbYd2nEdGg+SRRA0=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6129f82a-76e4-48bc-fe6f-08d8144d01c6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 12:33:45.0069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XN53AK2k66TenqO8xgGIF87CXhxnaknmill0KPH5b5bbh6Ko5DNudTOd4Sz22E0r/cxrcyj0eOaTJu6JhyJcbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5315
Received-SPF: pass client-ip=40.107.0.110;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 08:33:52
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

    Structure "struct syscallname" in file "strace.c" is used for "-strace"
    to print arguments and return values of syscalls. The last field of
    this structure "result" represents the calling function that prints the
    return values. This field was extended in this patch so that this function
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
    print_syscall_ret() at the end of "strace.c"). That is the reason why a
    function "syscall_print_err()" was added for this code and put inside these
    functions. Functions "print_newselect()" and "print_syscall_ret_newselect()"
    were changed to use this new implemented functionality and not store the syscall
    argument values in separate static variables.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/qemu.h    |   4 +-
 linux-user/strace.c  | 110 ++++++++++++++++++++++---------------------
 linux-user/syscall.c |   2 +-
 3 files changed, 61 insertions(+), 55 deletions(-)

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
index 0d9095c674..62117e8555 100644
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
@@ -631,18 +633,12 @@ print_clockid(int clockid, int last)
 
 /* select */
 #ifdef TARGET_NR__newselect
-static long newselect_arg1 = 0;
-static long newselect_arg2 = 0;
-static long newselect_arg3 = 0;
-static long newselect_arg4 = 0;
-static long newselect_arg5 = 0;
-
 static void
 print_newselect(const struct syscallname *name,
                 abi_long arg1, abi_long arg2, abi_long arg3,
                 abi_long arg4, abi_long arg5, abi_long arg6)
 {
-    qemu_log("%s(" TARGET_ABI_FMT_ld ",", name->name, arg1);
+    print_syscall_prologue(name);
     print_fdset(arg1, arg2);
     qemu_log(",");
     print_fdset(arg1, arg3);
@@ -650,14 +646,7 @@ print_newselect(const struct syscallname *name,
     print_fdset(arg1, arg4);
     qemu_log(",");
     print_timeval(arg5, 1);
-    qemu_log(")");
-
-    /* save for use in the return output function below */
-    newselect_arg1=arg1;
-    newselect_arg2=arg2;
-    newselect_arg3=arg3;
-    newselect_arg4=arg4;
-    newselect_arg5=arg5;
+    print_syscall_epilogue(name);
 }
 #endif
 
@@ -736,17 +725,29 @@ print_ipc(const struct syscallname *name,
  */
 
 static void
-print_syscall_ret_addr(const struct syscallname *name, abi_long ret)
+print_syscall_err(abi_long ret)
 {
     const char *errstr = NULL;
 
+    qemu_log(" = ");
     if (ret < 0) {
+        qemu_log("-1 errno=%d", errno);
         errstr = target_strerror(-ret);
+        if (errstr) {
+            qemu_log(" (%s)", errstr);
+        }
     }
-    if (errstr) {
-        qemu_log(" = -1 errno=%d (%s)\n", (int)-ret, errstr);
-    } else {
-        qemu_log(" = 0x" TARGET_ABI_FMT_lx "\n", ret);
+}
+
+static void
+print_syscall_ret_addr(const struct syscallname *name, abi_long ret,
+                       abi_long arg0, abi_long arg1, abi_long arg2,
+                       abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_err(ret);
+
+    if (ret >= 0) {
+        qemu_log("0x" TARGET_ABI_FMT_lx "\n", ret);
     }
 }
 
@@ -760,17 +761,25 @@ print_syscall_ret_raw(struct syscallname *name, abi_long ret)
 
 #ifdef TARGET_NR__newselect
 static void
-print_syscall_ret_newselect(const struct syscallname *name, abi_long ret)
-{
-    qemu_log(" = 0x" TARGET_ABI_FMT_lx " (", ret);
-    print_fdset(newselect_arg1,newselect_arg2);
-    qemu_log(",");
-    print_fdset(newselect_arg1,newselect_arg3);
-    qemu_log(",");
-    print_fdset(newselect_arg1,newselect_arg4);
-    qemu_log(",");
-    print_timeval(newselect_arg5, 1);
-    qemu_log(")\n");
+print_syscall_ret_newselect(const struct syscallname *name, abi_long ret,
+                            abi_long arg0, abi_long arg1, abi_long arg2,
+                            abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_err(ret);
+
+    if (ret >= 0) {
+        qemu_log(" = 0x" TARGET_ABI_FMT_lx " (", ret);
+        print_fdset(arg0, arg1);
+        qemu_log(",");
+        print_fdset(arg0, arg2);
+        qemu_log(",");
+        print_fdset(arg0, arg3);
+        qemu_log(",");
+        print_timeval(arg4, 1);
+        qemu_log(")");
+    }
+
+    qemu_log("\n");
 }
 #endif
 
@@ -783,18 +792,13 @@ print_syscall_ret_newselect(const struct syscallname *name, abi_long ret)
 #define TARGET_TIME_ERROR    5   /* clock not synchronized */
 #ifdef TARGET_NR_adjtimex
 static void
-print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret)
+print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret,
+                           abi_long arg0, abi_long arg1, abi_long arg2,
+                           abi_long arg3, abi_long arg4, abi_long arg5)
 {
-    const char *errstr = NULL;
+    print_syscall_err(ret);
 
-    qemu_log(" = ");
-    if (ret < 0) {
-        qemu_log("-1 errno=%d", errno);
-        errstr = target_strerror(-ret);
-        if (errstr) {
-            qemu_log(" (%s)", errstr);
-        }
-    } else {
+    if (ret >= 0) {
         qemu_log(TARGET_ABI_FMT_ld, ret);
         switch (ret) {
         case TARGET_TIME_OK:
@@ -2847,25 +2851,25 @@ print_syscall(int num,
 
 
 void
-print_syscall_ret(int num, abi_long ret)
+print_syscall_ret(int num, abi_long ret,
+                  abi_long arg1, abi_long arg2, abi_long arg3,
+                  abi_long arg4, abi_long arg5, abi_long arg6)
 {
     int i;
-    const char *errstr = NULL;
 
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
+                print_syscall_err(ret);
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


