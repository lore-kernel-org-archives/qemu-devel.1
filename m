Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1401FC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D878D20720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZY9uldhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D878D20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsbW-0003du-1b
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 08:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqbv-0004kq-HN
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:50:31 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:42307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqbt-0006EK-3N
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:50:31 -0400
Received: by mail-pf1-x433.google.com with SMTP id 1so2374836pfn.9
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dY1VnCufQZpa+aF68DC4K7OikxwvWj2GSrpOqri/zyA=;
 b=ZY9uldhl3XCVsiWK2GRXkZh5RfFmPh6KGV9OSMRbSVpk9NNnpIYmjImeKM1/xkw7W0
 fDvXKgrFg4TMXvNQXZSjdLZStDsMOISYAuIpWkrVkxYCY4wAcxopuBlaS3BTP2tlyqLU
 /EcUjFVLYtN1Y1peKwJXd0WiBrSLkcfYL7hIknrKCtk7x4+J5uowplOjEPjerkHzplMu
 wqXPTWJHHC/H3lzk8VgoOrgHfFDMfS0RjmdFcgK0gNjmhijKX3JStmBWqwL5KexpHdtB
 uMNiLgh9K5FqTTAzKRIwM+DK2eM9+4vMZ5NF2GAOAEzpPLLHZ/spTsbANhnSg0Vu3Ghm
 39Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dY1VnCufQZpa+aF68DC4K7OikxwvWj2GSrpOqri/zyA=;
 b=ujeNr5oTZ2V/O4OXIRja5x43we1bzWFXLBe+7XfczmLkb9MdanLPJC4UzIMv7937ta
 bKMPtguZLOuotktBv6gOIAdDlbF7G9AZSLlA57MJDrvratQbtnkWN51c7d+wqTg0r9Zz
 ngDmwvxn/kyx1/ovtDeHRSQ07Je7V7/26d8gU9K66joPRVjMY+zPe3YMN7rL55yQshCC
 DQcTSc7lZE3cAsHka1M3Fd2lEiiIWXuEz6sQxA8J5+qVCcL9ILPovpy87cXTwZakQPNS
 Ql3xLDKjRnA3lPPzNAb5+H09TANZas5L65OrzMCTUE3jONWVkomcJwYQJpqHrQI9vzCn
 GcAQ==
X-Gm-Message-State: AOAM531MWfAlHPWJ1hXAQqOp3FuPbOozgLeF7DGxNNkogyrpboAPuNVy
 1oYcI+AMRxLghPwgg8Eyolxf3k3ccLBekg==
X-Google-Smtp-Source: ABdhPJxy8e+X38Cnw0Gzb9HAP1qeyzPcOIpSgG90Z2J1eL2fzHkCQrqPMN8kbArg0IupXeaXgzmj0A==
X-Received: by 2002:a65:4502:: with SMTP id n2mr46494850pgq.132.1594378227180; 
 Fri, 10 Jul 2020 03:50:27 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:50:26 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 02/65] target/riscv: correct the gvec IR called in
 gen_vec_rsub16_i64()
Date: Fri, 10 Jul 2020 18:48:16 +0800
Message-Id: <20200710104920.13550-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x433.google.com
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
X-Mailman-Approved-At: Fri, 10 Jul 2020 08:57:17 -0400
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

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 433cdacbe1..7cd08f0868 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -937,7 +937,7 @@ static void gen_vec_rsub8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 
 static void gen_vec_rsub16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
-    tcg_gen_vec_sub8_i64(d, b, a);
+    tcg_gen_vec_sub16_i64(d, b, a);
 }
 
 static void gen_rsub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-- 
2.17.1


