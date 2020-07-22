Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC4BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:40:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6769E20714
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AI680HGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6769E20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBF0-0002fA-Kp
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAv6-0002aV-SC
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:20:12 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:38097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAv4-0005fK-KJ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:20:12 -0400
Received: by mail-pl1-x62e.google.com with SMTP id m16so653116pls.5
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8wfCLaacJLGQ4JsbotMOzZuv/OFkbZxRksmqcJIZmw4=;
 b=AI680HGJOj6z31w0yZEFHunmEgcm8ub6PAL9CyBGUlWmPhdbEdNjhcd6L1oB4WhbUv
 /+TwNcSfTjWqr2w+EZPBBwBznhhSYQZ0VrM0IKS0atZFKSM9rhTSqB3E2MBabRT16Xb/
 vDOpuavbri1IUUaCdvyntI6ZgUTLoPhR0uZPQPBjB3xegB4NR2ZbdvagniMJkSLd5sem
 HzV1jn7xKeOQaNo6uKE8hTmkdNkiBIdxdZVwhOw0UDocVOKMS/M1ha1F1jEjJSrs3uXK
 QHD3QyvHv2ExDPDmrrDOLYtixApW3wiFN+aGU0r1ZEmWf1nvHRCW0jWtVF8wXFXwOusm
 u2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8wfCLaacJLGQ4JsbotMOzZuv/OFkbZxRksmqcJIZmw4=;
 b=AcrdjE3S/rkoxQa4/4OmufnK338PU9lQfe8w2+lDkOoZIKrsyxm+gP1lAHo6DGsuYp
 vM6dZrifbm2MEpHPZYns8sLXgc4eQ2NoPmYsivmLWYHmxXPfPIW3QcFzi1jVfFpfJwcM
 ZXyTL+S2ikGd0CbtRfg+lBR0rydTairmIlvG21OCK5uUzixFwJMpSZsbh+bBQhLH7zMP
 TLZofjeOagSNmGHbjAM2RJYRcEMMT+oLCiniq/cPMvjdIfzqtp1bgC3y4DOZl56t1I38
 ICIZOGk7eqjfLlSeSp4sWVtXMnlDndYyIJ9ntAF8Gn+ZuN83vpyYAuw7Oo7NKaf5ji70
 vB8w==
X-Gm-Message-State: AOAM532Hu9a+EK8yA722IW7N11H/nwxq+pcWBvJuPTs7HP+Riim+4xIx
 vX1Z2Yf4uaKh0BWhX4TjkuJxTm8dkBg=
X-Google-Smtp-Source: ABdhPJyj190soGg4BEefZ+R3j6eY2+yzLctvvbXOY+zsuw3MPxEpTuiCxbhrK1RBeyLJtrQ3RppfRA==
X-Received: by 2002:a17:90a:ce96:: with SMTP id
 g22mr9112663pju.9.1595409609172; 
 Wed, 22 Jul 2020 02:20:09 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:20:08 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 35/76] target/riscv: rvv-0.9: iota instruction
Date: Wed, 22 Jul 2020 17:15:58 +0800
Message-Id: <20200722091641.8834-36-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62e.google.com
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
 target/riscv/insn32.decode   | 2 +-
 target/riscv/vector_helper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 37b2582981..4560bc4379 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -578,7 +578,7 @@ vfirst_m        010000 . ..... 10001 010 ..... 1010111 @r2_vm
 vmsbf_m         010100 . ..... 00001 010 ..... 1010111 @r2_vm
 vmsif_m         010100 . ..... 00011 010 ..... 1010111 @r2_vm
 vmsof_m         010100 . ..... 00010 010 ..... 1010111 @r2_vm
-viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
+viota_m         010100 . ..... 10000 010 ..... 1010111 @r2_vm
 vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
 vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
 vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index aeaf3d1cfa..c1ed0ff6ad 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4774,7 +4774,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
     CLEAR_FN(vd, vta, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));     \
 }
 
-GEN_VEXT_VIOTA_M(viota_m_b, uint8_t, H1, clearb)
+GEN_VEXT_VIOTA_M(viota_m_b, uint8_t,  H1, clearb)
 GEN_VEXT_VIOTA_M(viota_m_h, uint16_t, H2, clearh)
 GEN_VEXT_VIOTA_M(viota_m_w, uint32_t, H4, clearl)
 GEN_VEXT_VIOTA_M(viota_m_d, uint64_t, H8, clearq)
-- 
2.17.1


