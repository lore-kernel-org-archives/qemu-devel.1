Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FD4C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:07:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE4220748
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="j2UcR2vY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE4220748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtskN-000488-8m
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqea-0005l4-7n
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:53:16 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:33678)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqeY-0006po-6d
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:53:15 -0400
Received: by mail-pl1-x631.google.com with SMTP id 72so2113989ple.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FknZ1UMbodqKW1rGYXsaRm4nCR1UujTfta8rCOpQVsY=;
 b=j2UcR2vYeJwJJaQNK+0ZXH7q2QVYospdsewxsVril9bfdlW8uJFw7sKZDXGdFjxFS+
 2C05wWqmErF4UgnNJoqZmRkxAP+sGOfEKX1FTTGOFjmuVEUUFmt8ODDOiW9fu6xqvaaZ
 XlxxZkg8uzm1wVANo+jXAIVQTs+1y+UvhegRBdlUlKgLrffv8e361Bk4ytfZTeXJqmcg
 SVlvYa/UNe2u57Bg/RmcHV6Bs6I0At5HncwNb6vFY2bmb/WOrPdhZgZCcuEUUfJqVRxs
 5aDiKNjoY6zfEf1LOLbTgH/qXlR7JlU+ZxIuprM2KhxZ6KAN4NaRGabgQkkJbF5F8eKs
 Of0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FknZ1UMbodqKW1rGYXsaRm4nCR1UujTfta8rCOpQVsY=;
 b=d26ui2WwkCopi/vkr1/EEi5g8XOU8khN9BG6IxqrIIfgJix1CYg+zPFq1K7NtN/kVB
 5vd1bC/D6YkiNzT0pTp7c4bdMcI4UoZfK4sU/CTbSrzbHLxlvkaa9vvPmlIStg01Fsnw
 Y3ubj0GDrvg7DelwY54DRk79kSyJwjoS42BU7rZyd+tLGDDzhf42qMLo1q5BFnHb9uqT
 Ih7PUH1gOgAARA+OaNb/4EUXrlh9HDmCU7O7umBmbI+tP9sAaKeAnqntIzwWNHoqJ7nV
 C7CjMdUsPR3w00+NQarhEGssM182ZV9s5nWzSC17wjj0UWNB+SmyNMNvKsVr0IVV20kY
 4HbA==
X-Gm-Message-State: AOAM531FF88+SetxmavFahkqtfo3DDCVQizTeJUX57j5/X72nlKH7rik
 HnplacqxqEkihbq/NwmlBuCv7+twoA1sTA==
X-Google-Smtp-Source: ABdhPJw8KC/MoLUpDAbNtLcXzoiVMoj8uUR74T//2nz+zvvKig/pBQSxWpRS6SDsyp2gMcjuRGASeQ==
X-Received: by 2002:a17:90a:6048:: with SMTP id
 h8mr4979505pjm.230.1594378391394; 
 Fri, 10 Jul 2020 03:53:11 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:53:11 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 39/65] target/riscv: rvv-0.9: single-width saturating add and
 subtract instructions
Date: Fri, 10 Jul 2020 18:48:53 +0800
Message-Id: <20200710104920.13550-40-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x631.google.com
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
X-Mailman-Approved-At: Fri, 10 Jul 2020 08:57:18 -0400
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

Sign-extend vsaddu.vi immediate value.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 2 +-
 target/riscv/vector_helper.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 53c8dce159..152da0bd30 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2141,7 +2141,7 @@ GEN_OPIVX_TRANS(vsaddu_vx,  opivx_check)
 GEN_OPIVX_TRANS(vsadd_vx,  opivx_check)
 GEN_OPIVX_TRANS(vssubu_vx,  opivx_check)
 GEN_OPIVX_TRANS(vssub_vx,  opivx_check)
-GEN_OPIVI_TRANS(vsaddu_vi, 1, vsaddu_vx, opivx_check)
+GEN_OPIVI_TRANS(vsaddu_vi, 0, vsaddu_vx, opivx_check)
 GEN_OPIVI_TRANS(vsadd_vi, 0, vsadd_vx, opivx_check)
 
 /* Vector Single-Width Averaging Add and Subtract */
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 47ba264f1f..17a98bebe1 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2324,7 +2324,7 @@ vext_vv_rm_2(void *vd, void *v0, void *vs1, void *vs2,
         break;
     }
 
-    clearfn(vd, vta, vl, vl * dsz,  vlmax * dsz);
+    clearfn(vd, vta, vl, vl * dsz, vlmax * dsz);
 }
 
 /* generate helpers for fixed point instructions with OPIVV format */
-- 
2.17.1


