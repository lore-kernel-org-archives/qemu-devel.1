Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE6AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A45B206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AXGSNlW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A45B206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtstt-0005km-Im
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqdp-0005VB-0v
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:52:29 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqdn-0006hO-II
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:52:28 -0400
Received: by mail-pl1-x644.google.com with SMTP id x8so2092507plm.10
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=L4Kzsw7wUWuVwYBl74RPS8EslTXrh5P2ZhIpCnrFxpQ=;
 b=AXGSNlW/DmpQEPlIj1iYGCQ6q5VKp++KbE4TvMCO3hguVg8qB50762WxSabIOsHFdS
 tceUOedVxbiz1x1fRxnkelW09YaWDOP9fJNO1Bet7D4+OOFEHOQbSyxCFhoBUa1BTBsd
 H/oDPOfB5H8h/BKfWXDZHLrYmtqLjTVRz3ctm51CxGEVi6RlHeTJIiUYIZ2mu7cbBCjT
 lXN4W//Vu2iRp9/7vJKEEXvEFZL4xyfO8CRgZqRJOtuRAclWnoUAxoY39UUdlFjLWoDK
 SJZdT4BRlObggoOTdsioL5UeRT4m7+vqgO/OhYD80fc2p4uRCepvQqQyPEAQKmuYuD3U
 4pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=L4Kzsw7wUWuVwYBl74RPS8EslTXrh5P2ZhIpCnrFxpQ=;
 b=uNXBRnLrk5VTyVKX0AhFsFX5l8bUwOFF2Gnm7kxnE3vrTtJ9YYxQQgLTtCPqfwJ4vg
 th3dOFASOTgysGa1dU/V8VCo2PIWF4QuCOs7AfXgSyPDX0z0g/dtB4HOlOw4MxC4oaI8
 1soi3thE43v8RBzvSu8cDshU/F1ztpMbi558aCRcLVWBRas+Zi3m5Avtwp17QGhWX5f2
 fIhXhk5kj3inm8pP/4dXZ7QbKLvMYnXjx8QGGKACQpsvupiBQqD7Me7x0eFMxWeOipS8
 9UaLGSkccEep+X3+mByz1aB7iduXL8AllW0g8FtCJw4b8LIjP34hZj1MDhLVMuRr8nk8
 DLdw==
X-Gm-Message-State: AOAM533Z9N/JEKukDtcQ7OH2VGr209uUZbxvDA4jWdlNhYboyyf38BJh
 v8MqH+QNgEKhhQWAwAT6nYFAW8QKRLQpmw==
X-Google-Smtp-Source: ABdhPJwUvBPlCa0vvkaJFSsNoBRe8A66YVBpxOWdBPN/HyJHx2XLliXC7YfKXQCadAMny/p75JnKPg==
X-Received: by 2002:a17:902:446:: with SMTP id
 64mr14668853ple.157.1594378346243; 
 Fri, 10 Jul 2020 03:52:26 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:52:25 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 28/65] target/riscv: rvv-0.9: element index instruction
Date: Fri, 10 Jul 2020 18:48:42 +0800
Message-Id: <20200710104920.13550-29-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x644.google.com
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
 target/riscv/insn32.decode              |  2 +-
 target/riscv/insn_trans/trans_rvv.inc.c | 40 ++++++++++++-------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 4560bc4379..01316c908d 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -579,7 +579,7 @@ vmsbf_m         010100 . ..... 00001 010 ..... 1010111 @r2_vm
 vmsif_m         010100 . ..... 00011 010 ..... 1010111 @r2_vm
 vmsof_m         010100 . ..... 00010 010 ..... 1010111 @r2_vm
 viota_m         010100 . ..... 10000 010 ..... 1010111 @r2_vm
-vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
+vid_v           010100 . 00000 10001 010 ..... 1010111 @r1_vm
 vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
 vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
 vfmv_f_s        001100 1 ..... 00000 001 ..... 1010111 @r2rd
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 0e552c3660..c03f3326cc 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2813,27 +2813,27 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
 /* Vector Element Index Instruction */
 static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
 {
-    if (vext_check_isa_ill(s) &&
-        vext_check_reg(s, a->rd, false) &&
-        vext_check_overlap_mask(s, a->rd, a->vm, false)) {
-        uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    require_align(a->rd, s->flmul);
+    require_vm(a->vm, a->rd);
 
-        data = FIELD_DP32(data, VDATA, VM, a->vm);
-        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
-        data = FIELD_DP32(data, VDATA, VTA, s->vta);
-        data = FIELD_DP32(data, VDATA, VMA, s->vma);
-        static gen_helper_gvec_2_ptr * const fns[4] = {
-            gen_helper_vid_v_b, gen_helper_vid_v_h,
-            gen_helper_vid_v_w, gen_helper_vid_v_d,
-        };
-        tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
-                           cpu_env, 0, s->vlen / 8, data, fns[s->sew]);
-        gen_set_label(over);
-        return true;
-    }
-    return false;
+    uint32_t data = 0;
+    TCGLabel *over = gen_new_label();
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+
+    data = FIELD_DP32(data, VDATA, VM, a->vm);
+    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+    data = FIELD_DP32(data, VDATA, VTA, s->vta);
+    data = FIELD_DP32(data, VDATA, VMA, s->vma);
+    static gen_helper_gvec_2_ptr * const fns[4] = {
+        gen_helper_vid_v_b, gen_helper_vid_v_h,
+        gen_helper_vid_v_w, gen_helper_vid_v_d,
+    };
+    tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
+                       cpu_env, 0, s->vlen / 8, data, fns[s->sew]);
+    gen_set_label(over);
+    return true;
 }
 
 /*
-- 
2.17.1


