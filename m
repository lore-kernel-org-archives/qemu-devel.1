Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724DFC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:53:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED6E2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sx5Ic1jE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED6E2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9Ao-0007ul-82
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95c-00052c-OR
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:32 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:41984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95Z-0004na-Ce
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:32 -0400
Received: by mail-wr1-x42f.google.com with SMTP id d16so7985907wrq.9
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=C4FDGofxkhp2CW5sAZODmLDNNvMWWKgKI6wWO5BMgFQ=;
 b=sx5Ic1jEALy0P6us1DgVxG37lwqFttI+T7kib9lgHCKBtkyVf6G9vROR9jPSybEEXF
 Ln0FuUiIIYwZoqeEQSlYQD73Y++xTqxA8SpMzAQdcFNLzYuM3ZWk4r+Hp0ZNIa6zFvDl
 4YAGKgvYOgGfuLcgmj8yQhSWODmtJTPZUBF88yHLWyswyPpULiLwQzOmDhOVOOJTmjIO
 V3X6RE0+5x3kBdQuBnVzlNrv0ldcrRUIhb3X7pSWf5xE1p6oMlPGNUUB5dlzyAHgTr1D
 TIiCRzKZ8zGfrc82MjTvrZnsUeVPY9JtWPgQdAAsHGOuigGIEEYoqPoiHSyaKR39IAsd
 3lXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C4FDGofxkhp2CW5sAZODmLDNNvMWWKgKI6wWO5BMgFQ=;
 b=b3gJwHyHZA/KCTnpLsQ/IZ7VrkY9h3M7AqMDWIX57SaTePIbm5p5XCqGKPhzWlFoxm
 y65fdAEn6rbAZxDJaJS5Tgqn8KO5HWKlf3P0yi0xSoNakIWwV0TubDacO6GB30LwyINR
 NYTuN8quUWHf5GIT71s5+fwZBfSzmL4r9/tmlhRJ6LedATWafmlnyuw/NssQhwV8nkS2
 f1RS7c98jVh8NbjNWJheSAD34/owbO5BpqiFUrUu/wOR/yw7STY/DNNz26ITvrMMiAPu
 ovD5av/1QVTJcVwArsUUDpxdyA3gdSL+eECGky0UprqwwpoVrxtjxHT+wvEzn+VCVOhc
 yVcQ==
X-Gm-Message-State: AOAM531aV5/WTSIdUNYx5LcUtAUZuLf5h91UPBVuxiMw4WEMozoVLFc7
 1Fj8K3D7c/Ocxu78AAmsIW13e43e3pgoyLdr
X-Google-Smtp-Source: ABdhPJwhGDeXHfcAoZchRXHfXzpmADT9ZbKrd7kYZYeVhdlkVyZmSbpFTi9GzTlCM/vG/9Rl2tJHWw==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr4914066wrv.318.1598262507630; 
 Mon, 24 Aug 2020 02:48:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q6sm24877057wma.22.2020.08.24.02.48.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 02:48:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/27] hw/arm/smmuv3: Advertise SMMUv3.2 range invalidation
Date: Mon, 24 Aug 2020 10:47:56 +0100
Message-Id: <20200824094811.15439-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824094811.15439-1-peter.maydell@linaro.org>
References: <20200824094811.15439-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Eric Auger <eric.auger@redhat.com>

Expose the RIL bit so that the guest driver uses range
invalidation. Although RIL is a 3.2 features, We let
the AIDR advertise SMMUv3.1 support as v3.x implementation
is allowed to implement features from v3.(x+1).

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200728150815.11446-12-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-internal.h | 1 +
 hw/arm/smmuv3.c          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 9ae7d97fafd..fa3c088972e 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -55,6 +55,7 @@ REG32(IDR1,                0x4)
 REG32(IDR2,                0x8)
 REG32(IDR3,                0xc)
      FIELD(IDR3, HAD,         2, 1);
+     FIELD(IDR3, RIL,        10, 1);
 REG32(IDR4,                0x10)
 REG32(IDR5,                0x14)
      FIELD(IDR5, OAS,         0, 3);
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index b262f0e4a74..0122700e725 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -254,6 +254,7 @@ static void smmuv3_init_regs(SMMUv3State *s)
     s->idr[1] = FIELD_DP32(s->idr[1], IDR1, EVENTQS, SMMU_EVENTQS);
     s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS,   SMMU_CMDQS);
 
+    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, HAD, 1);
 
    /* 4K and 64K granule support */
-- 
2.20.1


