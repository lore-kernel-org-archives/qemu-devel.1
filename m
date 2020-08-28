Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF82C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFBCC208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rLYYnfV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBCC208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBadD-0005Xw-2D
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacQ-0003lO-2d
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:22 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36253)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacL-0004CE-MX
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:21 -0400
Received: by mail-wm1-x342.google.com with SMTP id z9so286765wmk.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=qGRrg8fqVk3kjMpo0tOF1M25f8LDIDHdvCUbdkd6EyQ=;
 b=rLYYnfV3W118pSJj3ZYnFao4Xq3D+F5AeNiYdh63Lvcvkd6bj6CMBBRnaJnbwry3hH
 GvGZfR5w8IFX5Zkomzn1bc/eMIGQgZdV1m0fpwIFkVSmSP5yk0ssj1e27F4tuytkLiab
 ogwVirvMZ3uT/YQwTKa5t6GRo0oiSD0JZLDdHcuL+KdCU4v5FGk3VNOUFPljEwA78V7h
 TXij080lauEEaGVvWFgFa6nZmYqNMFHm2tyv5vtBctx7f3r7JD7aaC63PatYCiBYXYsl
 lvo0o9CvNt4thhCxbfPaqSFfzj7M1b3vHRr/D1QuZ3enTjqbeTMVSy4lMdMMhEjmLIkA
 EX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qGRrg8fqVk3kjMpo0tOF1M25f8LDIDHdvCUbdkd6EyQ=;
 b=izDgfBuWtVDVYRt5ylo8uQgoN/vg1xRF4fhePZ5KvhIKJqQZttpYX3K6Mv8adFF13Y
 OuWaz9qjvBQ3SVcxPxBZejPzsTC8wTG3j0BdC0KEl+fp2WibCv8r5JnQeajTGTXtjfVf
 xKS1YkhhI3KRYbp08t7VojtP8EgTuzcPwnUshZdsZdbhU0H45VIcd9kqgPlF+iX+IbGg
 hpAczVbQmc594AF5VLGMuCU40BPpGTjQQkUJ5hqc4m+uDUx5M/6Pj20YzqXZ35lLPbKg
 CReloppjfoH6FRK+Thw6Wu/Pn7JaIecSelMxzuQCJQpiJbmJuIR22K3ek6E//qJMU48S
 zBaA==
X-Gm-Message-State: AOAM5337S/SLZHhPKRmnNOg8ij7VE7t9cIZax3tMnhyS04bH/7Fc7a8i
 QTDzPqgZQHt/j7B5PXLJdjUkC5ehIyC0h8TN
X-Google-Smtp-Source: ABdhPJyWnkth0SYsT1f9Yo/prloAG4fSNUgJIQuUnichGBUOHBj8CAiG1ct3P6IxA602dyffp7YAPg==
X-Received: by 2002:a1c:81cb:: with SMTP id c194mr716607wmd.45.1598606655957; 
 Fri, 28 Aug 2020 02:24:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/35] hw/arm/sbsa-ref: fix typo breaking PCIe IRQs
Date: Fri, 28 Aug 2020 10:23:39 +0100
Message-Id: <20200828092413.22206-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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

From: Graeme Gregory <graeme@nuviainc.com>

Fixing a typo in a previous patch that translated an "i" to a 1
and therefore breaking the allocation of PCIe interrupts. This was
discovered when virtio-net-pci devices ceased to function correctly.

Cc: qemu-stable@nongnu.org
Fixes: 48ba18e6d3f3 ("hw/arm/sbsa-ref: Simplify by moving the gic in the machine state")
Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200821083853.356490-1-graeme@nuviainc.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sbsa-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index f030a416fdf..2a7d9a61fc7 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -554,7 +554,7 @@ static void create_pcie(SBSAMachineState *sms)
 
     for (i = 0; i < GPEX_NUM_IRQS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
-                           qdev_get_gpio_in(sms->gic, irq + 1));
+                           qdev_get_gpio_in(sms->gic, irq + i));
         gpex_set_irq_num(GPEX_HOST(dev), i, irq + i);
     }
 
-- 
2.20.1


