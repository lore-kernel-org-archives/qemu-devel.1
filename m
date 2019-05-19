Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D04C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:32:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5A320578
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yNOh/qnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5A320578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53937 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTPY-0008MK-Ux
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:32:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSa3-0003zR-5a
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSa1-0004w6-Rg
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:51 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:32992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSa1-0004vH-HJ
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:49 -0400
Received: by mail-pf1-x442.google.com with SMTP id z28so6189151pfk.0
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=+4pgGcHqpI/1ayoviAyV/bToyhUBomMihY7gyQ1lsgY=;
	b=yNOh/qnBcfc5fIBsPkbMKp0aWj5JMGBfKFKQuWBaSZTKRjfxkpgNhxvNaDzlLjCYqs
	TBrqkqUE3q6+xcHx14kx7BGthawXJrn7hA6SwtgdfUST9H87q10uzV7pgPHZy5xoBmmT
	njOXPTa/zL8C2VlkoQLT1vPUn1nfwFF67WuZJy8lPiVxL2/aAZlYNpvW5sKBCYrBTFoP
	3UX52KZDgSlYFnIGePYlIvDdzCAm8d1porwbeQENJQxcYceAIlqQxH1GAGMdlFVaL4DX
	mu1/gDeY8HF0lX2dupdU/NoxBswx5V5zRU/b70NHoKPMb1f6fYv+k2p/X8i/W189OSV8
	FtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=+4pgGcHqpI/1ayoviAyV/bToyhUBomMihY7gyQ1lsgY=;
	b=EkKP9tFDzIMKcPTOMkMn3YrKn5NCj9LZBsDIWBaIEXsVbAM7m7dDNeDHBhFwDnE9d6
	U/7D1qkKygAI7azu3yJ3UdwXAo3kjG5dskyMMhITJKP9dJvd9LX3jZeHFReHK0dnZdI0
	xvZ2xVPw+f7qyvWs7BgvdrC2bIRpNapJkzZBcmWOIfe+qUdE6AAPtfZKF1s6nDuDVFvC
	5eb38mh+uChI8gaHyG7ae3Pk4pKoWeqIPcYprpxJf1ZODv8XJnm5EUB3Aup5VY+n0qnm
	FotfYPh8pR/thmm6NMsgpLRADP4aokVaisT/F0VLOJmZJzSmsgnKqXbStHwXgUMcXCgf
	tAuw==
X-Gm-Message-State: APjAAAV0yZh26cL2FLaRrBmJhBneTXzNWUR2zC7dgWWo/MVBF+O7jgtn
	F+ysKiJuRGrTWCen//gmYZDvp045ZYU=
X-Google-Smtp-Source: APXvYqxkqJAtq4uIY7sdluBmYGdBzclSAejJp4b/ZEH3udkVuuRfNTMJV3T0YIVrbWFXy/u+dzH5Sw==
X-Received: by 2002:a63:6a4a:: with SMTP id f71mr70548969pgc.44.1558298328375; 
	Sun, 19 May 2019 13:38:48 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:16 -0700
Message-Id: <20190519203726.20729-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v7 64/74] linux-user: Split out gethostname,
 sethostname
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
 linux-user/syscall-defs.h     |  4 ++++
 linux-user/syscall-proc.inc.c | 28 ++++++++++++++++++++++++++++
 linux-user/syscall.c          | 19 -------------------
 linux-user/strace.list        |  6 ------
 4 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 77d750f66f..3ba697fd53 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -59,6 +59,9 @@ SYSCALL_DEF(futimesat, ARG_ATDIRFD, ARG_STR, ARG_PTR);
 #ifdef TARGET_NR_fork
 SYSCALL_DEF(fork);
 #endif
+#ifdef TARGET_NR_gethostname
+SYSCALL_DEF(gethostname, ARG_PTR, ARG_DEC);
+#endif
 SYSCALL_DEF(getpgid, ARG_DEC);
 #ifdef TARGET_NR_getpgrp
 SYSCALL_DEF(getpgrp);
@@ -207,6 +210,7 @@ SYSCALL_DEF(semctl, ARG_DEC, ARG_DEC, ARG_DEC, ARG_HEX);
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_semget)
 SYSCALL_DEF(semget, ARG_DEC, ARG_DEC, ARG_HEX);
 #endif
+SYSCALL_DEF(sethostname, ARG_STR);
 SYSCALL_DEF(setpgid, ARG_DEC, ARG_DEC);
 SYSCALL_DEF(setsid);
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_semop)
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
index 567df54581..b1a801fb62 100644
--- a/linux-user/syscall-proc.inc.c
+++ b/linux-user/syscall-proc.inc.c
@@ -438,6 +438,21 @@ SYSCALL_IMPL(fork)
 }
 #endif
 
+#ifdef TARGET_NR_gethostname
+SYSCALL_IMPL(gethostname)
+{
+    char *name = lock_user(VERIFY_WRITE, arg1, arg2, 0);
+    abi_long ret;
+    
+    if (!name) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(gethostname(name, arg2));
+    unlock_user(name, arg1, arg2);
+    return ret;
+}
+#endif
+
 SYSCALL_IMPL(getpgid)
 {
     return get_errno(getpgid(arg1));
@@ -485,6 +500,19 @@ SYSCALL_IMPL(nice)
 }
 #endif
 
+SYSCALL_IMPL(sethostname)
+{
+    void *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(sethostname(p, arg2));
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+
 SYSCALL_IMPL(setpgid)
 {
     return get_errno(setpgid(arg1, arg2));
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b8b18ac1de..6dd4196647 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4240,12 +4240,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_sethostname:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(sethostname(p, arg2));
-        unlock_user(p, arg1, 0);
-        return ret;
 #ifdef TARGET_NR_setrlimit
     case TARGET_NR_setrlimit:
         {
@@ -7078,19 +7072,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     }
 #endif
-#ifdef TARGET_NR_gethostname
-    case TARGET_NR_gethostname:
-    {
-        char *name = lock_user(VERIFY_WRITE, arg1, arg2, 0);
-        if (name) {
-            ret = get_errno(gethostname(name, arg2));
-            unlock_user(name, arg1, arg2);
-        } else {
-            ret = -TARGET_EFAULT;
-        }
-        return ret;
-    }
-#endif
 #ifdef TARGET_NR_atomic_cmpxchg_32
     case TARGET_NR_atomic_cmpxchg_32:
     {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index b1c2f7851e..361ceec853 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -244,9 +244,6 @@
 #ifdef TARGET_NR_getgroups32
 { TARGET_NR_getgroups32, "getgroups32" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_gethostname
-{ TARGET_NR_gethostname, "gethostname" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_getitimer
 { TARGET_NR_getitimer, "getitimer" , NULL, NULL, NULL },
 #endif
@@ -1025,9 +1022,6 @@
 #ifdef TARGET_NR_sethae
 { TARGET_NR_sethae, "sethae" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_sethostname
-{ TARGET_NR_sethostname, "sethostname" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_setitimer
 { TARGET_NR_setitimer, "setitimer" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


