Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA7CC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:43:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B88620644
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N0JHQqNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B88620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53179 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSe4-0007C2-DE
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:43:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZ0-0002tn-BR
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSYz-0003bb-2x
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:46 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSYy-0003aR-SF
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:45 -0400
Received: by mail-pl1-x644.google.com with SMTP id d21so5723612plr.3
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=nuZhVVs0grkA8++mqqAYSgCu6GK8Ulmk49OHI5Gid5E=;
	b=N0JHQqNfxKmMMByWgPuV+E2KnwQJh2aUwKenfhLEps1BNQQOm69z+Lf51CpcuKx+GP
	E6/amsaEG1/0Q0Ne71CAm4hiSCRcJw0mdF4VCwD+5CRBcG4BYlmqDvVhzqPO7slBj3DC
	6nVr8j7UsdW9ubVZ4m4PuFxwPRBPBPLnLT3MbHfaWS8hS3QIDBAE67/bzsxvlxQsXGtv
	rHsr4LvRhgn36ortXh79KOJILn0/dhsJ8vU4FKx+G8w1oiYSrRQPUcmSLMXN6YSKngjN
	2qkKXeWL67f2yxqxQJjMgioVCNWiuoF3q07rDyb8mfgHD91xJh3IIbRtW3DKGAX6A4kU
	1yaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=nuZhVVs0grkA8++mqqAYSgCu6GK8Ulmk49OHI5Gid5E=;
	b=XV7T3Ya/AzpGbMLVjZl1b4ICDyqG/tAdlaPzHAbeq9Q0sLwQxCmmgi8UsZIJhq5FOh
	KgxPuNYNNRGHvipg3aHKXasX5QMhP/iYc48Qam2wyAB/ke2RFkxGSjTGIYjk00r285db
	dJ+zClnQqdBt6CxEySFTde3ZzmsXJQPUot4aYHG7tPn2BX8FeuWojW+6yLmeMVJZ1S98
	6F4EPEXKtLebUnfwPfciTQFEh4XC0vHZ1wBkTuKK771lOCKfv84IpeUKzGGn+I78Il40
	PQdv5hJ4673x/d85/Xgtvwo/eraYJIyVhfgBNC0Y2xV2sxz3udPUKbP1EWjbQDqW2GBy
	Pd1w==
X-Gm-Message-State: APjAAAU4Nx4pO4dO3FUb/0qj95URHpF1TgqIcJMijSg/1nBuCfFlnDcE
	F19BJS7HSNaybhYmA9/YFaHliSLQXRs=
X-Google-Smtp-Source: APXvYqwVSP0OO/yhtqjqnAcj4ng6ET73c+hfLNTliiTTRJGZk016O7ezEijepx31v9XNoKRMvYwbyQ==
X-Received: by 2002:a17:902:201:: with SMTP id
	1mr26870277plc.263.1558298263493; 
	Sun, 19 May 2019 13:37:43 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.37.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:37:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:22 -0700
Message-Id: <20190519203726.20729-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v7 10/74] linux-user: Split out pread64,
 pwrite64
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
 linux-user/syscall-defs.h     |  6 ++++
 linux-user/syscall-file.inc.c | 62 +++++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 36 --------------------
 linux-user/strace.list        |  6 ----
 4 files changed, 68 insertions(+), 42 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 130ba7e344..027793d5d0 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -21,6 +21,12 @@ SYSCALL_DEF(close, ARG_DEC);
 SYSCALL_DEF(open, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
 #endif
 SYSCALL_DEF(openat, ARG_ATDIRFD, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
+SYSCALL_DEF_FULL(pread64, .impl = impl_pread64,
+                 .args = args_pread64_pwrite64,
+                 .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 });
+SYSCALL_DEF_FULL(pwrite64, .impl = impl_pwrite64,
+                 .args = args_pread64_pwrite64,
+                 .arg_type = { ARG_DEC, ARG_PTR, ARG_DEC, ARG_DEC64 });
 SYSCALL_DEF(read, ARG_DEC, ARG_PTR, ARG_DEC);
 #ifdef TARGET_NR_readlink
 SYSCALL_DEF(readlink, ARG_STR, ARG_PTR, ARG_DEC);
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 2297ca1760..43aa6eeeb8 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -323,6 +323,68 @@ SYSCALL_IMPL(openat)
     return do_openat(cpu_env, arg1, arg2, arg3, arg4);
 }
 
+/*
+ * Both pread64 and pwrite64 merge args into a 64-bit offset,
+ * but the input registers and ordering are target specific.
+ */
+#if TARGET_ABI_BITS == 32
+SYSCALL_ARGS(pread64_pwrite64)
+{
+    /* We have already assigned out[0-2].  */
+    int off = regpairs_aligned(cpu_env, TARGET_NR_pread64);
+    out[3] = target_offset64(in[3 + off], in[4 + off]);
+    return def;
+}
+#else
+#define args_pread64_pwrite64 NULL
+#endif
+
+SYSCALL_IMPL(pread64)
+{
+    int fd = arg1;
+    abi_ulong target_buf = arg2;
+    abi_ulong len = arg3;
+    uint64_t off = arg4;
+    void *p;
+    abi_long ret;
+
+    if (target_buf == 0 && len == 0) {
+        /* Special-case NULL buffer and zero length, which should succeed */
+        p = NULL;
+    } else {
+        p = lock_user(VERIFY_WRITE, target_buf, len, 0);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+    }
+    ret = get_errno(pread64(fd, p, len, off));
+    unlock_user(p, target_buf, ret);
+    return ret;
+}
+
+SYSCALL_IMPL(pwrite64)
+{
+    int fd = arg1;
+    abi_ulong target_buf = arg2;
+    abi_ulong len = arg3;
+    uint64_t off = arg4;
+    void *p;
+    abi_long ret;
+
+    if (target_buf == 0 && len == 0) {
+        /* Special-case NULL buffer and zero length, which should succeed */
+        p = 0;
+    } else {
+        p = lock_user(VERIFY_READ, target_buf, len, 1);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+    }
+    ret = get_errno(pwrite64(fd, p, len, off));
+    unlock_user(p, target_buf, 0);
+    return ret;
+}
+
 SYSCALL_IMPL(read)
 {
     int fd = arg1;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8086626707..f636fb8bb3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9404,42 +9404,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #else
 #error unreachable
 #endif
-#endif
-#ifdef TARGET_NR_pread64
-    case TARGET_NR_pread64:
-        if (regpairs_aligned(cpu_env, num)) {
-            arg4 = arg5;
-            arg5 = arg6;
-        }
-        if (arg2 == 0 && arg3 == 0) {
-            /* Special-case NULL buffer and zero length, which should succeed */
-            p = 0;
-        } else {
-            p = lock_user(VERIFY_WRITE, arg2, arg3, 0);
-            if (!p) {
-                return -TARGET_EFAULT;
-            }
-        }
-        ret = get_errno(pread64(arg1, p, arg3, target_offset64(arg4, arg5)));
-        unlock_user(p, arg2, ret);
-        return ret;
-    case TARGET_NR_pwrite64:
-        if (regpairs_aligned(cpu_env, num)) {
-            arg4 = arg5;
-            arg5 = arg6;
-        }
-        if (arg2 == 0 && arg3 == 0) {
-            /* Special-case NULL buffer and zero length, which should succeed */
-            p = 0;
-        } else {
-            p = lock_user(VERIFY_READ, arg2, arg3, 1);
-            if (!p) {
-                return -TARGET_EFAULT;
-            }
-        }
-        ret = get_errno(pwrite64(arg1, p, arg3, target_offset64(arg4, arg5)));
-        unlock_user(p, arg2, 0);
-        return ret;
 #endif
     case TARGET_NR_getcwd:
         if (!(p = lock_user(VERIFY_WRITE, arg1, arg2, 0)))
diff --git a/linux-user/strace.list b/linux-user/strace.list
index c4ae70b485..a11ad3c3c7 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1025,9 +1025,6 @@
 #ifdef TARGET_NR_prctl
 { TARGET_NR_prctl, "prctl" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_pread64
-{ TARGET_NR_pread64, "pread64" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_preadv
 { TARGET_NR_preadv, "preadv" , NULL, NULL, NULL },
 #endif
@@ -1055,9 +1052,6 @@
 #ifdef TARGET_NR_putpmsg
 { TARGET_NR_putpmsg, "putpmsg" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_pwrite64
-{ TARGET_NR_pwrite64, "pwrite64" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_pwritev
 { TARGET_NR_pwritev, "pwritev" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


