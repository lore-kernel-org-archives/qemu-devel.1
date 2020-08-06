Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643A8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B2A1204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PpDMDk3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2A1204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dwX-0003em-GN
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSg-0003tQ-LQ
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:26 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:37187)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSc-00080h-Cu
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:25 -0400
Received: by mail-pl1-x632.google.com with SMTP id p1so27310073pls.4
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rAe65mQIx6pZoNM/rbKMGrIY0zLbjlJXMGbPmJEv2dg=;
 b=PpDMDk3cJ9ht/ukl1BFiD+aWvRNFw4c3gI0NaizdncvPXstc5dq6vUVok6o8gKnylH
 4Nl3I1o5fY4Ybvck7/+kQ7ad82kmWg/CGbKMwkIe6B5NlV924T5tybQfy/1wVhmnEq1G
 hHcHJWk+p+G+2blp+l9QnB1loJVuL+N9CGk0zSDqDXkOqG8R11R6ec1ke4uD6qh1eRIp
 HyFJxCR8YeJxMaJXvB11fwEZGF7H2YXDfs1kBIzoJ5I5pqCKYloW2mtVxZ8V9MM6DFDc
 bw9weKlddHF4PLRvzzg2PZM/B8t5R1Whr2+oBE4L4dUvc2rr/mLSmmIDlaRRKzF1YaYo
 wbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rAe65mQIx6pZoNM/rbKMGrIY0zLbjlJXMGbPmJEv2dg=;
 b=IK19i3OtvLeC0hDi0afmpSNUUgw+XuKIfOax9DGjAILDnry2EHT1t6EuilOiSUGeNh
 +M1+DP6CmS3Xpwpx3udYudPPPb4CEBfVXMn8pxDdFtt0Fi+9U9IwCy9oMFxX4+MRRVfu
 uxaJaWlPcXtQmkWvq4MzR+MEAl54QydA1DWBb+yGmjYJPA3WjEaPOTUZEzqRtcv7ToCD
 G7lozsUrZJUWBKu6smrTY5Y/KypH8LEqf7FW1xG1PPYfZGDnddQqq8vdEWgwaDTWV0HS
 gXsTYlUY2EHDIkT7rUox99B+u+Puazh+TVLe59S2oIHksqPxuCigiq5J9TyaoIIehuyr
 8SFg==
X-Gm-Message-State: AOAM533AGJjvMvQu3m6ANrEMqWM3pq+hlfX6pxM+dHsfiQBGZFMhgipf
 63MTLReuEPcokaqnih3berjFwbKV1hI=
X-Google-Smtp-Source: ABdhPJyyiOt4I0jkYGagOyc0gnQoZWh0jhPsi+c3ByPRuG989v1XGT997lLCLh80biVkVQ6W7DtrgA==
X-Received: by 2002:a17:90b:4d0f:: with SMTP id
 mw15mr7593385pjb.174.1596710960900; 
 Thu, 06 Aug 2020 03:49:20 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:49:20 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 49/71] target/riscv: rvv-1.0: single-width saturating add and
 subtract instructions
Date: Thu,  6 Aug 2020 18:46:46 +0800
Message-Id: <20200806104709.13235-50-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x632.google.com
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
index 263f2535d8c..c2eda17c0ce 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2329,7 +2329,7 @@ GEN_OPIVX_TRANS(vsaddu_vx,  opivx_check)
 GEN_OPIVX_TRANS(vsadd_vx,  opivx_check)
 GEN_OPIVX_TRANS(vssubu_vx,  opivx_check)
 GEN_OPIVX_TRANS(vssub_vx,  opivx_check)
-GEN_OPIVI_TRANS(vsaddu_vi, IMM_ZX, vsaddu_vx, opivx_check)
+GEN_OPIVI_TRANS(vsaddu_vi, IMM_SX, vsaddu_vx, opivx_check)
 GEN_OPIVI_TRANS(vsadd_vi, IMM_SX, vsadd_vx, opivx_check)
 
 /* Vector Single-Width Averaging Add and Subtract */
-- 
2.17.1


