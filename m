Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2433C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:29:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DC9220578
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e92Pq6GS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC9220578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53876 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSTNG-0006Ct-PC
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:29:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZn-0003nx-TY
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZm-0004dC-OX
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:35 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZm-0004cc-Ix
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:34 -0400
Received: by mail-pf1-x442.google.com with SMTP id t87so6175430pfa.2
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=15I+Dq5Rg7507HNEwiC18Z0vUWpngHfr2VdrwlZdjRg=;
	b=e92Pq6GScDIB/U3McwgwB4NOwZ33hkNI/s+n+3qt06GaxocxfmeeVfdlvCxbf68HZz
	NE+q3UkNzPh59OnF7sG8wVyoyIhLmaU8y5N6mwHktBV+vMEvIOvHjGmZN1l0We1rP0uk
	BlZQa9N6psUTe+RGiY8SOkFGK60r09PjJj9Ka/DjaptVYsyLLXfVdQY70oR18PwN/zGT
	cSzzs1YZOhEcXhCViOhMWkGQJWcvVvMan5pLpyAo2jU26N/jlATImui5GWzHVMlzYRst
	D+3qPiQNocrrq4JY9FNaFd1Stvw2YrUSSQkQOePrxKtXZjSe0I+cPjEfSWc4Ak5Fd6uW
	nODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=15I+Dq5Rg7507HNEwiC18Z0vUWpngHfr2VdrwlZdjRg=;
	b=X+gg0I57HnJxUqocJd75TpSHFUk0nb/RuPJQBl70WsuZr2o2VVtaf0l3WVdbZELuQM
	QIKWRZ6fFDxunzByZjj2IvR6ciNirJgO7QksdtY/XowXnvldSMO8dohoZPU74XH7dzed
	D7CiCZtctp5K/UPQGaqSDdKHrqOmbaBdLiajR+Rn+yQLFYWvuzQl1C7HI5GDKV5dtu0r
	K3EYCZoe8A0H88WrU8dCMXTbUtnf87mZ0FZW1AacfOC0g/uKnuhDFKbpmTCLtKk6A9Qf
	KRuh1TDt7U5DKdtmm38o3vhuRTUdcUEV2ex3+elp7vsoAKld8KhxzHlBFIXw7mWx6Hk1
	nkSg==
X-Gm-Message-State: APjAAAWKHuYmUr6VYZ6WKr13aq26HXBuCN50rreaLd6QY7Hzo0VcrU3h
	7dqFETWsxO6yb1e8zCYTxDisEG9xdN8=
X-Google-Smtp-Source: APXvYqyMHYcgYcDE0SWOhwmK6GWfGdPCrZlwTibUXea9P0y5Oh5hPhmFbE3HuLZVXEsgztTcvQ36/Q==
X-Received: by 2002:aa7:860a:: with SMTP id p10mr58741919pfn.214.1558298313395;
	Sun, 19 May 2019 13:38:33 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:03 -0700
Message-Id: <20190519203726.20729-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v7 51/74] linux-user: Split out setpgid
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
 linux-user/syscall-defs.h     | 1 +
 linux-user/syscall-proc.inc.c | 5 +++++
 linux-user/syscall.c          | 2 --
 linux-user/strace.list        | 3 ---
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 5cf39f2bb9..6de7b84351 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -187,6 +187,7 @@ SYSCALL_DEF(semctl, ARG_DEC, ARG_DEC, ARG_DEC, ARG_HEX);
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_semget)
 SYSCALL_DEF(semget, ARG_DEC, ARG_DEC, ARG_HEX);
 #endif
+SYSCALL_DEF(setpgid, ARG_DEC, ARG_DEC);
 #if !defined(SYSCALL_TABLE) || defined(TARGET_NR_semop)
 SYSCALL_DEF(semop, ARG_DEC, ARG_PTR, ARG_DEC);
 #endif
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
index 517f84e139..5bd27d1d4b 100644
--- a/linux-user/syscall-proc.inc.c
+++ b/linux-user/syscall-proc.inc.c
@@ -468,6 +468,11 @@ SYSCALL_IMPL(nice)
 }
 #endif
 
+SYSCALL_IMPL(setpgid)
+{
+    return get_errno(setpgid(arg1, arg2));
+}
+
 SYSCALL_IMPL(times)
 {
     abi_ulong target_buf = arg1;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 45fe05ac78..dcb35e1228 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4241,8 +4241,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_setpgid:
-        return get_errno(setpgid(arg1, arg2));
     case TARGET_NR_umask:
         return get_errno(umask(arg1));
     case TARGET_NR_chroot:
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 68e202ca15..4a527b0c65 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1073,9 +1073,6 @@
 #ifdef TARGET_NR_setns
 { TARGET_NR_setns, "setns" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_setpgid
-{ TARGET_NR_setpgid, "setpgid" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_setpgrp
 { TARGET_NR_setpgrp, "setpgrp" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


