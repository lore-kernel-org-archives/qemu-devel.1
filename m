Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B751C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EC6A2073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDsi1I0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC6A2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdT81-0002ai-IT
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 02:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSzZ-00074g-Sa; Tue, 26 May 2020 02:23:13 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSzZ-0002Ux-3r; Tue, 26 May 2020 02:23:13 -0400
Received: by mail-wr1-x441.google.com with SMTP id j16so6751382wrb.7;
 Mon, 25 May 2020 23:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T2fFw/3ecGdUBJpHTI/rjWpVW7MRtnqzt7F58rWYdgA=;
 b=cDsi1I0yUC8EPuAw+OuEzzF0OrA56wIYloZrYfN3Mu626tQCvkYC4nUuFHkaJ4MCV+
 IIiiFu6Tv2Xdbnvesj3JxOEfx2/Zsoj2lEme0Gh4+hk+VbZJSiRrjPocQxm0sqk60aaQ
 pJ8smH0j97zQrgscQeHsRJ3klrbZwhYCbmXYxX1Vw8lU6P0JC9rtLZTxKcYT57usJjvg
 VRgZNt4IJNx3PmhJzigCo9cRD9B6DzIRZRGUk0eMm8tJAMeltfCGNKCVFSbv6+farAHr
 5aZ48f/bWfbfJYxR1UBO4P/6MfoDG6xgeZ8JLCf63QxStgL+BvsgPakbPB4X4AZKPllJ
 3CUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=T2fFw/3ecGdUBJpHTI/rjWpVW7MRtnqzt7F58rWYdgA=;
 b=UQPGOTF975+6ZDzt8pNo/NjLlODt5b6ZUlngvxvsfIs6OUsXK6hrPddjqTvFtJ7Y1J
 OmzJyAYQaB5bXQQ7M6DnwXjDLdIGCeiCJQ7hitD2e9H0LjoSAT1S51dXO+Dv1uraBzgB
 t0gZ2jxKpeJpKRn+pL6X7dW5CCOnGj48wnQnyvncSP5n5/e7zF8HDoX4SX2fXzyoaeJX
 UTKWBxV31YuyfYMA0AenEzpOZOZMRA2kffSbFmMU2gDGO0EzCRpex/2NF7mKCDn/SDxt
 Eat1xPsGuTSLoQNqYl72Wk63SR9tNJKCHYjkc4+faexw0aGrWfM+LHj6PHHfGVYCP7dK
 ReLQ==
X-Gm-Message-State: AOAM532qsz0iVfxpaIgOI0Nf4gxDdyLFLdZvutxpJHWactJvmhDC5st7
 G2qeT455uSJiiqpb57GzSrU=
X-Google-Smtp-Source: ABdhPJz8ghzcg+M9qFGETi2kDN84YG6gkwryvq3ETq74bJY5MIf9N9sfJHo3OlramgCA7Ix3w5UWTw==
X-Received: by 2002:adf:edc8:: with SMTP id v8mr5552424wro.176.1590474191169; 
 Mon, 25 May 2020 23:23:11 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id a16sm5764745wrx.8.2020.05.25.23.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 23:23:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 11/14] hw/display/vmware_vga: Let the PCI device own its I/O
 MemoryRegion
Date: Tue, 26 May 2020 08:22:49 +0200
Message-Id: <20200526062252.19852-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526062252.19852-1-f4bug@amsat.org>
References: <20200526062252.19852-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To avoid the orphan I/O memory region being added in the /unattached
QOM container, register the PCI device as its owner.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
RFC: This might break migration
---
 hw/display/vmware_vga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 5c0fc49d9d..2579f6b218 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1306,7 +1306,7 @@ static void pci_vmsvga_realize(PCIDevice *dev, Error **errp)
     dev->config[PCI_LATENCY_TIMER] = 0x40;
     dev->config[PCI_INTERRUPT_LINE] = 0xff;          /* End */
 
-    memory_region_init_io(&s->io_bar, NULL, &vmsvga_io_ops, &s->chip,
+    memory_region_init_io(&s->io_bar, OBJECT(dev), &vmsvga_io_ops, &s->chip,
                           "vmsvga-io", 0x10);
     memory_region_set_flush_coalesced(&s->io_bar);
     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io_bar);
-- 
2.21.3


