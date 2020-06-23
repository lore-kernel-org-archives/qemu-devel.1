Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E63EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 193A920738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGFhPP2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193A920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhXS-0007Si-AI
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHG-0003TS-1u
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:46 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:46052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHE-0003OW-BD
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:45 -0400
Received: by mail-wr1-x429.google.com with SMTP id s10so210768wrw.12
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+w15e9ooi+Fid4NWJLS9FC7iSLoBvgjk5tCxJ/erKho=;
 b=fGFhPP2AyvH3Zjh2rmupUiWzREw7ID+AuhRPpFGsgue7H37/iapTfBjPS2P88enupZ
 qCDMvrEQu28mhHWecS70AtSgNT8nP32G+EcmS91lsndrh6r0Wie4YYxuwdkldexTEmj3
 yL+uzfOI8XQOzQKxJlgKAtSfl5k3wmxt+WJnZWILxBX45Wakbe4q7ERidm6e8ZXN1ezy
 I/egzJzWiXAFxP0doJ13xayRsio5HQeTK4BK3rH6l/PR0hoMX7J8galFgPyo9ggs1Ldc
 I2hE+zcgTSREdOGFCtW7kPevM77FiwLJVJnPd8BY4Bdi/u3fxJiPl1z+pRkg3qRTbtne
 5h+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+w15e9ooi+Fid4NWJLS9FC7iSLoBvgjk5tCxJ/erKho=;
 b=c8ThKoSxAmI3ehsbeyErpWyJXvcLpenaPx0eWsvlvqbjSb2cEf2JGbcgF1SDSFyjQx
 6QcpQ772vMNynhpSFx5sahDK7er+/RQRpb8jBAJEbpeCofsttUkPhOZiSW07wd9hR6v0
 uuiwzmGUIjBX2MGTWNaDRaqITO2n5WzkgP9i0o4JETqY/OI33HTS1Bso3NamDas1Tsqj
 ClGegWM/a77FmD7x7hF8i1aQCNPpjDsaz+0b9cURRYW9MW7mks4CHad3OM7Hk9oxblS/
 CxyNJGu3o3RuTIeJocBm05ppukKF0sxaOYG9Ka+UWzMspJcQ+fpI5DgAL+D5TVxEuAKh
 CuHQ==
X-Gm-Message-State: AOAM5304MEB3sAkwEDwooKQoYpTgqoc20pZIkfnJwwn6fSEpaQDsEfbY
 K8LtqhroevuMB0emuvzIBHpm8C3oM6jGIg==
X-Google-Smtp-Source: ABdhPJy+jhUnmp+63XPKsthxJeUaQYS4TqHuM6pqdc/xQQ6elZaogmyADNK7gTfIzwg8xYibO01IKQ==
X-Received: by 2002:adf:c44d:: with SMTP id a13mr3319154wrg.205.1592912382721; 
 Tue, 23 Jun 2020 04:39:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/42] hw/arm/mps2: Document CMSDK/FPGA APB subsystem sections
Date: Tue, 23 Jun 2020 12:38:53 +0100
Message-Id: <20200623113904.28805-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200617072539.32686-7-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mps2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index daa55f730b1..ee555f919de 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -65,7 +65,9 @@ typedef struct {
     MemoryRegion blockram_m2;
     MemoryRegion blockram_m3;
     MemoryRegion sram;
+    /* FPGA APB subsystem */
     MPS2SCC scc;
+    /* CMSDK APB subsystem */
     CMSDKAPBDualTimer dualtimer;
 } MPS2MachineState;
 
@@ -299,9 +301,9 @@ static void mps2_common_init(MachineState *machine)
         g_assert_not_reached();
     }
 
+    /* CMSDK APB subsystem */
     cmsdk_apb_timer_create(0x40000000, qdev_get_gpio_in(armv7m, 8), SYSCLK_FRQ);
     cmsdk_apb_timer_create(0x40001000, qdev_get_gpio_in(armv7m, 9), SYSCLK_FRQ);
-
     object_initialize_child(OBJECT(mms), "dualtimer", &mms->dualtimer,
                             TYPE_CMSDK_APB_DUALTIMER);
     qdev_prop_set_uint32(DEVICE(&mms->dualtimer), "pclk-frq", SYSCLK_FRQ);
@@ -310,6 +312,7 @@ static void mps2_common_init(MachineState *machine)
                        qdev_get_gpio_in(armv7m, 10));
     sysbus_mmio_map(SYS_BUS_DEVICE(&mms->dualtimer), 0, 0x40002000);
 
+    /* FPGA APB subsystem */
     object_initialize_child(OBJECT(mms), "scc", &mms->scc, TYPE_MPS2_SCC);
     sccdev = DEVICE(&mms->scc);
     qdev_prop_set_uint32(sccdev, "scc-cfg4", 0x2);
-- 
2.20.1


