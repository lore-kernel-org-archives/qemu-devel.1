Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AD3C28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73EF72083D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BwlYGcqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73EF72083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39714 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ha9uO-0004qg-LG
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 22:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53124)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9e2-0006Ei-2e
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9e1-0001l2-3A
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:46 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:44311)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9e0-0001kZ-Tq
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:45 -0400
Received: by mail-pl1-x62a.google.com with SMTP id t7so372418plr.11
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 19:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QgB0Nu+t0mnNwyHYnQWVmh0yxCdODZBJfwH8/zBCUgo=;
 b=BwlYGcqRvTqqTTj86O4PyI6MUqVgFjfAK7QGWBsrVIDFe94kq4sBN1MdoYsTlSXjHd
 drHZoCOplE1r6SoJKTb9j2172Ljh5/ee6lVSry4FUAbOShTT0WMUQkG5gen51AT7F18B
 bi2z+1P/KzRg98NqVJWTZk3tq4WmpWpYlfiHaRAieCzRKdoN7x7EscsV5Ot71CqPscSZ
 ZEILsQeEPpumQ2Z/XKOiWrpKop+WjSRJ8v5OvnSRPu8O8NuWYBod7+1J12jb5sDjxuqQ
 4YW1A+H6jeOjjSkn3swWvQbyTz0Lfwsna6uNSo/wtATccf6MXE1r6LR6kJWACWzNvWZw
 YuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QgB0Nu+t0mnNwyHYnQWVmh0yxCdODZBJfwH8/zBCUgo=;
 b=MlWLEK6XMqEAxvZBAkd/V5GMumiqQlh2ZMSrV/5Fd9taCJjSaHCToHqUl5tMRaAsGB
 9QtiP/6+XPglK2tU/Pg5Wc5Am6oqQLrnku9ZRQ3Ytp2zhxKMo+eGInAvT49pFe3FaHyq
 21b7en2/sjyElAvWJPif6iZWhDFIz05sRNkKo9cGP+1ARbhopsf7X71SHE1Ne3ZWurIy
 RAJVay+/N7Ja22mmyaxJCYrwvQNm8BhvXEKN9UHnb7pDrK42ADF6h8qr6e94X3luS2ik
 jHmDPsBww0HSuq4TJomYLUZ0MmR8ALa8haZkwYDZbpujuieOI2xEG8t6NAq86PUN8lde
 FvwQ==
X-Gm-Message-State: APjAAAUUfI7OF94D1xi1G8zq6OENBDc9m+qrWv5slxM3ChmTVLMJw+3O
 h1UMvz3FblrYpiqDKBKsWXJC/SpXits=
X-Google-Smtp-Source: APXvYqwGOZfGmfoqrb+E78oIhc3FNKCEnEYB3s0dBzxFQY+RxzzCOXv8Ri3W1/elfzCNY5nTyExxqQ==
X-Received: by 2002:a17:902:7793:: with SMTP id
 o19mr7838314pll.110.1560132163631; 
 Sun, 09 Jun 2019 19:02:43 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id l63sm9749013pfl.181.2019.06.09.19.02.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 19:02:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 19:01:58 -0700
Message-Id: <20190610020218.9228-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
References: <20190610020218.9228-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62a
Subject: [Qemu-devel] [PULL 19/39] target/moxie: Use env_cpu, env_archcpu
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cleanup in the boilerplate that each target must define.
Replace moxie_env_get_cpu with env_archcpu.  The combination
CPU(moxie_env_get_cpu) should have used ENV_GET_CPU to begin;
use env_cpu now.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/moxie/cpu.h       | 5 -----
 target/moxie/helper.c    | 4 ++--
 target/moxie/translate.c | 2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index 275fb9bfbb..b9f5635e50 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -90,11 +90,6 @@ typedef struct MoxieCPU {
     CPUMoxieState env;
 } MoxieCPU;
 
-static inline MoxieCPU *moxie_env_get_cpu(CPUMoxieState *env)
-{
-    return container_of(env, MoxieCPU, env);
-}
-
 #define ENV_OFFSET offsetof(MoxieCPU, env)
 
 void moxie_cpu_do_interrupt(CPUState *cs);
diff --git a/target/moxie/helper.c b/target/moxie/helper.c
index f5c1d4181c..b1919f62b3 100644
--- a/target/moxie/helper.c
+++ b/target/moxie/helper.c
@@ -28,7 +28,7 @@
 
 void helper_raise_exception(CPUMoxieState *env, int ex)
 {
-    CPUState *cs = CPU(moxie_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = ex;
     /* Stash the exception type.  */
@@ -65,7 +65,7 @@ uint32_t helper_udiv(CPUMoxieState *env, uint32_t a, uint32_t b)
 
 void helper_debug(CPUMoxieState *env)
 {
-    CPUState *cs = CPU(moxie_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = EXCP_DEBUG;
     cpu_loop_exit(cs);
diff --git a/target/moxie/translate.c b/target/moxie/translate.c
index c668178f2c..c87e9ec2b1 100644
--- a/target/moxie/translate.c
+++ b/target/moxie/translate.c
@@ -816,7 +816,7 @@ static int decode_opc(MoxieCPU *cpu, DisasContext *ctx)
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 {
     CPUMoxieState *env = cs->env_ptr;
-    MoxieCPU *cpu = moxie_env_get_cpu(env);
+    MoxieCPU *cpu = env_archcpu(env);
     DisasContext ctx;
     target_ulong pc_start;
     int num_insns;
-- 
2.17.1


