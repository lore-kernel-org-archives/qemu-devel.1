Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62EEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A96E20781
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A96E20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr1Er-0004bH-Or
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 11:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jr17a-0000b3-H4
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:27:30 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:34775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jr17W-0006J4-QT
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:27:30 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MirX2-1jC9zD2VLI-00eru1; Thu, 02 Jul 2020 17:27:15 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 04/12] linux-user: Extend strace support to enable argument
 printing after syscall execution
Date: Thu,  2 Jul 2020 17:27:02 +0200
Message-Id: <20200702152710.84602-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702152710.84602-1-laurent@vivier.eu>
References: <20200702152710.84602-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:15Cb0Bmyj1TMZtdh8oJw7jlYQovftkTrZjQTP5G1zPpdUI+zUlV
 +FIH/GLVJDTceprewge6lql+9YUMflGP01UFLN03vdIZ/MRW5y9bg3nZXs1n692e4JQmq67
 YwRv3l0xIzKiPIcHPAttC8IGxuaHlQCUPfIxG8D18zPgGakh1uwQCnKSkaEWxnAjtLbYD6U
 Ai97oCtP+DcphnROdvmcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0eWG7K9fXnQ=:Kdt5JJYcEB2SslJkDXII4R
 fE1I5zc15Ib9kV92LwdBbRqxjNraIesUnc7WKyqYvWF+3xBEE7suehkBqUe1Cc3rieJfd5+/c
 rWrmV6JAH0/84xjqOXEqP+AkZRQvoNzLJkWs9DhBqs/qbSP6NszCJLZyDgSrQcgDwrOPr1nN0
 qaJIC2b2gizgKH+l3gIggPoA0s2zTQwkt0LN12pXECH156b+jeF9eXJFJL0VQUfsEyNyxm3xK
 ovGdvP789V6QITLyi48AxRZWDFs+eXS36ek9t56h+kydc+f75IpiJVewtMciPdY1t5HCdf035
 GfhtcXSYk7PNMKLYQ3oozeawFiGdNoOaZY+f+yQb7lyrtRcNaequZ4ZlADYvarr0MdKXiSFgA
 X6BlrDs2YLskwDTgC81hIwj4O1ciUqMe62QonCh9jXZQRupYtDTPkNp4h3cA/j+deQrwlgoHS
 8aJS5EVJpzda3cJi85Uq36toWyYldbwFREPu9e4QlkvA/Hp4zsGzRpO0vIlNHCS9xyBwEMJh/
 2K6NSTexku+5Dl4XK5GoNUep2mMriY1Y472WJ4PK0MsYYxc98mPzi4wQWLQQ0oItxtGuHk73a
 abn6OUInylkwLaw6iQqqCsLkjYZxcykubbqmrnXNRvxFpq06o1w1RsPQZFOv2ON5SCJ7NBHyx
 V+q2HTjAryl5xcmPIuQUBIlf7yH5D16/2kxLyZ5nZNMhNvMdWVx3lx+Htavwsb76iphXMXVs2
 HyECtzkX6o+biwj67vGI1zAtfe68x2TkGT1VxWw3bherI42dspISA52bSiKedR+lDqTtG7RJZ
 1oaIszvn8eCLgCUGz7+3Gi5zdAy3+uKOYdvhdxdWfFL9ugLj1Y=
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 10:57:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Filip Bozuta <Filip.Bozuta@syrmia.com>, Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko <atar4qemu@gmail.com>
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200619123331.17387-2-filip.bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/qemu.h    |   4 +-
 linux-user/strace.c  | 110 ++++++++++++++++++++++---------------------
 linux-user/syscall.c |   2 +-
 3 files changed, 61 insertions(+), 55 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index ce902f5132a6..8f938b8105b3 100644
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
index 0d9095c674f4..62117e8555f6 100644
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
index 17ed7f8d6b59..1b971c06b270 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12565,7 +12565,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                       arg5, arg6, arg7, arg8);
 
     if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
-        print_syscall_ret(num, ret);
+        print_syscall_ret(num, ret, arg1, arg2, arg3, arg4, arg5, arg6);
     }
 
     record_syscall_return(cpu, num, ret);
-- 
2.26.2


