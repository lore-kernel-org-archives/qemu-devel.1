Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FF1C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:58:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA5E20678
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUCGFniQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA5E20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxFb-0003MV-HR
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwML-0005Ov-2E; Thu, 03 Sep 2020 17:01:29 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46539)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwMJ-0007vm-CE; Thu, 03 Sep 2020 17:01:28 -0400
Received: by mail-ot1-x344.google.com with SMTP id c10so3976986otm.13;
 Thu, 03 Sep 2020 14:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ukiMnU2Ka9CilWgAW2sSo5sQypISiGu+XOTOgn0j23Q=;
 b=EUCGFniQXNizA5SYD5PkHcdWgwJn+49NwLtLVyQFwft/kWN11w3Ls7K8tUaFkMw42A
 9/wws5PNQVxB3V/4hD8vS+ojTNZq8N++M6EPbR0ETxQ645u16fHRojhD+yrcR4qWzH4z
 /jUQT+/uSVCRPEzrEuMRxeFNI6C4DpWlofEG5RZKXI5FeXMlqYDr627JSsnrf0xvEb9P
 5EyKsI3viZotUyqt+poFpfl9MMCpPEJQJeYAPZnloUNGxW55uzNQYUy+pilj6mNTOJVU
 IZURk+eRV9ngU3UxWZxPbij5pwxpDmdePVgxQUGfsHvgzUH8Bb+hx1INeYUyhx5ev7Of
 VM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ukiMnU2Ka9CilWgAW2sSo5sQypISiGu+XOTOgn0j23Q=;
 b=h/qz+sM5284+m9mEY0EYuOVJ1T7n4zNmQdECGvkE4r36cB/CIRxlvqMi+1fsnnHuwo
 kRrnXvEu+RAOv+q0RyZ2UQQzCAZjLsgFFTtfG5PfngLRBtwhGlUxDMCxqFW4N+kVYPYp
 0soJ6r1E3cgR4BTF9VA3Qcwcp7oMI+2MoCBSa3AC4I00Fz2XDRaVw5GhtjfknIe2IbTO
 LBVKoz4PcADaENvnTjrUR/XQBr0gTnwrlnor0WaGzuqMfQtjaSV1e4Qe591JmGbX5pVw
 0j2ljnA4TFVAkJcz4nslyA1tTvjAjvW1jpD69OrhM/fUn769YMaMOGZG/8Of7oWL/F7z
 Ybgw==
X-Gm-Message-State: AOAM533RKODU/K4G3AU5td0T5mFy6zeB7A3zCRN/ABMJESlB6MKYI0aj
 uaciZCwCD7ffGNcBf6L6Nt0Y6xnrJP7tYA==
X-Google-Smtp-Source: ABdhPJz8pRPBwG8xRM1knu8gsqApuT1ZW9/ewO5C+peXCXPcSQb2bt5OVOvxr6bERYp7cFyv/I7JQg==
X-Received: by 2002:a05:6830:1c61:: with SMTP id
 s1mr2941421otg.149.1599166885564; 
 Thu, 03 Sep 2020 14:01:25 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id w13sm740900oiw.50.2020.09.03.14.01.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:01:25 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 76/77] hw/arm/sbsa-ref: fix typo breaking PCIe IRQs
Date: Thu,  3 Sep 2020 15:59:34 -0500
Message-Id: <20200903205935.27832-77-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Graeme Gregory <graeme@nuviainc.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org
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
(cherry picked from commit 870f0051b4ada9a361f7454f833432ae8c06c095)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/arm/sbsa-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 8409ba853d..0b32084dc0 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -555,7 +555,7 @@ static void create_pcie(SBSAMachineState *sms)
 
     for (i = 0; i < GPEX_NUM_IRQS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
-                           qdev_get_gpio_in(sms->gic, irq + 1));
+                           qdev_get_gpio_in(sms->gic, irq + i));
         gpex_set_irq_num(GPEX_HOST(dev), i, irq + i);
     }
 
-- 
2.17.1


