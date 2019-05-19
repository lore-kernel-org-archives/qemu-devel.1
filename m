Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6217FC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA5A20657
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JxCQ5vv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA5A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53534 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hST1R-0002fw-A7
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:07:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZc-0003cT-CP
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZZ-0004Ky-9G
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:23 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZX-0004GK-Aj
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:20 -0400
Received: by mail-pl1-x642.google.com with SMTP id r18so5698795pls.13
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Fe7E5QRFjEHLy1d+AjizcpNZcZxNIdj6eQS1u8xiwio=;
	b=JxCQ5vv6JneusoOCcHuWwJwAtEJ75qJqIWbtzgPlH9Eh4Ffz5r0hXmE2pKPnd1vDGO
	DnE1Y4qjWIDJZ8vCdmyDiA3taIhIG8YaixMXkqx94v9TwUJVprG33zKRgIKCOeDkhIVq
	X+Om79IvXcBrEkf43Eyj/ox8oOoQ0eJG1sSfX4z3L9YJyba1Bfu/+pT+kI67x2Gi3WOf
	0rZqs8K8wPtvEESqtoa9iS4lxH1wRr+gjO/p6pfJ7xn7kvoEBpdSIGaFq/wO4WNiFKr1
	TBmEIjUv722dVTlClRhpgm+1eETvmK0wo2o28jxmd+PL4DCEnVeXGj/JRVs6OIsgd9FP
	sN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Fe7E5QRFjEHLy1d+AjizcpNZcZxNIdj6eQS1u8xiwio=;
	b=fGEmgQkroXS2M/3578ctTTv/YOQBGtGxkrsjiP5inkKmEiCOuBeeVYd/UhbsRTTKSK
	GinBazdhLFnWpgc1HCylkEE4XzoBecLbElu5FgrrWGN/LK0qgxZMBLt3bQ+wGuZyrZVz
	2vITs8lTD9ZEuo9A2rq3kGHbApCZhM+K/NU8LhT7uJOY0LCf5W6CEIfU9bjNhGiw/EX/
	BIb73JrzzX16HHuKCz4ms18apiBO5oi6o/AHDaU66n6UW+EimVUGqwP4q+/R5slvssRX
	hgM2WPd4Gn/0OKEKVox5Nk47wIidaeq0pfl/Fh6wRZQXoI/kMkSZCp6DULNN0E+MCZfS
	s4Pw==
X-Gm-Message-State: APjAAAXMhovQ7LtsvNT3+tgMZaf013Y8d1EwoCk9CeqBhqJV0z4JuY33
	N1hfUF6jfkCiUpw/Fcrla5Be6EkrE6k=
X-Google-Smtp-Source: APXvYqyQZBPK6pQ40xRQonpT6t4LssLVE44wc96yjhKlNBchpa6s3bXBRiTGkB9H9ZF57dJ9g2oYww==
X-Received: by 2002:a17:902:bd46:: with SMTP id
	b6mr10558681plx.173.1558298296924; 
	Sun, 19 May 2019 13:38:16 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:49 -0700
Message-Id: <20190519203726.20729-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v7 37/74] linux-user: Split out nice
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
 linux-user/syscall-defs.h     | 3 +++
 linux-user/syscall-proc.inc.c | 7 +++++++
 linux-user/syscall.c          | 4 ----
 linux-user/strace.list        | 3 ---
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 39e3ae3c21..860754aaca 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -111,6 +111,9 @@ SYSCALL_DEF(munlockall);
 SYSCALL_DEF(munmap, ARG_PTR, ARG_DEC);
 SYSCALL_DEF(name_to_handle_at,
             ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_PTR, ARG_ATFLAG);
+#ifdef TARGET_NR_nice
+SYSCALL_DEF(nice, ARG_DEC);
+#endif
 #ifdef TARGET_NR_open
 SYSCALL_DEF(open, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
 #endif
diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
index 4d8d385b38..e29c2ede25 100644
--- a/linux-user/syscall-proc.inc.c
+++ b/linux-user/syscall-proc.inc.c
@@ -461,6 +461,13 @@ SYSCALL_IMPL(getxpid)
 }
 #endif
 
+#ifdef TARGET_NR_nice
+SYSCALL_IMPL(nice)
+{
+    return get_errno(nice(arg1));
+}
+#endif
+
 /*
  * Map host to target signal numbers for the wait family of syscalls.
  * Assume all other status bits are the same.
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b5ade974a7..6d30e8ff2f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5380,10 +5380,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-#ifdef TARGET_NR_nice /* not on alpha */
-    case TARGET_NR_nice:
-        return get_errno(nice(arg1));
-#endif
     case TARGET_NR_sync:
         sync();
         return 0;
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 80b9220e89..3161546afc 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -527,9 +527,6 @@
 #ifdef TARGET_NR_nfsservctl
 { TARGET_NR_nfsservctl, "nfsservctl" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_nice
-{ TARGET_NR_nice, "nice" , NULL, NULL, NULL },
-#endif
 #ifdef TARGET_NR_old_adjtimex
 { TARGET_NR_old_adjtimex, "old_adjtimex" , NULL, NULL, NULL },
 #endif
-- 
2.17.1


