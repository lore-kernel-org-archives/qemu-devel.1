Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6E6C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 07:21:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A18C720790
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 07:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/LyL0de"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18C720790
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRs8t-0005ub-Ml
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 03:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRs77-0004JY-Nj; Mon, 12 Oct 2020 03:19:21 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50237)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRs76-0007kf-66; Mon, 12 Oct 2020 03:19:21 -0400
Received: by mail-wm1-x341.google.com with SMTP id 13so16257243wmf.0;
 Mon, 12 Oct 2020 00:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=prE09q32YD42ye5PeFp5wgpW0hirQThD2Ei+DC4S6LM=;
 b=e/LyL0deoDjKJ5DmtoHS2Tl8PTMDBMjgD4tbM8Y1MGo6wVAYsDZnQmk1I3W2R5VLbe
 VwrLQHBotPCBVLHMeNwgtOLM0C47DGnNHKiVbiq3M55b00yd8kySvPyuXOMGe4Qx5NP5
 6tCATx4KCo7SvZdb0uXL8pTnV29QhSFULyX9wlshb1lWXGLgmNW7u2Q1nq/4v8Aatpbl
 knlMysnqhrJFGA9gI9E7DvXg6zQsvh21dAfsgwEZqSQTCtWXBSCLYxsVf1A8s82FS2Co
 QUtynV96f3qR5KW0kPKlgSOzz4bCGSzSAo1CPQ1n5BB56pADSu1NL6Z6gvFlURJtnsp7
 4oUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=prE09q32YD42ye5PeFp5wgpW0hirQThD2Ei+DC4S6LM=;
 b=N6JUzLKU1rsTiUcUshC+5nuBZyD7QkN4E1MmmYpufBCz7+bdZLxBPBewW+wsJHNGzf
 VOW2M5kSquOeeb/Z5UjIFYfYu4lc4ymTqiRAGclkgPgTRvlbKTgkhOwMUiwQcygVX4e6
 dJQdYW4+aUoYDaB0BNd8eLLrR/hC1iWBEX2dexK9cQBsMKwI9i7sJmEr6TC3FG2pPClX
 4gSw0kNMTsKQUMt4NSPYfyy208fAth0q5xlUJPstofNFXTYVQdSDRoSIj4jx9eVjSnG1
 vTjTrqRfLpH4cn2/5vfX2apuuIF5TjJwD+mtQpZeBp9FZXwpJOcgF+aHQBlwXJG/CZ9c
 S9ag==
X-Gm-Message-State: AOAM530KzO4fJlo2nq5jOvCI15uLs4E0mD2oUZ4YunqUgI0QYxKG1s17
 w8GELeEJao2DLgmIBTL6b+Hdpx3O28s=
X-Google-Smtp-Source: ABdhPJy61sTR4ko9asU1VmmS8JjOErOGh2Q9ze45Be5RN1ru14PYI68qUpvioV5DZUa5xQVcXoaAvg==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr9216349wmh.94.1602487157626;
 Mon, 12 Oct 2020 00:19:17 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 205sm8020285wme.38.2020.10.12.00.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 00:19:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] hw/pci-host/prep: Remove legacy PReP machine temporary
 workaround
Date: Mon, 12 Oct 2020 09:19:04 +0200
Message-Id: <20201012071906.3301481-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012071906.3301481-1-f4bug@amsat.org>
References: <20201012071906.3301481-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The legacy PReP machine has been removed in commit b2ce76a0730
("hw/ppc/prep: Remove the deprecated "prep" machine and the
OpenHackware BIOS"). This temporary workaround is no more
required, remove it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/prep.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 80dfb67da43..064593d1e52 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -75,7 +75,6 @@ struct PRePPCIState {
     RavenPCIState pci_dev;
 
     int contiguous_map;
-    bool is_legacy_prep;
 };
 
 #define BIOS_SIZE (1 * MiB)
@@ -229,24 +228,18 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
     MemoryRegion *address_space_mem = get_system_memory();
     int i;
 
-    if (s->is_legacy_prep) {
-        for (i = 0; i < PCI_NUM_PINS; i++) {
-            sysbus_init_irq(dev, &s->pci_irqs[i]);
-        }
-    } else {
-        /*
-         * According to PReP specification section 6.1.6 "System Interrupt
-         * Assignments", all PCI interrupts are routed via IRQ 15
-         */
-        s->or_irq = OR_IRQ(object_new(TYPE_OR_IRQ));
-        object_property_set_int(OBJECT(s->or_irq), "num-lines", PCI_NUM_PINS,
-                                &error_fatal);
-        qdev_realize(DEVICE(s->or_irq), NULL, &error_fatal);
-        sysbus_init_irq(dev, &s->or_irq->out_irq);
+    /*
+     * According to PReP specification section 6.1.6 "System Interrupt
+     * Assignments", all PCI interrupts are routed via IRQ 15.
+     */
+    s->or_irq = OR_IRQ(object_new(TYPE_OR_IRQ));
+    object_property_set_int(OBJECT(s->or_irq), "num-lines", PCI_NUM_PINS,
+                            &error_fatal);
+    qdev_realize(DEVICE(s->or_irq), NULL, &error_fatal);
+    sysbus_init_irq(dev, &s->or_irq->out_irq);
 
-        for (i = 0; i < PCI_NUM_PINS; i++) {
-            s->pci_irqs[i] = qdev_get_gpio_in(DEVICE(s->or_irq), i);
-        }
+    for (i = 0; i < PCI_NUM_PINS; i++) {
+        s->pci_irqs[i] = qdev_get_gpio_in(DEVICE(s->or_irq), i);
     }
 
     qdev_init_gpio_in(d, raven_change_gpio, 1);
@@ -403,9 +396,6 @@ static Property raven_pcihost_properties[] = {
     DEFINE_PROP_UINT32("elf-machine", PREPPCIState, pci_dev.elf_machine,
                        EM_NONE),
     DEFINE_PROP_STRING("bios-name", PREPPCIState, pci_dev.bios_name),
-    /* Temporary workaround until legacy prep machine is removed */
-    DEFINE_PROP_BOOL("is-legacy-prep", PREPPCIState, is_legacy_prep,
-                     false),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.26.2


