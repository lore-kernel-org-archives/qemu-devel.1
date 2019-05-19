Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A32C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:58:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C59520657
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KDyaYmLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C59520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53396 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSt0-0003BD-AB
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:58:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZP-0003Ux-Pq
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZO-00046X-1n
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:11 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:35574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZN-00045Z-SC
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:09 -0400
Received: by mail-pl1-x642.google.com with SMTP id p1so336469plo.2
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=O0n99AE5tNLgI5sw9XY04BuwTLwo+9pblzvHaGIq2Io=;
	b=KDyaYmLeMB/Lq790sWs17F/wY9hB5NqTGzlcS7bVGZbIg9MYUjVb989BAFRRIFW/we
	FyYXn+8izZQ2c1QP+wPD5EuEqSRxDh5rSnU/PY6POtKptC8mcGG5oLDMXZVkJTZfMR1Q
	p8gTcpdONvb2iL+uttUKRnUNEF/dlc+1SJ/reitNFLIj5kYHatkF2mCh0yE1DB/yg+Xa
	PkLzJ+rQAqdrqpDTCPt/nYLFQ5RmmzcYJK9qp/CLXuamq2FMN+iBk+fQT/B7PZqaxlK7
	T9s/DAGhjrQdRcaycjSDVv1wO1yj9xd1TMdxkvJbY8qSKTSVAaosenku+0EE0RXFRcX/
	mDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=O0n99AE5tNLgI5sw9XY04BuwTLwo+9pblzvHaGIq2Io=;
	b=qpWZeMGg6WyGW9pK1zxejP110y9n7ig8E6Qowny99wL58dhKc9dIxYRTk1Bti6fWeh
	NghTvFzQ2039S+IClIYzUDN4esPuKlAu2dbTUu5uMcYABDY5f8FInMeOrirrfLFu1cUW
	U432Wnkgn2G0PAlNSsf4TGrSvQvQaQr3zt+qFaa4k6ru/LuhahixElQxApMAmNwU+p+u
	VaS63saTdqxPnB2wMcoR51BsUdywUa4xBRrCUXJoPm4GQkTLQIvKTSW1Y2yg/mXjbMrF
	+vkd0eC+pEsP4Tvq4uYcSkQOLwrxvOBRj5yWqBEvVjMYy7lQMARr23Blav1Rhyw0y+Uc
	30Iw==
X-Gm-Message-State: APjAAAWf+eZuxuYz7RF5vcdSAT7xO1qJshHTtaNbxlxn5SwKzjbAZT1D
	rWV1wrOnTxfemfYboCiUJR2f5s4uu18=
X-Google-Smtp-Source: APXvYqzkRNeC86Vn6e3yr7jx9LErbIZci9s71FmGiD9QG2DNX4uGogZU7eJByWIj2Z+KTn5l17fatg==
X-Received: by 2002:a17:902:7617:: with SMTP id
	k23mr28206500pll.175.1558298288656; 
	Sun, 19 May 2019 13:38:08 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:42 -0700
Message-Id: <20190519203726.20729-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v7 30/74] linux-user: Split out getpid, getppid,
 getxpid
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
 linux-user/syscall-defs.h     |  9 +++++++++
 linux-user/syscall-proc.inc.c | 23 +++++++++++++++++++++++
 linux-user/syscall.c          | 14 --------------
 linux-user/strace.list        |  9 ---------
 4 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 3453e7afdf..d163bbf409 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -36,6 +36,15 @@ SYSCALL_DEF(fchmodat, ARG_ATDIRFD, ARG_STR, ARG_MODEFLAG);
 #ifdef TARGET_NR_fork
 SYSCALL_DEF(fork);
 #endif
+#ifdef TARGET_NR_getpid
+SYSCALL_DEF(getpid);
+#endif
+#ifdef TARGET_NR_getppid
+SYSCALL_DEF(getppid);
+#endif
+#ifdef TARGET_NR_getxpid
+SYSCALL_DEF(getxpid);
+#endif
 #ifdef TARGET_NR_ipc
 SYSCALL_DEF_ARGS(ipc, ARG_HEX, ARG_DEC, ARG_DEC, ARG_HEX, ARG_PTR, ARG_HEX);
 #endif
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
index fd114d1f03..4d8d385b38 100644
--- a/linux-user/syscall-proc.inc.c
+++ b/linux-user/syscall-proc.inc.c
@@ -438,6 +438,29 @@ SYSCALL_IMPL(fork)
 }
 #endif
 
+#ifdef TARGET_NR_getpid
+SYSCALL_IMPL(getpid)
+{
+    return getpid();
+}
+#endif
+
+#ifdef TARGET_NR_getppid
+SYSCALL_IMPL(getppid)
+{
+    return getppid();
+}
+#endif
+
+#ifdef TARGET_NR_getxpid
+SYSCALL_IMPL(getxpid)
+{
+    /* Alpha specific */
+    cpu_env->ir[IR_A4] = getppid();
+    return getpid();
+}
+#endif
+
 /*
  * Map host to target signal numbers for the wait family of syscalls.
  * Assume all other status bits are the same.
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9eff91d67e..29ea56deee 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5380,16 +5380,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#if defined(TARGET_NR_getxpid) && defined(TARGET_ALPHA)
-    /* Alpha specific */
-    case TARGET_NR_getxpid:
-        ((CPUAlphaState *)cpu_env)->ir[IR_A4] = getppid();
-        return get_errno(getpid());
-#endif
-#ifdef TARGET_NR_getpid
-    case TARGET_NR_getpid:
-        return get_errno(getpid());
-#endif
     case TARGET_NR_mount:
         {
             /* need to look at the data field */
@@ -5721,10 +5711,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     }
 #endif
-#ifdef TARGET_NR_getppid /* not on alpha */
-    case TARGET_NR_getppid:
-        return get_errno(getppid());
-#endif
 #ifdef TARGET_NR_getpgrp
     case TARGET_NR_getpgrp:
         return get_errno(getpgrp());
diff --git a/linux-user/strace.list b/linux-user/strace.list
index fb37c72a1f..3e898ea307 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -298,15 +298,9 @@
 #ifdef TARGET_NR_getpgrp
 { TARGET_NR_getpgrp, "getpgrp" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_getpid
-{ TARGET_NR_getpid, "getpid" , "%s()", NULL, NULL },
-#endif
 #ifdef TARGET_NR_getpmsg
 { TARGET_NR_getpmsg, "getpmsg" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_getppid
-{ TARGET_NR_getppid, "getppid" , "%s()", NULL, NULL },
-#endif
 #ifdef TARGET_NR_getpriority
 { TARGET_NR_getpriority, "getpriority", "%s(%#x,%#x)", NULL, NULL },
 #endif
@@ -365,9 +359,6 @@
 #ifdef TARGET_NR_getxgid
 { TARGET_NR_getxgid, "getxgid" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_getxpid
-{ TARGET_NR_getxpid, "getxpid" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_getxuid
 { TARGET_NR_getxuid, "getxuid" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


