Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BC8C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F30E20657
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NBW1rsds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F30E20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53477 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSyk-0008PG-Hg
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:04:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZX-0003X6-9y
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZV-0004G0-Cp
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:19 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZR-00048V-Ln
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:14 -0400
Received: by mail-pl1-x641.google.com with SMTP id p15so5718925pll.4
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=FcVdmu4jJhr5SxGI0pZ6zduAqhixd7w4CsRDiK5ssJ4=;
	b=NBW1rsdsAeQKQIkAPkswlg4vV1I2Kbo3HgNVFCXApRyVXSWDtkETS0tSGyGyDszXR8
	if1vF1uhZlttD332RE0c7rukzIPQWMUKRP0jg0c+qxnwJ8E3o9T57lK9aAMhPaI6YXYk
	6QfWm4U1YyEMdt3Mhvom0Qqh1fcgxGHpBJkOtyIzS9wtzBrg0y4DXS8ws2yetw2z0fLZ
	eFBtBn+59JWJ5RYYswooOvP2qAfe1Z/EIAG3kaB7wuZy6ETBsdU0rs1QYfb591exX9vZ
	BXx/D22pLlA/Zffd8DdPGI4zIw+d1YgMIUSnDQe9IjUX8KY9PjPBzTAE7oy/2p/PnX/+
	MI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=FcVdmu4jJhr5SxGI0pZ6zduAqhixd7w4CsRDiK5ssJ4=;
	b=rG/++Ko6a9HrEGm0g7wXseI9/iBD/odUnKRMrydU6/R9tV7et9LNYxTWQwDW4MB+Ut
	pDQrWrBoPIBfMRuhnNRklPt2f61OGR0fYt9QI6d7fuvQ+2oHU11yhOAYXmpgv+sCfW/t
	+byJGo2gVpfQQOpJi8d1tyWcl6BQ71lp32za0PB2KvuTjj+8KH0Y11JNkNp71cv2ZGUM
	b+HwIXMnsWfaWjNrf07QzX+eHVvu1i8Zamtmjkh12tV6mnWKS7YS4OKnPmOhIwK1qd5G
	lAeFkftKseMU/MIptFO8lgE3vWE5Bx623nQ/aLdZhpCst+ZyLflPV3pCoyTWfzSx1wXT
	Hx9g==
X-Gm-Message-State: APjAAAVzsCszWrY9Sk1ms56VktlVukBHMacqiJqrVLQ+CJqjvxzUfi/3
	v/ZDX7XutkUnS+vw7WFh0UfzeKC/Tc8=
X-Google-Smtp-Source: APXvYqzXupgeOwSmKGSnNucrIKVtWzK/DHQ/mcuSBlFwaZ9sWV4gz1+CadnHg+kTuZZKZHL2KLDvPA==
X-Received: by 2002:a17:902:e00a:: with SMTP id
	ca10mr73329060plb.18.1558298290948; 
	Sun, 19 May 2019 13:38:10 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:44 -0700
Message-Id: <20190519203726.20729-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v7 32/74] linux-user: Split out umount, umount2
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

Note that umount2 is unconditionally available.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  4 ++++
 linux-user/syscall.h          |  1 +
 linux-user/strace.c           | 30 ++++--------------------------
 linux-user/syscall-file.inc.c | 25 +++++++++++++++++++++++++
 linux-user/syscall.c          | 16 ----------------
 linux-user/strace.list        |  6 ------
 6 files changed, 34 insertions(+), 48 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 2b331c6a6d..0d8da0c6d6 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -155,6 +155,10 @@ SYSCALL_DEF(shmget, ARG_DEC, ARG_DEC, ARG_HEX);
 #ifdef TARGET_NR_time
 SYSCALL_DEF(time, ARG_PTR);
 #endif
+#ifdef TARGET_NR_umount
+SYSCALL_DEF(umount, ARG_STR);
+#endif
+SYSCALL_DEF(umount2, ARG_STR, ARG_UMOUNTFLAG);
 #ifdef TARGET_NR_unlink
 SYSCALL_DEF(unlink, ARG_STR);
 #endif
diff --git a/linux-user/syscall.h b/linux-user/syscall.h
index 35dd3e5fa3..3c936b648a 100644
--- a/linux-user/syscall.h
+++ b/linux-user/syscall.h
@@ -64,6 +64,7 @@ typedef enum {
     ARG_MODEFLAG,
     ARG_MOUNTFLAG,
     ARG_OPENFLAG,
+    ARG_UMOUNTFLAG,
     ARG_UNLINKATFLAG,
     ARG_LSEEKWHENCE,
 
diff --git a/linux-user/strace.c b/linux-user/strace.c
index a99ab46b97..278d235ae6 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -733,7 +733,7 @@ static struct flags const mount_flags[] = {
     FLAG_END,
 };
 
-UNUSED static struct flags umount2_flags[] = {
+static struct flags const umount2_flags[] = {
 #ifdef MNT_FORCE
     FLAG_GENERIC(MNT_FORCE),
 #endif
@@ -2015,31 +2015,6 @@ print_symlinkat(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_umount
-static void
-print_umount(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
-#ifdef TARGET_NR_umount2
-static void
-print_umount2(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_string(arg0, 0);
-    print_flags(umount2_flags, arg1, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_utime
 static void
 print_utime(const struct syscallname *name,
@@ -2305,6 +2280,9 @@ static void print_syscall_def1(const SyscallDef *def, int64_t args[6])
         case ARG_OPENFLAG:
             len = add_open_flags(b, rest, arg);
             break;
+        case ARG_UMOUNTFLAG:
+            len = add_flags(b, rest, umount2_flags, arg, false);
+            break;
         case ARG_UNLINKATFLAG:
             len = add_flags(b, rest, unlinkat_flags, arg, true);
             break;
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 4fc12512c2..345b4cb421 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -816,6 +816,31 @@ SYSCALL_IMPL(readlinkat)
 }
 #endif
 
+static abi_long do_umount2(abi_ulong target_path, int flags)
+{
+    char *p = lock_user_string(target_path);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(umount2(p, flags));
+    unlock_user(p, target_path, 0);
+    return ret;
+}
+
+#ifdef TARGET_NR_umount
+SYSCALL_IMPL(umount)
+{
+    return do_umount2(arg1, 0);
+}
+#endif
+
+SYSCALL_IMPL(umount2)
+{
+    return do_umount2(arg1, arg2);
+}
+
 static abi_long do_unlinkat(int dirfd, abi_ulong target_path, int flags)
 {
     char *p = lock_user_string(target_path);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c826c65317..f3e03f535d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5380,14 +5380,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_umount
-    case TARGET_NR_umount:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(umount(p));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
 #ifdef TARGET_NR_stime /* not on alpha */
     case TARGET_NR_stime:
         {
@@ -5608,14 +5600,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p, arg1, 0);
         }
         return ret;
-#ifdef TARGET_NR_umount2
-    case TARGET_NR_umount2:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(umount2(p, arg2));
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
     case TARGET_NR_ioctl:
         return do_ioctl(arg1, arg2, arg3);
 #ifdef TARGET_NR_fcntl
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 9b4024d94f..973a4c9209 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1368,12 +1368,6 @@
 #ifdef TARGET_NR_umask
 { TARGET_NR_umask, "umask" , "%s(%#o)", NULL, NULL },
 #endif
-#ifdef TARGET_NR_umount
-{ TARGET_NR_umount, "umount" , NULL, print_umount, NULL },
-#endif
-#ifdef TARGET_NR_umount2
-{ TARGET_NR_umount2, "umount2" , NULL, print_umount2, NULL },
-#endif
 #ifdef TARGET_NR_uname
 { TARGET_NR_uname, "uname" , "%s(%p)", NULL, NULL },
 #endif
-- 
2.17.1


