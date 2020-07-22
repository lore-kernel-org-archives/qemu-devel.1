Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AE9C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A7AE206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KOZSJweb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7AE206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyB3U-000320-Ol
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAtx-0000Gg-CM
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:19:01 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46534)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAtu-0005W2-Ip
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:19:01 -0400
Received: by mail-pg1-x542.google.com with SMTP id s189so857282pgc.13
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6l7ajT+KNolo0CGKboLF/OzzmhcDECUMbbw6mVvJ14o=;
 b=KOZSJwebz0Y7RyEt60irDwlHYeE/gcbbE7SXN5eHqWuXCJSNftu/iNDsi736pLa5f4
 tA9ui0lpHBgYTt0GayuT8uCGaSHhhTPLxMmVC71dJx5Y7DylYc5AR1SHLryYbxXd4gVY
 aSELJivstDPO65LBIg79Un4YuL465Cv0lNSsbzKpjVfae1wCFAuUnEbKWHgC0eZj8kl+
 yb/203ksDEwuXgbGIY0KJBwUSeMQdbyITB8TFu+Y0oomau3CcFtymifFzzoNHOzphkP6
 PzWhmGiATCjnFSwmVQg4dya0dRwnVotJvp4VAP50Wfyqj3Jzd4oNzclO8GbhhDP55AXi
 5gZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6l7ajT+KNolo0CGKboLF/OzzmhcDECUMbbw6mVvJ14o=;
 b=bJqyy8xc09MsTZ2fm0D8wcu7CeKrRmwe7JaC9ViNBxJRWQAXJFzOBzUepkdLzyeFYB
 rhXcbKlNTx+LsfhL2SO/9VG/7l7znO8lAFMzhQVFQO0zawqMwmLVIu0PtHxYwDewtVQn
 FdI73aCXk9ST6fYTZsUVGOVJEoZjS7nU6z4Jc1dbwLc+625x4gAcUklJl5CArDx9VdqC
 FB8OTytHeTuWmbsIjkqKALEpioRJRp40IFdWn2a6071tltCLIZGKL9cQKkjzi4baw0q2
 kmktI6NAk7Vwu18PsyxU7ZC6VkiDVVLbWuvWSSTOxyHs6myGraY8vATTvtpkUiBXaX9R
 c3Vg==
X-Gm-Message-State: AOAM533IBfD7/EE9RJv6InUrUKFD95TUeUtj6w9KJQqrK7qoz8isKdt1
 BY54kevQD/5GKeOHHR9Zrne59bX52tQ=
X-Google-Smtp-Source: ABdhPJyOhIcggfbs5DsF5MgqfWnXsbLbJibleSVTqSJRw3v+NVRiIQFp5l6QX4Sg7QOR+48mHaObQg==
X-Received: by 2002:a62:1782:: with SMTP id 124mr26899231pfx.204.1595409537051; 
 Wed, 22 Jul 2020 02:18:57 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:18:56 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 20/76] target/riscv: rvv-0.9: apply narrower nanbox helper in
 opfvf_trans
Date: Wed, 22 Jul 2020 17:15:43 +0800
Message-Id: <20200722091641.8834-21-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x542.google.com
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

If SEW < FLEN, call narrower_nanbox_fpr helper to generate the
correspond NaN-boxed value.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 22b4e11a20..85738ba4f7 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2196,7 +2196,18 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     tcg_gen_addi_ptr(src2, cpu_env, vreg_ofs(s, vs2));
     tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
 
-    fn(dest, mask, cpu_fpr[rs1], src2, cpu_env, desc);
+    if ((s->sew < MO_64 && has_ext(s, RVD)) ||
+        (s->sew < MO_32)) {
+        /* SEW < FLEN */
+        TCGv_i64 t1 = tcg_temp_new_i64();
+        TCGv_i32 sew = tcg_const_i32(1 << (s->sew + 3));
+        gen_helper_narrower_nanbox_fpr(t1, cpu_fpr[rs1], sew, cpu_env);
+        fn(dest, mask, t1, src2, cpu_env, desc);
+        tcg_temp_free_i64(t1);
+        tcg_temp_free_i32(sew);
+    } else {
+        fn(dest, mask, cpu_fpr[rs1], src2, cpu_env, desc);
+    }
 
     tcg_temp_free_ptr(dest);
     tcg_temp_free_ptr(mask);
-- 
2.17.1


