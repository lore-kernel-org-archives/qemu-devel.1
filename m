Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5525C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75A932063A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iBjL2Lcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A932063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bDu-0004SB-Mg
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7asn-0002QB-Mn
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:45 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:42243)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7asl-0005HC-Gu
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:45 -0400
Received: by mail-pg1-x52a.google.com with SMTP id j21so7786702pgi.9
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=OaP9J0DWVywZWPLwll9kCChmSU8Z+ILd6UJs5gTEiPI=;
 b=iBjL2LcpPiboLjkJm1fF4Aa1/MumVKpEjp+YmcgSgy0XRK63qBOguKf20LG+P/gO/U
 fTZoecfVKunDj0JneuTmfCZGzs6ODvhlY0wlaSb+uXivGncXEDYuAAg1y2pi3o2AyBhf
 Gc2cI9jte7LmmK+Agta/myNoPBaZGgD3ADEpKR6EBB5dASD9yiHEzJK6yIeq7qSXj7f0
 hHVsCf42IWD5uYeeTL6knY8nWrqY39i0H8Z4jW/c1Keg59rZ2md77RVMl8aoDIRcDpa+
 7mFs7OsgTia37DgJjQOSzkpy9m2RV+nhP/OycF8PSZfSeIGJ07OjXqQI4H4OpzGDv6Uq
 O93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=OaP9J0DWVywZWPLwll9kCChmSU8Z+ILd6UJs5gTEiPI=;
 b=EhsdkxWNZLlWxt1UVceltMHxtL8N+7UFEXU5KA6eomKJ4TrS2IIJ6QlVUpOfzfVWu2
 xW/rEkIgBcHJB9tavQhI9DFaSRHduOWjXgizvpWE/U8rLw9kUrN5Cz9fqMvkzLTFFdUH
 6z9UIOl/ZtAM3m6hLeVLrG1G5p5QP9rPDQWpQCRHykmewWPeCl779mB6104j3zHHqty6
 D88l+nlSuIJITsQPWI+gcQ2P0MN8+Ji8W58v6fcLne+LK0j3Nlzoeu56XNVO7GGse4H6
 uMKuZ0iP6U3bcqpUoEtm7JpV7kNB/K9/hrKhf6kQC3+CSh03THoPFUnc/ZOYr9hfYxqi
 sH0w==
X-Gm-Message-State: AOAM532a5gEAsxsjcMal1vXM1LlUdtn4m+hxCDoxbBuYBn8UmZQ3Yo2V
 K0RCKDEpTGmBsyI+eb5L+8s2bA401zF0Ig==
X-Google-Smtp-Source: ABdhPJxXTQZqIpFlD5DJYCQOlo/UQs9rp1MVeS6hlS3S4ov/CJTJvI3mtnuRYNKYi+JKU6LzU/4kug==
X-Received: by 2002:a63:30c6:: with SMTP id w189mr9042929pgw.241.1597654361417; 
 Mon, 17 Aug 2020 01:52:41 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:52:41 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 56/70] target/riscv: rvv-1.0: widening floating-point
 reduction instructions
Date: Mon, 17 Aug 2020 16:49:41 +0800
Message-Id: <20200817084955.28793-57-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x52a.google.com
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
 target/riscv/insn_trans/trans_rvv.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 41a60cf2fb9..2ebe2373237 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2977,7 +2977,7 @@ GEN_OPFVV_TRANS(vfredmax_vs, reduction_check)
 GEN_OPFVV_TRANS(vfredmin_vs, reduction_check)
 
 /* Vector Widening Floating-Point Reduction Instructions */
-GEN_OPFVV_WIDEN_TRANS(vfwredsum_vs, reduction_check)
+GEN_OPFVV_WIDEN_TRANS(vfwredsum_vs, reduction_widen_check)
 
 /*
  *** Vector Mask Operations
-- 
2.17.1


