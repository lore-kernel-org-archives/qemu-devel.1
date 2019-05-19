Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25A6C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:15:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE7020449
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ceaU80lF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE7020449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53672 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hST9p-00029O-RK
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:15:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZs-0003rB-AF
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZr-0004iz-5w
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:40 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZq-0004i4-V6
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:39 -0400
Received: by mail-pg1-x544.google.com with SMTP id 145so5730522pgg.9
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ttWxbzBbz5ihBAO0dy5RNz6XPVqQZ5W6pS6uncyoUTw=;
	b=ceaU80lFl0hNLo3mamAAuO33hhZrmGbtyI7ycPbYg50IMB1ddBC4BHTkQ00WvE1pW+
	qFdLzn5KItuiHl30u+GRqXYe7xaZhA4aI8yMyLyh1MRP+yTG3KXXqLR6LEBhcRNj+Wza
	cfL4hD3ql9eSVgmhDPwZMpsHGpN+lv2WTFlUYF4uazb+C+lWTAuWg+tXH6hcSCtKsRSc
	+DUL44+j1eREW2mmqeOizZFkht7KJs8ND+6MQK3Qa+OYMOhWkKE3ZOdM0GTGd0Km+olw
	tFJbI6eTrYtiqNNUSsYw8kycgw76MjTMNORCpWkQG8/uvatR9lFGTr08bqaMzmBYdFdp
	XcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ttWxbzBbz5ihBAO0dy5RNz6XPVqQZ5W6pS6uncyoUTw=;
	b=DRJKQKBQXh5jDF65mjlI3LLX7D25OUD/BMCLwJ4hRvRjwiSimyx1eke2NLIRXFnabB
	tC11R9A8mhjJixuDh8+7yYFV30PUD9sBZqvnjvj10zkdWnuNL/V2P5o+9H5LPHeGUoDF
	rlR+BlpvFhMmxWXoTG2c2WaSKNkGHXA23FSTteu9LqVYcK/1nF1djuXDCQqU7oAtlarM
	Nvz69BAfPlzOFhhV9/GVkFbbZUySVnHoknp8WFwsh0D9TWaVExx0TllAatunvQwgYJON
	3TkTAfpc6gKz7j31JjZlbg2ui90DWjfQTxmpM+VrWwncgkOvG36lFNnu4cqoxv2l0nZE
	smSg==
X-Gm-Message-State: APjAAAVBSOJ6lk85Qsoeiu0Zc1Nk/VhY1NiPSbQhbWzSq5MHH79LZlhm
	Lvrfp4x1EaNLuiVQpTQH7hn+uqA8gxA=
X-Google-Smtp-Source: APXvYqzESC3LlQaQGPZnHpVh7OjjN/hl2NcJX/DzavPCN82jKNjwnfYR935celpeRsO0Ules0sZsLw==
X-Received: by 2002:a65:6559:: with SMTP id a25mr47363983pgw.33.1558298317681; 
	Sun, 19 May 2019 13:38:37 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:07 -0700
Message-Id: <20190519203726.20729-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v7 55/74] linux-user: Split out getsid, setsid
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
 linux-user/syscall-defs.h     |  2 ++
 linux-user/syscall-proc.inc.c | 10 ++++++++++
 linux-user/syscall.c          |  4 ----
 linux-user/strace.list        |  6 ------
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 2ade9ec749..cd2c127c41 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -69,6 +69,7 @@ SYSCALL_DEF(getpid);
 #ifdef TARGET_NR_getppid
 SYSCALL_DEF(getppid);
 #endif
+SYSCALL_DEF(getsid, ARG_DEC);
 #ifdef TARGET_NR_getxpid
 SYSCALL_DEF(getxpid);
 #endif
@@ -193,6 +194,7 @@ SYSCALL_DEF(semctl, ARG_DEC, ARG_DEC, ARG_DEC, ARG_HEX);
 SYSCALL_DEF(semget, ARG_DEC, ARG_DEC, ARG_HEX);
 #endif
 SYSCALL_DEF(setpgid, ARG_DEC, ARG_DEC);
+SYSCALL_DEF(setsid);
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_semop)
 SYSCALL_DEF(semop, ARG_DEC, ARG_PTR, ARG_DEC);
 #endif
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
index 39de5b7863..567df54581 100644
--- a/linux-user/syscall-proc.inc.c
+++ b/linux-user/syscall-proc.inc.c
@@ -464,6 +464,11 @@ SYSCALL_IMPL(getppid)
 }
 #endif
 
+SYSCALL_IMPL(getsid)
+{
+    return get_errno(getsid(arg1));
+}
+
 #ifdef TARGET_NR_getxpid
 SYSCALL_IMPL(getxpid)
 {
@@ -485,6 +490,11 @@ SYSCALL_IMPL(setpgid)
     return get_errno(setpgid(arg1, arg2));
 }
 
+SYSCALL_IMPL(setsid)
+{
+    return get_errno(setsid());
+}
+
 SYSCALL_IMPL(times)
 {
     abi_ulong target_buf = arg1;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 75989a01bf..0e9f4fd5ae 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4241,8 +4241,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_setsid:
-        return get_errno(setsid());
 #ifdef TARGET_NR_sigaction
     case TARGET_NR_sigaction:
         {
@@ -5664,8 +5662,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         /* NOTE: the flock constant seems to be the same for every
            Linux platform */
         return get_errno(safe_flock(arg1, arg2));
-    case TARGET_NR_getsid:
-        return get_errno(getsid(arg1));
 #if defined(TARGET_NR_fdatasync) /* Not on alpha (osf_datasync ?) */
     case TARGET_NR_fdatasync:
         return get_errno(fdatasync(arg1));
diff --git a/linux-user/strace.list b/linux-user/strace.list
index d283c924a7..bf87a6d4cb 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -292,9 +292,6 @@
 #ifdef TARGET_NR_getrusage
 { TARGET_NR_getrusage, "getrusage" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_getsid
-{ TARGET_NR_getsid, "getsid" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_getsockname
 { TARGET_NR_getsockname, "getsockname" , NULL, NULL, NULL },
 #endif
@@ -1100,9 +1097,6 @@
 #ifdef TARGET_NR_set_robust_list
 { TARGET_NR_set_robust_list, "set_robust_list" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_setsid
-{ TARGET_NR_setsid, "setsid" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_setsockopt
 { TARGET_NR_setsockopt, "setsockopt" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


