Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91172C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:55:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5943020657
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jUuFL8+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5943020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53339 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSpx-0000Pw-Fx
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:55:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZC-0003DB-Ab
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZB-0003qW-89
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:58 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZB-0003pY-1A
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:57 -0400
Received: by mail-pg1-x543.google.com with SMTP id j26so5740758pgl.5
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=NM8YohXjNmh5aO/78Xnvs2un3+sKv0xFoH3Xe6VAfyY=;
	b=jUuFL8+PmCYyXNNWJMqmhoYeb3XOWwsea+DvhQ+2Px1BxVUrdCGROdI+MKDNF24Htn
	AXNk48XnhF0Y5fa5YZ6PBcLZ9JxlftTDpW+nszdOHE0O+FtR5/34W08QiDJZM9svpk1e
	g5QY3SFFoeYARGkXrgLVdxhcWC9GwhEZYeNiVeIzQ+uE/WeWM0UwmLpNFGuPZjMx/i5D
	AMrx1aMqPnV0u0G4wZtQkbeSyJgwaeKOFCtUFIjOMmNEkJwEoGry7aOPwfmubtNhhoZ/
	n/Q66jMVqqCrhuAN640+/uFv6WSCvIatyh8nYjJVbPUiSAQvbIo1V5eHq06dOFhtNvHI
	iEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=NM8YohXjNmh5aO/78Xnvs2un3+sKv0xFoH3Xe6VAfyY=;
	b=f9HTqn4Whxt5gm7AFTRyYMNAx/cvy/fzajunX4WiR6oTmMlt/JG5x7gV8GJ5cgFQMV
	46tOt6rmDvGubdnB1pg6MTdzt+ef7sAyjXf6u0J6d7iaq9VctmZ9fzsV+jbaK7r1yoYn
	JDaufWjztqPz+r3DvZDpuEydk4NVwUXeP3eoIf6Q71oIwkD2vrpbej582o/xSnVFCdvm
	CD5ACXsWQRxWqGyj+ApQMMwCKAShtIC74/Eaf0EoYmvcw849JPhueyKFnc/1gbGeuasx
	Wwgt8VPD3kR5owWDCoFZQn24Te2DpXdWQ5CWwNfiXbzT3xvLJizluZAtI0umPOskLonn
	cecA==
X-Gm-Message-State: APjAAAU5b/7yJNesN76PlLwr2941MGmLewkMeybU7p2vK44ScN+ULttM
	pNA302QZpyoXkf638GqNNV3U9pEg45I=
X-Google-Smtp-Source: APXvYqx9YGDKzVM77sSuLk+eiKaKf6T+5Si2jYsKvOSO/hSh6AZGqokii5h7i48fsmxYK8BgepV05g==
X-Received: by 2002:a63:d150:: with SMTP id c16mr71006064pgj.439.1558298275860;
	Sun, 19 May 2019 13:37:55 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.37.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:37:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:32 -0700
Message-Id: <20190519203726.20729-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v7 20/74] linux-user: Split out creat
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
 linux-user/syscall-defs.h     |  3 +++
 linux-user/strace.c           | 13 -------------
 linux-user/syscall-file.inc.c | 16 ++++++++++++++++
 linux-user/syscall.c          |  9 ---------
 linux-user/strace.list        |  3 ---
 5 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index f099d98fa3..de7a99f0c6 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -21,6 +21,9 @@ SYSCALL_DEF_FULL(brk, .impl = impl_brk,
                  .arg_type = { ARG_PTR });
 SYSCALL_DEF_ARGS(clone, ARG_CLONEFLAG, ARG_PTR, ARG_PTR, ARG_PTR, ARG_PTR);
 SYSCALL_DEF(close, ARG_DEC);
+#ifdef TARGET_NR_creat
+SYSCALL_DEF(creat, ARG_STR, ARG_MODEFLAG);
+#endif
 SYSCALL_DEF(exit, ARG_DEC);
 #ifdef TARGET_NR_fork
 SYSCALL_DEF(fork);
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 842136e425..640a80f32b 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1195,19 +1195,6 @@ print_clock_adjtime(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_creat
-static void
-print_creat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 0);
-    print_file_mode(arg1, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_execv
 static void
 print_execv(const struct syscallname *name,
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index dd44d5b804..9b966ad627 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -24,6 +24,22 @@ SYSCALL_IMPL(close)
     return get_errno(close(fd));
 }
 
+#ifdef TARGET_NR_creat
+SYSCALL_IMPL(creat)
+{
+    char *p = lock_user_string(arg1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(creat(p, arg2));
+    fd_trans_unregister(ret);
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+#endif
+
 /*
  * Helpers for do_openat, manipulating /proc/self/foo.
  */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index bdb0d45d9a..491e1d7cfb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5383,15 +5383,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_creat /* not on alpha */
-    case TARGET_NR_creat:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(creat(p, arg2));
-        fd_trans_unregister(ret);
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
 #ifdef TARGET_NR_link
     case TARGET_NR_link:
         {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 759b35458e..41f8f8d0d0 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -94,9 +94,6 @@
 #ifdef TARGET_NR_connect
 { TARGET_NR_connect, "connect" , "%s(%d,%#x,%d)", NULL, NULL },
 #endif
-#ifdef TARGET_NR_creat
-{ TARGET_NR_creat, "creat" , NULL, print_creat, NULL },
-#endif
 #ifdef TARGET_NR_create_module
 { TARGET_NR_create_module, "create_module" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


