Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5860C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:18:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90DDA20449
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yOdEk4RB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DDA20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53700 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTCT-0004X7-NI
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:18:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZr-0003rA-57
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZq-0004hg-1f
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:39 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZp-0004gf-QO
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:37 -0400
Received: by mail-pl1-x642.google.com with SMTP id f12so5707321plt.8
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=MSnLx4TEMgAogxZCRA6zSvqXurn3uaPFvTU6tGKAUTY=;
	b=yOdEk4RBWdpJRxv5GrOS2C+3ELsjxW6DTlLQXge1/VAhTA2M30GV6M0ZwzyotMj/T9
	8DraWkYKjUgJ16N9+SME7qtxLqrIlsWYBhcszL9x10kpqMLDuUOQ6x9xKk55IVwCVPgA
	YAxA1jQkHnikbkRcAtYJrGhIZ27Jmu4tTfdYurD8qkBlwFejOM8JlC6J5LQC7Z6x1gdn
	RUJ9go/PemRQ1Q3AstEEXA8DRLLh8AOW+1tYHOjlZ0191WMfX814acBPWv1EZZDkpKLC
	WF5S4mXRbKA+3dk6q6Pwyga0vQhLiegklfTLanzvpU6LqwBE0K8TDMmW3Vhpd3Nliep9
	KZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=MSnLx4TEMgAogxZCRA6zSvqXurn3uaPFvTU6tGKAUTY=;
	b=dWg1bxegxo8MwwGHVxeimbCS850pNAg8bmYYqb/kZsht+6DHptdT77Xi2//5UmiUZe
	GhwSeArOr9zURXb+GlwZ135Uuiou4cBuVwV8cRsO5oY9WKW1uYDb7inmkYbQu9oXKsCU
	1xpSdhPQnHsJzfVYmBqIjouEAIM/Yl62a/d7hzp897PtvdKcXJegI3hQ5Lf86MFOy0Jf
	ympUtjZE4fcjUl/KJzV+rxXDYpi+5oNhI6uVkdwI99G4Az+Mc83KxSxAZubjDgEnSvVB
	xZLxb5lUS+P0dfhcZuypJgeZlgnftYKj0k05/v/Sg3vkaWzJYA+ef0psrFMLAk20FcmZ
	7wHQ==
X-Gm-Message-State: APjAAAVwjhN8FmxdZA1UYO7+qcej1F3yjEAJG7YWs+v0d64wBi70UNSP
	NIpsWpu6GkKidByqxngOrNQi7lBx1D8=
X-Google-Smtp-Source: APXvYqzDjf6RKJ/fR5vhWZXIxBWEEDgbv9oW7hDd1e5T9mtfv3Y/ABrzwTZWsmFbfrj8+NP+J+1njQ==
X-Received: by 2002:a17:902:70c6:: with SMTP id
	l6mr54073267plt.84.1558298316633; 
	Sun, 19 May 2019 13:38:36 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:06 -0700
Message-Id: <20190519203726.20729-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v7 54/74] linux-user: Split out getpgid, getpgrp
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
 linux-user/syscall-proc.inc.c | 12 ++++++++++++
 linux-user/syscall.c          |  6 ------
 linux-user/strace.list        |  6 ------
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index b93ca1f78a..2ade9ec749 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -59,6 +59,10 @@ SYSCALL_DEF(futimesat, ARG_ATDIRFD, ARG_STR, ARG_PTR);
 #ifdef TARGET_NR_fork
 SYSCALL_DEF(fork);
 #endif
+SYSCALL_DEF(getpgid, ARG_DEC);
+#ifdef TARGET_NR_getpgrp
+SYSCALL_DEF(getpgrp);
+#endif
 #ifdef TARGET_NR_getpid
 SYSCALL_DEF(getpid);
 #endif
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
index 5bd27d1d4b..39de5b7863 100644
--- a/linux-user/syscall-proc.inc.c
+++ b/linux-user/syscall-proc.inc.c
@@ -438,6 +438,18 @@ SYSCALL_IMPL(fork)
 }
 #endif
 
+SYSCALL_IMPL(getpgid)
+{
+    return get_errno(getpgid(arg1));
+}
+
+#ifdef TARGET_NR_getpgrp
+SYSCALL_IMPL(getpgrp)
+{
+    return get_errno(getpgrp());
+}
+#endif
+
 #ifdef TARGET_NR_getpid
 SYSCALL_IMPL(getpid)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 255765aaa7..75989a01bf 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4241,10 +4241,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_getpgrp
-    case TARGET_NR_getpgrp:
-        return get_errno(getpgrp());
-#endif
     case TARGET_NR_setsid:
         return get_errno(setsid());
 #ifdef TARGET_NR_sigaction
@@ -5388,8 +5384,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         return ret;
 #endif
-    case TARGET_NR_getpgid:
-        return get_errno(getpgid(arg1));
     case TARGET_NR_fchdir:
         return get_errno(fchdir(arg1));
     case TARGET_NR_personality:
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 7679e844b6..d283c924a7 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -262,12 +262,6 @@
 #ifdef TARGET_NR_getpeername
 { TARGET_NR_getpeername, "getpeername" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_getpgid
-{ TARGET_NR_getpgid, "getpgid" , NULL, NULL, NULL },
-#endif
-#ifdef TARGET_NR_getpgrp
-{ TARGET_NR_getpgrp, "getpgrp" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_getpmsg
 { TARGET_NR_getpmsg, "getpmsg" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


