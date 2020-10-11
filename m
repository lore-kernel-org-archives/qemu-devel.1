Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B134C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:04:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C7842078A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnqfCER2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7842078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRgdu-0003y4-AD
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 15:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRgd8-0003Rn-8z; Sun, 11 Oct 2020 15:03:38 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRgd6-0003gG-M9; Sun, 11 Oct 2020 15:03:37 -0400
Received: by mail-wm1-x344.google.com with SMTP id d81so15172682wmc.1;
 Sun, 11 Oct 2020 12:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gco4YRR45nuH6XpEMRUFQ155EIRVvfJb2Vz7xg/mTBI=;
 b=jnqfCER2SMbbh7QNuaSSSlXzdYrlGU+kKN+pXuJUsiCkAqFX0fAC4ICZV94hdYTH7k
 JIw/0qeiqy/JE5f/PBPTlIDaQmJ4IrXd+6d2dQlPNsvqZ0I3o6XdYsAz+taFTyt1+Zzd
 +5lPraLwnbo4s198UGa9nqQlteYLzF++Yq4SOFbzECe667zyZxtTU7N2Y0FUvLFS0TY3
 +7f6oyPAd0enWKn+z1JYjIildJkZ/omM6NQg6Fy72l6e5M6H24vlJSyzMu3GdIJItfgp
 Khb00GYJCCADnIPAW4v88VoyskATp/y4HAtTbD9uzU1jdKCZPH0TJ+fzJ7WdOVR6CK+v
 s0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=gco4YRR45nuH6XpEMRUFQ155EIRVvfJb2Vz7xg/mTBI=;
 b=G55MNk3TqMNXM4cY3vy0QJIlx41mFkalbFbd5jTy2CWba6HePZqYsxIxU6fyo1a6LG
 bjubGIGjJBezDf6QL9wrDu01cyd2GD3lQW3Q8uOZg4jQAAw/lQyKdhDAazElJuXe7ZI1
 xIgtnXZNjvP2uPQ/4xAW2UeMHFd5Y+ue1nxGDq6yNh53IXFUY6OihiA0J1g0Y3eGOw7j
 vCO0kXbAkq5JykRjX3z0PwQ2w2yZZZBomvXzEmsfyoEuxGCHoy66WfAHMLqHOn6rnAFu
 KeyRcu4jKWB8in/sJEdEk+5FuQXCyP1pOGauZsB2/EW3PQ04BX6BBPZ9X1DmvmtpW7HA
 k6fg==
X-Gm-Message-State: AOAM53003Rej6VV0lm7Gl4RgHxKtqWYXNHZlamkL7WEE4RT22RrCbzJn
 wxPzS1Vjp0kCyHTJuf9DhKxI2VpQnvo=
X-Google-Smtp-Source: ABdhPJyWjIjyBHiz/my7Jc51ZC0lIv9DNchonPTQzSRjwoIFUe6NRYTa9J1XJrmJN8Hh2DkLGAa4dA==
X-Received: by 2002:a1c:1f87:: with SMTP id f129mr7911564wmf.182.1602443014144; 
 Sun, 11 Oct 2020 12:03:34 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 205sm6296620wme.38.2020.10.11.12.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2020 12:03:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/pci-host/grackle: Verify PIC link is properly set
Date: Sun, 11 Oct 2020 21:03:32 +0200
Message-Id: <20201011190332.3189611-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Grackle PCI host model expects the interrupt controller
being set, but does not verify it is present. Add a check to
help developers using this model.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/grackle.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 57c29b20afb..20361d215ca 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -76,6 +76,10 @@ static void grackle_realize(DeviceState *dev, Error **errp)
     GrackleState *s = GRACKLE_PCI_HOST_BRIDGE(dev);
     PCIHostState *phb = PCI_HOST_BRIDGE(dev);
 
+    if (!s->pic) {
+        error_setg(errp, TYPE_GRACKLE_PCI_HOST_BRIDGE ": 'pic' link not set");
+        return;
+    }
     phb->bus = pci_register_root_bus(dev, NULL,
                                      pci_grackle_set_irq,
                                      pci_grackle_map_irq,
-- 
2.26.2


