Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFBFC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7548C20449
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 21:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HRJ6Ux3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7548C20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53620 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hST7K-0008HM-Jq
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 17:13:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZo-0003op-SP
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSZn-0004ee-TD
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:36 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSZn-0004dm-NT
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:38:35 -0400
Received: by mail-pf1-x443.google.com with SMTP id g9so6149183pfo.11
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=oFRsgmqF2zgcYNLWzzaBWoMP1N3UdMw/D2eCjGA4dbU=;
	b=HRJ6Ux3gg5LIul/AE9nq+zSXlQfOw3QbDX5D8Hwrps9d0CKvLXGTQPUh0lqD3TPzhA
	KkzrSWknpFoS0uA9nfTnWoOZP5+2rLxnusQMl44kXg8Y8ffsQVBI/JM1LwtL4qAQltaP
	UAcn/OA3cM7r10zYsPTUtgM0jP+u8TI/tpSbREMYvsBc3oJw057s4rjnfHaNFgikYsHN
	/lOSfQghorpWtHNEC+G7G+J8ri/2cQTZweGxZaksBrIwc5UWiRC1S+3DX8mh+jk7p05b
	0nhF24eYBwnG3qapea/k3jhzs8PSflrUVSM5nlXVbrZ00vt6P+gPmt/1pPU4/dl8+Lt7
	+j4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=oFRsgmqF2zgcYNLWzzaBWoMP1N3UdMw/D2eCjGA4dbU=;
	b=Tcy6i261W/Z+aJFBtf6GH51lGfVICEeZhjFeevUmZYNCT6oR+8bAjeejyqC1wMC1wB
	AUDCNooxJFMH4xVevqvlTsay7hC16mM++eztPYkug7Er7/MJszB7UcDtkaSuaBRyZx20
	OrWIIUdU7+Xips09S3a2qPwBBvc9wKe/4UfvSvVs7LHq1iIjUL3X/EwWRwESxpEruR0W
	YwBXMvcLEtxcQAIrWNlSg/T8gS4N7bul+WT6hAFo7ghFGa/QRJ2502suo7kE1TIm+G3Z
	zGFaeMTCEGo4YclKfVJxyoLM726mGo/7DksPC9XijygG+Z/MnfIWui/MEwAowiqI1lki
	SNog==
X-Gm-Message-State: APjAAAXWcQrG2qhKk8jDe/eqToxs0HcXz9xRNGh8vKHuim7zhpMcJNri
	KdYxxFcG7yhKfDUcQIm8IEpgsQ00pqw=
X-Google-Smtp-Source: APXvYqzPLhhXMbW4tWgkJtT698t22Lo4lgn2vW79AX7AvT762mEr5VHeG2iuRVTdutyZFa5Wjh4heg==
X-Received: by 2002:a62:4d04:: with SMTP id a4mr4173256pfb.177.1558298314536; 
	Sun, 19 May 2019 13:38:34 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.38.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:38:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:37:04 -0700
Message-Id: <20190519203726.20729-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v7 52/74] linux-user: Split out umask
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
 linux-user/syscall-file.inc.c | 5 +++++
 linux-user/syscall.c          | 2 --
 linux-user/strace.list        | 3 ---
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 6de7b84351..b6538350a3 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -214,6 +214,7 @@ SYSCALL_DEF(syncfs, ARG_DEC);
 SYSCALL_DEF(time, ARG_PTR);
 #endif
 SYSCALL_DEF(times, ARG_PTR);
+SYSCALL_DEF(umask, ARG_OCT);
 #ifdef TARGET_NR_umount
 SYSCALL_DEF(umount, ARG_STR);
 #endif
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 4080ab250e..cbde6d906f 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -1117,6 +1117,11 @@ SYSCALL_IMPL(rmdir)
 }
 #endif
 
+SYSCALL_IMPL(umask)
+{
+    return get_errno(umask(arg1));
+}
+
 SYSCALL_IMPL(unlinkat)
 {
     return do_unlinkat(arg1, arg2, arg3);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index dcb35e1228..419edceab2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4241,8 +4241,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_umask:
-        return get_errno(umask(arg1));
     case TARGET_NR_chroot:
         if (!(p = lock_user_string(arg1)))
             return -TARGET_EFAULT;
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 4a527b0c65..61d22ad16b 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1293,9 +1293,6 @@
 #ifdef TARGET_NR_ulimit
 { TARGET_NR_ulimit, "ulimit" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_umask
-{ TARGET_NR_umask, "umask" , "%s(%#o)", NULL, NULL },
-#endif
 #ifdef TARGET_NR_uname
 { TARGET_NR_uname, "uname" , "%s(%p)", NULL, NULL },
 #endif
-- 
2.17.1


