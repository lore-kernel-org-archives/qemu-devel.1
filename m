Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F5FC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 13:40:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B894221473
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 13:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B894221473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xiyoulinux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53316 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDUVY-0002lO-Rb
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 09:40:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ghorges@xiyoulinux.org>) id 1hDUUm-0002SC-UO
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ghorges@xiyoulinux.org>) id 1hDUUe-0000AV-UF
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:39:29 -0400
Received: from smtpproxy19.qq.com ([184.105.206.84]:51187)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ghorges@xiyoulinux.org>)
	id 1hDUUb-00005D-IP
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:39:22 -0400
X-QQ-mid: bizesmtp22t1554730746tfk8xpip
Received: from localhost.localdomain (unknown [117.32.216.84])
	by esmtp6.qq.com (ESMTP) with 
	id ; Mon, 08 Apr 2019 21:39:05 +0800 (CST)
X-QQ-SSF: A1100000002000508550000A0000000
X-QQ-FEAT: Tp2hW+Mew+dY834xQ3/jsddr0CA6a7tcSjPdj9umDKJAXMdcZhWA7x1fhWvl1
	toyUTJqE04Pa/oJ8hM22n5EA2BpukC9LzVU5wHgUmFE1RRj6QRWh7eWkaDY4ABJgvbISGy1
	1ipVlJkIbl47yjkqtwa/gmDqiBBMEEeLD25VfPKxwpv5lGd1k74l9rxB+Ba+OQ+hYbNohfb
	XEBjREjvmmU4AUwr8as7KUegPyNlWMUX3zsTdNz7cc/4awH09gW7eu3yniVafEjc6N/shrC
	lUPblKjZlKarkg0yFpeDGLmw7dmjOHPzixU7Z7dawWcSIK
X-QQ-GoodBg: 0
From: ghorges <ghorges@xiyoulinux.org>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 21:38:54 +0800
Message-Id: <20190408133854.25737-1-ghorges@xiyoulinux.org>
X-Mailer: git-send-email 2.17.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:xiyoulinux.org:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.4.x
X-Received-From: 184.105.206.84
Subject: [Qemu-devel] [PATCH] Wshadow in qemu/linux-user/syscall.c:Changed
 some variable names
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ghorges <1298394633@qq.com>, riku.voipio@iki.fi, laurent@vivier.eu,
	ghorges <ghorges@xiyoulinux.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408133854.nQrgCTk8MHJiY12RlGNy3VUde2G8ycQC-dXgXeyCN58@z>

From: ghorges <1298394633@qq.com>

Signed-off-by: ghorges <ghorges@xiyoulinux.org>
---
 linux-user/syscall.c | 66 ++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 208fd1813d..985095e4d5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8240,7 +8240,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 size_t size;
             } sig, *sig_ptr;
 
-            abi_ulong arg_sigset, arg_sigsize, *arg7;
+            abi_ulong arg_sigset, arg_sigsize, *arg7s;
             target_sigset_t *target_sigset;
 
             n = arg1;
@@ -8280,13 +8280,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 sig_ptr = &sig;
                 sig.size = SIGSET_T_SIZE;
 
-                arg7 = lock_user(VERIFY_READ, arg6, sizeof(*arg7) * 2, 1);
-                if (!arg7) {
+                arg7s = lock_user(VERIFY_READ, arg6, sizeof(*arg7s) * 2, 1);
+                if (!arg7s) {
                     return -TARGET_EFAULT;
                 }
-                arg_sigset = tswapal(arg7[0]);
-                arg_sigsize = tswapal(arg7[1]);
-                unlock_user(arg7, arg6, 0);
+                arg_sigset = tswapal(arg7s[0]);
+                arg_sigsize = tswapal(arg7s[1]);
+                unlock_user(arg7s, arg6, 0);
 
                 if (arg_sigset) {
                     sig.set = &set;
@@ -9479,14 +9479,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
     case TARGET_NR_getcpu:
         {
-            unsigned cpu, node;
-            ret = get_errno(sys_getcpu(arg1 ? &cpu : NULL,
+            unsigned cpus, node;
+            ret = get_errno(sys_getcpu(arg1 ? &cpus : NULL,
                                        arg2 ? &node : NULL,
                                        NULL));
             if (is_error(ret)) {
                 return ret;
             }
-            if (arg1 && put_user_u32(cpu, arg1)) {
+            if (arg1 && put_user_u32(cpus, arg1)) {
                 return -TARGET_EFAULT;
             }
             if (arg2 && put_user_u32(node, arg2)) {
@@ -10649,24 +10649,24 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_listxattr:
     case TARGET_NR_llistxattr:
     {
-        void *p, *b = 0;
+        void *q, *b = 0;
         if (arg2) {
             b = lock_user(VERIFY_WRITE, arg2, arg3, 0);
             if (!b) {
                 return -TARGET_EFAULT;
             }
         }
-        p = lock_user_string(arg1);
-        if (p) {
+        q = lock_user_string(arg1);
+        if (q) {
             if (num == TARGET_NR_listxattr) {
-                ret = get_errno(listxattr(p, b, arg3));
+                ret = get_errno(listxattr(q, b, arg3));
             } else {
-                ret = get_errno(llistxattr(p, b, arg3));
+                ret = get_errno(llistxattr(q, b, arg3));
             }
         } else {
             ret = -TARGET_EFAULT;
         }
-        unlock_user(p, arg1, 0);
+        unlock_user(q, arg1, 0);
         unlock_user(b, arg2, arg3);
         return ret;
     }
@@ -10686,25 +10686,25 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_setxattr:
     case TARGET_NR_lsetxattr:
         {
-            void *p, *n, *v = 0;
+            void *q, *n, *v = 0;
             if (arg3) {
                 v = lock_user(VERIFY_READ, arg3, arg4, 1);
                 if (!v) {
                     return -TARGET_EFAULT;
                 }
             }
-            p = lock_user_string(arg1);
+            q = lock_user_string(arg1);
             n = lock_user_string(arg2);
-            if (p && n) {
+            if (q && n) {
                 if (num == TARGET_NR_setxattr) {
-                    ret = get_errno(setxattr(p, n, v, arg4, arg5));
+                    ret = get_errno(setxattr(q, n, v, arg4, arg5));
                 } else {
-                    ret = get_errno(lsetxattr(p, n, v, arg4, arg5));
+                    ret = get_errno(lsetxattr(q, n, v, arg4, arg5));
                 }
             } else {
                 ret = -TARGET_EFAULT;
             }
-            unlock_user(p, arg1, 0);
+            unlock_user(q, arg1, 0);
             unlock_user(n, arg2, 0);
             unlock_user(v, arg3, 0);
         }
@@ -10731,25 +10731,25 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_getxattr:
     case TARGET_NR_lgetxattr:
         {
-            void *p, *n, *v = 0;
+            void *q, *n, *v = 0;
             if (arg3) {
                 v = lock_user(VERIFY_WRITE, arg3, arg4, 0);
                 if (!v) {
                     return -TARGET_EFAULT;
                 }
             }
-            p = lock_user_string(arg1);
+            q = lock_user_string(arg1);
             n = lock_user_string(arg2);
-            if (p && n) {
+            if (q && n) {
                 if (num == TARGET_NR_getxattr) {
-                    ret = get_errno(getxattr(p, n, v, arg4));
+                    ret = get_errno(getxattr(q, n, v, arg4));
                 } else {
-                    ret = get_errno(lgetxattr(p, n, v, arg4));
+                    ret = get_errno(lgetxattr(q, n, v, arg4));
                 }
             } else {
                 ret = -TARGET_EFAULT;
             }
-            unlock_user(p, arg1, 0);
+            unlock_user(q, arg1, 0);
             unlock_user(n, arg2, 0);
             unlock_user(v, arg3, arg4);
         }
@@ -10776,19 +10776,19 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_removexattr:
     case TARGET_NR_lremovexattr:
         {
-            void *p, *n;
-            p = lock_user_string(arg1);
+            void *q, *n;
+            q = lock_user_string(arg1);
             n = lock_user_string(arg2);
-            if (p && n) {
+            if (q && n) {
                 if (num == TARGET_NR_removexattr) {
-                    ret = get_errno(removexattr(p, n));
+                    ret = get_errno(removexattr(q, n));
                 } else {
-                    ret = get_errno(lremovexattr(p, n));
+                    ret = get_errno(lremovexattr(q, n));
                 }
             } else {
                 ret = -TARGET_EFAULT;
             }
-            unlock_user(p, arg1, 0);
+            unlock_user(q, arg1, 0);
             unlock_user(n, arg2, 0);
         }
         return ret;
-- 
2.17.0




