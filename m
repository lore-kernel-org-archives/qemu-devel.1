Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270A3C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D671220644
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DiXkK1HU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D671220644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53790 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTIF-0001Sf-SG
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:24:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSa5-00041U-5E
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSa4-0004zA-7B
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:53 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSa4-0004yQ-1X
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:52 -0400
Received: by mail-pl1-x641.google.com with SMTP id r18so5699095pls.13
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=bykKUGCflVir5L1X693JNtqoexPRstJK20ieV2db78g=;
	b=DiXkK1HULs1qZQr6XHCdONJlFdr4Z6wp5i2+/yVPGm4ltSd06UxUbj88jhjOY5yS6r
	6b1sM7jbMixUzHUW+5NthhDJvTSJF03KlzWTOlbK5InvaNLIA1fkm+yjQ7/gQeSL0fML
	8h+ErZgLWozYoGlaBs6ASRdFSZ6btkE6gs1zJM80kehykFEi+tug1yeRWaU7yv+xflof
	B6ubZwuKSNswz4iTYBcGz7phNibpZautwa8NQAJuZSPjrXLKHUxSnM9YLMXR3JDP2ogz
	oezydmOdVFGjkpUf40jWHnaE0Z8wJ7C/0nOTKVVQj/zdEBN2yPWLnnXAhuUJhA95KRga
	uZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=bykKUGCflVir5L1X693JNtqoexPRstJK20ieV2db78g=;
	b=j1z1MskPmqtoE442rE1OhoQDl4l/o+D4Ew48E355XrAljMbcDSH0RYqTAO3cuJWuQ8
	cMfvblFtvvBJWWdseZvBPDPZxT+5UFFQQvi7YURV/pyaXjdFZPfg/gFsCtmNUhuw3AdT
	xbmTz8CT/Rai9NWE0iIQIXM0FnNcGiK/UdzLJCVBOdIj7D7QjilH235HPEynF4on7/4q
	xXJwrchVTpU5/a1uZvLkU8wbAXW0rAcuMX2HWZyD3QfZxx+AFQazd1XE6UPjGpEKm0du
	bjiAB27I6+HnNOn/+G/vyMiwZf/TB4ROdmhhgL7iyLBK6dXUiHRWcCff2ACScgs8WMTh
	gz0Q==
X-Gm-Message-State: APjAAAUf7+DETbkHq9X8c8ykwM1EWIgJIdcG4P9oq5NCt81IaAGvXsLh
	79/+9Le4T78QZm4hukD6c+8UXKDAXh0=
X-Google-Smtp-Source: APXvYqy7Xo55keKIjpgFUODNPw2D3QNNSkcUJwmFzso98SAZGdgswnm8e1cMYGeXjaCxvQNXA3ZY5g==
X-Received: by 2002:a17:902:7617:: with SMTP id
	k23mr28208583pll.175.1558298330853; 
	Sun, 19 May 2019 13:38:50 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:18 -0700
Message-Id: <20190519203726.20729-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v7 66/74] linux-user: Split out getrusage
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
 linux-user/syscall-defs.h     |  1 +
 linux-user/syscall-proc.inc.c | 12 ++++++++++++
 linux-user/syscall.c          |  9 ---------
 linux-user/strace.list        |  3 ---
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 34426a2e23..446175af84 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -75,6 +75,7 @@ SYSCALL_DEF(getppid);
 #ifdef TARGET_NR_getrlimit
 SYSCALL_DEF(getrlimit, ARG_DEC, ARG_PTR);
 #endif
+SYSCALL_DEF(getrusage, ARG_DEC, ARG_PTR);
 SYSCALL_DEF(getsid, ARG_DEC);
 #ifdef TARGET_NR_getxpid
 SYSCALL_DEF(getxpid);
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
index 1238b08191..bf9e278bf0 100644
--- a/linux-user/syscall-proc.inc.c
+++ b/linux-user/syscall-proc.inc.c
@@ -499,6 +499,18 @@ SYSCALL_IMPL(getrlimit)
     return ret;
 }
 #endif
+
+SYSCALL_IMPL(getrusage)
+{
+    struct rusage rusage;
+    abi_long ret = get_errno(getrusage(arg1, &rusage));
+
+    if (!is_error(ret)) {
+        ret = host_to_target_rusage(arg2, &rusage);
+    }
+    return ret;
+}
+
 SYSCALL_IMPL(getsid)
 {
     return get_errno(getsid(arg1));
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 401450b0e3..5fe52c775d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4240,15 +4240,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_getrusage:
-        {
-            struct rusage rusage;
-            ret = get_errno(getrusage(arg1, &rusage));
-            if (!is_error(ret)) {
-                ret = host_to_target_rusage(arg2, &rusage);
-            }
-        }
-        return ret;
     case TARGET_NR_gettimeofday:
         {
             struct timeval tv;
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 711ad9c0aa..00a32bc616 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -283,9 +283,6 @@
 #ifdef TARGET_NR_get_robust_list
 { TARGET_NR_get_robust_list, "get_robust_list" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_getrusage
-{ TARGET_NR_getrusage, "getrusage" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_getsockname
 { TARGET_NR_getsockname, "getsockname" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


