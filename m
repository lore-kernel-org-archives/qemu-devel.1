Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19313C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:45:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D58592068F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hy4+5qHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58592068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBJZ-0004gX-2E
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAvk-0003vJ-At
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:20:52 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:34092)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAvi-0005rj-PJ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:20:52 -0400
Received: by mail-pl1-x630.google.com with SMTP id o1so663768plk.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WjHpOZhQo9fn4TvBmPBi/s1E299zigQx0QS5Nn+Jx2A=;
 b=hy4+5qHmG3bscVR9ymz9XSSLmdj3T8+hCXu0ILL+hfLWVIgUF+f9xdy0CPgaaj3OQT
 AkB1zyFu56xkSjMWlTOf4W1Cj7vmYnuKvZqYdQw8W1tKDmuoFJUHpM34rWCAOmIrV6Ps
 hnbjDKqyG5qSP6KJhWzpBr6569SPTIJ5j0MCjV+VeYQijiuWTUMMvI/53XInk3xw5eL+
 huhfigAz2JmizvNNY+owM1uhgcGLPxBDexL0x9q0q6s3tF89pzduZ9DbGrbvtavWtDWl
 uu7A3DgHLBRNeV25cZum01legBzINTX3vewyhSYQpis+2onH8dumDxW7lVDjxu5xvZs6
 HHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WjHpOZhQo9fn4TvBmPBi/s1E299zigQx0QS5Nn+Jx2A=;
 b=nsoCBL7S/nGFf6v1jqOzgLBgbJp4MDPpJVJEcPFUcI0Kif4vaNOP5YOSOvd76PXXrg
 NjTDLhAq3KHQra/Pjjnp7f1ZeezfO45Pnbe1DnSUkgf7IiAYUCD2mtYse4gWzTMFVPp1
 l9KgSjwxsKZ+oQDW5CyOEAw6DD8/4Bl9YJRkssW0USYZfq+yTD2ZOT7tSazflwHxV0J1
 klgr6Thmf8tBC7O34X5AnqNTtpxTdfm+Dx+gi7GdEhw6r3MUEUCi2avMzEhUrpcwDrOO
 RoSUg1W5/COttosqw2hodTuzo668yFfndDhaSyl4bMwH0KFkKhGgzkPgo8Et0CFzjNzj
 KG1Q==
X-Gm-Message-State: AOAM530NAUPvh8DigJk0UNx9UnjTm+yP0MorzdRezOo6epTIpUvGS7qu
 lDofTj382ACq/avfEQ8cBAAiNXOeGmE=
X-Google-Smtp-Source: ABdhPJzYx14Qs0LXm56kMmpSffBhJiqk1Zz6h5sgIhnC3Mu3NNONuWcS0CKa0G7YNZtszq8iyj3YIA==
X-Received: by 2002:a17:902:b682:: with SMTP id
 c2mr24830046pls.273.1595409649347; 
 Wed, 22 Jul 2020 02:20:49 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:20:49 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 45/76] target/riscv: rvv-0.9: single-width bit shift
 instructions
Date: Wed, 22 Jul 2020 17:16:08 +0800
Message-Id: <20200722091641.8834-46-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x630.google.com
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

Truncate vsll.vi, vsrl.vi, vsra.vi's immediate values to lg2(SEW) bits.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index d531c4edd1..3998011ef7 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1947,9 +1947,9 @@ GEN_OPIVX_GVEC_SHIFT_TRANS(vsll_vx,  shls)
 GEN_OPIVX_GVEC_SHIFT_TRANS(vsrl_vx,  shrs)
 GEN_OPIVX_GVEC_SHIFT_TRANS(vsra_vx,  sars)
 
-GEN_OPIVI_GVEC_TRANS(vsll_vi, IMM_ZX, vsll_vx, shli)
-GEN_OPIVI_GVEC_TRANS(vsrl_vi, IMM_ZX, vsrl_vx, shri)
-GEN_OPIVI_GVEC_TRANS(vsra_vi, IMM_ZX, vsra_vx, sari)
+GEN_OPIVI_GVEC_TRANS(vsll_vi, IMM_TRUNC_SEW, vsll_vx, shli)
+GEN_OPIVI_GVEC_TRANS(vsrl_vi, IMM_TRUNC_SEW, vsrl_vx, shri)
+GEN_OPIVI_GVEC_TRANS(vsra_vi, IMM_TRUNC_SEW, vsra_vx, sari)
 
 /* Vector Narrowing Integer Right Shift Instructions */
 static bool opivv_narrow_check(DisasContext *s, arg_rmrr *a)
-- 
2.17.1


