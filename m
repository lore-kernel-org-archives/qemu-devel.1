Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2982DC072AD
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:32:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D766E20578
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MW276PEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D766E20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53941 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTPf-0008Qj-3A
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:32:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSaD-0004Ab-Sd
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:39:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSaC-00059o-L2
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:39:01 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSaC-00058x-EW
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:39:00 -0400
Received: by mail-pg1-x544.google.com with SMTP id c13so5748377pgt.1
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=81B5oVWex5Gu+YUrZz7czpuJcnBNioLb7beqWXgK+Ug=;
	b=MW276PEeOF33ylNFozQxdOOz4TXNh6y0F6sLo8pPFZpkVOf33zi0mx3NAOsdQbdU3+
	7uho8rBFL2KXgpj5fqeWy7CVguXwrPipVelVHIcoKAg+4WL/hjTuDwIBvjKTZ4Q0+ZKX
	vNYAiXFY+DOKMHCHwESEySq3ZdqaICyfZBhy29W/aa1xUQAV9wpw40srFj2paVYrZf7/
	y7x9Cs5PBJtN9MBzlbeWV8qJTcu1j0IMXl2wR5qtS4oc7CNPOnRnOD3muDf2RL/3+TvB
	8WkIrnTB1Lx5zaf9Wlljd9AmFWYrw5Pdn6H4RGZd47sn6T2dJDDApZyveZUlYBIrmduo
	73Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=81B5oVWex5Gu+YUrZz7czpuJcnBNioLb7beqWXgK+Ug=;
	b=Eud5Ar/3PYTi++pMudBeCJnx3ZVyE4BCun9M4vo5E8HhOtKiiJ168IyC5bnHSGOK3a
	c5mLU6R2IdOpWli2L1kNghnCE1YiGqSZhw+K4/9+kfsN6Et+bRPpzfAvLcS6MWoCra1R
	QBTZgquNws2PmjoOqNicb/kLqNEAmm+ABlkmoC4VqM2PfKNxo8KBKqo5ZJM0vOzAXFJ5
	T3nrBmbDpV6dvfNIuIiXYmeAf7pmO20+bL5eW3jFCOq+gXIUAtNkThsob3bDgDNmGjfP
	QARoQ758KciYx1DbhaWDXTocpo1FB9uPpVvfoedgZFDpluEgcYTzlwiNFeyGeEUOwdUC
	oW8w==
X-Gm-Message-State: APjAAAVQozMJ5yO9qMG7VrExIoKOgszP4SM3GYH9wdMlZB3/XD7qvTWY
	Xh3qbrHpagXmZ6c1Cpnd1gVpUH8xr+E=
X-Google-Smtp-Source: APXvYqxzxnOih+PS0wJcjWM1nHFueQiUhsKcRChRuuaorbMD3oMf4t+3zDc1Msz1qPIJ8+kxuRYyxA==
X-Received: by 2002:a63:374b:: with SMTP id g11mr15575741pgn.421.1558298339261;
	Sun, 19 May 2019 13:38:59 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:25 -0700
Message-Id: <20190519203726.20729-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v7 73/74] linux-user: Split out truncate,
 truncate64, ftruncate, ftruncate64
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     | 16 +++++++++++++++
 linux-user/syscall-file.inc.c | 32 +++++++++++++++++++++++++++++
 linux-user/syscall.c          | 38 -----------------------------------
 linux-user/strace.list        | 12 -----------
 4 files changed, 48 insertions(+), 50 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 67c908448d..8b2d95d19e 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -59,6 +59,14 @@ SYSCALL_DEF(futimesat, ARG_ATDIRFD, ARG_STR, ARG_PTR);
 #ifdef TARGET_NR_fork
 SYSCALL_DEF(fork);
 #endif
+#ifdef TARGET_NR_ftruncate
+SYSCALL_DEF(ftruncate, ARG_DEC, ARG_DEC);
+#endif
+#ifdef TARGET_NR_ftruncate64
+SYSCALL_DEF_FULL(ftruncate64, .impl = impl_ftruncate,
+                 .args = args_ftruncate64_truncate64,
+                 .arg_type = { ARG_DEC, ARG_DEC64 });
+#endif
 #ifdef TARGET_NR_gethostname
 SYSCALL_DEF(gethostname, ARG_PTR, ARG_DEC);
 #endif
@@ -292,6 +300,14 @@ SYSCALL_DEF(syncfs, ARG_DEC);
 SYSCALL_DEF(time, ARG_PTR);
 #endif
 SYSCALL_DEF(times, ARG_PTR);
+#ifdef TARGET_NR_truncate
+SYSCALL_DEF(truncate, ARG_STR, ARG_DEC);
+#endif
+#ifdef TARGET_NR_truncate64
+SYSCALL_DEF_FULL(truncate64, .impl = impl_truncate,
+                 .args = args_ftruncate64_truncate64,
+                 .arg_type = { ARG_STR, ARG_DEC64 });
+#endif
 SYSCALL_DEF(umask, ARG_OCT);
 #ifdef TARGET_NR_umount
 SYSCALL_DEF(umount, ARG_STR);
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index bdf42ad437..7697cb304a 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -182,6 +182,25 @@ SYSCALL_IMPL(fchmodat)
     return do_fchmodat(arg1, arg2, arg3);
 }
 
+#ifdef TARGET_NR_ftruncate64
+# if TARGET_ABI_BITS == 32
+SYSCALL_ARGS(ftruncate64_truncate64)
+{
+    /* We have already assigned out[0].  */
+    int off = regpairs_aligned(cpu_env, TARGET_NR_ftruncate64);
+    out[1] = target_offset64(in[1 + off], in[2 + off]);
+    return def;
+}
+# else
+#  define args_ftruncate64_truncate64 NULL
+# endif
+#endif
+
+SYSCALL_IMPL(ftruncate)
+{
+    return get_errno(ftruncate(arg1, arg2));
+}
+
 #ifdef TARGET_NR_futimesat
 SYSCALL_IMPL(futimesat)
 {
@@ -1319,6 +1338,19 @@ SYSCALL_IMPL(syncfs)
     return get_errno(syncfs(arg1));
 }
 
+SYSCALL_IMPL(truncate)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(truncate(p, arg2));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+
 static abi_long do_umount2(abi_ulong target_path, int flags)
 {
     char *p = lock_user_string(target_path);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 80e8b360a9..1b1d44bf32 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3721,20 +3721,6 @@ static inline abi_long target_truncate64(void *cpu_env, const char *arg1,
 }
 #endif
 
-#ifdef TARGET_NR_ftruncate64
-static inline abi_long target_ftruncate64(void *cpu_env, abi_long arg1,
-                                          abi_long arg2,
-                                          abi_long arg3,
-                                          abi_long arg4)
-{
-    if (regpairs_aligned(cpu_env, TARGET_NR_ftruncate64)) {
-        arg2 = arg3;
-        arg3 = arg4;
-    }
-    return get_errno(ftruncate64(arg1, target_offset64(arg2, arg3)));
-}
-#endif
-
 static inline abi_long target_to_host_timespec(struct timespec *host_ts,
                                                abi_ulong target_addr)
 {
@@ -4158,18 +4144,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_truncate
-    case TARGET_NR_truncate:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(truncate(p, arg2));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
-#ifdef TARGET_NR_ftruncate
-    case TARGET_NR_ftruncate:
-        return get_errno(ftruncate(arg1, arg2));
-#endif
     case TARGET_NR_getpriority:
         /* Note that negative values are valid for getpriority, so we must
            differentiate based on errno settings.  */
@@ -5371,18 +5345,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     }
 #endif
-#ifdef TARGET_NR_truncate64
-    case TARGET_NR_truncate64:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-	ret = target_truncate64(cpu_env, p, arg2, arg3, arg4);
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
-#ifdef TARGET_NR_ftruncate64
-    case TARGET_NR_ftruncate64:
-        return target_ftruncate64(cpu_env, arg1, arg2, arg3, arg4);
-#endif
 #ifdef TARGET_NR_stat64
     case TARGET_NR_stat64:
         if (!(p = lock_user_string(arg1))) {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 3326541f17..55b617239c 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -193,12 +193,6 @@
 #ifdef TARGET_NR_ftime
 { TARGET_NR_ftime, "ftime" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_ftruncate
-{ TARGET_NR_ftruncate, "ftruncate" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_ftruncate64
-{ TARGET_NR_ftruncate64, "ftruncate64" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_futex
 { TARGET_NR_futex, "futex" , NULL, print_futex, NULL },
 #endif
@@ -1173,12 +1167,6 @@
 #ifdef TARGET_NR_tkill
 { TARGET_NR_tkill, "tkill" , NULL, print_tkill, NULL },
 #endif
-#ifdef TARGET_NR_truncate
-{ TARGET_NR_truncate, "truncate" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_truncate64
-{ TARGET_NR_truncate64, "truncate64" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_tuxcall
 { TARGET_NR_tuxcall, "tuxcall" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


