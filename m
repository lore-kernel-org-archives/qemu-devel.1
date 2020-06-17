Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B370C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6576B207DD
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJLC88zO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6576B207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlR6M-0006wy-Ks
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 01:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlQzl-0002lz-HT; Wed, 17 Jun 2020 01:52:21 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44390)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlQzi-0004Sy-IV; Wed, 17 Jun 2020 01:52:21 -0400
Received: by mail-wr1-x441.google.com with SMTP id b6so897628wrs.11;
 Tue, 16 Jun 2020 22:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r/YRzT9yihQX0CYaeW9uQbX0lprIdEmCq4Q/T1MB1VU=;
 b=ZJLC88zOoWGxy3J019QfpFXXmkZhp7YIRZEPMvTDK0fYziOXtOJHunxsMUisNcCokj
 i80IzExPXgMIQGBcErj95c+4Z2OAzeN/wTeSwCq7xR7H2bHeSZPMgBrJxtMivfnZ5jSm
 tE52ZYigyQeAbq7b9kftEsD/7BqDpGhqPFSko1J/dWnxq3iuMVPMXwUtgF89dQLslqot
 EQ1sgKAkjeTdvLU0UAb87ED6vKJSDBssDptPNdoYU7PB2unzgPPorykUgno7eS3KuSL9
 1w2eSapRwuDBut2GEt+zWcu3s/Cr10OLWjpaB7aH5f/V1wiqPaGBEvomq5xsBCqBGsFL
 bKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=r/YRzT9yihQX0CYaeW9uQbX0lprIdEmCq4Q/T1MB1VU=;
 b=FofkUBLicHc/NkltVjsB4I7cR1OE/OQp2gDYiH+W2sZRj3WPkYkUZ/jwTU6MeCj2TU
 Uyky6xw19K2wNJs6d56hyuuIBlnOweNCM9mS9BUXFh0BKKFjOjf0fatG4ByZep2EQilI
 LxdIHcSVBAl3rvs4KzBnUYYtGSVytRFCPFhXWYZmfYbtLf+eqK7QWGUr5us7pg8UEekv
 4ywVv4pFU2GQHHFNjJlm+38y+AwETfGnfX0xBT4DVQpq0OdvgSErvO4PHCz99JgaQQSw
 NGLubymBqoxABWcrSpfn2MHtCoGGHVxCIgS+nj7UusZDFbCreT+zFMWt4dWLyswmFB9+
 k2mA==
X-Gm-Message-State: AOAM530GXZjeeATXG4KbsA3SQG3an/DsfubJOUDOmREAo9LJK4gaOOBY
 VdwsCxjgRPvXzb3xMoy6UX/bCK2t
X-Google-Smtp-Source: ABdhPJxk+/M6YNNuxdikRTHPK38sBsHr22tUx9DPV48qqVSLVTNQDuvtJmwPYkyN4sDOAKQzgdX3Kw==
X-Received: by 2002:adf:e7ce:: with SMTP id e14mr7079209wrn.217.1592373136790; 
 Tue, 16 Jun 2020 22:52:16 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id d28sm3000809wrc.50.2020.06.16.22.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 22:52:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/14] hw/arm/mps2: Add CMSDK APB watchdog device
Date: Wed, 17 Jun 2020 07:51:59 +0200
Message-Id: <20200617055205.3576-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617055205.3576-1-f4bug@amsat.org>
References: <20200617055205.3576-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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

We already model the CMSDK APB watchdog device, let's use it!

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: Use existing TYPE_CMSDK_APB_WATCHDOG (pm215)
---
 hw/arm/mps2.c  | 7 +++++++
 hw/arm/Kconfig | 1 +
 2 files changed, 8 insertions(+)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 4fe5cc8622..f7bef20b40 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -312,6 +312,13 @@ static void mps2_common_init(MachineState *machine)
     sysbus_connect_irq(SYS_BUS_DEVICE(&mms->dualtimer), 0,
                        qdev_get_gpio_in(armv7m, 10));
     sysbus_mmio_map(SYS_BUS_DEVICE(&mms->dualtimer), 0, 0x40002000);
+    object_initialize_child(OBJECT(mms), "watchdog", &mms->watchdog,
+                            TYPE_CMSDK_APB_WATCHDOG);
+    qdev_prop_set_uint32(DEVICE(&mms->watchdog), "wdogclk-frq", SYSCLK_FRQ);
+    sysbus_realize(SYS_BUS_DEVICE(&mms->watchdog), &error_fatal);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&mms->watchdog), 0,
+                       qdev_get_gpio_in_named(armv7m, "NMI", 0));
+    sysbus_mmio_map(SYS_BUS_DEVICE(&mms->watchdog), 0, 0x40008000);
 
     /* FPGA APB subsystem */
     object_initialize_child(OBJECT(mms), "scc", &mms->scc, TYPE_MPS2_SCC);
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 9afa6eee79..5c8f689b3d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -405,6 +405,7 @@ config MPS2
     select PL080    # DMA controller
     select SPLIT_IRQ
     select UNIMP
+    select CMSDK_APB_WATCHDOG
 
 config FSL_IMX7
     bool
-- 
2.21.3


