Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69003C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CCC20679
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 12:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czA9z+We"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CCC20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfjnx-0007Zx-Dd
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 08:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjms-00067c-PN
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:43:30 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:35804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jfjms-00055O-2S
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 08:43:30 -0400
Received: by mail-wr1-x42d.google.com with SMTP id x14so11415587wrp.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 05:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sHSdc0omkhqpxjCauytiNdW8vYCwQDAfVEOw9sLViU4=;
 b=czA9z+We+XfNOI4ZypgIG9lXspW9DlIafHHFBX9ls6K+e8tMnrv/FQYqPHhn/jwl5B
 y9t7tWYWRh0+hQyZZVcW/ZULhRV1HqcuVFz4fWiYLvJZz8DhMTAcYV8HNRxPfci1yrj4
 5S9TeZLLxIDGzqDxmHsfmEjrn/WwIoUt8F7mTdcpLw4NdP2IoS6XvnopQGhrUNUzj1HN
 pSeI2fqgccXtuZpuUok+rDI8wAJXKXQqNM9sUXXDm1np73yF4Vy1KOpPIVbtlQiZE5WH
 HJf3vgWt1eoGIBm5RKyhTRxP/0M+Hk+YjcUpBa/Do7UDhpazuqa1f13VqYmXUUVFD9ED
 8u6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sHSdc0omkhqpxjCauytiNdW8vYCwQDAfVEOw9sLViU4=;
 b=TAjzwUvW7THFSR4hn97JIXVDPvTjtAB7eArHwCjaKbjCQyX7UV04q84q667WlYyS0r
 QW3ex6g+HKhe8cCjhgg7NQwFZ/+NKrdyNnudELqUZYdUC8Ekp3lh8dHqrjw6OliXUMQ1
 VuylK+BCx7yn3HYXhU3QyxEih0tesxik81JJPz+WTmx7TWtyWI+k6U9vEpa5zKx3uh4c
 nDOpuYahan4VusS5cqSf9GXpdKFLbT/dF4sME5ffIbxo+hhD5G1c0jiB04ayfkMOJDzh
 IeDn3XRq3eqoP2PeKQJuh6OnupNL0YYEbcJ8r0ala+AgLdmtbg5DhQteBZbR+JMddKlB
 wjZQ==
X-Gm-Message-State: AOAM530FFOuF6AqGc3ovGqNuW+6bndB2mniRHEA+Ay/Je4iH6dFHo/WG
 L3PfKFoYpS9eU1Yem9BrZTsqZQtqBEM=
X-Google-Smtp-Source: ABdhPJysuJ6L4JKcUOYolfIwRee6d1s81v/C6ePXJFf0Sq6GaTVu7c8vaA1NBwN/n59ttkTcBQnxtw==
X-Received: by 2002:a5d:4a04:: with SMTP id m4mr23727222wrq.153.1591015408543; 
 Mon, 01 Jun 2020 05:43:28 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id n23sm10948474wmc.0.2020.06.01.05.43.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2020 05:43:28 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/6] hw/mips: Add CPU IRQ3 delivery for KVM
Date: Mon,  1 Jun 2020 14:43:22 +0200
Message-Id: <1591015405-19651-4-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591015405-19651-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591015405-19651-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Huacai Chen <zltjiangshi@gmail.com>

Currently, KVM/MIPS only deliver I/O interrupt via IP2, this patch add
IP3 delivery as well, because Loongson-3 based machine use both IRQ2
(CPU's IP2) and IRQ3 (CPU's IP3).

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <1588501221-1205-4-git-send-email-chenhc@lemote.com>
---
 hw/mips/mips_int.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index 4a1bf84..0f9c6f0 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -51,7 +51,7 @@ static void cpu_mips_irq_request(void *opaque, int irq, int level)
         env->CP0_Cause &= ~(1 << (irq + CP0Ca_IP));
     }
 
-    if (kvm_enabled() && irq == 2) {
+    if (kvm_enabled() && (irq == 2 || irq == 3)) {
         kvm_mips_set_interrupt(cpu, irq, level);
     }
 
-- 
2.7.4


