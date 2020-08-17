Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFE5C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:13:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B2832063A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="I00Wkwfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2832063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bCQ-0000tS-E0
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7as0-0001Ih-OV
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:51:57 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034]:36584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7ars-000580-SR
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:51:56 -0400
Received: by mail-pj1-x1034.google.com with SMTP id ha11so7376595pjb.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TLFoCDPeQcW7A+mBd93r9Pik+AUdqCFF5a8qm7ybiZg=;
 b=I00Wkwfk3Yw5W74E3BukTEbiqZ6xkNXG6J6rBx1jUZ/DKMX3Z0aIVtl6M9DPUFq7wx
 wPcHr/ekhsaYC1yWDC6Xu1k+wL9M1vBDEU2IIv5+HOPNonQ0/7Iucv5K7IWOmUSl1Hcg
 extYcn0qmn43Hk32VrH8dfZTUo6w7vkQj9GWgUZnE+tuQmitAxr3Gl+BybQGQL2lldeI
 Uq14uB0uL5VPhBNBfJLOu6VNsNZOkOW8G/0zCVeOmyPryzwZgrXg9UB42MOkYYwxHF4r
 O6ocqMpmzT44cMG5SeoPEelvVtgXpTa8/NxDkrpbFhqfD1TiBhqZesRJE3HFMGwICtXN
 YieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=TLFoCDPeQcW7A+mBd93r9Pik+AUdqCFF5a8qm7ybiZg=;
 b=WcLgAER4OlO5ZlbMi3IqNCF19+uZgQ/IWfd7S0pv8fMIMuPIgAFLb2sauM7BWc0VcN
 Yr00OuzNByMRpXJbYdai7XykR3tfVwg2EVx7wIzIfxJmnGliRZbUrbX1HlGJtwk6XjdG
 6qEe6lvkuKRLCeDaVS4tBVMa68obbYNUwHpY4oQNAiBic7pdB6+xq8AJfWAbj7AEnpar
 b9Mf9NfsUTyW443perrZwxFi9QZT6HG53miqKTol467EXgqICNrHNwVSxeC/DzpJOG2W
 NKJZSDqJYtLOo6u5gU9IPF0w/u3vkw4gOzBvUcmyIMJZdVlQNr1SWC4vYWG4OtaSFxmk
 kJ0g==
X-Gm-Message-State: AOAM531q8aTF1W/iTBRt4RZnainaBB5M0HHTZLPud01lZi+XXpALa6kq
 nfukxgEiH45je5TMyOBox5jxDtA5Oe5J4Q==
X-Google-Smtp-Source: ABdhPJzRWb8q9HZD+EuF6AhQOWgCWq9cslqs8sg7W7koUqdnHhi5WkQxlE6gzSB2nM9Espw/QFFDqw==
X-Received: by 2002:a17:902:6a88:: with SMTP id
 n8mr10886312plk.261.1597654307322; 
 Mon, 17 Aug 2020 01:51:47 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:51:46 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 36/70] target/riscv: rvv-1.0: floating-point move instruction
Date: Mon, 17 Aug 2020 16:49:21 +0800
Message-Id: <20200817084955.28793-37-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1034.google.com
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

NaN-boxed the scalar floating-point register based on RVV 1.0's rules.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 92d34be5a99..7a12b89dc13 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2689,12 +2689,17 @@ GEN_OPFVF_TRANS(vfmerge_vfm,  opfvf_check)
 static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
 {
     if (require_rvv(s) &&
+        has_ext(s, RVF) &&
         vext_check_isa_ill(s) &&
         require_align(a->rd, 1 << s->lmul) &&
         (s->sew != 0)) {
+        TCGv_i64 t1 = tcg_temp_local_new_i64();
+        /* NaN-box f[rs1] */
+        do_nanbox(s, t1, cpu_fpr[a->rs1]);
+
         if (s->vl_eq_vlmax) {
             tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
-                                 MAXSZ(s), MAXSZ(s), cpu_fpr[a->rs1]);
+                                 MAXSZ(s), MAXSZ(s), t1);
             mark_vs_dirty(s);
         } else {
             TCGv_ptr dest;
@@ -2711,13 +2716,15 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
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


