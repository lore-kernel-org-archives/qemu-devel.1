Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CB0C004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876A2205ED
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ztlVI8Vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876A2205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56591 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOALf-0003q7-On
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:22:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA78-0007b9-Lg
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA76-0006y1-Ku
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:13 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA75-0006ny-EF
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:07:12 -0400
Received: by mail-pf1-x444.google.com with SMTP id 10so9495480pfo.5
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=ibb3OfpNtU4NVHHARrwIHaHoS9z7x74Z77VSeJYRX1k=;
	b=ztlVI8Vl7ku1Hh+77EEChmw1UKGXCCtPzmUEmN34ktQlBedRWKj7/lpemmXpuFAQs+
	1RUBMdbzNX0Jt9dtKfXkNgR/+xQ4fGWbABmHgjHOa6qOUyGrdl6Le0J8vHw2h4SOQovD
	bmq4WZmlUURkeG2wpf7wgrqWFfHcm5DzAefVeZyOYInkClUMG49hcZLzAt3GluJw6foV
	3kQP2dQecMJ7jUDb9AMcPpPi/YzRR/YMats9ITGSiTda3Oc1RoYjAY0YP4wq0IraaGj8
	RnqDcBw4Jle6TPu6mpqNHtiWQQIhL0r+7mWxTM+Fd6VbXZbHtB8qe0p0JqDlDFIq+/Hs
	iHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=ibb3OfpNtU4NVHHARrwIHaHoS9z7x74Z77VSeJYRX1k=;
	b=kjVEkiLdleykixFKrb+rVRtHesZLnDR2yKK+LvUzyZbTwCg3MTCLKzucCtrXOimfN9
	eigQdxT2+XqcEX+8VOpLY709zHvVd+vdDaZ236QADhRKJbqO6kMg/djnz8ZIAt1Sn+aJ
	AD4kzRW/hJqxZmcn93sYC8YDhxL0/Xz4Fl2ZuCi1ip1FPGvgrX3M1NUpllJLOV17qWPB
	whlSpQl3HklvRxOjbBaNQ3lqsLW2uyRBbNQuGD1QdiycrIGC4azOAA6QyC8hN481/8gl
	ZlkyVbh6/y7ih3nVkVigbK5NQer4f74nf5mJAwYST7zqPhRLMujihejRNs4B2fkwyuOl
	ZhIA==
X-Gm-Message-State: APjAAAWa8jg6GBl6GGhEHUYxiKs9XrG//iFeuGvQQUdXOWJ+6whhsVvr
	rxeOJYxUz3ss/GCnRUb4MNnvVRc/Nkk=
X-Google-Smtp-Source: APXvYqxxImstXAbfsAhyvOaAd9gn92eS6PCt1+72JB7wyyHpGk45/E9/Y4hVcFjxkcrsVnCMpqyGvA==
X-Received: by 2002:a63:e602:: with SMTP id g2mr2856250pgh.172.1557274028117; 
	Tue, 07 May 2019 17:07:08 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.07.06 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:07:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:21 -0700
Message-Id: <20190508000641.19090-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v3 19/39] target/moxie: Use env_cpu, env_archcpu
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/moxie/cpu.h       | 5 -----
 target/moxie/helper.c    | 6 +++---
 target/moxie/translate.c | 2 +-
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index 5b9aae95d2..a481a92833 100644
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
index 287a45232c..a18b21c4c0 100644
--- a/target/moxie/helper.c
+++ b/target/moxie/helper.c
@@ -42,7 +42,7 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
 
 void helper_raise_exception(CPUMoxieState *env, int ex)
 {
-    CPUState *cs = CPU(moxie_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = ex;
     /* Stash the exception type.  */
@@ -79,7 +79,7 @@ uint32_t helper_udiv(CPUMoxieState *env, uint32_t a, uint32_t b)
 
 void helper_debug(CPUMoxieState *env)
 {
-    CPUState *cs = CPU(moxie_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = EXCP_DEBUG;
     cpu_loop_exit(cs);
@@ -89,7 +89,7 @@ void helper_debug(CPUMoxieState *env)
 
 void moxie_cpu_do_interrupt(CPUState *cs)
 {
-    CPUState *cs = CPU(moxie_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = -1;
 }
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


