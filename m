Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A389C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41EF0207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fuItrZYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41EF0207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfgt-0007eK-Gc
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFV-0002Pn-NI
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:21:01 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:50935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFS-0005Qv-PI
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:21:01 -0400
Received: by mail-pj1-x1042.google.com with SMTP id i13so567200pjv.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Dfp4IqU2KYAnvz32O5a9TP5rQnlGG8wPHCxVkh2Xx9w=;
 b=fuItrZYYFv5RGph+ZsLBdLvS401JPvBt83KMJ2WSSjPlnI0FbMdv2zvNNJoBPtF9Y7
 Y7ugxmG8MTBR5M3UeUxwz4l8MPEN5IVq/YqxdowxxEfj5es0CfIyp8IQ2T/s1x3DdKXL
 HgW8cNBoA0YcvSupEulK12n0MZnWQ6V24K59Ro+pfUjOogOhqUUY/RHWzXFGUOdI+bTA
 jbhdrM4kNp3Bz4wAZFd/KYALZ7bAFbZHQVCyuh4UkfaN+8haOozIqHgbVNHyHRfxXm4O
 9Ru9mByU41xJkqTaHZpLSm0KVZhIxuG9PzuHv8KEIp1f7dp+8flc1rxg1ZzGzAGMWqYW
 V5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Dfp4IqU2KYAnvz32O5a9TP5rQnlGG8wPHCxVkh2Xx9w=;
 b=d1B8P7rcQSfIqB+NvGZpmWEPdKfugILzCFPfniZJEyhTXIr2BmXT3DKHSrqASOV55t
 J3Csjfn1c0ocBltzwXsURVU1SCVZAJDRxP2/P6ZFf0oaRLyuk5xTUufNSZmJvr/oHI2C
 qDcne3slg0DCAm02uqKZONLxPF7pXZN09Bwb4aKKtzURf5dj+lq2KTXTFcFubKrfoCUs
 Z90tXzZjKUyHW+vwrHeRUAlmTyP6msn11H9JHR3o7/GUFKbXIiVrO/Ehjjx8ZvJSKkL/
 Apd+H3nlae57Qwx0BV3xy7vdtSNV6D6UuP8U543uit1eXJUALzl+2BgaFhE6svXcH4z1
 V8fw==
X-Gm-Message-State: AOAM5339bTJcEjSgdJZ0CFc9nY9kxr+z2AZ972u790/m+gkGzd6wnKps
 zfmGLQe9pc1zR6sxB1mYyqMqAfEcJiqrBA==
X-Google-Smtp-Source: ABdhPJwWrzFFOlfJ1sh6b2zrd6PEUUux/zNigtsmMWoaPwMUgaCQqVY7otyNsOdIIzT6KNuk78MFDg==
X-Received: by 2002:a17:902:b082:: with SMTP id
 p2mr1496402plr.266.1598624456959; 
 Fri, 28 Aug 2020 07:20:56 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 67/76] target/microblaze: Convert dec_bcc to decodetree
Date: Fri, 28 Aug 2020 07:19:20 -0700
Message-Id: <20200828141929.77854-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/insns.decode | 36 +++++++++++++
 target/microblaze/translate.c  | 99 ++++++++++++++++++----------------
 2 files changed, 88 insertions(+), 47 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index 340dd999b6..e6a61f147a 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -20,8 +20,10 @@
 &typea0         rd ra
 &typea          rd ra rb
 &typea_br       rd rb
+&typea_bc       ra rb
 &typeb          rd ra imm
 &typeb_br       rd imm
+&typeb_bc       ra imm
 
 # Include any IMM prefix in the value reported.
 %extimm         0:s16 !function=typeb_imm
@@ -35,12 +37,18 @@
 # Officially typea, but with ra as opcode.
 @typea_br       ...... rd:5 ..... rb:5 ...........      &typea_br
 
+# Officially typea, but with rd as opcode.
+@typea_bc       ...... ..... ra:5 rb:5 ...........      &typea_bc
+
 # Officially typeb, but any immediate extension is unused.
 @typeb_bs       ...... rd:5 ra:5 ..... ...... imm:5     &typeb
 
 # Officially typeb, but with ra as opcode.
 @typeb_br       ...... rd:5 ..... ................      &typeb_br imm=%extimm
 
+# Officially typeb, but with rd as opcode.
+@typeb_bc       ...... ..... ra:5 ................      &typeb_bc imm=%extimm
+
 # For convenience, extract the two imm_w/imm_s fields, then pack
 # them back together as "imm".  Doing this makes it easiest to
 # match the required zero at bit 5.
@@ -68,6 +76,34 @@ andi            101001 ..... ..... ................     @typeb
 andn            100011 ..... ..... ..... 000 0000 0000  @typea
 andni           101011 ..... ..... ................     @typeb
 
+beq             100111 00000 ..... ..... 000 0000 0000  @typea_bc
+bge             100111 00101 ..... ..... 000 0000 0000  @typea_bc
+bgt             100111 00100 ..... ..... 000 0000 0000  @typea_bc
+ble             100111 00011 ..... ..... 000 0000 0000  @typea_bc
+blt             100111 00010 ..... ..... 000 0000 0000  @typea_bc
+bne             100111 00001 ..... ..... 000 0000 0000  @typea_bc
+
+beqd            100111 10000 ..... ..... 000 0000 0000  @typea_bc
+bged            100111 10101 ..... ..... 000 0000 0000  @typea_bc
+bgtd            100111 10100 ..... ..... 000 0000 0000  @typea_bc
+bled            100111 10011 ..... ..... 000 0000 0000  @typea_bc
+bltd            100111 10010 ..... ..... 000 0000 0000  @typea_bc
+bned            100111 10001 ..... ..... 000 0000 0000  @typea_bc
+
+beqi            101111 00000 ..... ................     @typeb_bc
+bgei            101111 00101 ..... ................     @typeb_bc
+bgti            101111 00100 ..... ................     @typeb_bc
+blei            101111 00011 ..... ................     @typeb_bc
+blti            101111 00010 ..... ................     @typeb_bc
+bnei            101111 00001 ..... ................     @typeb_bc
+
+beqid           101111 10000 ..... ................     @typeb_bc
+bgeid           101111 10101 ..... ................     @typeb_bc
+bgtid           101111 10100 ..... ................     @typeb_bc
+bleid           101111 10011 ..... ................     @typeb_bc
+bltid           101111 10010 ..... ................     @typeb_bc
+bneid           101111 10001 ..... ................     @typeb_bc
+
 br              100110 ..... 00000 ..... 000 0000 0000  @typea_br
 bra             100110 ..... 01000 ..... 000 0000 0000  @typea_br
 brd             100110 ..... 10000 ..... 000 0000 0000  @typea_br
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 5c6e6e599e..b8dcef8f1c 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1095,6 +1095,58 @@ DO_BR(brad, braid, true, true, false)
 DO_BR(brld, brlid, true, false, true)
 DO_BR(brald, bralid, true, true, true)
 
+static bool do_bcc(DisasContext *dc, int dest_rb, int dest_imm,
+                   TCGCond cond, int ra, bool delay)
+{
+    TCGv_i32 zero, next;
+
+    if (delay) {
+        setup_dslot(dc, dest_rb < 0);
+    }
+
+    dc->jmp_cond = cond;
+
+    /* Cache the condition register in cpu_bvalue across any delay slot.  */
+    tcg_gen_mov_i32(cpu_bvalue, reg_for_read(dc, ra));
+
+    /* Store the branch taken destination into btarget.  */
+    if (dest_rb > 0) {
+        dc->jmp_dest = -1;
+        tcg_gen_addi_i32(cpu_btarget, cpu_R[dest_rb], dc->base.pc_next);
+    } else {
+        dc->jmp_dest = dc->base.pc_next + dest_imm;
+        tcg_gen_movi_i32(cpu_btarget, dc->jmp_dest);
+    }
+
+    /* Compute the final destination into btarget.  */
+    zero = tcg_const_i32(0);
+    next = tcg_const_i32(dc->base.pc_next + (delay + 1) * 4);
+    tcg_gen_movcond_i32(dc->jmp_cond, cpu_btarget,
+                        reg_for_read(dc, ra), zero,
+                        cpu_btarget, next);
+    tcg_temp_free_i32(zero);
+    tcg_temp_free_i32(next);
+
+    return true;
+}
+
+#define DO_BCC(NAME, COND)                                              \
+    static bool trans_##NAME(DisasContext *dc, arg_typea_bc *arg)       \
+    { return do_bcc(dc, arg->rb, 0, COND, arg->ra, false); }            \
+    static bool trans_##NAME##d(DisasContext *dc, arg_typea_bc *arg)    \
+    { return do_bcc(dc, arg->rb, 0, COND, arg->ra, true); }             \
+    static bool trans_##NAME##i(DisasContext *dc, arg_typeb_bc *arg)    \
+    { return do_bcc(dc, -1, arg->imm, COND, arg->ra, false); }          \
+    static bool trans_##NAME##id(DisasContext *dc, arg_typeb_bc *arg)   \
+    { return do_bcc(dc, -1, arg->imm, COND, arg->ra, true); }
+
+DO_BCC(beq, TCG_COND_EQ)
+DO_BCC(bge, TCG_COND_GE)
+DO_BCC(bgt, TCG_COND_GT)
+DO_BCC(ble, TCG_COND_LE)
+DO_BCC(blt, TCG_COND_LT)
+DO_BCC(bne, TCG_COND_NE)
+
 static bool trans_brk(DisasContext *dc, arg_typea_br *arg)
 {
     if (trap_userspace(dc, true)) {
@@ -1419,52 +1471,6 @@ static void dec_msr(DisasContext *dc)
     }
 }
 
-static void dec_bcc(DisasContext *dc)
-{
-    static const TCGCond mb_to_tcg_cc[] = {
-        [CC_EQ] = TCG_COND_EQ,
-        [CC_NE] = TCG_COND_NE,
-        [CC_LT] = TCG_COND_LT,
-        [CC_LE] = TCG_COND_LE,
-        [CC_GE] = TCG_COND_GE,
-        [CC_GT] = TCG_COND_GT,
-    };
-    unsigned int cc;
-    unsigned int dslot;
-    TCGv_i32 zero, next;
-
-    cc = EXTRACT_FIELD(dc->ir, 21, 23);
-    dslot = dc->ir & (1 << 25);
-
-    if (dslot) {
-        setup_dslot(dc, dc->type_b);
-    }
-
-    dc->jmp_cond = mb_to_tcg_cc[cc];
-
-    /* Cache the condition register in cpu_bvalue across any delay slot.  */
-    tcg_gen_mov_i32(cpu_bvalue, cpu_R[dc->ra]);
-
-    /* Store the branch taken destination into btarget.  */
-    if (dc->type_b) {
-        dc->jmp_dest = dc->base.pc_next + dec_alu_typeb_imm(dc);
-        tcg_gen_movi_i32(cpu_btarget, dc->jmp_dest);
-    } else {
-        dc->jmp_dest = -1;
-        tcg_gen_addi_i32(cpu_btarget, reg_for_read(dc, dc->rb),
-                         dc->base.pc_next);
-    }
-
-    /* Compute the final destination into btarget.  */
-    zero = tcg_const_i32(0);
-    next = tcg_const_i32(dc->base.pc_next + (dslot + 1) * 4);
-    tcg_gen_movcond_i32(dc->jmp_cond, cpu_btarget,
-                        reg_for_read(dc, dc->ra), zero,
-                        cpu_btarget, next);
-    tcg_temp_free_i32(zero);
-    tcg_temp_free_i32(next);
-}
-
 static inline void do_rti(DisasContext *dc)
 {
     TCGv_i32 t0, t1;
@@ -1595,7 +1601,6 @@ static struct decoder_info {
     };
     void (*dec)(DisasContext *dc);
 } decinfo[] = {
-    {DEC_BCC, dec_bcc},
     {DEC_RTS, dec_rts},
     {DEC_MSR, dec_msr},
     {DEC_STREAM, dec_stream},
-- 
2.25.1


