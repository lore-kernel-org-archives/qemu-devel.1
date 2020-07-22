Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469F9C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:31:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11CAA206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QMqHoray"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CAA206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyB5e-0007DM-BF
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAvQ-00038S-Ay
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:20:32 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:54176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAvO-0005oL-9g
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:20:32 -0400
Received: by mail-pj1-x1044.google.com with SMTP id a9so866829pjd.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RsjYqEd04rZOwTgEVDJRj2EjmbnjKZAUxlfDmSey2n4=;
 b=QMqHoraymo6ZHu3en9HR9qnl7q2fRz62DP7dLa+JFXPOwP/34xN9hdEVaEJ+XQPKH3
 iiUAnMaZLam1BhEYlWRC88C2ouxKbhW36tC1DmLyjU18agmLuF2Szyole/yvK+eykDCe
 nR7TBcatauOBPCOMmSIh08gNkXg6EJEi+YeJOSzOHsVrZAnc5oagnlZmuo9DiaTGpQBW
 +h3tXd8LF4XozNQur8grG9iYEeccQS8DvE2k9utbMWWCYJyhHTMgqoMipLwS47sJaBES
 +9amxzx9GhoqE7OU2UeYBDisS879BCMXina7IqV2je/2brCvcOkcDa05HUO6JuSMl585
 TpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RsjYqEd04rZOwTgEVDJRj2EjmbnjKZAUxlfDmSey2n4=;
 b=nWJ1WCpez3R+T9PH2gzUz/LJ+ipK6anyoR1xcT+lk9zHRgjirPKLnZ/ViAgHULqS/d
 fOCzCYq+/OjLsJZ4vq4PB3J2CiS1ZeD9sPZHQT7vOe61XfY/MN47bbj2MFnwUXWo5c0G
 PtRT0raWwI6NmqywyKIXT60b5++vioHDhzME3vITmeh1+WxD8ool03PCkmgE0j37j81m
 kWtj3DV3N09v/kzNvLFceaosH/60vFUTJgZbwdlIp3JdzJY6Z0Vwg0tWuRxiXQyBmw31
 V7HGqIJTT7rkvqZ/JgOMELh1eDygB/o4/g5gBiFYmX+AvLceaqgesSCHu5rYR9xxyswP
 v3Qw==
X-Gm-Message-State: AOAM532govsEqD9oDkcOqGRESQEJxZcmHCVnN8086NSkeEKE6gkyxaVU
 TgxTuLAXDBgBCIR+DLWC89EydP//n5Y=
X-Google-Smtp-Source: ABdhPJywhaIt7+yrWBwlfZyqEcv6IC9+qMUk6Jj/gZi5Uasgn7SIfSpzT03acDxT8QRD8vom7lQFww==
X-Received: by 2002:a17:902:b205:: with SMTP id
 t5mr26305231plr.7.1595409628847; 
 Wed, 22 Jul 2020 02:20:28 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:20:28 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 40/76] target/riscv: rvv-0.9: floating-point move instruction
Date: Wed, 22 Jul 2020 17:16:03 +0800
Message-Id: <20200722091641.8834-41-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1044.google.com
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

NaN-boxed the scalar floating-point register based on RVV 0.9's rules.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 780f8660bf..54c08ea1f8 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2722,6 +2722,7 @@ GEN_OPFVF_TRANS(vfmerge_vfm,  opfvf_check)
 static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
 {
     if (require_rvv(s) &&
+        has_ext(s, RVF) &&
         vext_check_isa_ill(s) &&
         require_align(a->rd, s->flmul) &&
         (s->sew != 0)) {
@@ -2744,7 +2745,20 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
             dest = tcg_temp_new_ptr();
             desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
             tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, a->rd));
-            fns[s->sew - 1](dest, cpu_fpr[a->rs1], cpu_env, desc);
+
+            if ((s->sew < MO_64 && has_ext(s, RVD)) ||
+                (s->sew < MO_32)) {
+                /* SEW < FLEN */
+                TCGv_i64 t1 = tcg_temp_new_i64();
+                TCGv_i32 sew = tcg_const_i32(1 << (s->sew + 3));
+                gen_helper_narrower_nanbox_fpr(t1, cpu_fpr[a->rs1],
+                                               sew, cpu_env);
+                fns[s->sew - 1](dest, t1, cpu_env, desc);
+                tcg_temp_free_i64(t1);
+                tcg_temp_free_i32(sew);
+            } else {
+                fns[s->sew - 1](dest, cpu_fpr[a->rs1], cpu_env, desc);
+            }
 
             tcg_temp_free_ptr(dest);
             tcg_temp_free_i32(desc);
-- 
2.17.1


