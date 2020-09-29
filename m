Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624C2C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:30:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC0AC20774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aIAn8Bs/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0AC20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLKb-0005XL-Ip
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKyH-00065E-RI
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:07:29 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKyE-0002Fd-PR
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:07:29 -0400
Received: by mail-pg1-x543.google.com with SMTP id x16so4650248pgj.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Dgz3FhfTw8GOnd9OxFv1aL29mGED9JHvOecPRJ6gvME=;
 b=aIAn8Bs/4Degxc3EHaBnXUq46BuVx3iXfLvFjuaYq06GBh2DqPtvOfsgefM1wF+GO+
 TqNCMd6fOy+jrPVstbhKVKWs61MiUqkG2vZlMIAnYo6gFCcBSjTq0copOcrwtzs+E5cq
 DkOllvvu+YIJvCr2QQ8mO8OWze29cLCxtbpfGsaVapGqajJPtsxy/KDXjeRKrTxBxmRa
 gdkZZyDdPaHGMcDHYwhfz3A343DKdnNg7+29zKNhJg2W++p4SF2X+I9kzGIklXuodpDX
 f4XFoRbcIc7UdWmvt1+PRc2sBgjXmUp499aNXEpWKXUV/LGomn2jMDwr+29AwiIBSpdA
 V93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Dgz3FhfTw8GOnd9OxFv1aL29mGED9JHvOecPRJ6gvME=;
 b=gt2H4tWDeMg0YLa4q72E8SBrjuYLAy0Wr/b/XvZ1BqpyWEryQutvy5di3IkYYYInG7
 cTVqjrTC00HM0HmqgfBTAx2ssDjkQz0DcgMQHAA/5MAYfw+FjgcbO26gxrZXBVICNLs7
 x7rkO3A8HK/ORR456c6Js36/VMYpy40ZRrLkHpH3n085O9SM2VPyqiG1VJzusH+VegFO
 brFWZwB+V89qsdjMw1NEXO9l6FrqZS4JawzPPmvtaM5+63w2HXLVIbyx/o4J/MCwhdGC
 gYfzSrZoNTxmFx1rvrI7rzTIvKcgwiSsNloYG52mnfQlzK28wWI7KCe/4qmIZ7Ly9NK1
 1W8Q==
X-Gm-Message-State: AOAM530xrTn/ApJfUldRsgNgrVUgEdB7OQsZ1D5ArhhqbqaFXk/5X1MK
 EWEeUx4fS0WaCYL75oRXIq+uO0JhP4V3Nw==
X-Google-Smtp-Source: ABdhPJxGvecUEPYFcrHc/enVIT9nQfq/MMuufs4aJoJit6x5cbotQjkKjai1ZEqEnNJ3I2kP4wA16g==
X-Received: by 2002:a63:df42:: with SMTP id h2mr4575594pgj.239.1601406445351; 
 Tue, 29 Sep 2020 12:07:25 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:07:24 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 36/68] target/riscv: rvv-1.0: floating-point move instruction
Date: Wed, 30 Sep 2020 03:04:11 +0800
Message-Id: <20200929190448.31116-37-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

NaN-boxed the scalar floating-point register based on RVV 1.0's rules.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 46317ae490..254cface60 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2709,9 +2709,15 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
         require_rvf(s) &&
         vext_check_isa_ill(s) &&
         require_align(a->rd, s->lmul)) {
+        TCGv_i64 t1;
+
         if (s->vl_eq_vlmax) {
+            t1 = tcg_temp_new_i64();
+            /* NaN-box f[rs1] */
+            do_nanbox(s, t1, cpu_fpr[a->rs1]);
+
             tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
-                                 MAXSZ(s), MAXSZ(s), cpu_fpr[a->rs1]);
+                                 MAXSZ(s), MAXSZ(s), t1);
             mark_vs_dirty(s);
         } else {
             TCGv_ptr dest;
@@ -2725,16 +2731,22 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
             TCGLabel *over = gen_new_label();
             tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
 
+            t1 = tcg_temp_new_i64();
+            /* NaN-box f[rs1] */
+            do_nanbox(s, t1, cpu_fpr[a->rs1]);
+
             dest = tcg_temp_new_ptr();
             desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
             tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, a->rd));
-            fns[s->sew - 1](dest, cpu_fpr[a->rs1], cpu_env, desc);
+
+            fns[s->sew - 1](dest, t1, cpu_env, desc);
 
             tcg_temp_free_ptr(dest);
             tcg_temp_free_i32(desc);
             mark_vs_dirty(s);
             gen_set_label(over);
         }
+        tcg_temp_free_i64(t1);
         return true;
     }
     return false;
-- 
2.17.1


