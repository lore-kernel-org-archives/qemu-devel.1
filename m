Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C82EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA85206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBV0tcVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA85206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl5Ai-0001Xd-5R
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 02:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl58g-0007wR-KV; Tue, 16 Jun 2020 02:32:06 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl58e-0003Lk-Ta; Tue, 16 Jun 2020 02:32:06 -0400
Received: by mail-wr1-x444.google.com with SMTP id x13so19439573wrv.4;
 Mon, 15 Jun 2020 23:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MjgVP8rwX0nk7ybJEZVD26qOTyCHQ8rjBa6s5OZUNzs=;
 b=sBV0tcVoyjFqt1tVIHJE+6IUOMYpnGXt9S+RgQDfZjA9NOv5tjC1sg9ErQTj7r7USx
 IQRta6mwBfv7PmQZM8/NDJ3s4JS7VvEcznMWyiRRMgolaf0b9yQeYytC9MUtcf/2SqVI
 MPepvu8uqkipGJJPz/7H5+H6TOI0xsx+H6GfyYlscitRJs3S/nCDlhNxymHPAf4w4wb0
 D33za4FDs4BxrJbsju3v+FgSHMY+lgsvVfrvdc0ULAehQSYRbgjgJYIRWMbeiOzciMte
 Ng2/l0P9rmV4a3nDB9AHZzFgh0avziaKClgHYv8jKFP8WxpXH5pmcE0D+vBezardStt2
 kwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=MjgVP8rwX0nk7ybJEZVD26qOTyCHQ8rjBa6s5OZUNzs=;
 b=j+mpgQ8WbfnfIpIADZxgIF9TjlZJB77e3f+Vqyq5nyKSUVdLiyQQlh93u8hQAgfwZ0
 DqWULdFmqq5tN71vwh9KE6sKa1fWXvMCFdQmW9XSqW7mqJa2sBcJk67TKWsllM3oH7fh
 h1wvZSI/ESjesbxucIucrDkwbTVP3gwErfLY94E4XU4qaCnkwLoVNHgCjuoP1tWOxetd
 dw/XlOSxRWOraRi8I6GdLJVokaqfzF/J95kQWVTcMlO9kadFRw4tbd77WcXBo66uCB7s
 AxzLVlpN5aI8LH/Uf9ZeMQo4nZPaTYZdKmLrcv+ktrEbzB1Lc6ubVTfJdCeYMxLbzmt+
 IscA==
X-Gm-Message-State: AOAM530LGAx93xNHsHqhqWhZl9Rj2+Hu0rw41ZLrB9Uh82joCjRXYgbY
 djTB+D/K31xDEQLYZNn390P7A26T
X-Google-Smtp-Source: ABdhPJzrJxrt0nbB08y0ysvfGXIsFhjZG84V14gT6T/WIrBhemXlay9mir0pJFKTC5XfvIWsXhLesw==
X-Received: by 2002:adf:a350:: with SMTP id d16mr1345314wrb.237.1592289122994; 
 Mon, 15 Jun 2020 23:32:02 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id t188sm2483250wmt.27.2020.06.15.23.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 23:32:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] hw/arm/mps2: Add CMSDK APB watchdog as unimplemented
 device
Date: Tue, 16 Jun 2020 08:31:53 +0200
Message-Id: <20200616063157.16389-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200616063157.16389-1-f4bug@amsat.org>
References: <20200616063157.16389-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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

Register the watchdog peripheral as unimplemented to better
follow its accesses, for example booting Zephyr:

  ----------------
  IN: wdog_cmsdk_apb_init
  0x00000900:  b508       push     {r3, lr}
  0x00000902:  4b07       ldr      r3, [pc, #0x1c]
  0x00000904:  4a07       ldr      r2, [pc, #0x1c]
  0x00000906:  6018       str      r0, [r3]
  0x00000908:  4b07       ldr      r3, [pc, #0x1c]
  0x0000090a:  4808       ldr      r0, [pc, #0x20]
  0x0000090c:  f8c3 2c00  str.w    r2, [r3, #0xc00]
  0x00000910:  4a07       ldr      r2, [pc, #0x1c]
  0x00000912:  6812       ldr      r2, [r2]
  0x00000914:  601a       str      r2, [r3]
  0x00000916:  f000 f9f9  bl       #0xd0c
  cmsdk-apb-watchdog: unimplemented device write (size 4, value 0x1acce551, offset 0xc00)
  cmsdk-apb-watchdog: unimplemented device write (size 4, value 0xe4e1c00, offset 0x0)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/mps2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 1e8d5f21f9..570ec50aa8 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -314,6 +314,7 @@ static void mps2_common_init(MachineState *machine)
     sysbus_connect_irq(SYS_BUS_DEVICE(&mms->dualtimer), 0,
                        qdev_get_gpio_in(armv7m, 10));
     sysbus_mmio_map(SYS_BUS_DEVICE(&mms->dualtimer), 0, 0x40002000);
+    create_unimplemented_device("cmsdk-apb-watchdog", 0x40008000, 0x1000);
 
     sysbus_init_child_obj(OBJECT(mms), "scc", &mms->scc,
                           sizeof(mms->scc), TYPE_MPS2_SCC);
-- 
2.21.3


