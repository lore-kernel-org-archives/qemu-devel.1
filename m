Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E879C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 01:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD02D207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 01:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaB32+NQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD02D207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwEpl-0005wN-3O
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 21:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jwEpB-0005Xb-Gj
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 21:06:05 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45269)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jwEp8-0004Yf-Di
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 21:06:05 -0400
Received: by mail-pf1-x444.google.com with SMTP id z3so4548276pfn.12
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 18:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=m2hDaWTugTlRwftfxzR404gSH/pGnw7yw+DdJofwF0I=;
 b=UaB32+NQPRJXHWlXgDifXOdIFYC3QZBgCwBqCZmGsmY9fbi4ZEzpJ4YaP+36jWgoDf
 s8iSMShF49xBaVtJ80Qu3cM7651qE6ctseUkreEgSz73Ifjk4Pj+BnJLDjpk/v8hQqQ5
 mL63MiLGwB3dlVKCCMI5oGS+QIHMunBuCY2ruQ0cCD4+C1NfIsk1uCagsyIGDYy1qsNv
 o5vd+NqHYuk2/xNlbeDFluELWocHMIekeH3GIEA/Rbo9cDTNdkAGtKL+M49DfLwy5uwL
 fIL4hvuR//0zdQq7CLlgAW1gHGx0fNNFLHcqpjAHq45IwJC/c/VFGAZ4ymGDniOtEZOo
 OheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=m2hDaWTugTlRwftfxzR404gSH/pGnw7yw+DdJofwF0I=;
 b=S4xGIIxzCVhi3QACc2Wl97G6Kyj21d7nprq/+NitduvLNi5wAAVCa/p1ZkJ2JCQtic
 nSOmN1TTmWE228wTk8b+Jwe/0x96NIUdBr9ue/7n/bff0cXKXZuuPTO/712CQ/KQmpoE
 /vOe6zjiFT/xhiCwVDtEZJPq6vbMPKyDbyg7OVA86y/25ZLHZ8a3wMjONuaVQ3qdss6i
 HplWbDJ6LzajSycukm1Qc2eT9De0GtfdXw4CtTJYVE/y/StO/xtl3/c776S5G6ti9w6t
 sz5jYSbdtWQKd6Ug0hzaKPvi0rNl/BxngEOvW71ULn08K2CcaDYOZV61Ah9GPKjsv9xK
 KGaQ==
X-Gm-Message-State: AOAM530zbRhIi8fk/nGTuDiwheLmb8adBbDUyrDZW2bK38egfTD8swOO
 YyxrTd3TeH06nhnbd8FToiY=
X-Google-Smtp-Source: ABdhPJxNQITZq+XbmVzHbh1F4emUFin3vfCyHepze5ZdxOXWGfqV5xK+xpGpi6C3tH2K3rVyevDGRw==
X-Received: by 2002:a63:525a:: with SMTP id s26mr6381553pgl.155.1594947960348; 
 Thu, 16 Jul 2020 18:06:00 -0700 (PDT)
Received: from localhost.localdomain ([75.167.235.8])
 by smtp.gmail.com with ESMTPSA id l126sm5975016pfd.202.2020.07.16.18.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 18:05:59 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] usb: only build hcd-dwc2 host controller for RASPI target
Date: Thu, 16 Jul 2020 18:05:48 -0700
Message-Id: <20200717010548.9902-1-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=pauldzim@gmail.com; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paul Zimmerman <pauldzim@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The hcd-dwc2 host controller is currently built for all targets.
Since for now hcd-dwc2 is only implemented on RASPI, restrict its
build to that target only.

Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
---

Hi Gerd,

Do we want to apply this before the 5.1.0 release? It seems a waste
to build this code for every target when it's only used on one.
Sorry I didn't realize this earlier.

Thanks,
Paul

 hw/arm/Kconfig | 1 +
 hw/usb/Kconfig | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4a224a6351..bc3a423940 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -315,6 +315,7 @@ config RASPI
     select FRAMEBUFFER
     select PL011 # UART
     select SDHCI
+    select USB_DWC2
 
 config STM32F205_SOC
     bool
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index d4d8c37c28..5e63dc75f8 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -48,7 +48,6 @@ config USB_MUSB
 
 config USB_DWC2
     bool
-    default y
     select USB
 
 config TUSB6010
-- 
2.17.1


