Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F15CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:28:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25E5120738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPnp9n+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E5120738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgU3-0003vl-EP
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3i-00086z-IW
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:46 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:42950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3g-0001rc-IN
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:46 -0400
Received: by mail-pf1-x42b.google.com with SMTP id 17so8289609pfw.9
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SsU/apSMePMugaV3JgWngynDwxXG4uJq3nxeDvv6ZKI=;
 b=aPnp9n+Ga23x/zM7vJyS67pzNbQsCWuexzVbTCCZiChxxra+Fw73umXihyHQeNMI8l
 KHpFMkXhpTHOGLwKftuXkI6cw7m8aZ+zJojnflgsbpxpsEYdz8fITv/A3KYR9cgAnX+p
 FEHWC19BzBpgkj8jI9b6aCllcBijozZ7oGbbuTdUs8BDC+vEcjIEJxrLBjtT5g9PA2iB
 JTmGayAWUHzYVrJS4r60eS2U8C1c8y1OtfxoMeMutUF4IWFoD9Zbl9FjrS79uixofGER
 6IKrAF5YI/YOVVhTRJmg32z2G42qxKorNBSdWdAhESyF6NcelVATwR7HNWh2AWHOOmSB
 3jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SsU/apSMePMugaV3JgWngynDwxXG4uJq3nxeDvv6ZKI=;
 b=gZKYY3PLRym4bgufpEF+iFFle082/D3CrByFzU792L25Kp8AP964IpH1hcxgDa1f55
 9/nn8gBTAnxwkElC1/2aHifu4N2a1m0DNKeLB7cIDIFJ+at7FnxdcX6EutyMeAqAQuET
 M1z2CSfoJwcq5bIcrJcyDbbaprAKMe0jby4FSfY5AygCa+W/EOjO8Dg+5VeRV7hSmHkW
 BWUYT6isEucbrs/hBfr9UgzYpcQqKqaHGWsVhA+ckFvWZK63beVJAEiDdLAeCCm+9Hmg
 Mk8FxHP0SZfl4iwshlOQCk+nbU6K4cwQpVY0REDtRsW0TDVJuP0v6f6gO3FCXOlsJHp/
 9FaA==
X-Gm-Message-State: AOAM532r/LWkmrn5gF1j9F2L3xVBU/XAXI3vE5l57heBPtgK0smhoM+a
 Vyw6miUzILpScf7U0WSnb9riYkL4YpCKPA==
X-Google-Smtp-Source: ABdhPJx43c7yBLMrIxlV2ubC7hixSwP0UDL2Zj8Q6Kp26NmxTrEeqEo7jCKFaKv84O9AR/aqm7CgAA==
X-Received: by 2002:aa7:92d7:: with SMTP id k23mr9123640pfa.295.1598389242728; 
 Tue, 25 Aug 2020 14:00:42 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 40/77] target/microblaze: Convert dec_and, dec_or,
 dec_xor to decodetree
Date: Tue, 25 Aug 2020 13:59:13 -0700
Message-Id: <20200825205950.730499-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/insns.decode | 12 ++++++++++
 target/microblaze/translate.c  | 44 ++++++++++++----------------------
 2 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index 8d3de039fb..6b3cc9a182 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -38,9 +38,18 @@ addic           001010 ..... ..... ................     @typeb
 addik           001100 ..... ..... ................     @typeb
 addikc          001110 ..... ..... ................     @typeb
 
+and             100001 ..... ..... ..... 000 0000 0000  @typea
+andi            101001 ..... ..... ................     @typeb
+
+andn            100011 ..... ..... ..... 000 0000 0000  @typea
+andni           101011 ..... ..... ................     @typeb
+
 cmp             000101 ..... ..... ..... 000 0000 0001  @typea
 cmpu            000101 ..... ..... ..... 000 0000 0011  @typea
 
+or              100000 ..... ..... ..... 000 0000 0000  @typea
+ori             101000 ..... ..... ................     @typeb
+
 pcmpbf          100000 ..... ..... ..... 100 0000 0000  @typea
 pcmpeq          100010 ..... ..... ..... 100 0000 0000  @typea
 pcmpne          100011 ..... ..... ..... 100 0000 0000  @typea
@@ -54,3 +63,6 @@ rsubi           001001 ..... ..... ................     @typeb
 rsubic          001011 ..... ..... ................     @typeb
 rsubik          001101 ..... ..... ................     @typeb
 rsubikc         001111 ..... ..... ................     @typeb
+
+xor             100010 ..... ..... ..... 000 0000 0000  @typea
+xori            101010 ..... ..... ................     @typeb
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index de2cf5b153..5252790b09 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -331,6 +331,16 @@ DO_TYPEBV(addic, true, gen_addc)
 DO_TYPEBI(addik, false, tcg_gen_addi_i32)
 DO_TYPEBV(addikc, true, gen_addkc)
 
+static void gen_andni(TCGv_i32 out, TCGv_i32 ina, int32_t imm)
+{
+    tcg_gen_andi_i32(out, ina, ~imm);
+}
+
+DO_TYPEA(and, false, tcg_gen_and_i32)
+DO_TYPEBI(andi, false, tcg_gen_andi_i32)
+DO_TYPEA(andn, false, tcg_gen_andc_i32)
+DO_TYPEBI(andni, false, gen_andni)
+
 static void gen_cmp(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 {
     TCGv_i32 lt = tcg_temp_new_i32();
@@ -354,6 +364,9 @@ static void gen_cmpu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 DO_TYPEA(cmp, false, gen_cmp)
 DO_TYPEA(cmpu, false, gen_cmpu)
 
+DO_TYPEA(or, false, tcg_gen_or_i32)
+DO_TYPEBI(ori, false, tcg_gen_ori_i32)
+
 static void gen_pcmpeq(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 {
     tcg_gen_setcond_i32(TCG_COND_EQ, out, ina, inb);
@@ -417,32 +430,8 @@ DO_TYPEBV(rsubic, true, gen_rsubc)
 DO_TYPEBV(rsubik, false, gen_rsubk)
 DO_TYPEBV(rsubikc, true, gen_rsubkc)
 
-static void dec_and(DisasContext *dc)
-{
-    unsigned int not;
-
-    not = dc->opcode & (1 << 1);
-
-    if (!dc->rd)
-        return;
-
-    if (not) {
-        tcg_gen_andc_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
-    } else
-        tcg_gen_and_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
-}
-
-static void dec_or(DisasContext *dc)
-{
-    if (dc->rd)
-        tcg_gen_or_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
-}
-
-static void dec_xor(DisasContext *dc)
-{
-    if (dc->rd)
-        tcg_gen_xor_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
-}
+DO_TYPEA(xor, false, tcg_gen_xor_i32)
+DO_TYPEBI(xori, false, tcg_gen_xori_i32)
 
 static void msr_read(DisasContext *dc, TCGv_i32 d)
 {
@@ -1567,9 +1556,6 @@ static struct decoder_info {
     };
     void (*dec)(DisasContext *dc);
 } decinfo[] = {
-    {DEC_AND, dec_and},
-    {DEC_XOR, dec_xor},
-    {DEC_OR, dec_or},
     {DEC_BIT, dec_bit},
     {DEC_BARREL, dec_barrel},
     {DEC_LD, dec_load},
-- 
2.25.1


