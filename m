Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84860C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 513562063A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lHj1amz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513562063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bBM-000717-H1
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7asN-0001rJ-O7
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:19 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:53205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7asM-0005Dr-6j
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:19 -0400
Received: by mail-pj1-x1033.google.com with SMTP id kr4so7487750pjb.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=G8xY9EjYzT0XnuzWLh9hgfRhkrBj0VFGlmYhXAzpEgw=;
 b=lHj1amz4ok9zTImu+WblNSxcqc/q+D5YpCE2cxZ2VBb+JDOKHrMrILUX/Dy/JSKRCl
 ZcBxYgocQsABUZg56JWjPtMSuT3ai6nRWx9nSPtayzycG40ze6F9dIvKYeSc5AJ4voKR
 nCv9vRANQhLcU47EBHyQw85aBqzmT3bIhgRrXmvxZXK1Hk7tHN1AnJxuqlBTYi0OdkLz
 GG7ein4AGp2+LlUpJQyyKp16KmcCuhW/HgUQLmbtnmEOeyc+iRqgobq3kCYuOrpVDMO1
 SJRYVvoVszhuaNwC/KSTeh6lX9pg2mRjJyX+Kw1hiRvBuLT9sOoI9iyT9LRCewFcWZWB
 Efcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=G8xY9EjYzT0XnuzWLh9hgfRhkrBj0VFGlmYhXAzpEgw=;
 b=FRsYzgjq53tDLiqPczuLKqXUvwWzH99lkDcvOzqRvPIFa75eV7bN2s5Hyg7C2Cslaw
 1lQCKdPopM9R/YLmhnsSH05wYmN8dw7IMUEPDncj1vftJmrtyrBQVK0R6Lup8283wIBC
 Tw9vQC15kw20hy4FituJuJdbMm7paaTsNTo+0h3dWyNXGBFjwoBjlYzCH0Tp0991tW5X
 j8Wx5pc3X6NIX/0Lux1dPVV6kvk59+nbKByW0C2l4+CNwBTX0W8MixeGBo1GUsd07t0n
 JYiyj6sOvjAYplXBfep5STQH/Ccbt0+3K65NeAQIw8nnBjNIUdYJF447Zp9f2Ajkze5E
 agEQ==
X-Gm-Message-State: AOAM532YXOUFvlH7HJir0Z1IN2f6Ooo6IUG6OcvamUz02UzIUJ1WULg0
 Bg93QvbOxIwNGkAfl+uaq4CqcuSFGYwEkg==
X-Google-Smtp-Source: ABdhPJxFcHqznGu54/4/lAuGGEXeV8phSSmDJXGNLoWOWUnWVrPJvVHb/x0+2ygRDMKOtEG2Pmin1w==
X-Received: by 2002:a17:902:6ac3:: with SMTP id
 i3mr9406278plt.21.1597654336828; 
 Mon, 17 Aug 2020 01:52:16 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:52:16 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 47/70] target/riscv: rvv-1.0: single-width saturating add and
 subtract instructions
Date: Mon, 17 Aug 2020 16:49:32 +0800
Message-Id: <20200817084955.28793-48-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1033.google.com
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

Sign-extend vsaddu.vi immediate value.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 809280f4c5c..ef100254830 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2341,7 +2341,7 @@ GEN_OPIVX_TRANS(vsaddu_vx,  opivx_check)
 GEN_OPIVX_TRANS(vsadd_vx,  opivx_check)
 GEN_OPIVX_TRANS(vssubu_vx,  opivx_check)
 GEN_OPIVX_TRANS(vssub_vx,  opivx_check)
-GEN_OPIVI_TRANS(vsaddu_vi, IMM_ZX, vsaddu_vx, opivx_check)
+GEN_OPIVI_TRANS(vsaddu_vi, IMM_SX, vsaddu_vx, opivx_check)
 GEN_OPIVI_TRANS(vsadd_vi, IMM_SX, vsadd_vx, opivx_check)
 
 /* Vector Single-Width Averaging Add and Subtract */
-- 
2.17.1


