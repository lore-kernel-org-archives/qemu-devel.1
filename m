Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35534C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032F42067C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iecMGP07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032F42067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7arC-00073S-7p
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 04:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7aqK-0005JS-8E
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:50:12 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:54280)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7aqI-0004h6-LN
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:50:11 -0400
Received: by mail-pj1-x1042.google.com with SMTP id mt12so7481978pjb.4
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=drhHEFRj8g8xHCSfNMMcorRHdIOXXyDjguE7cUlbARg=;
 b=iecMGP07zaiJXyWaAklHyylpOdh/NAWnQ9Voskn9E9pRHJ6bBuCvHq+bv66sNPtUbs
 bcpG3PEmBVGw/hrF+bQH1BkqWHk0QCOczLxdkyjygpqit8hss3Qqv7AfLpM2ZXyMUubS
 pso8cTkdEMOViNQQs9s7KUeA62LQyWc7WDLR57FXH+RTyfrHhUTp4Q0YgS7pnB4nXCSX
 BnWtrFS21n4zycMeXUh35RuxIQQevFBBMCwVoqXTaZoix36GxI2E+/Ra/1oSt7walysn
 u48eEJZaPPp/3DlvpqUcjZMb8Rc+5G0JqxDk6ME83FUzfHiS1AzqcjsutStoGNGZvrVC
 8uIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=drhHEFRj8g8xHCSfNMMcorRHdIOXXyDjguE7cUlbARg=;
 b=A297YsJNgKM/cvWy6KMKLlES+iIid1EsjJo2gNtchqcSFMyKOyJS0Ze06KSnib/cFE
 zs+mBcEXKPxQMN2bAbMnDyd0jfGPesF/WEKb9mELUPvhHhoMXAdcorB5PRvyESb2FmzU
 z5pzaerQW7GTVysgM3vWxDlU4worBBG+cHBh1Kg7hze5QJfRWeaVww8nauWj7494rsmv
 84u4KjbtuwTt7PvqjSkV9EPYihiAqF9smlCFWLC8aFYsz0jYtRuB30Wp8wI9hZAOgJHB
 g3aN0fuFRdHr/lu04qLjQRXWj4TPmnylXMjOMN10VRtFAWzl7wcZTa7mDE+FZysEPW74
 r3Bg==
X-Gm-Message-State: AOAM532PVM8BlJo2xiLTE3DDcVoBvJnmaLapHirNqHLtw0lzGvUwahhJ
 lnnU3es3NIUwz6OaRzU5Ww5ZwPITA2pROA==
X-Google-Smtp-Source: ABdhPJxljN4QMQU6VVGiBc2pDbxQxnaDLGOzChs5AUvWnMfAGFX08NISh2Cl0128bOvqOZd8Fsuflg==
X-Received: by 2002:a17:902:10f:: with SMTP id
 15mr10734656plb.232.1597654209214; 
 Mon, 17 Aug 2020 01:50:09 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:50:08 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 02/70] target/riscv: Use FIELD_EX32() to extract wd field
Date: Mon, 17 Aug 2020 16:48:47 +0800
Message-Id: <20200817084955.28793-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1042.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/vector_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 793af990673..43ba272c09b 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -98,7 +98,7 @@ static inline uint32_t vext_lmul(uint32_t desc)
 
 static uint32_t vext_wd(uint32_t desc)
 {
-    return (simd_data(desc) >> 11) & 0x1;
+    return FIELD_EX32(simd_data(desc), VDATA, WD);
 }
 
 /*
-- 
2.17.1


