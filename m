Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0328C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8616820738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jztX9O/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8616820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzbA-0005lq-QK
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juza7-0004nJ-H6
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:37:24 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juza4-00023Y-Ps
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:37:23 -0400
Received: by mail-wm1-x344.google.com with SMTP id 22so13556398wmg.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nB/5rC0VVxktBcVawvErd/qrg+KIJA8SmLqeHRRk/Lw=;
 b=jztX9O/7Tm1QBLswG/KSEekcoGrtP1uoa3C5mQ709P7uaI9ZUgiBvt/FrcQH1gORb1
 TITwNct1XaEUQCO+j0epMYjNjyVV/DSuYKJmJAkgCpb+B7NVMjyhInp7Oim5IBrT0uft
 FjWBZu4o7c4L5dLsujcPY9TlBcbNAuWdke+n1+0V7GZhyIXdQGh3eShdx4tCoeEdVJSB
 2v5wa0Hfc00gA3yy17OtE6mo814RGaFdZmJfgtqJhQiyjZnUISWgINeEQJOqKOfykZUd
 2xGb1Q6ICWG+mTXyngl9hAOfTp8F6vezq0Wu21Q0szAUJHbrbJGZmAHLbAefzKiGt37D
 pu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nB/5rC0VVxktBcVawvErd/qrg+KIJA8SmLqeHRRk/Lw=;
 b=LojyvfwS3SfqjCIT0nZ9Qy64gElPs4J3o7EffahZfVxvGHUnJAr97+hy32p5LKsPoF
 oe8/RbExVzEeF8oSWxG45WZf7sthlqsK6fakn7lkYqPtIULVedpidurpxGGHkG/sryQD
 IbwSBt4crpuGmtdj/3ReGHneLx4+DH5f6M7EXmXPk3Sqwd1OenwNBrqSpKFNYGtBrqgI
 WjzqJXRGubM7YeN5k0F2tJGT86ObaGHMVIm2LbIrw22xXl4sA11bcKSxuINQuE3kM2Zu
 baYLk/w1tkGcDJePAefWwTKIFMpZJR+EaeqrfDu4RBNkEBn4wsNY91RS6AXPz2vEEhrS
 pNKQ==
X-Gm-Message-State: AOAM533tkP4+VHpksNOH7064PZmgUjUVZik16q/f2bJW6OAH5sfW2AUy
 HncAPY2aeSs79YP4/j40TKBRYA==
X-Google-Smtp-Source: ABdhPJxCXszoS5DDXnCS2jJeKv8OGvgM180wCHerla5a8GwLjY0oYzNhMiFdJHa6s7K1/Zyeh18KFQ==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr256888wml.33.1594651038602;
 Mon, 13 Jul 2020 07:37:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t4sm23464334wmf.4.2020.07.13.07.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:37:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.1] hw/arm/armsse: Assert info->num_cpus is in-bounds in
 armsse_realize()
Date: Mon, 13 Jul 2020 15:37:16 +0100
Message-Id: <20200713143716.9881-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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


