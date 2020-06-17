Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2B6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:57:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AF4C207DD
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsbKIV4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF4C207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlR4X-0003SP-9O
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 01:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlQzi-0002f1-2T; Wed, 17 Jun 2020 01:52:18 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlQzg-0004ST-EQ; Wed, 17 Jun 2020 01:52:17 -0400
Received: by mail-wr1-x441.google.com with SMTP id l11so954416wru.0;
 Tue, 16 Jun 2020 22:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cg5OZZgeFdkySmBsDID4sS8qarnHbFdRK4wloQNjZ2E=;
 b=dsbKIV4O6UW9D34HPyz4x0JsQR5PpSXq7B6LRYAcivUcVNbOCBTjlJAGxsFPDg/jQ+
 TgMgF8LGQaEo5GHaeCUKVOWYemZEaqGy6nI2NyzdBsnMLV0B+n4dBV9lWv35hIzGm3c1
 nbrzAtHOwocUrk9yXtY3tZ0xikCf8DUQBX50LPqqhHfN0eMm6v8aPS8LER1ow7r4KOVb
 0rBf/RJ89ISk2aUomERaqIB/EhJaufu4VH/rDhKVPxenj94HCiQMeiUH9vWkx/Z0R2vI
 fBhc6fYDnv7GJdnhFyuQnvszxe7pD01s2S1iD34JrTfQr1SrYd9rVkF8yu9q/xsVIqan
 CIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cg5OZZgeFdkySmBsDID4sS8qarnHbFdRK4wloQNjZ2E=;
 b=r7g97rsRaUYOlQqI6IGqTnWznVxg012r8o6mjCc7dSnn3we6x19gOwMMyfobytvoDg
 pBGPPrCSZDPhVbMbwHUKG1fb+nWCkjPUrAfD/z+Jh+XlVWNke5QenNakAylRBPhGJb1z
 CXCbrAUlscBzpcRkRSFILTQWYMdRsjYNzloQi76JXoHgpbXfMDhtb9OHFvIhq9SgG9Um
 k2Q+txomZXSu2KVTnM+ZeA7tIlBnM5qsCvCoDia1XYKkb+VC+ZgL7KWx9a+fmaOZX43m
 ppK/1M+pQeOC9hfzHdtg7X2MF6XsOllJHZdrfPug1Sbr8AssA1S638AeRywA/aiKF3G/
 J9NQ==
X-Gm-Message-State: AOAM530aITYyczTdbxANmFf7jyUp+LmpYMcMiGUr53RJTtjIHbVd+BKC
 EYpS9gjnHID0KwC0tq2S36xh+KgY
X-Google-Smtp-Source: ABdhPJzbbzaJ+ul27/cXGDCJIqGun8Fv9v9trLwVDDTKWSWCPoUOQ8+NPg5kP/fSLbZjxHF0/lLemQ==
X-Received: by 2002:a5d:49c5:: with SMTP id t5mr6725072wrs.18.1592373134616;
 Tue, 16 Jun 2020 22:52:14 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id d28sm3000809wrc.50.2020.06.16.22.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 22:52:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/14] hw/arm/mps2: Document CMSDK/FPGA APB subsystem
 sections
Date: Wed, 17 Jun 2020 07:51:57 +0200
Message-Id: <20200617055205.3576-7-f4bug@amsat.org>
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/mps2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index daa55f730b..ee555f919d 100644
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
2.21.3


