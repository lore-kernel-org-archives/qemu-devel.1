Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066D3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5AF620759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q/TnoCI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5AF620759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbogG-0003x4-UW
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJ1-0004I5-7K
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:29 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:33295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIz-0006fx-FF
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:26 -0400
Received: by mail-qk1-x744.google.com with SMTP id z80so7920154qka.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1YbnvmhNqAhmF66BGNb4cMj4pII5ByUEQJWinpDd9pc=;
 b=q/TnoCI4H+ymq812X+QylsSs+yotoXQHuK5XQ86dskxT4XUhLhFLdQVMcnjRfoFsg8
 oKZVAJCxcTmyu/d3++GU+ySi7Jt0Pab4RI3MMXd4zpB0/07baKfTt1MYNNXY8+7SdcYF
 X5FxOt+FgsttBlc72MuzGEpTC5XAhRC28vE92qUF6Yrx8Tz/a/wpaso16TwqNZxPtIcN
 HM1gLuVYeiMfGtxF75GFjk8dpFweDqBie8HTni8Iz/+U2x70fS7SwbEX/ZHUUcAvvLXY
 ojgltGTB8F0gcASjoYFNTiU4+3S8cS2Tg6fxdQCmJMsPbCKoSFKNDy+Wln+3WkNm045I
 RTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1YbnvmhNqAhmF66BGNb4cMj4pII5ByUEQJWinpDd9pc=;
 b=FKW/umluEyKL4BevTPOf6dZQ4V1NmNm6CbVHEFoJ8nRaeIVzEEWWwS9dJd3O6S3hoy
 adFW70fvv8YHd/059a9wIaTW7eceKkotH1dK2+CqVv5D6ymrhUuxH1KPNDbmYkD5uv4v
 FbtvSRtmG+k53eYmgwKhfxBRtd5vzMlYukNBNABkOWhuhjjOJVuNAxcQqTrHv0gXaWL9
 XCjq0iC/ASTP6JKwSozKsqYOpq2OCk3EcgeTM4Fgir5jcB5opEtR0HXF6ufLan/r3DCF
 DscWYs+TzVC7hrOa3PAqMSCJVP1alAgbKmTS4PbpGtv0yCNOM/kKo/ZrSkTT7NP4YX2A
 rzxg==
X-Gm-Message-State: AOAM531OONGRHHt9qNimBm2gB5SgyWb1Ywmd/8KppFj6cgwTOUrxRSsF
 jH4VDnTMTFn3wdX4GVDrp4fLRA90OvBVlg==
X-Google-Smtp-Source: ABdhPJwfYjwdxv/a49GNC97mzxqnoK92+WnjvQMHgER9RdhbwMDUYzqbEoJSW7wubEu6A+nU+t+RbQ==
X-Received: by 2002:a37:4cd:: with SMTP id 196mr10736716qke.455.1590079464352; 
 Thu, 21 May 2020 09:44:24 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:23 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 52/74] nios: convert to cpu_interrupt_request
Date: Thu, 21 May 2020 12:39:49 -0400
Message-Id: <20200521164011.638-53-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x744.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Marek Vasut <marex@denx.de>, robert.foley@linaro.org,
 Chris Wulff <crwulff@gmail.com>, richard.henderson@linaro.org, cota@braap.org,
 peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Chris Wulff <crwulff@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/nios2/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 8f7011fcb9..fe5fd9adfd 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -36,7 +36,7 @@ static void nios2_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool nios2_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
+    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 
 static void nios2_cpu_reset(DeviceState *dev)
-- 
2.17.1


