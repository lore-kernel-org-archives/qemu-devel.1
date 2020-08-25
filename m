Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2831BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:17:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E10DD20738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G9oMrc3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10DD20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgJU-0007xi-65
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3n-0008HV-QB
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:51 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3l-0001uC-2z
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:51 -0400
Received: by mail-pf1-x444.google.com with SMTP id y206so8287766pfb.10
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EBVpcdmGEzyJpy5TxBqmLFo/yQsChKNTx1tPZX/BrS4=;
 b=G9oMrc3TDTy2qVaNzl/jLz8sZ8+MtQFzNkA4Q9NQtm/6nIewCWZxNY/NqObR2+hp/Q
 OJ6pjiDbtPqTvnfYpPRcYgWhm6LN5lTbFthO2izWDiTWFmn41VS+VAf9UhxILSbaj/Tu
 xeFrhb2XcrHx3yp3Hd5n8EGd59+QBhfq0D3/UGOXxLDAjqGIX14tXbln+QSxL9bSOGx4
 fSjav3yBHYvnHSiOY1eXnPI0UN7FZqOX+UO8CC3NwKH4l/RATFSK/bwHQvyk5oINuHlC
 Qn3hqipb1SVF4VosvjUZ67iu9Nic0Vi2SsR/hF+gwgvs/ZiZ01q4f88T1IIMAkwhWBWQ
 rZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EBVpcdmGEzyJpy5TxBqmLFo/yQsChKNTx1tPZX/BrS4=;
 b=s66TwZQykk994sd8P2TQ1NZrKSupUJIKYMPFYeIpTeNWcKvH0uYOvpOhugYBIpoFyo
 U2EoAMI5a3rKantfc5UsHfn/jLAyuYGDOYJkWEYMbMfK8HxuMnKsowO6xDGt6P+1aQsO
 YblUHJ547Zgw3PpwDcdBYs8zecBLVhvipUbOnr/BqXZmwvz7SBMyvsBM5zNrS+IKzByA
 57bPQr+gNQv84L4l13FaUvhk03mXex2xZb49O+OVe9V/Kcyf7ucRO0+SCsYnNN/IDmMj
 FNNPgRxrOYZDHzGMGfJ4gZH99IgFtp29d0wgyTSCeBta6T+ZiJiWzYiEa7yXr0IaXXa4
 J8gg==
X-Gm-Message-State: AOAM531aYWPmtKPGMnZxB1lqB2Z7HDkiu66b/fhA42T3nXm6rkwjbH48
 bi62zIs2g/fn9wsO3i7PBu/VVT2a9vBqyA==
X-Google-Smtp-Source: ABdhPJzP050xianL0sYua5XFzEeWW11T5KMYUPmbZlJHqLNe1DI7a81y7mEa4UELj0VcrFchO26gMA==
X-Received: by 2002:a63:5825:: with SMTP id m37mr8290222pgb.257.1598389247238; 
 Tue, 25 Aug 2020 14:00:47 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 44/77] target/microblaze: Convert dec_bit to decodetree
Date: Tue, 25 Aug 2020 13:59:17 -0700
Message-Id: <20200825205950.730499-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
 target/microblaze/insns.decode |  20 +++++
 target/microblaze/translate.c  | 148 +++++++++++++++++----------------
 2 files changed, 95 insertions(+), 73 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index 18619e923e..5666b381b9 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -17,6 +17,7 @@
 # License along with this library; if not, see <http://www.gnu.org/licenses/>.
 #
 
+&typea0         rd ra
 &typea          rd ra rb
 &typeb          rd ra imm
 
@@ -26,6 +27,9 @@
 @typea          ...... rd:5 ra:5 rb:5 ... .... ....     &typea
 @typeb          ...... rd:5 ra:5 ................       &typeb imm=%extimm
 
+# Officially typea, but with rb==0, which is not used.
+@typea0         ...... rd:5 ra:5 ................       &typea0
+
 ###
 
 add             000000 ..... ..... ..... 000 0000 0000  @typea
@@ -44,6 +48,8 @@ andi            101001 ..... ..... ................     @typeb
 andn            100011 ..... ..... ..... 000 0000 0000  @typea
 andni           101011 ..... ..... ................     @typeb
 
+clz             100100 ..... ..... 00000 000 1110 0000  @typea0
+
 cmp             000101 ..... ..... ..... 000 0000 0001  @typea
 cmpu            000101 ..... ..... ..... 000 0000 0011  @typea
 
@@ -73,5 +79,19 @@ rsubic          001011 ..... ..... ................     @typeb
 rsubik          001101 ..... ..... ................     @typeb
 rsubikc         001111 ..... ..... ................     @typeb
 
+sext8           100100 ..... ..... 00000 000 0110 0000  @typea0
+sext16          100100 ..... ..... 00000 000 0110 0001  @typea0
+
+sra             100100 ..... ..... 00000 000 0000 0001  @typea0
+src             100100 ..... ..... 00000 000 0010 0001  @typea0
+srl             100100 ..... ..... 00000 000 0100 0001  @typea0
+
+swapb           100100 ..... ..... 00000 001 1110 0000  @typea0
+swaph           100100 ..... ..... 00000 001 1110 0010  @typea0
+
+# Cache operations have no effect in qemu: discard the arguments.
+wdic            100100 00000 ----- ----- -00 -11- 01-0  # wdc
+wdic            100100 00000 ----- ----- 000 0110 1000  # wic
+
 xor             100010 ..... ..... ..... 000 0000 0000  @typea
 xori            101010 ..... ..... ................     @typeb
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 1d54ea02f0..10ae369cb0 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -241,6 +241,21 @@ static bool do_typea(DisasContext *dc, arg_typea *arg, bool side_effects,
     return true;
 }
 
+static bool do_typea0(DisasContext *dc, arg_typea0 *arg, bool side_effects,
+                      void (*fn)(TCGv_i32, TCGv_i32))
+{
+    TCGv_i32 rd, ra;
+
+    if (arg->rd == 0 && !side_effects) {
+        return true;
+    }
+
+    rd = reg_for_write(dc, arg->rd);
+    ra = reg_for_read(dc, arg->ra);
+    fn(rd, ra);
+    return true;
+}
+
 static bool do_typeb_imm(DisasContext *dc, arg_typeb *arg, bool side_effects,
                          void (*fni)(TCGv_i32, TCGv_i32, int32_t))
 {
@@ -283,6 +298,14 @@ static bool do_typeb_val(DisasContext *dc, arg_typeb *arg, bool side_effects,
     static bool trans_##NAME(DisasContext *dc, arg_typea *a) \
     { return dc->cpu->cfg.CFG && do_typea(dc, a, SE, FN); }
 
+#define DO_TYPEA0(NAME, SE, FN) \
+    static bool trans_##NAME(DisasContext *dc, arg_typea0 *a) \
+    { return do_typea0(dc, a, SE, FN); }
+
+#define DO_TYPEA0_CFG(NAME, CFG, SE, FN) \
+    static bool trans_##NAME(DisasContext *dc, arg_typea0 *a) \
+    { return dc->cpu->cfg.CFG && do_typea0(dc, a, SE, FN); }
+
 #define DO_TYPEBI(NAME, SE, FNI) \
     static bool trans_##NAME(DisasContext *dc, arg_typeb *a) \
     { return do_typeb_imm(dc, a, SE, FNI); }
@@ -345,6 +368,13 @@ DO_TYPEBI(andi, false, tcg_gen_andi_i32)
 DO_TYPEA(andn, false, tcg_gen_andc_i32)
 DO_TYPEBI(andni, false, gen_andni)
 
+static void gen_clz(TCGv_i32 out, TCGv_i32 ina)
+{
+    tcg_gen_clzi_i32(out, ina, 32);
+}
+
+DO_TYPEA0_CFG(clz, use_pcmp_instr, false, gen_clz)
+
 static void gen_cmp(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 {
     TCGv_i32 lt = tcg_temp_new_i32();
@@ -474,6 +504,51 @@ DO_TYPEBV(rsubic, true, gen_rsubc)
 DO_TYPEBV(rsubik, false, gen_rsubk)
 DO_TYPEBV(rsubikc, true, gen_rsubkc)
 
+DO_TYPEA0(sext8, false, tcg_gen_ext8s_i32)
+DO_TYPEA0(sext16, false, tcg_gen_ext16s_i32)
+
+static void gen_sra(TCGv_i32 out, TCGv_i32 ina)
+{
+    tcg_gen_andi_i32(cpu_msr_c, ina, 1);
+    tcg_gen_sari_i32(out, ina, 1);
+}
+
+static void gen_src(TCGv_i32 out, TCGv_i32 ina)
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    tcg_gen_mov_i32(tmp, cpu_msr_c);
+    tcg_gen_andi_i32(cpu_msr_c, ina, 1);
+    tcg_gen_extract2_i32(out, ina, tmp, 1);
+
+    tcg_temp_free_i32(tmp);
+}
+
+static void gen_srl(TCGv_i32 out, TCGv_i32 ina)
+{
+    tcg_gen_andi_i32(cpu_msr_c, ina, 1);
+    tcg_gen_shri_i32(out, ina, 1);
+}
+
+DO_TYPEA0(sra, false, gen_sra)
+DO_TYPEA0(src, false, gen_src)
+DO_TYPEA0(srl, false, gen_srl)
+
+static void gen_swaph(TCGv_i32 out, TCGv_i32 ina)
+{
+    tcg_gen_rotri_i32(out, ina, 16);
+}
+
+DO_TYPEA0(swapb, false, tcg_gen_bswap32_i32)
+DO_TYPEA0(swaph, false, gen_swaph)
+
+static bool trans_wdic(DisasContext *dc, arg_wdic *a)
+{
+    /* Cache operations are nops: only check for supervisor mode.  */
+    trap_userspace(dc, true);
+    return true;
+}
+
 DO_TYPEA(xor, false, tcg_gen_xor_i32)
 DO_TYPEBI(xori, false, tcg_gen_xori_i32)
 
@@ -740,78 +815,6 @@ static void dec_barrel(DisasContext *dc)
     }
 }
 
-static void dec_bit(DisasContext *dc)
-{
-    CPUState *cs = CPU(dc->cpu);
-    TCGv_i32 t0;
-    unsigned int op;
-
-    op = dc->ir & ((1 << 9) - 1);
-    switch (op) {
-        case 0x21:
-            /* src.  */
-            t0 = tcg_temp_new_i32();
-
-            tcg_gen_shli_i32(t0, cpu_msr_c, 31);
-            tcg_gen_andi_i32(cpu_msr_c, cpu_R[dc->ra], 1);
-            if (dc->rd) {
-                tcg_gen_shri_i32(cpu_R[dc->rd], cpu_R[dc->ra], 1);
-                tcg_gen_or_i32(cpu_R[dc->rd], cpu_R[dc->rd], t0);
-            }
-            tcg_temp_free_i32(t0);
-            break;
-
-        case 0x1:
-        case 0x41:
-            /* srl.  */
-            tcg_gen_andi_i32(cpu_msr_c, cpu_R[dc->ra], 1);
-            if (dc->rd) {
-                if (op == 0x41)
-                    tcg_gen_shri_i32(cpu_R[dc->rd], cpu_R[dc->ra], 1);
-                else
-                    tcg_gen_sari_i32(cpu_R[dc->rd], cpu_R[dc->ra], 1);
-            }
-            break;
-        case 0x60:
-            tcg_gen_ext8s_i32(cpu_R[dc->rd], cpu_R[dc->ra]);
-            break;
-        case 0x61:
-            tcg_gen_ext16s_i32(cpu_R[dc->rd], cpu_R[dc->ra]);
-            break;
-        case 0x64:
-        case 0x66:
-        case 0x74:
-        case 0x76:
-            /* wdc.  */
-            trap_userspace(dc, true);
-            break;
-        case 0x68:
-            /* wic.  */
-            trap_userspace(dc, true);
-            break;
-        case 0xe0:
-            if (trap_illegal(dc, !dc->cpu->cfg.use_pcmp_instr)) {
-                return;
-            }
-            if (dc->cpu->cfg.use_pcmp_instr) {
-                tcg_gen_clzi_i32(cpu_R[dc->rd], cpu_R[dc->ra], 32);
-            }
-            break;
-        case 0x1e0:
-            /* swapb */
-            tcg_gen_bswap32_i32(cpu_R[dc->rd], cpu_R[dc->ra]);
-            break;
-        case 0x1e2:
-            /*swaph */
-            tcg_gen_rotri_i32(cpu_R[dc->rd], cpu_R[dc->ra], 16);
-            break;
-        default:
-            cpu_abort(cs, "unknown bit oc=%x op=%x rd=%d ra=%d rb=%d\n",
-                      (uint32_t)dc->base.pc_next, op, dc->rd, dc->ra, dc->rb);
-            break;
-    }
-}
-
 static inline void sync_jmpstate(DisasContext *dc)
 {
     if (dc->jmp == JMP_DIRECT || dc->jmp == JMP_DIRECT_CC) {
@@ -1534,7 +1537,6 @@ static struct decoder_info {
     };
     void (*dec)(DisasContext *dc);
 } decinfo[] = {
-    {DEC_BIT, dec_bit},
     {DEC_BARREL, dec_barrel},
     {DEC_LD, dec_load},
     {DEC_ST, dec_store},
-- 
2.25.1


