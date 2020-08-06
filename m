Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6B9C433E3
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:23:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB37204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CNiC7tUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB37204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dou-0004K1-Pp
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSQ-0003Li-V2
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:10 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:52006)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSO-0007xb-C4
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:10 -0400
Received: by mail-pj1-x1041.google.com with SMTP id c6so6462360pje.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ZKAl9PO46LZJ4bQ695RquDoityy5/63I6FwO7ZGsZPg=;
 b=CNiC7tUhaM/V0zMtPzx+IktUkze6UhqNcOUvsRtNt5hGeihyOgeDLitRbV9rEQoHB6
 Dcf1yGdA8Qs2wo080NnMwaAA0wEblb96epp/d2fpvxHOF38U+RsIeS5Oe+y7qSxYGk/T
 fe5uMU3CjEXStA7F/B8rW5PsGJc2vSHzA0N7jNSlk25+lvFzPjU8YdqoVTBFMhTsZEvI
 CJ5Fd0h1pzhAoPI5YIqMLLG+uqhOu5vJU+zn02+iUfZKdWTh4NR/VArPP9kgYLSrbtLo
 MXVHL3StDVSrxTeezXV7ItDs1ILHFR1dpRMIRnjRRUCMXKdnSx2J2igjNKE1pRg307eI
 hQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ZKAl9PO46LZJ4bQ695RquDoityy5/63I6FwO7ZGsZPg=;
 b=pIOW7eXr44v6lV2ya3adeLe7fMpNXw0zOLU81mXArQx/33tzCSxuJm6iOEkN0KPFPW
 earNhUx2rob5xDcH1/cLrS2jYuR1tQ/S0L1rm79Lop60jSZhi0Jpgj7HBp3ZrRNnzIr1
 2H222apqjLQeqCmfNp38WnIJWZhlwytlZiBZV2Sxu4NvoTKpVNnq6LQlnMNwpEk8bfEG
 dvkvBQS9z8ybu8Xr8MhHI6bqA59QA1KmwVJWJy3Ykf6hMiLqGUVtAburO1hi2SNuDOI5
 yowm0m0ih8i7WSAhKAO8DdRMHfFpTrTIQs/6EI7yfoIM/XF2LFUVZDjO3qES6d8OCZrL
 AjJQ==
X-Gm-Message-State: AOAM530U/9+N2XgrZlaOE1Mu3Dbk36PkgSFER8VeQ7ZOQJkmH0nwF7h4
 3OLS1NQIf2pCoi9LEPGG47vnQJigfCo=
X-Google-Smtp-Source: ABdhPJzAbcp43Tslb1kz4UqR5537XETXM+pf92APi5K+pNeta6hF5cSeN4R8AL6eutMQLF7iDVrkzA==
X-Received: by 2002:a17:90a:eac9:: with SMTP id
 ev9mr7543733pjb.106.1596710946882; 
 Thu, 06 Aug 2020 03:49:06 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:49:06 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 43/71] target/riscv: rvv-1.0: single-width bit shift
 instructions
Date: Thu,  6 Aug 2020 18:46:40 +0800
Message-Id: <20200806104709.13235-44-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Truncate vsll.vi, vsrl.vi, vsra.vi's immediate values to lg2(SEW) bits.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 68634298fa5..a22db5f2f13 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1901,9 +1901,9 @@ GEN_OPIVX_GVEC_SHIFT_TRANS(vsll_vx,  shls)
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


