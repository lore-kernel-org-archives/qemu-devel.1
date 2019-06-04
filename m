Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C91C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD88F207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 20:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3fO8J5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD88F207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57797 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYGNk-0005qR-O9
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 16:50:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8Z-0001FF-J0
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYG8Y-0004MC-JT
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:27 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYG8Y-0004Lg-Ez
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 16:34:26 -0400
Received: by mail-ot1-x344.google.com with SMTP id r21so8384428otq.6
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 13:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=QgB0Nu+t0mnNwyHYnQWVmh0yxCdODZBJfwH8/zBCUgo=;
	b=A3fO8J5+4OJIc7888KLjwbp2SWTw7/dH4ziVpWKdpR4hVx8U/lDOqI8KA+884s9j+a
	sl55Ev/nPWyEy1SE4eFW471ZBPQuTYpP2qOJs5Talcs1GyXvCVBXl5OzrHS36fEVjgOA
	EsyhJU3v3z9tdETt/49LfDE0tIqy+k4qbfkGYtk8zKnujdUuGLrMyUuCBEv1S/dgMVFp
	DHOhBbn5hz47mgy07q6KLd1igkCuVcPOr1yXVGIj2B+ex5zucAkmTwA+KMapEdZkhxUc
	xKobWq2uniRODN2EL6DpCg18zPpjj1rMUbhTqiqcLFtSSCTODg2+OeOD7EgQ1i6pcIka
	J9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=QgB0Nu+t0mnNwyHYnQWVmh0yxCdODZBJfwH8/zBCUgo=;
	b=FXsq38KG8nno/KOMAkNLI55b6zI4TAC2IQ+KI7sXZ6FyuaOFu68s+Af7JvKFryrxtT
	4N8V5qrcxRP236+ei5FfCOPoBhMKz2LMOmKKIQ+7DjwRMYRu+OGKZgtbNdCGWd2FHWEt
	1L/bM0UfR94ueELntsb9upuxpc3xTGWIGPDNTkDiCdeta7mrRV7nmU5T5t3GfKK2S2Tp
	wjOBRNVFLx14q8M38Vx3LidhMMneeqQWZ3k2rLQ0oAtbb7Q5AZNHlPjdK8p073lzjTLq
	fqAazn8D92xGUkhijtlbMX7xr5R1jhJm+V22L16bfwvIGW+YlEwAsljJYQj3w9BbqCZ1
	7s+w==
X-Gm-Message-State: APjAAAVoCTIJoBzQF9cMd8OyGfinZ4WL8DkaaozBP/pFW45xyAuXXSco
	2oL2uNR87z7DGKDLEP+virOiRb7llk72GQ==
X-Google-Smtp-Source: APXvYqwKYk2gMzWA2+bQSbYVjvQUSOUaJdFCu5+s1NqzFR33r/18MS8Vav4HcvvOB1DT/2YO46G6xQ==
X-Received: by 2002:a9d:806:: with SMTP id 6mr1889115oty.15.1559680465423;
	Tue, 04 Jun 2019 13:34:25 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id h1sm5979901otj.78.2019.06.04.13.34.24
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 13:34:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 15:33:31 -0500
Message-Id: <20190604203351.27778-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604203351.27778-1-richard.henderson@linaro.org>
References: <20190604203351.27778-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: [Qemu-devel] [PATCH v4 19/39] target/moxie: Use env_cpu, env_archcpu
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


