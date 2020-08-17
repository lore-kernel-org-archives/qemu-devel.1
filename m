Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC53C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C01206C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nW7TvjdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C01206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7b9B-0002cg-Cy
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7asY-00022p-QB
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:30 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:35586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7asX-0005FH-Bs
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:30 -0400
Received: by mail-pf1-x42d.google.com with SMTP id d188so7899759pfd.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9SPiVjhB7+vpiXzes/q/y9lQUYKkdB8mqr6lOjW0j+0=;
 b=nW7TvjdS1NOAzh+bJcn+OqfsTm49GlE1HNfXdqq3sDsn/SrxgGJqsucsRyi5wLj72i
 BVYNQVWoP8K6p4u1EB30YGWubqA0sJKHTcaWeKvcwmFtPl5Ay0u19Mj7WCprLCsFhYN9
 53PgcAL3a5m6npSVAeH72Jv73HydCHsS5EBXFsHBVPXM719JtnMCCCJv/KaEEZ2I48W5
 UA5XsgtoUslg0sWqHh5JoSE+oyusZ1gNXb7S/39zMyW659pHVsyPKKyBv0t05nyyfKkx
 q/pkotNqJ0TNvRkkveiIEQUY7z4Au0aLCGVFP2CK/UEssACNboMSVhYnM4eCChbxLN+a
 meKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9SPiVjhB7+vpiXzes/q/y9lQUYKkdB8mqr6lOjW0j+0=;
 b=P28DTQijdTwAfzIJiio6//YBUMzemVi71k11IDtDAxIWR7yxoZ8paTDmy+lgs8d0Fo
 H0bwUAHNiYlLm2Zj8pwFJyv5YqYINUxB92JjlJi8DBnykxgGoWGVh09yKV5e9v3ThgOf
 c5NtRLRAf+eZJpOQEXa/HB2NKxbrEoKI8oT0u06qMVyL+SZE7Z6E3Hmsih0AtVulDQG+
 jZ4MjWSmEZhuijQYLmUj8eBZdl6Igi9J5rAWeDTzBgRCIN3BRCt7kcaaoLfBgVnpPdBf
 RDbhC6U0BhPLFC9UK8umy74R5x6oY7WSWdJMkHBfKU30kE6eeiEfLUmEG3TKHgxGP7ws
 qFBg==
X-Gm-Message-State: AOAM530YACldzC97VTGV4kxjItSPI29RTLq6JMQvtn6khdeRluJhMsmg
 u0M+e7Yto2CZTpo7F7ndDKl2ibTPIMMSOg==
X-Google-Smtp-Source: ABdhPJxfLCR4c1R10bUXe5uU6BfLrEvm/TICgE/690fYEBpLUS/8q+tGk/wISN4djt/XhFovjyoBIQ==
X-Received: by 2002:a63:1a66:: with SMTP id a38mr9046386pgm.253.1597654347928; 
 Mon, 17 Aug 2020 01:52:27 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:52:27 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 51/70] target/riscv: rvv-1.0: mask-register logical
 instructions
Date: Mon, 17 Aug 2020 16:49:36 +0800
Message-Id: <20200817084955.28793-52-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
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

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 3 ++-
 target/riscv/vector_helper.c            | 4 ----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index c3be3dd97ff..41789a2ba6f 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2987,7 +2987,8 @@ GEN_OPFVV_WIDEN_TRANS(vfwredsum_vs, reduction_check)
 #define GEN_MM_TRANS(NAME)                                         \
 static bool trans_##NAME(DisasContext *s, arg_r *a)                \
 {                                                                  \
-    if (vext_check_isa_ill(s)) {                                   \
+    if (require_rvv(s) &&                                          \
+        vext_check_isa_ill(s)) {                                   \
         uint32_t data = 0;                                         \
         gen_helper_gvec_4_ptr *fn = gen_helper_##NAME;             \
         TCGLabel *over = gen_new_label();                          \
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 766622d3878..ea1715b5484 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4490,7 +4490,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
                   void *vs2, CPURISCVState *env,          \
                   uint32_t desc)                          \
 {                                                         \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen;          \
     uint32_t vl = env->vl;                                \
     uint32_t i;                                           \
     int a, b;                                             \
@@ -4500,9 +4499,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
         b = vext_elem_mask(vs2, i);                       \
         vext_set_elem_mask(vd, i, OP(b, a));              \
     }                                                     \
-    for (; i < vlmax; i++) {                              \
-        vext_set_elem_mask(vd, i, 0);                     \
-    }                                                     \
 }
 
 #define DO_NAND(N, M)  (!(N & M))
-- 
2.17.1


