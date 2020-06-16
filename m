Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96F9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B275920734
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5PsuaTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B275920734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl5Cw-0004sb-03
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 02:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl58j-00082C-QT; Tue, 16 Jun 2020 02:32:09 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33754)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl58i-0003Mc-2W; Tue, 16 Jun 2020 02:32:09 -0400
Received: by mail-wr1-x442.google.com with SMTP id l11so19465026wru.0;
 Mon, 15 Jun 2020 23:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2FjgOSd/PcaKbg94PaHicHO0rGFHpV0TnPuxXVdcN10=;
 b=T5PsuaTM5zThSTjUXQD/0QYhszyEdhoZHQp8fhpUlPl7mAtK235dFj/CuvulyuNC45
 D4WcjwAEZex9pSb326jKayEUew1vxgnA2ap1jDLxL7ISjeZhelQg+HIVkybgzswZmb3E
 /NyqDeijTjljMlgKldEwu3NuUnLnDIBgzDNBekopeNCh2qEvAW/N4p99rdvP3lXt/Fuv
 RTA9Rnm2AbHqk8J5Zm/itD9hAf0R/40XKYoyMEBStSqyxrlH6IzPlTODrB0dc+zcPwb8
 y65VcVCr4wfvGB1KTo3vUlLKfaAy68bpGqjoYyGToXpV1tqQKFHQ7GPJAFYUY8Z164Bj
 L9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2FjgOSd/PcaKbg94PaHicHO0rGFHpV0TnPuxXVdcN10=;
 b=jOLSWNHAdegBT3VPJDSjc+9jJC7nyQ9Djm7J6hK1GfDRt69eGNLKMGPSrme67nxfRY
 hcIu8LMaif8AndPq9J5YZemaOoxLtXrggYY761Nf/HckgYdZ1isWhYnKUJLH8Eq6V5U4
 jrqOwtEPJta5BzTubM7AbS1DW7auYP8wNgn8UVXwgiy2fN30DLEzbsj3vEvS1d0CP+rX
 hTVKtuMVe0hmsAlaWmYGiAV0y8SqpkWYQoCyCHLS5KQmolFJ/Bz52xibTtdstU8feELI
 /cOdcYR1h3YhkDkBYra2Jm6KyfGqhi6DW1C1zqIs+VhVnljSOQmLGUqWKFw6GToHBeuE
 SP8A==
X-Gm-Message-State: AOAM532sdqHXssNiIM0gcHC6Fiy4i2gnxV2P1n49QMQkp8ZmyVWM6CS/
 DqeRlnlzXnE1ykKj3WEHXUBxykM5
X-Google-Smtp-Source: ABdhPJwtY74K9OAMAZYUnH7lhCuobvYIiZAvY7IcA6o2SgRxRE6nPWfsKMxIN/N4CnR/sG7C0Y0G1w==
X-Received: by 2002:a5d:5744:: with SMTP id q4mr1264543wrw.137.1592289126139; 
 Mon, 15 Jun 2020 23:32:06 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id t188sm2483250wmt.27.2020.06.15.23.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 23:32:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] hw/arm/mps2: Map the FPGA I/O block
Date: Tue, 16 Jun 2020 08:31:56 +0200
Message-Id: <20200616063157.16389-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200616063157.16389-1-f4bug@amsat.org>
References: <20200616063157.16389-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/mps2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 6224d7a63c..345ba551ab 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -38,6 +38,7 @@
 #include "hw/timer/cmsdk-apb-timer.h"
 #include "hw/timer/cmsdk-apb-dualtimer.h"
 #include "hw/misc/mps2-scc.h"
+#include "hw/misc/mps2-fpgaio.h"
 #include "hw/net/lan9118.h"
 #include "net/net.h"
 
@@ -66,6 +67,7 @@ typedef struct {
     MemoryRegion blockram_m3;
     MemoryRegion sram;
     MPS2SCC scc;
+    MPS2FPGAIO fpgaio;
     CMSDKAPBDualTimer dualtimer;
 } MPS2MachineState;
 
@@ -337,6 +339,11 @@ static void mps2_common_init(MachineState *machine)
 
         sysbus_create_simple("versatile_i2c", i2cbase[i], NULL);
     }
+    sysbus_init_child_obj(OBJECT(mms), "fpgaio", &mms->fpgaio,
+                          sizeof(mms->fpgaio), TYPE_MPS2_FPGAIO);
+    object_property_set_bool(OBJECT(&mms->fpgaio), true, "realized",
+                             &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&mms->fpgaio), 0, 0x40028000);
 
     /* In hardware this is a LAN9220; the LAN9118 is software compatible
      * except that it doesn't support the checksum-offload feature.
-- 
2.21.3


