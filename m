Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363ADC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0271820734
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mX7AeBCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0271820734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl5D9-00058q-6o
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 02:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl58i-00080U-Hn; Tue, 16 Jun 2020 02:32:08 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl58h-0003MH-1t; Tue, 16 Jun 2020 02:32:08 -0400
Received: by mail-wm1-x341.google.com with SMTP id j198so1519972wmj.0;
 Mon, 15 Jun 2020 23:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0C754Z2styJVcWZeah0XfpUldg+E2WED/NhKiLJuUwM=;
 b=mX7AeBCmISmFvf1ccvUqkR0mMy1JR8NNO98AQPSOzV4WYlL6sf5STJzzK7oDXR+E03
 R0CXPdpfts55K3YTMA2Acz9YHFrtm/JbUCXC+3GrbEQGIEV1Vv4dPshC4U5TpXB8oqPy
 oJpCC6kKvHaCiqyvgHuz5u3ollxjm8f/Jgk0ECRbo8FBjoZz62TatXlRU/fHuSbO2QI6
 PipW+aLCNLmcKyW7o8XqXdjwn2Xyz6WmGPrqvR7fc8H3eSJAjOomBcqzj1S01mOSBEV9
 /ssPOyLMADJqFH1u/eU5Ty0rFPtcFs6hJLaJAVXrVFUcFR9o85QUYv/vC+GiMRdCmwiy
 9IHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0C754Z2styJVcWZeah0XfpUldg+E2WED/NhKiLJuUwM=;
 b=rrlve4pCZNqXzK7IBdoapoOHiEEzED0oVzapBEVBA891QmUMlQGJnC7f57+KXJZWEy
 md6j1u4qB6jemmXYFLWiE/8q8r/EVSjKSrO/OhEoI1kwi4aGahUQmodcE0gxOOg2wB50
 gkHRcpPansWfSUPs0JAx12XVg563FFH2mB9bZtbzSg5fhV9TQBklMNeAyNvnvm68EDBj
 JkI0aStD3BnvJwg15k5yYShh3gCk+SQw2UbFvWhJuhbkptRKTTAUWBl1FSLXXsYUg3MP
 ybSqMheLcczXqcLhM4ToyndrPfLlZs3XLV+K9PK82e3/4MdT106/HJhqw8MQnT7SdqWS
 hBaA==
X-Gm-Message-State: AOAM533npcPKP98VB5eNdL7Be2l9Uu8L525Mc7Iu81kOi19xU2cG3hAX
 sHiRmbR3CE7hRwCO/St/jCyUKBo2
X-Google-Smtp-Source: ABdhPJzlPadS5VEC26TKnCCdNA0iXGEZ7JZ2XekaKsP6DbW7l6mwdkDDgV5T99IwPunfRpmXd+Qt1Q==
X-Received: by 2002:a1c:9613:: with SMTP id y19mr1475307wmd.135.1592289125102; 
 Mon, 15 Jun 2020 23:32:05 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id t188sm2483250wmt.27.2020.06.15.23.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 23:32:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] hw/arm/mps2: Add I2C busses on FPGA APB
Date: Tue, 16 Jun 2020 08:31:55 +0200
Message-Id: <20200616063157.16389-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200616063157.16389-1-f4bug@amsat.org>
References: <20200616063157.16389-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Esteban Bosse <estebanbosse@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are 4 different I2C peripherals on the FPGA APB.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/mps2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 4a49bfa9b9..6224d7a63c 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -321,6 +321,7 @@ static void mps2_common_init(MachineState *machine)
         create_unimplemented_device("cmsdk-ahb-gpio", gpiobase[i], 0x1000);
     }
 
+    /* FPGA APB */
     sysbus_init_child_obj(OBJECT(mms), "scc", &mms->scc,
                           sizeof(mms->scc), TYPE_MPS2_SCC);
     sccdev = DEVICE(&mms->scc);
@@ -330,6 +331,12 @@ static void mps2_common_init(MachineState *machine)
     object_property_set_bool(OBJECT(&mms->scc), true, "realized",
                              &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(sccdev), 0, 0x4002f000);
+    for (i = 0; i < 4; i++) {
+        static const hwaddr i2cbase[] = {0x40022000, 0x40023000,
+                                         0x40029000, 0x4002a000};
+
+        sysbus_create_simple("versatile_i2c", i2cbase[i], NULL);
+    }
 
     /* In hardware this is a LAN9220; the LAN9118 is software compatible
      * except that it doesn't support the checksum-offload feature.
-- 
2.21.3


