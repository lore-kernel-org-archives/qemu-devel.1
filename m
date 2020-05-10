Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FDDC38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3FB22080C
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 21:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPgszTLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FB22080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXtBO-0000hZ-Q9
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 17:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt53-0007OG-Dd
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:49 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:36224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXt51-00016a-Cv
 for qemu-devel@nongnu.org; Sun, 10 May 2020 17:01:48 -0400
Received: by mail-ej1-x643.google.com with SMTP id z5so5392807ejb.3
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 14:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gEArLcdVFbJa5wuXqVtjUOCd7tloprZST1TLvA6aPgg=;
 b=BPgszTLex8FCtSMffY6aAHz8T7k64zx3u6G1BEGSP3dYbD2FPuQ7t3OZZ+FkoeAe/V
 FCy9zmDdrkHmmw4wfWmr58RmfCqSN96Pq7mA1O+aGALRmA4oJwCvl+M96N3ZsMKSUzT7
 vviR01ddeiAEs4uzBmgVAulingKuuzTlgy1WaQOdCQJAtm4bqmM42vE/xQJPNSzJIpMR
 ON+dJCoQR5cyPdIJeuTjpib7y51T9lTbQrzEdGFQAZeytNP/bkFEy4yO34K46JukBY2e
 Z7zOEWDdLwUsg1/6lVsv7fDKeAW/+Yg/xaZde0RhjCV//PighnD0yIYsplXH0Nvb2Utj
 /SEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gEArLcdVFbJa5wuXqVtjUOCd7tloprZST1TLvA6aPgg=;
 b=fjzuSYaSDT2st7FgJU9yIDWLWsTRfQvtu3qX7LxVfIMmqFvJ7osEVlhwHFRlBBq4hJ
 bpoeFrzgIAygOJUqOIVWqmAi5HDh7M5FtPrzkx/Cg+gqI/BXVtOFeg+Wg7AaIvtF5hEb
 pDgjbt5eJYfFtgeNVcfO+w/NbWfFpiXrDPSjxHiy6KJLYN1OC5vDlc0NAL2lh1I1RgYd
 XhbCTFwLdqevWQ9VedwGIEFykofhBsSKH1r03jnsD0AFehdViR/qwsoO9Jsd1jqKDzNo
 mua5EZGbkV09M0uUfJd/lLMjBhrSl024OOUtha4KWgmorMvFTiWp8FdJCSy8psJIexCh
 wWFA==
X-Gm-Message-State: AGi0Pub/aKai5SKyZpAVTT8teRYVcR//cn144cZ15oI6vjlD/pb+NcZT
 xCjgl8PdgGEQCQagWYifHjyeGu78wao=
X-Google-Smtp-Source: APiQypI8vAWsC49U84xRyk7hrGOMA3Ca9DpvjVKp5L0Ublw06S+z/eMkLROJOpJhfM9yYWSlXUNKPw==
X-Received: by 2002:a17:906:3952:: with SMTP id
 g18mr10982023eje.191.1589144505540; 
 Sun, 10 May 2020 14:01:45 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id d15sm921152ejr.50.2020.05.10.14.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 14:01:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/12] hw/pci-host/bonito: Map peripheral using physical
 address
Date: Sun, 10 May 2020 23:01:23 +0200
Message-Id: <20200510210128.18343-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200510210128.18343-1-f4bug@amsat.org>
References: <20200510210128.18343-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peripherals are mapped at physical address on busses.
Only CPU/IOMMU can use virtual addresses.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/bonito.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 10ead31e4f..7ed462ffb5 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -647,12 +647,12 @@ static void bonito_realize(PCIDevice *dev, Error **errp)
     memory_region_init_io(&s->iomem_ldma, OBJECT(s), &bonito_ldma_ops, s,
                           "ldma", 0x100);
     sysbus_init_mmio(sysbus, &s->iomem_ldma);
-    sysbus_mmio_map(sysbus, 3, 0xbfe00200);
+    sysbus_mmio_map(sysbus, 3, 0x1fe00200);
 
     memory_region_init_io(&s->iomem_cop, OBJECT(s), &bonito_cop_ops, s,
                           "cop", 0x100);
     sysbus_init_mmio(sysbus, &s->iomem_cop);
-    sysbus_mmio_map(sysbus, 4, 0xbfe00300);
+    sysbus_mmio_map(sysbus, 4, 0x1fe00300);
 
     /* Map PCI IO Space  0x1fd0 0000 - 0x1fd1 0000 */
     memory_region_init_alias(&s->bonito_pciio, OBJECT(s), "isa_mmio",
-- 
2.21.3


