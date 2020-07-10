Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8599C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931CE206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LD1jbWwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931CE206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsvW-0000cv-S6
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqdw-0005Wx-IT
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:52:36 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:40355)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqdu-0006j3-EK
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:52:36 -0400
Received: by mail-pf1-x42d.google.com with SMTP id u5so2381850pfn.7
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7Q67QVqDBeMJrBOEyv3FAnRJwEl+sGTsKf9+UnYk/r8=;
 b=LD1jbWwZ33C2AiPVOpsPmCyuzRGQrL5wJtgLdCalFiKr+tMX++YqrF4egoajqYQBlG
 c3bKCUaaLpcDADeY3+zXpJg14dHW8Vw1kNcAwYCKaau/+LgcoAXBAcoxvYZKNROGlgpu
 K650sHJYpYdi8pMQ1Jy3UlHeIbn6bM3M6KTYtZL8m5fmoqgUS/wn3DL9DBf9Rlwg7iy7
 NeyYlLEwIJL/MtFO8RkQfFnPDlhiFhp8Qvr2QQoSZPIk5dErY94xOOP6+DMEwnys92GW
 MOBbsAZXoRnlwESxOkczvCKVUL+jJCEPnpAf18pig9HzMUX8+XCm6myRwktGz9fS8Mt0
 2iyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7Q67QVqDBeMJrBOEyv3FAnRJwEl+sGTsKf9+UnYk/r8=;
 b=nIHxtBjDUf8gCUA4kehMVR+PaaYPDElIL0mMi8ThejL5uspJ/td1LbKJo/4xcbw20P
 eG1lUDYbGH+5aJ1MCtEsC/kFTcgAs18QSZo8I/MJYYikhZ+Z6hn2/esKLgrtkLpZBP4K
 kNyZEM/ULNQLPrtfg3x0Dp69mLRPp16F7eA/i53wAuOzhOm32T/SztglTHrQfmm4cLVb
 fF+gDgjfzkzFWw31ewA8DTWpNUw7RB7eS8FJIzMJkU+ZfOGWw+muuysp+xGt7kkf225M
 y1WbvMMx0dTuxb+BjznKDlvpYHKYjsQosfKwE4JJYvnv5f+9jRyNK9YWz8+me9wjyX3O
 05Bw==
X-Gm-Message-State: AOAM532ZAYPzTvdKAjm5/k2QGMdVgtFV1kaeuhIheBNdDfdKRl8wzO+0
 Yd92O43X4h+2YTdN36PYZ0Rk6F4/0VV0vg==
X-Google-Smtp-Source: ABdhPJySnn40O1t/tuo5uswcbCz0Efyx13E/OkIihVqOFJgIf4kcCc9DnE4PTfcvKfETa9uiQH92rw==
X-Received: by 2002:a62:1c13:: with SMTP id c19mr46193619pfc.52.1594378350332; 
 Fri, 10 Jul 2020 03:52:30 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:52:29 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 29/65] target/riscv: rvv-0.9: integer scalar move instructions
Date: Fri, 10 Jul 2020 18:48:43 +0800
Message-Id: <20200710104920.13550-30-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42d.google.com
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
X-Mailman-Approved-At: Fri, 10 Jul 2020 08:57:17 -0400
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Frank Chang <frank.chang@sifive.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn32.decode              |  3 +-
 target/riscv/insn_trans/trans_rvv.inc.c | 59 +++++++++++++++++--------
 2 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 01316c908d..ef53df7c73 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -580,8 +580,9 @@ vmsif_m         010100 . ..... 00011 010 ..... 1010111 @r2_vm
 vmsof_m         010100 . ..... 00010 010 ..... 1010111 @r2_vm
 viota_m         010100 . ..... 10000 010 ..... 1010111 @r2_vm
 vid_v           010100 . 00000 10001 010 ..... 1010111 @r1_vm
+vmv_x_s         010000 1 ..... 00000 010 ..... 1010111 @r2rd
+vmv_s_x         010000 1 00000 ..... 110 ..... 1010111 @r2
 vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
-vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
 vfmv_f_s        001100 1 ..... 00000 001 ..... 1010111 @r2rd
 vfmv_s_f        001101 1 00000 ..... 101 ..... 1010111 @r2
 vslideup_vx     001110 . ..... ..... 100 ..... 1010111 @r_vm
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index c03f3326cc..801b9319a5 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2986,30 +2986,53 @@ static void vec_element_storei(DisasContext *s, int vreg,
     store_element(val, cpu_env, endian_ofs(s, vreg, idx), s->sew);
 }
 
+/* vmv.x.s rd, vs2 # x[rd] = vs2[0] */
+static bool trans_vmv_x_s(DisasContext *s, arg_vmv_x_s *a)
+{
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+
+    TCGv_i64 t1;
+    TCGv dest;
+
+    t1 = tcg_temp_new_i64();
+    dest = tcg_temp_new();
+    /*
+     * load vreg and sign-extend to 64 bits,
+     * then truncate to XLEN bits before storing to gpr.
+     */
+    vec_element_loadi(s, t1, a->rs2, 0, true);
+    tcg_gen_trunc_i64_tl(dest, t1);
+    gen_set_gpr(a->rd, dest);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free(dest);
+    mark_vs_dirty(s);
+
+    return true;
+}
+
 /* vmv.s.x vd, rs1 # vd[0] = rs1 */
 static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
 {
-    if (vext_check_isa_ill(s)) {
-        /* This instruction ignores LMUL and vector register groups */
-        int maxsz = s->vlen >> 3;
-        TCGv_i64 t1;
-        TCGLabel *over = gen_new_label();
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
 
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
-        tcg_gen_gvec_dup_imm(SEW64, vreg_ofs(s, a->rd), maxsz, maxsz, 0);
-        if (a->rs1 == 0) {
-            goto done;
-        }
+    /* This instruction ignores LMUL and vector register groups */
+    TCGv_i64 t1;
+    TCGLabel *over = gen_new_label();
 
-        t1 = tcg_temp_new_i64();
-        tcg_gen_extu_tl_i64(t1, cpu_gpr[a->rs1]);
-        vec_element_storei(s, a->rd, 0, t1);
-        tcg_temp_free_i64(t1);
-    done:
-        gen_set_label(over);
-        return true;
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+    if (a->rs1 == 0) {
+        goto done;
     }
-    return false;
+
+    t1 = tcg_temp_new_i64();
+    tcg_gen_extu_tl_i64(t1, cpu_gpr[a->rs1]);
+    vec_element_storei(s, a->rd, 0, t1);
+    tcg_temp_free_i64(t1);
+done:
+    gen_set_label(over);
+    return true;
 }
 
 /* Floating-Point Scalar Move Instructions */
-- 
2.17.1


