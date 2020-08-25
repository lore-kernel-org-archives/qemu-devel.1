Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCF8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:28:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1968B20738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tqaRjjts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1968B20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgUD-0004GX-BN
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3h-00085K-Lr
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:45 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:35884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3f-0001rQ-Eh
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:45 -0400
Received: by mail-pf1-x436.google.com with SMTP id m8so8306626pfh.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SnN2rcoH8SEue8/YmUSsyA4G1cGVPVXaIp+iYJ1qNQA=;
 b=tqaRjjtsWSmUHQ6a/EJNgzvWcL9kP3ImCmobt/Zy8ILxkhecloVzdTMtcx5+s0Cn1y
 76wHqHkCihr3eIKAuADSorQoOzLIZxfzl1/qI5KIdHp6nEYNMAdR3m/mkA5Q4sCSMgww
 k942D5TqCyGfJWG1KF+pJA+wfP4KdkEmamy7zDAlIJ/zmIl/OORL4DB9Btx2VTkO7PXe
 rfDpMWVkHg1XlZLWbOPeOZx+9OUndnswaz4OG+/aWcTPQwZt7i85vsUgYjyGLTS9SoTk
 biQI+aAvl7bv9P+F2h2hKvLRjeWXIpsl0MiZBxRF3vQ2gaZlcmYQi6yLw/xtmJKScPpU
 EEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SnN2rcoH8SEue8/YmUSsyA4G1cGVPVXaIp+iYJ1qNQA=;
 b=Tm3ucQhLZa8hMKfbQEQJhgPgN4VMfA+La6vcUyFJSGTNtzmedeVzP1FFHD2A4lVu2v
 2fQHvf6Rnogc0HddiY8kRTCaDiYWzpNKl/NpoTI1rTZsRloXmYjGGQef1S5NQ9ivKbcD
 ICEWE5gcbkEU7wyExeCwOa0DXIQqYqUyEHas1Mp0t/cclUsxdtXVudaqccRkw7e8pjmP
 N9WgknWXnIe6QOyYIuc95odgOhTOWTrI53O41Ll4kIt4CUlvsuFW/No/AplZco4oc7tX
 WjhwegAzYnf+HiCISrhvvAtV5OjX3jnZjhnQJt53Njucdtzjan2xcjJYNdpQf9Svdema
 /lVg==
X-Gm-Message-State: AOAM530GlNYmXxHFY3NWDSovMvoPi3/LGdoksTA+uKi1SgFcOvPFmdzG
 Xdq2BeXD7uhqyNPb2O6m0RVGHyEcbgcQwg==
X-Google-Smtp-Source: ABdhPJxVzHa3t1mCAOv+gYijGRzIxC2HjTIK11kMP1KbxUHvtnNwNSL+U2jshiwyf8+GElMNxU4atg==
X-Received: by 2002:a62:26c2:: with SMTP id m185mr9533310pfm.115.1598389241600; 
 Tue, 25 Aug 2020 14:00:41 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 39/77] target/microblaze: Convert dec_pattern to decodetree
Date: Tue, 25 Aug 2020 13:59:12 -0700
Message-Id: <20200825205950.730499-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
 target/microblaze/insns.decode |  4 ++
 target/microblaze/translate.c  | 67 +++++++++-------------------------
 2 files changed, 22 insertions(+), 49 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index 3f5f7b1852..8d3de039fb 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -41,6 +41,10 @@ addikc          001110 ..... ..... ................     @typeb
 cmp             000101 ..... ..... ..... 000 0000 0001  @typea
 cmpu            000101 ..... ..... ..... 000 0000 0011  @typea
 
+pcmpbf          100000 ..... ..... ..... 100 0000 0000  @typea
+pcmpeq          100010 ..... ..... ..... 100 0000 0000  @typea
+pcmpne          100011 ..... ..... ..... 100 0000 0000  @typea
+
 rsub            000001 ..... ..... ..... 000 0000 0000  @typea
 rsubc           000011 ..... ..... ..... 000 0000 0000  @typea
 rsubk           000101 ..... ..... ..... 000 0000 0000  @typea
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index ce91645f05..de2cf5b153 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -279,6 +279,10 @@ static bool do_typeb_val(DisasContext *dc, arg_typeb *arg, bool side_effects,
     static bool trans_##NAME(DisasContext *dc, arg_typea *a) \
     { return do_typea(dc, a, SE, FN); }
 
+#define DO_TYPEA_CFG(NAME, CFG, SE, FN) \
+    static bool trans_##NAME(DisasContext *dc, arg_typea *a) \
+    { return dc->cpu->cfg.CFG && do_typea(dc, a, SE, FN); }
+
 #define DO_TYPEBI(NAME, SE, FNI) \
     static bool trans_##NAME(DisasContext *dc, arg_typeb *a) \
     { return do_typeb_imm(dc, a, SE, FNI); }
@@ -350,6 +354,20 @@ static void gen_cmpu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 DO_TYPEA(cmp, false, gen_cmp)
 DO_TYPEA(cmpu, false, gen_cmpu)
 
+static void gen_pcmpeq(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    tcg_gen_setcond_i32(TCG_COND_EQ, out, ina, inb);
+}
+
+static void gen_pcmpne(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    tcg_gen_setcond_i32(TCG_COND_NE, out, ina, inb);
+}
+
+DO_TYPEA_CFG(pcmpbf, use_pcmp_instr, false, gen_helper_pcmpbf)
+DO_TYPEA_CFG(pcmpeq, use_pcmp_instr, false, gen_pcmpeq)
+DO_TYPEA_CFG(pcmpne, use_pcmp_instr, false, gen_pcmpne)
+
 /* No input carry, but output carry. */
 static void gen_rsub(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 {
@@ -399,49 +417,10 @@ DO_TYPEBV(rsubic, true, gen_rsubc)
 DO_TYPEBV(rsubik, false, gen_rsubk)
 DO_TYPEBV(rsubikc, true, gen_rsubkc)
 
-static void dec_pattern(DisasContext *dc)
-{
-    unsigned int mode;
-
-    if (trap_illegal(dc, !dc->cpu->cfg.use_pcmp_instr)) {
-        return;
-    }
-
-    mode = dc->opcode & 3;
-    switch (mode) {
-        case 0:
-            /* pcmpbf.  */
-            if (dc->rd)
-                gen_helper_pcmpbf(cpu_R[dc->rd], cpu_R[dc->ra], cpu_R[dc->rb]);
-            break;
-        case 2:
-            if (dc->rd) {
-                tcg_gen_setcond_i32(TCG_COND_EQ, cpu_R[dc->rd],
-                                   cpu_R[dc->ra], cpu_R[dc->rb]);
-            }
-            break;
-        case 3:
-            if (dc->rd) {
-                tcg_gen_setcond_i32(TCG_COND_NE, cpu_R[dc->rd],
-                                   cpu_R[dc->ra], cpu_R[dc->rb]);
-            }
-            break;
-        default:
-            cpu_abort(CPU(dc->cpu),
-                      "unsupported pattern insn opcode=%x\n", dc->opcode);
-            break;
-    }
-}
-
 static void dec_and(DisasContext *dc)
 {
     unsigned int not;
 
-    if (!dc->type_b && (dc->imm & (1 << 10))) {
-        dec_pattern(dc);
-        return;
-    }
-
     not = dc->opcode & (1 << 1);
 
     if (!dc->rd)
@@ -455,22 +434,12 @@ static void dec_and(DisasContext *dc)
 
 static void dec_or(DisasContext *dc)
 {
-    if (!dc->type_b && (dc->imm & (1 << 10))) {
-        dec_pattern(dc);
-        return;
-    }
-
     if (dc->rd)
         tcg_gen_or_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
 }
 
 static void dec_xor(DisasContext *dc)
 {
-    if (!dc->type_b && (dc->imm & (1 << 10))) {
-        dec_pattern(dc);
-        return;
-    }
-
     if (dc->rd)
         tcg_gen_xor_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
 }
-- 
2.25.1


