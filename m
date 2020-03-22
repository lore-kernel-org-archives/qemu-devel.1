Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F67EC54EEB
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 20:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 598E02072D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 20:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fL99Mj4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598E02072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG7dD-0002mk-H7
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 16:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jG7cN-0001Tg-O1
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 16:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jG7cM-00017y-N0
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 16:54:47 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38132)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jG7cM-00017c-F5; Sun, 22 Mar 2020 16:54:46 -0400
Received: by mail-wr1-x443.google.com with SMTP id s1so14434449wrv.5;
 Sun, 22 Mar 2020 13:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=b+iEG6NgD+qJY3iETm1Vxe+CjvjfGQQXFzkKx5oalXs=;
 b=fL99Mj4itHablf4yOqJowsf9KdMGkIcmSWuqgDR3gmi3BdOYcb66f30IAKjdK93A5+
 IUmA5FxiZ36oj1t51P76lQSGJn2kFRovvTg0Vn4hqEjiMqedoSt95RLE8Lx8JdAYlAvR
 MjnDdxGq7rCUW1QImwj0NwXwyygsN8kRO6xMnJit16m4YAIrTMUPMQeH3DoxOoXXw9Ir
 6iFXsySjeY8lvMtKdphbuDvzmvIxj0vIr+NLVqSe6+O90uET+Zll8wxpH9oPoft+XU9K
 960/FvqjzU2Rf9zPhC/s6u445CN4muGvFmyloqPm/1PCa6qqrYL5yF5KO/iC4c0vL1nr
 /Esg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=b+iEG6NgD+qJY3iETm1Vxe+CjvjfGQQXFzkKx5oalXs=;
 b=R/ALg+xXB9msm8Gzcvydunan3Kv/ynybZmUKzwzt7lKMX0ZL9UEL1Bs/enisTuGEpU
 Lsi7OQN9noe0wTgTwz8NUzcgveVx+kFgLeqMD2ZvrS/HNCtaG1LbrNh3dCJD3ayrGyHH
 wEyI6a5MmONa8bFhqQV816ZN6vIvm8e4oD1kquVL4pz53s34zEsASHZT8uZnoR/qLnxT
 alBPSeOy50JqtIFx+kX6HSiMZDTdUpYifmhMQ2xszE6xEJbObccTF9+hhuYvWyuW7x7w
 3Lrr5z+Pt0bM4bxESNGmkF+lCWipwp9NhbrDn+5PeoNpnsJ3LD6HAdfB0d8QLP1/SJac
 rKkQ==
X-Gm-Message-State: ANhLgQ37WOUq2s4AxZ2dLxwRS9WOQWOZMPx7bSz3lnQ5TpwzSi97D/XG
 ou54Y7XRAcKoH/RvNV7iQrSAP1C+
X-Google-Smtp-Source: ADFU+vvSWMM/f+/rGtKAaYxszqy2hysaJoO+UGJa2Fy9CwjuUOzKBfyQdsfYq12El773n9KKfQ6OzQ==
X-Received: by 2002:adf:dd86:: with SMTP id x6mr19047071wrl.169.1584910485010; 
 Sun, 22 Mar 2020 13:54:45 -0700 (PDT)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id w7sm21083875wrr.60.2020.03.22.13.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2020 13:54:44 -0700 (PDT)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/arm/orangepi: check for potential NULL pointer when
 calling blk_is_available
Date: Sun, 22 Mar 2020 21:54:38 +0100
Message-Id: <20200322205439.15231-1-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: peter.maydell@linaro.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Orange Pi PC initialization function needs to verify that the SD card
block backend is usable before calling the Boot ROM setup routine. When
calling blk_is_available() the input parameter should not be NULL.
This commit ensures that blk_is_available is only called with non-NULL input.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 hw/arm/orangepi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 181f5badab..a9f64c5680 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -104,7 +104,7 @@ static void orangepi_init(MachineState *machine)
                                 machine->ram);
 
     /* Load target kernel or start using BootROM */
-    if (!machine->kernel_filename && blk_is_available(blk)) {
+    if (!machine->kernel_filename && blk && blk_is_available(blk)) {
         /* Use Boot ROM to copy data from SD card to SRAM */
         allwinner_h3_bootrom_setup(h3, blk);
     }
-- 
2.17.1


