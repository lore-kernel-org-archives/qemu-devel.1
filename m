Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB61C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF57220714
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nlR3bQta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF57220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRzym-0000sV-UH
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqD-0006iR-M4
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:25 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqB-0007H8-B9
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:25 -0400
Received: by mail-wr1-x442.google.com with SMTP id s9so7586880wro.8
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nB/5rC0VVxktBcVawvErd/qrg+KIJA8SmLqeHRRk/Lw=;
 b=nlR3bQtaTb75A/+lOyljTxIX/zlzaBrk5N4K5biR8DgXFQPBFuHCuJdcnoAtLSneTD
 BnQ/UzVz3K6WXDVxbQwbFcIou5Up985dUHnpwODSDJ577bFZOQHIv1H71KXjufL5G0CT
 YPjdTFil8NBC5lNZ0u28aSApEtCrZ5a+xSYoISzRAzESmc9JBTXH8eNKa2HzFONgTkvf
 PxYfAHgSyf/hscCblsGfQWn3NWV0Dug2uraZlwYZm9tFZoHvUFIE9blC5xryb0UUnS/p
 ijRTimX7XPVgkc71V9o0SlowpeROPT1D0wb5T3BVDaKKY2QrLroaCoyS7hd21J2N2Q5n
 2IhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nB/5rC0VVxktBcVawvErd/qrg+KIJA8SmLqeHRRk/Lw=;
 b=Lzn1ZtlUH34X5bRuKfgc2atlF35At0WOL/ZcAyq4KuvWHAOsAieOUXFya+ia0ujeaF
 cneBTS7OKiQ36kcXyr1CoqCQkEPGcoAYFyxFr3C5Rgxd9lECJNKIFNtsRGgM5i2AelhP
 EsQjR5fSlycby9p+x4UNvg34LIg7fovDFa/uLR5w/iJh7imz+/VlgYbCIiCS+47onMaS
 fwaXhUMAMvUi63rkra6Mp3AyxHdey8FJYrfcA+RbQn4spt3EI6140R7ZPZmdautsv01c
 sT7CdFbmAfc/d6DEu1rPBy51NaHsrV2OMbl+OM6BJmcqnJqfBs6gUaoAsFhgqBdBY2sc
 0Sbg==
X-Gm-Message-State: AOAM532329vtR1t/ysY2AT6HhE/v+vHb9aaOL1VOWqyNpAc3/Q2Zpkrl
 dR+KeARuxKoBJoEc+zrthrGQaw==
X-Google-Smtp-Source: ABdhPJzIL2PmGk4RUC6MO/+auZdoIoj7A8Va1G0BME2l0/ZdDnAqVNBZSFxk8pgYEkRF/xQ/FsH1fQ==
X-Received: by 2002:a5d:4d10:: with SMTP id z16mr11113890wrt.360.1602516861968; 
 Mon, 12 Oct 2020 08:34:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm19675284wrq.73.2020.10.12.08.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:34:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.1] hw/arm/armsse: Assert info->num_cpus is in-bounds in
 armsse_realize()
Date: Mon, 12 Oct 2020 16:33:33 +0100
Message-Id: <20201012153408.9747-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153408.9747-1-peter.maydell@linaro.org>
References: <20201012153408.9747-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In armsse_realize() we have a loop over [0, info->num_cpus), which
indexes into various fixed-size arrays in the ARMSSE struct.  This
confuses Coverity, which warns that we might overrun those arrays
(CID 1430326, 1430337, 1430371, 1430414, 1430430).  This can't
actually happen, because the info struct is always one of the entries
in the armsse_variants[] array and num_cpus is either 1 or 2; we also
already assert in armsse_init() that num_cpus is not too large.
However, adding an assert to armsse_realize() like the one in
armsse_init() should help Coverity figure out that these code paths
aren't possible.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/armsse.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 64fcab895f7..dcbff9bd8f4 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -452,6 +452,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    assert(info->num_cpus <= SSE_MAX_CPUS);
+
     /* max SRAM_ADDR_WIDTH: 24 - log2(SRAM_NUM_BANK) */
     assert(is_power_of_2(info->sram_banks));
     addr_width_max = 24 - ctz32(info->sram_banks);
-- 
2.20.1


