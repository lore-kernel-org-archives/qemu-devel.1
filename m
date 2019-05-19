Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7707C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:02:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D64C20657
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VcrrAraR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D64C20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53458 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSwa-0006YR-RM
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:02:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZe-0003eR-CE
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZd-0004P4-1T
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:26 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZZ-0004He-7N
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:23 -0400
Received: by mail-pf1-x441.google.com with SMTP id g3so6171662pfi.4
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=trhc0Rc4LDpLHBX/8qxpTfKaIrV8kdNRhDojH/u1TVk=;
	b=VcrrAraR3P2FH/TyydTN4gf6E4HL1lu8TIAS/7Mfkdzh/z9NZK0sA3XGseQhRyAA49
	Ey4Pr9FJa5//qsilaJ0hI2O7uNITkYxutxP3x2SIah5gCZuxQeBsr0ZWXFnd5eJNKrGQ
	takqHHTh/tdqUWu8L4TAusVtB3bUTNT89F1kOzFbAbSJWkJEv+/6kXlBoW/dLvpQDIz4
	K7DUhFUwpgZpzFkOs/wzOchMC4wj+iytwdiEICeY/DiEJSrVDSkxdmnhJ/ebgXlR++wR
	zcARnZSYAJZNbN4sRfaRwgJGyExFOJGMJpytcTl75zpYahzn3bie6Gzicem/DfiUpgzS
	/KNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=trhc0Rc4LDpLHBX/8qxpTfKaIrV8kdNRhDojH/u1TVk=;
	b=nWfkZYs0OSfe2NJKuorfY/otK9SL56bQprnm8fwPwvmXvffPM8mhpRs2MoZuY882Bz
	zIZw/AI0EfcXESNGW7NTbaB+LM/sb68dnUHKZY+2kriwgj2Iwcc5VcSCYpJqS0ScEfWB
	/YtdFH5pMLo7Wxt4y28B58Y/5q1Ss24o/4U1Eb7WH/ghGXdHBEyKocJ3l2HmGpWZWPv+
	WkzFb0durPic9Nwtvj7jaw5ZhtfRA4a8kNoj/+Jv7tMTwil/KZTO7hrODNGPWH990nUR
	uBd4JYde0PK2SHgrYw5WoXILBUb0t/tIZJX7UNXR+Ey+a8l6DeXAN4+8hrapNwtJajmH
	T/LQ==
X-Gm-Message-State: APjAAAUaRoIo1OdXXGZzN0QrEMHiScVx5H0Zqck1ZjCsjYrIJHZpoC1H
	iSA1k29InSKAq5lOUM06lXsvwFmvl5g=
X-Google-Smtp-Source: APXvYqyHXyGV4nWVN8OGbAKf1nkwmbGU44qoJ8mwnWMQj5J7z5IVaaQnkhVhYtRoiw5dN0jWmZ5oJA==
X-Received: by 2002:a63:2124:: with SMTP id h36mr70764891pgh.186.1558298298098;
	Sun, 19 May 2019 13:38:18 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:50 -0700
Message-Id: <20190519203726.20729-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v7 38/74] linux-user: Split out sync, syncfs
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

Note that syncfs is universally available.
If !CONFIG_SYNCFS, provide our own syscall replacement.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  2 ++
 linux-user/syscall-file.inc.c | 11 +++++++++++
 linux-user/syscall.c          | 20 ++++++++++++--------
 linux-user/strace.list        |  6 ------
 4 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 860754aaca..497fbdba66 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -171,6 +171,8 @@ SYSCALL_DEF(shmget, ARG_DEC, ARG_DEC, ARG_HEX);
 #ifdef TARGET_NR_stime
 SYSCALL_DEF(stime, ARG_PTR);
 #endif
+SYSCALL_DEF(sync);
+SYSCALL_DEF(syncfs, ARG_DEC);
 #ifdef TARGET_NR_time
 SYSCALL_DEF(time, ARG_PTR);
 #endif
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 5e276d13bc..9f3cf7221a 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -873,6 +873,17 @@ SYSCALL_IMPL(readlinkat)
 }
 #endif
 
+SYSCALL_IMPL(sync)
+{
+    sync();
+    return 0;
+}
+
+SYSCALL_IMPL(syncfs)
+{
+    return get_errno(syncfs(arg1));
+}
+
 static abi_long do_umount2(abi_ulong target_path, int flags)
 {
     char *p = lock_user_string(target_path);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 6d30e8ff2f..d612dade23 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -199,6 +199,15 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
 #define __NR_sys_gettid __NR_gettid
 _syscall0(int, sys_gettid)
 
+/*
+ * These definitions produce an ENOSYS from the host kernel.
+ * Performing a bogus syscall is easier than boilerplating
+ * the replacement functions here in C.
+ */
+#ifndef __NR_syncfs
+#define __NR_syncfs  -1
+#endif
+
 /* For the 64-bit guest on 32-bit host case we must emulate
  * getdents using getdents64, because otherwise the host
  * might hand us back more dirent records than we can fit
@@ -254,11 +263,13 @@ _syscall3(int, ioprio_set, int, which, int, who, int, ioprio)
 #if defined(TARGET_NR_getrandom) && defined(__NR_getrandom)
 _syscall3(int, getrandom, void *, buf, size_t, buflen, unsigned int, flags)
 #endif
-
 #if defined(TARGET_NR_kcmp) && defined(__NR_kcmp)
 _syscall5(int, kcmp, pid_t, pid1, pid_t, pid2, int, type,
           unsigned long, idx1, unsigned long, idx2)
 #endif
+#ifndef CONFIG_SYNCFS
+_syscall1(int, syncfs, int, fd)
+#endif
 
 static bitmask_transtbl fcntl_flags_tbl[] = {
   { TARGET_O_ACCMODE,   TARGET_O_WRONLY,    O_ACCMODE,   O_WRONLY,    },
@@ -5380,13 +5391,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_sync:
-        sync();
-        return 0;
-#if defined(TARGET_NR_syncfs) && defined(CONFIG_SYNCFS)
-    case TARGET_NR_syncfs:
-        return get_errno(syncfs(arg1));
-#endif
     case TARGET_NR_kill:
         return get_errno(safe_kill(arg1, target_to_host_signal(arg2)));
 #ifdef TARGET_NR_rename
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 3161546afc..749bdce638 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1260,12 +1260,6 @@
 #ifdef TARGET_NR_symlinkat
 { TARGET_NR_symlinkat, "symlinkat", NULL, print_symlinkat, NULL },
 #endif
-#ifdef TARGET_NR_sync
-{ TARGET_NR_sync, "sync" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_syncfs
-{ TARGET_NR_syncfs, "syncfs" , "%s(%d)", NULL, NULL },
-#endif
 #ifdef TARGET_NR_syscall
 { TARGET_NR_syscall, "syscall" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


