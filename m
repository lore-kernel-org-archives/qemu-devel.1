Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19088C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:07:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB42E22D0B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HKI45LCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB42E22D0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dnN-0000vk-G3
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSN-0003Hi-6m
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:07 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:44198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSK-0007wy-7i
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:06 -0400
Received: by mail-pg1-x52b.google.com with SMTP id m34so120957pgl.11
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=NR1664it16RY8C1uPlBNxYlSGqAXR1fGDYTpsJCJOoM=;
 b=HKI45LCs/0bqDHMjo52hTqgX98AHmw2KHH92T06aj78ZYtyn87XLo22PLw/wJKv5Xk
 SQ9miLRl0yMY+ZyaKf4tsrNoyyv1CpCUU8rNNWoSQcM52B7HQato5vaOC9cRfCJ7iBU5
 FwdNUC5TtdqeIzomi7cXtFzHxQq/i+Gk/ruswrxLzIOdfUk2xBv1qbtrxxFy06b9UCrY
 3zx/Bed0wUpCIgkCh7TcHQOe6Wizi0UD9hyYsynaVsFA75bxiFpKYpAEAMPqg8DyhxHC
 olksowavG37mpwvAZ67nW2tpy9bwDXnYAqmvzv5RetwWtaDE1Nk/1MqgDD0dS2F06FUk
 679g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=NR1664it16RY8C1uPlBNxYlSGqAXR1fGDYTpsJCJOoM=;
 b=SMfHg1HFnnTcQLHw6PYTQf/8mo809Xvu/eZycSFSaPYw07h+GmS6O6ViwpmIQgSWQh
 saIop9eFJmkO3qVpac3HuxAUGdih1/h706xlJC9f19dkVd3I3ttLaW9Pig50LyFwDdZn
 PlfcmYGTe5n85VA2A6n/nhT3FLXMCW55gFHb3j1OIO9jH0lMpv15N2a38uxzZ+RRx7ot
 5C3IO/8QLNvT/rsQQ0swV3HpGiXySyi6W9mjqmjukDiDIQEA7VGw5tFp9nNgqpTWyqf6
 Kh9nR1fQ5uY+G1UNbVTCFdH6iRRyTOLkGIUYPjVAhA85DofvE5voMrjto2W98Q3yg0Y1
 byCw==
X-Gm-Message-State: AOAM531pcJsZGgBoV1DW6/ZP8MZTcTj3hGplYkH6porkF5/I05AyckhE
 iLcm0MYtEeCReYSB7GmPgFlfjCrLLUY=
X-Google-Smtp-Source: ABdhPJyp+IEfMMpMNffVXb72FX8njlDVFW5IJWCwGeRqnPqRQktOl68rV43y8GOGO+zb3W7wEDc4KQ==
X-Received: by 2002:a62:3185:: with SMTP id x127mr7507474pfx.290.1596710942475; 
 Thu, 06 Aug 2020 03:49:02 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:49:02 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 41/71] target/riscv: rvv-1.0: integer extension instructions
Date: Thu,  6 Aug 2020 18:46:38 +0800
Message-Id: <20200806104709.13235-42-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x52b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Add the following instructions:

* vzext.vf2
* vzext.vf4
* vzext.vf8
* vsext.vf2
* vsext.vf4
* vsext.vf8

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/helper.h                   | 14 ++++
 target/riscv/insn32.decode              |  8 +++
 target/riscv/insn_trans/trans_rvv.inc.c | 85 +++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 31 +++++++++
 4 files changed, 138 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 35fb09d2892..7ce2fa08d58 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1118,3 +1118,17 @@ DEF_HELPER_6(vcompress_vm_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vcompress_vm_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vcompress_vm_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vcompress_vm_d, void, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_5(vzext_vf2_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vzext_vf2_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vzext_vf2_d, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vzext_vf4_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vzext_vf4_d, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vzext_vf8_d, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_5(vsext_vf2_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vsext_vf2_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vsext_vf2_d, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vsext_vf4_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vsext_vf4_d, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vsext_vf8_d, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 65ff1688c25..2b9700a42ad 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -619,5 +619,13 @@ vmv2r_v         100111 1 ..... 00001 011 ..... 1010111 @r2rd
 vmv4r_v         100111 1 ..... 00011 011 ..... 1010111 @r2rd
 vmv8r_v         100111 1 ..... 00111 011 ..... 1010111 @r2rd
 
+# Vector Integer Extension
+vzext_vf2       010010 . ..... 00110 010 ..... 1010111 @r2_vm
+vzext_vf4       010010 . ..... 00100 010 ..... 1010111 @r2_vm
+vzext_vf8       010010 . ..... 00010 010 ..... 1010111 @r2_vm
+vsext_vf2       010010 . ..... 00111 010 ..... 1010111 @r2_vm
+vsext_vf4       010010 . ..... 00101 010 ..... 1010111 @r2_vm
+vsext_vf8       010010 . ..... 00011 010 ..... 1010111 @r2_vm
+
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index c3fe5d0eee7..cb9062e6ad8 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -3491,3 +3491,88 @@ GEN_VMV_WHOLE_TRANS(vmv1r_v, 1)
 GEN_VMV_WHOLE_TRANS(vmv2r_v, 2)
 GEN_VMV_WHOLE_TRANS(vmv4r_v, 4)
 GEN_VMV_WHOLE_TRANS(vmv8r_v, 8)
+
+static bool int_ext_check(DisasContext *s, arg_rmr *a, uint8_t div)
+{
+    uint32_t from = (1 << (s->sew + 3)) / div;
+    bool ret = require_rvv(s);
+    ret &= (from >= 8 && from <= 64) &&
+           (a->rd != a->rs2) &&
+           require_align(a->rd, s->flmul) &&
+           require_align(a->rs2, s->flmul / div) &&
+           require_vm(a->vm, a->rd);
+    if ((s->flmul / div) < 1) {
+        ret &= require_noover(a->rd, s->flmul, a->rs2, s->flmul / div);
+    } else {
+        ret &= require_noover_widen(a->rd, s->flmul, a->rs2, s->flmul / div);
+    }
+    return ret;
+}
+
+static bool int_ext_op(DisasContext *s, arg_rmr *a, uint8_t seq)
+{
+    uint32_t data = 0;
+    gen_helper_gvec_3_ptr *fn;
+    TCGLabel *over = gen_new_label();
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+
+    static gen_helper_gvec_3_ptr * const fns[6][4] = {
+        {
+            NULL, gen_helper_vzext_vf2_h,
+            gen_helper_vzext_vf2_w, gen_helper_vzext_vf2_d
+        },
+        {
+            NULL, NULL,
+            gen_helper_vzext_vf4_w, gen_helper_vzext_vf4_d,
+        },
+        {
+            NULL, NULL,
+            NULL, gen_helper_vzext_vf8_d
+        },
+        {
+            NULL, gen_helper_vsext_vf2_h,
+            gen_helper_vsext_vf2_w, gen_helper_vsext_vf2_d
+        },
+        {
+            NULL, NULL,
+            gen_helper_vsext_vf4_w, gen_helper_vsext_vf4_d,
+        },
+        {
+            NULL, NULL,
+            NULL, gen_helper_vsext_vf8_d
+        }
+    };
+
+    fn = fns[seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    data = FIELD_DP32(data, VDATA, VM, a->vm);
+    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+
+    tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
+                       vreg_ofs(s, a->rs2), cpu_env, 0,
+                       s->vlen / 8, data, fn);
+
+    mark_vs_dirty(s);
+    gen_set_label(over);
+    return true;
+}
+
+/* Vector Integer Extension */
+#define GEN_INT_EXT_TRANS(NAME, DIV, SEQ)             \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a) \
+{                                                     \
+    if (int_ext_check(s, a, DIV)) {                   \
+        return int_ext_op(s, a, SEQ);                 \
+    }                                                 \
+    return false;                                     \
+}
+
+GEN_INT_EXT_TRANS(vzext_vf2, 2, 0)
+GEN_INT_EXT_TRANS(vzext_vf4, 4, 1)
+GEN_INT_EXT_TRANS(vzext_vf8, 8, 2)
+GEN_INT_EXT_TRANS(vsext_vf2, 2, 3)
+GEN_INT_EXT_TRANS(vsext_vf4, 4, 4)
+GEN_INT_EXT_TRANS(vsext_vf8, 8, 5)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index d7827a9db10..33378940ae1 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4793,3 +4793,34 @@ GEN_VEXT_VCOMPRESS_VM(vcompress_vm_b, uint8_t,  H1)
 GEN_VEXT_VCOMPRESS_VM(vcompress_vm_h, uint16_t, H2)
 GEN_VEXT_VCOMPRESS_VM(vcompress_vm_w, uint32_t, H4)
 GEN_VEXT_VCOMPRESS_VM(vcompress_vm_d, uint64_t, H8)
+
+/* Vector Integer Extension */
+#define GEN_VEXT_INT_EXT(NAME, ETYPE, DTYPE, HD, HS1)            \
+void HELPER(NAME)(void *vd, void *v0, void *vs2,                 \
+                  CPURISCVState *env, uint32_t desc)             \
+{                                                                \
+    uint32_t vl = env->vl;                                       \
+    uint32_t vm = vext_vm(desc);                                 \
+    uint32_t i;                                                  \
+                                                                 \
+    for (i = 0; i < vl; i++) {                                   \
+        if (!vm && !vext_elem_mask(v0, i)) {                     \
+            continue;                                            \
+        }                                                        \
+        *((ETYPE *)vd + HD(i)) = *((DTYPE *)vs2 + HS1(i));       \
+    }                                                            \
+}
+
+GEN_VEXT_INT_EXT(vzext_vf2_h, uint16_t, uint8_t,  H2, H1)
+GEN_VEXT_INT_EXT(vzext_vf2_w, uint32_t, uint16_t, H4, H2)
+GEN_VEXT_INT_EXT(vzext_vf2_d, uint64_t, uint32_t, H8, H4)
+GEN_VEXT_INT_EXT(vzext_vf4_w, uint32_t, uint8_t,  H4, H1)
+GEN_VEXT_INT_EXT(vzext_vf4_d, uint64_t, uint16_t, H8, H2)
+GEN_VEXT_INT_EXT(vzext_vf8_d, uint64_t, uint8_t,  H8, H1)
+
+GEN_VEXT_INT_EXT(vsext_vf2_h, int16_t, int8_t,  H2, H1)
+GEN_VEXT_INT_EXT(vsext_vf2_w, int32_t, int16_t, H4, H2)
+GEN_VEXT_INT_EXT(vsext_vf2_d, int64_t, int32_t, H8, H4)
+GEN_VEXT_INT_EXT(vsext_vf4_w, int32_t, int8_t,  H4, H1)
+GEN_VEXT_INT_EXT(vsext_vf4_d, int64_t, int16_t, H8, H2)
+GEN_VEXT_INT_EXT(vsext_vf8_d, int64_t, int8_t,  H8, H1)
-- 
2.17.1


