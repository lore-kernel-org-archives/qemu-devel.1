Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0647BC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:01:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B61C420657
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AyIGZgac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61C420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53450 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSvi-0005Xl-0b
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:01:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZI-0003No-Ro
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZH-0003z2-Os
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:04 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZH-0003y7-IH
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:03 -0400
Received: by mail-pf1-x443.google.com with SMTP id 13so6157230pfw.9
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=F+fKej9fPmaDrSPzKASFQtBx9UbES7Ex48WVScqi++Y=;
	b=AyIGZgacVo1RSvmJgHsjrxMNdHL0qO6O7OQoHEIjI6sQOu1zg1i8IuMjvWUDjcCCGO
	yW/1kZUtgIhqnnlF5WbemkE/r0epfOs0FbhBW8lbtEA6aK42VKZOHGlhBVUnu8CLCUoJ
	Di/UinbDRth9n8uSqEMu4N+9OxNqet3+w9pns9w5KdAXGJQOGwd0xtvU/6CFhkvhSrWT
	Bpi7hvMEI2Zb3QdWZko78kSNgewVZENWmqhwNRTe+c3wUj1I3B7tusF4XA6opr1xTpbO
	shNs8SmS7BN5Oihg0fqJsLQ4PNtI1LSJm4yTHg0qOhji1sDU4gyqvpQhIA6q0MUh6CC6
	T4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=F+fKej9fPmaDrSPzKASFQtBx9UbES7Ex48WVScqi++Y=;
	b=Ry2QXvOqb6LQl2ZWr6omxRW9LiE/5rrVTRNJfRdFtdAcDDdiN//1CBrozlq5IikZpL
	zlhnLsJalazoBbX1geDvTxBgFaMrrNstohyxFnabe0MA9La23Cg37ehEur+MdwS7WnmP
	YPjDL/KUSCOOUHwP7qD44iZBe6bq60wqz7KmUR3qbOIfwBVmKeLb2KQ/dfqM+yXayb2d
	8Ll5OaojnuWXuTmCu6y6aJA6iNGSps0urjh4VHh6TdfQM3lvq59wy9kJpRAIF6LTqFJF
	qUUZjLmTnpdzMWRDNHSQ6tlANO6DfEAHm0NobkNrcE+uuSMFvf24icAlKRMVzIGeYn5w
	888w==
X-Gm-Message-State: APjAAAVQOY94pO0utIt/w07+A8ZWa/7l6CUDWUzbJiPCUW/PB0xMek/p
	Azo9Z3HxgBUMzdcwx+3GoEAzXTlHLtI=
X-Google-Smtp-Source: APXvYqyJCY2nR0ZQQtVLHkL0GjYYLfqIhte6lhILpp06gc3oX0Sdh8iN0NVGyyEG2uGk+Fsg0yq9Zw==
X-Received: by 2002:a63:d354:: with SMTP id u20mr22999650pgi.129.1558298282395;
	Sun, 19 May 2019 13:38:02 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:37 -0700
Message-Id: <20190519203726.20729-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v7 25/74] linux-user: Split out chdir
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Note that chdir is universally provided.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  1 +
 linux-user/strace.c           | 12 ------------
 linux-user/syscall-file.inc.c | 14 ++++++++++++++
 linux-user/syscall.c          |  6 ------
 linux-user/strace.list        |  3 ---
 5 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 392bd1579c..3fad9d51f0 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -19,6 +19,7 @@
 SYSCALL_DEF_FULL(brk, .impl = impl_brk,
                  .print_ret = print_syscall_ptr_ret,
                  .arg_type = { ARG_PTR });
+SYSCALL_DEF(chdir, ARG_STR);
 SYSCALL_DEF_ARGS(clone, ARG_CLONEFLAG, ARG_PTR, ARG_PTR, ARG_PTR, ARG_PTR);
 SYSCALL_DEF(close, ARG_DEC);
 #ifdef TARGET_NR_creat
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 9d6c765715..b234274034 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1113,18 +1113,6 @@ print_access(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_chdir
-static void
-print_chdir(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_chroot
 static void
 print_chroot(const struct syscallname *name,
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 5acd8ecc10..76637fe71b 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -16,6 +16,20 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+SYSCALL_IMPL(chdir)
+{
+    abi_ulong target_path = arg1;
+    char *p = lock_user_string(target_path);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(chdir(p));
+    unlock_user(p, target_path, 0);
+    return ret;
+}
+
 SYSCALL_IMPL(close)
 {
     int fd = arg1;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index affcd81273..0bf5901014 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5384,12 +5384,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_chdir:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(chdir(p));
-        unlock_user(p, arg1, 0);
-        return ret;
 #ifdef TARGET_NR_time
     case TARGET_NR_time:
         {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index c6bb475728..3f79159b63 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -61,9 +61,6 @@
 #ifdef TARGET_NR_capset
 { TARGET_NR_capset, "capset" , "%s(%p,%p)", NULL, NULL },
 #endif
-#ifdef TARGET_NR_chdir
-{ TARGET_NR_chdir, "chdir" , NULL, print_chdir, NULL },
-#endif
 #ifdef TARGET_NR_chmod
 { TARGET_NR_chmod, "chmod" , NULL, print_chmod, NULL },
 #endif
-- 
2.17.1


