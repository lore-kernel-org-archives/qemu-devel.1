Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DA7C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A14620644
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ltrAgxdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A14620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSjs-0003rm-KJ
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:49:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSYx-0002on-ER
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSYw-0003YA-Dd
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:43 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSYw-0003XN-6n
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:37:42 -0400
Received: by mail-pf1-x441.google.com with SMTP id z26so6167151pfg.6
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=v4TN8eiQB7XlopQZigkJd3iS16AoI2I7VjbeWaf5rzc=;
	b=ltrAgxdo+sqOTVlbfP4OEyTUTut08QxXb1zpk7dgtyQ93CnBcsxetW6RNelYHnjmcf
	SdN+rLfpAfSsh9iKcesaPWHVnFyvxO5h1MJEhu9UA2VVWPmbjTaGHQFfeu1NbTM6olhb
	W5FrxkclUwiCdfil0SsaT70j0efcaUBdqc9oAmGIAjyw5RYLqrbHkdMkwdCqyKv8sslk
	jChGwj6YqZGtHpq40sQl9Km8jcoio6Y60j+zuYNdH/gArg+tJ3NgW9uR+SSXGqoym0oR
	t8/sOe/3RL31Q9C15ZvMmqAOHr3/1dbeUAnlkPsrC0JJgKNTDSNFwuzNBlYo98DK7WYV
	dVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=v4TN8eiQB7XlopQZigkJd3iS16AoI2I7VjbeWaf5rzc=;
	b=qI8zPMNhYcYvwmDmdYa1Kw8/ziW8T2EBI9uzX2YK7b3QYT/PnHIYnFts05QaxIMfrD
	bSpYbWmlOEr8AGZlpvxmHz/ZPYCLc+/1BJ/kFLm+Yj2D3QALSenAAOV8YXHZ0JY3uoIf
	d6YruK96fpkPBblXaqG9RQ3ji7KFdCx+yrGjek9sfmmT5oAeTbfikoJhKS6ulMjcZnfP
	cCv7bhwl3bv9bwHrnfq9AJT3WTtzdKAGSCxQ8WmLqrzZyGMy80j/hdMqtg72HcV1bvOx
	BCmP8hS5zz+p3nBpu93HSJZvRLTp3TmPc/0tpTFso3L6eMcxggYxoLGTXrgo4ydkYaWH
	G4oQ==
X-Gm-Message-State: APjAAAXWb7zekd+zkBft1mIS1JHi7OTXV5k7HJsaZM5tHjlhF85BqZFF
	qmRaCLG1xbjCLOtt0YANDxQNueWVJTU=
X-Google-Smtp-Source: APXvYqz3FltNzJN/T3SQ6gyk0y12pZM7hUfXHdI+SCzOBBuSPwn0qHoW2u7Jc8FLOGWExvl4HCa1dQ==
X-Received: by 2002:a62:d044:: with SMTP id p65mr55690797pfg.37.1558298260905; 
	Sun, 19 May 2019 13:37:40 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	i7sm11397448pfo.19.2019.05.19.13.37.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:37:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:36:20 -0700
Message-Id: <20190519203726.20729-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
References: <20190519203726.20729-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v7 08/74] linux-user: Reduce regpairs_aligned &
 target_offset64 ifdefs
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
 linux-user/syscall.c | 54 ++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index de80ddb330..61cd73db26 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -464,37 +464,38 @@ static inline int next_free_host_timer(void)
 }
 #endif
 
-/* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
+/*
+ * Returns true if syscall NUM expects 64bit types aligned even
+ * on pairs of registers.
+ */
+static inline bool regpairs_aligned(void *cpu_env, int num)
+{
 #ifdef TARGET_ARM
-static inline int regpairs_aligned(void *cpu_env, int num)
-{
-    return ((((CPUARMState *)cpu_env)->eabi) == 1) ;
-}
-#elif defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
+    return ((CPUARMState *)cpu_env)->eabi;
+#elif defined(TARGET_MIPS) && TARGET_ABI_BITS == 32
+    return true;
 #elif defined(TARGET_PPC) && !defined(TARGET_PPC64)
-/* SysV AVI for PPC32 expects 64bit parameters to be passed on odd/even pairs
- * of registers which translates to the same as ARM/MIPS, because we start with
- * r3 as arg1 */
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
+    /*
+     * SysV AVI for PPC32 expects 64bit parameters to be passed on
+     * odd/even pairs of registers which translates to the same as
+     * we start with r3 as arg1.
+     */
+    return true;
 #elif defined(TARGET_SH4)
-/* SH4 doesn't align register pairs, except for p{read,write}64 */
-static inline int regpairs_aligned(void *cpu_env, int num)
-{
+    /* SH4 doesn't align register pairs, except for p{read,write}64.  */
     switch (num) {
     case TARGET_NR_pread64:
     case TARGET_NR_pwrite64:
-        return 1;
-
+        return true;
     default:
-        return 0;
+        return false;
     }
-}
 #elif defined(TARGET_XTENSA)
-static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
+    return true;
 #else
-static inline int regpairs_aligned(void *cpu_env, int num) { return 0; }
+    return false;
 #endif
+}
 
 #define ERRNO_TABLE_SIZE 1200
 
@@ -6161,21 +6162,16 @@ void syscall_init(void)
     }
 }
 
-#if TARGET_ABI_BITS == 32
-static inline uint64_t target_offset64(uint32_t word0, uint32_t word1)
+static inline uint64_t target_offset64(abi_ulong word0, abi_ulong word1)
 {
-#ifdef TARGET_WORDS_BIGENDIAN
+#if TARGET_ABI_BITS == 64
+    return word0;
+#elif defined(TARGET_WORDS_BIGENDIAN)
     return ((uint64_t)word0 << 32) | word1;
 #else
     return ((uint64_t)word1 << 32) | word0;
 #endif
 }
-#else /* TARGET_ABI_BITS == 32 */
-static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
-{
-    return word0;
-}
-#endif /* TARGET_ABI_BITS != 32 */
 
 #ifdef TARGET_NR_truncate64
 static inline abi_long target_truncate64(void *cpu_env, const char *arg1,
-- 
2.17.1


