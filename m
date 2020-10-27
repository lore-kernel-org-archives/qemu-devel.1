Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74166C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:48:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E3120757
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qR97ONEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E3120757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOPH-00053k-NY
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNQ9-0002BF-IK
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:46 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46828)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNQ6-0004qV-0t
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:45 -0400
Received: by mail-wr1-x444.google.com with SMTP id n6so1491985wrm.13
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=vqJag2qE3QdrFaGEy+qwjksLcU+OfxV+X+dGHhLho5w=;
 b=qR97ONEwfMqjR09q+V+jN3LUS3jZVXOHBn7DXeQkxjRvdmnW7szJOtnBItBCjy/VVH
 f/I6CiFCkbdBjG5CJNEXklp2uMKVpuwsgEOqs3hiZm4I2Nnosb2CSuGDK60bFyJ6ucPd
 vgwXJ8YeftyEv/pzsKs4Ti2AEi0EwOiK05c9kTcssQaJ442PnVjjsdlBvnmxWVr2ohuT
 B7LrjsKZlrbtlDaiaSYtev5nczBfNpzOTW+wcVVcUnuRD751sJdy+yN9MfUoXm8K1UYT
 NxzRyHtdsGrW/qGsyI5PH11vOYmnEO40Qbn8PIGccAWWdjIQiQ+l+P/UV1rMWktF2GzJ
 xFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vqJag2qE3QdrFaGEy+qwjksLcU+OfxV+X+dGHhLho5w=;
 b=cW8S44qtvVSSD/Q1ycqW3VuJKwXOYku6gKg4swnl/EtR8KcggfwcA2q78LoX34ZiXn
 cenod5ikeFOSQLVY2tzvbxP3CkNMiFEX2WQPFDljZoMg+O1VVlrPKOCNZbyaNThDgkSF
 6mLqpcqB+JrCNS8P/cAVDEJtX/fDXexqjKkCdgT+gBjO1BgnsWnI1+QC07S5AzKidNmy
 k1meu3WIIoC9WEYLciYlXebhMZndh9Md3OXXebcIgtukXH8ljinlcGc9Y3b8nGFgETjE
 JLPoX/g26al+wnwmlEKVpeli2te59i7pb7b1ZgSG0LcsiffxqTs4rdnSOYpNOzt8e21K
 mJOg==
X-Gm-Message-State: AOAM531kaONEN/O9J0Rl29zpKHkjDFlS1vd/DYujwGcwZwyRZnMlzXZP
 60WMpwrzyZVeKciEURBgIejh8WtT1rN54w==
X-Google-Smtp-Source: ABdhPJyhHvsiheG5WbHIDUU/HR7DwXrYYsv6vSGNfzDwOOvywxAWEZNP0jI839Fg5z9X+/hzWRrxTA==
X-Received: by 2002:a5d:5106:: with SMTP id s6mr2317142wrt.51.1603799136395;
 Tue, 27 Oct 2020 04:45:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/48] hw/arm/bcm2835_peripherals: connect the UART clock
Date: Tue, 27 Oct 2020 11:44:34 +0000
Message-Id: <20201027114438.17662-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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

From: Luc Michel <luc@lmichel.fr>

Connect the 'uart-out' clock from the CPRMAN to the PL011 instance.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Luc Michel <luc@lmichel.fr>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/bcm2835_peripherals.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index d33ec54c414..dcff13433e5 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -169,6 +169,8 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     }
     memory_region_add_subregion(&s->peri_mr, CPRMAN_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cprman), 0));
+    qdev_connect_clock_in(DEVICE(&s->uart0), "clk",
+                          qdev_get_clock_out(DEVICE(&s->cprman), "uart-out"));
 
     memory_region_add_subregion(&s->peri_mr, ARMCTRL_IC_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ic), 0));
-- 
2.20.1


