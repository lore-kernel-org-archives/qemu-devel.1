Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E250CC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49AA20771
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w6FmxZwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49AA20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIucG-0005xO-NV
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 09:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jIub1-0004Oo-6D
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jIub0-00016D-6c
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:36:55 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:50612)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jIub0-00014Y-0s
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:36:54 -0400
Received: by mail-wm1-x336.google.com with SMTP id t128so1556362wma.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 06:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=WTqWyO7pGTPXb6HXG/SCIMQhmD5yDN8g6Rdw1sDZPts=;
 b=w6FmxZwXaVZA1naDD9FOHNSgnAJ1xKhvMqCvmBiEeqdl9VYDDKW/qdzVHwHvuOQujt
 CXw5XGlKmFTv6tzlkOasDJYrZjnXgLHftvQE7BGL5WNRP0fu+ZQxP8ZSi7Jh2HlRG669
 2yxeuUd2rFGm9qBu2IVAI3D8i3iIUCz28rs6IrW0tjhtC3Y7eQDy4NuivpjCePBbK8rc
 qr2mAsw9ha1o7tCDjyAZ97l5bIZqyieAwAZp0tlGL2gx8NdtjOc+sCzqNTT0K5/CtlVs
 SrfBIpuUO8EpbYz1unSPQPjjMut3TGrcuYYrG90HurU6QmL+l6WnpXPWZ3c4JaqcOeXD
 MI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WTqWyO7pGTPXb6HXG/SCIMQhmD5yDN8g6Rdw1sDZPts=;
 b=HkmeVKaBLIAzf9J0IbMMsSAnPcwQnyNanKOMeEWENNs5Zh5biYPsYaztIzRv4Gs/Dw
 g7R1waYdTbbCnf0Su3Byrznk2QN33wMW+oz6xLkoVFFRp1SfR2ZDkjMMd8Vb/cHZxZAC
 lVLhPCnTop3gsmiO/E3zw5LgOwDRC02ab3k5sFlxQz1uZxBhyM4habEgemyzeOlnOQTo
 rNNfMydOggaJu56xDx31VWmlUoN/ljN7rPQIp5aljDe2bWisWQacj1aKH15gFWPdPnCL
 PMI6+0Shau7UuUCoKVvtekdqCeFQFHjX1FVOEGfXfhYpTWbMVacG+ctixbTnqXHhp03D
 4uEw==
X-Gm-Message-State: ANhLgQ3BeYFAheNe8E+ZajmKMQ/lNZ1XSai2DEbwDIthuzRMwmrhIpTs
 lTiUFzdH92w2f4DoDBdbdYwjEbXC0tds/g==
X-Google-Smtp-Source: ADFU+vsTsaFXtoOMrzH4di9IwSjRVUIp0y3IbY/TrXOcGeMJumGPhFH+lVppGjFl23LpAjaZtc1u+Q==
X-Received: by 2002:a7b:c40b:: with SMTP id k11mr1686190wmi.157.1585575412614; 
 Mon, 30 Mar 2020 06:36:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o14sm20756504wmh.22.2020.03.30.06.36.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 06:36:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/6] hw/misc/allwinner-h3-dramc: enforce 64-bit multiply when
 calculating row mirror address
Date: Mon, 30 Mar 2020 14:36:44 +0100
Message-Id: <20200330133648.22297-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200330133648.22297-1-peter.maydell@linaro.org>
References: <20200330133648.22297-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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

From: Niek Linnenbank <nieklinnenbank@gmail.com>

The allwinner_h3_dramc_map_rows function simulates row addressing behavior
when bootloader software attempts to detect the amount of available SDRAM.

Currently the line that calculates the 64-bit address of the mirrored row
uses a signed 32-bit multiply operation that in theory could result in the
upper 32-bit be all 1s. This commit ensures that the row mirror address
is calculated using only 64-bit operations.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Message-id: 20200323192944.5967-1-nieklinnenbank@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/allwinner-h3-dramc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/allwinner-h3-dramc.c b/hw/misc/allwinner-h3-dramc.c
index 2b5260260e7..1d37cf422cd 100644
--- a/hw/misc/allwinner-h3-dramc.c
+++ b/hw/misc/allwinner-h3-dramc.c
@@ -85,8 +85,8 @@ static void allwinner_h3_dramc_map_rows(AwH3DramCtlState *s, uint8_t row_bits,
 
     } else if (row_bits_actual) {
         /* Row bits not matching ram_size, install the rows mirror */
-        hwaddr row_mirror = s->ram_addr + ((1 << (row_bits_actual +
-                                                  bank_bits)) * page_size);
+        hwaddr row_mirror = s->ram_addr + ((1ULL << (row_bits_actual +
+                                                     bank_bits)) * page_size);
 
         memory_region_set_enabled(&s->row_mirror_alias, true);
         memory_region_set_address(&s->row_mirror_alias, row_mirror);
-- 
2.20.1


