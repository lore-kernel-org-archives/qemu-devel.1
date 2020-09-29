Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69A5C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4783620897
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="lg6y/3mW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4783620897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNCDG-0002Lr-B4
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 05:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kNCA8-0006hA-Rt
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:43:08 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39877)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kNCA7-0006pC-7s
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:43:08 -0400
Received: by mail-wm1-x343.google.com with SMTP id t17so1443361wmi.4
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 02:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OdqFefkl4maWCp9vvcc70mZR+cDjhhDDVOWkpRFdv+A=;
 b=lg6y/3mWBcMche6SvRrPGMI6wPdHN6q5WCNia8LqacOUHfXahU07EmM+AKWo7LmAey
 ETmqnBqMWz3/JnuY8SjrkKbsIzSug9OERSMwZ0NbsIwNwNbd2BJWllR6VaTh7AMtfoEL
 NW4xhnYkOSDa4xlWhVp4f0ghqfKKA5wJEHj92K+Q2M5zzJuOkf+Mu9s5Gl3ovdwDup3/
 pOjNBSy8NOjLXK04VDg8FnbHXaMEIgsVZWzmK/pXOooyX5XVKSvHzYmvigHmVVQdGIKc
 44+7D0QrOFBu918qtyN7n2yoNkRV39/X0T0RG7+WNnf2MQDXxlnyZeOEwSyEtD0+jGCA
 ld+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OdqFefkl4maWCp9vvcc70mZR+cDjhhDDVOWkpRFdv+A=;
 b=MD550d1W1wBYwM7UV6Iz6/7tvSHsCe7++djzdMpY8nvE5YGIU4UZZVBMiFtvRWljBq
 AQ/TZJNcGb0Us46GUqe8h4nodiYKabDNguRXt4OUwb/6lXsTxmZglCsszck8mHexr1Gf
 gZyYzFY0uPgDS877QPcqfy2B7hg6P/Zz9oZxdHBec4Wyui3owlgY0v7ZcwV3XfUeMefT
 Dkn+JIDJkYe+sXCJvaMHqWzSeR2DadUOX8Wm38gY1h/+OP32bRmTp6PqBbSYrn8d+6P5
 A/FIyGGgtNi8L8d/DBoUQn9stJYDwNLw27QG9STJNHZCSNPzIKJGo3u9dveTETUoexbv
 l7vg==
X-Gm-Message-State: AOAM5331U3uUa+ARDG9ALYFaU07pn+FDsQMviF6g+Qu3AmraVvkJKODs
 YEFUUXN/tl8FhPx+FuGe6mW53S8oORAcGxQi
X-Google-Smtp-Source: ABdhPJx2d4wV2ZtLPLP/NkEZGAMlBZUUgFN1uSD8ZMke1v9H/jY8jYy7Y4sUCTH+fg7OJOYu2JH99A==
X-Received: by 2002:a7b:c3c8:: with SMTP id t8mr3566696wmj.101.1601372586006; 
 Tue, 29 Sep 2020 02:43:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8010:64d6::1d89])
 by smtp.gmail.com with ESMTPSA id t6sm5887797wre.30.2020.09.29.02.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 02:43:05 -0700 (PDT)
From: Graeme Gregory <graeme@nuviainc.com>
To: qemu-arm@nongnu.org
Subject: [PATCH 1/2] hw/arm/sbsa-ref : Fix SMMUv3 Initialisation
Date: Tue, 29 Sep 2020 10:42:50 +0100
Message-Id: <20200929094251.151722-2-graeme@nuviainc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200929094251.151722-1-graeme@nuviainc.com>
References: <20200929094251.151722-1-graeme@nuviainc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=graeme@nuviainc.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Graeme Gregory <graeme@nuviainc.com>, peter.maydell@linaro.org,
 jamie@nuviainc.com, rad@semihalf.com, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, leif@nuviainc.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SMMUv3 has an error in previous patch where a i was transposed to a 1
meaning interrupts would not have been correctly assigned to the SMMUv3
instance.

Fixes: 48ba18e6d3f3 ("hw/arm/sbsa-ref: Simplify by moving the gic in the machine state")
Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
---
 hw/arm/sbsa-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 257ada9425..47e83252c1 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -530,7 +530,7 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
-                           qdev_get_gpio_in(sms->gic, irq + 1));
+                           qdev_get_gpio_in(sms->gic, irq + i));
     }
 }
 
-- 
2.25.1


