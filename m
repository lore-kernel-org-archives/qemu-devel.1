Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB6AC55178
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 744D121D41
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnV4oB7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744D121D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWQLg-0007lh-Cv
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 16:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWQJi-0006O3-C0
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 16:39:10 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42280)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWQJg-00050R-Ro
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 16:39:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id j7so7025380wrt.9
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 13:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gjdx/sgpy/3BJT5WSuSXlsJvImMblnkYoqBwhpQoRMQ=;
 b=LnV4oB7LtbUJaxPjjzJ/CKkJv1MOjO9YDDQAjet1omseCbMHcaIfofm56RbXhU8/ZV
 BsGh+jOnzFMYlu+GUyHi8MadlDJxCQoRD8PhsGB4uAB+p+FsjmPOx7F19bo/PuSXS6ps
 74v+Kwn+MZwXZpJ/e7yMA0HyHZ8gGkDdfjzM56XJIwc14ukFDB7kOisWLnNtvIPjOi7l
 rWD9DGmqzCq2MUhsHueCS8gVFOgI4m8hJEbOJwwefiWb099IZBoFJA0LUo5WN+esjYqq
 7DmDg0neXRC4X4yNzKWu656YAuRrk7/i24QKRsVRhpI+IchvSdw5A3LIGJdL/HtECACU
 T6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gjdx/sgpy/3BJT5WSuSXlsJvImMblnkYoqBwhpQoRMQ=;
 b=WOs4khfngz/FB78Re6ywNxXbxGBhdvbkMxIU9eoVcztZD8suC+3i5UrneOPf5a497S
 n+nEKvvVlseLsgJoja8t7EebJsp3RkiwFvA4lqjl/OBs3Q66T64jBIurypYCfYpVFh6A
 ahgve3JA2EDWXH5383l/iIDuMjV6kufZ3r8G46rVDfhzek/9BmII4qVu0+tykyf0m7Zw
 yoLFexqNm+gDQKDYcUBL1XTinfoWbT1WEeJazNYTJB8CvQjVgoydbTz0n2kOrHmZlAsL
 PrVvtjxMfQyOaMIGJIIdGdPD+ygi06sxuin4VYjAia36BAaq0kAIXAgLxX9a2R/UbfmN
 XvUw==
X-Gm-Message-State: AOAM5339fkzLha7YjJjv1Y+XYCs0dPTxKZu9PEQ9t/KiSXDqWBXl5VdP
 a/NHILbqX4fEaCeBAP+6LSY=
X-Google-Smtp-Source: ABdhPJyPeurzuIyvDTkusYQoF4tcaNdC3+1aVgpb+zLtplHoEaureGXhjR/M/mjsw1BKC29ZKkb5QA==
X-Received: by 2002:a5d:4c4f:: with SMTP id n15mr9005485wrt.137.1603571947035; 
 Sat, 24 Oct 2020 13:39:07 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id s2sm13739240wmf.45.2020.10.24.13.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2020 13:39:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] hw/pci: Extract pci_bus_change_irq_level() from
 pci_change_irq_level()
Date: Sat, 24 Oct 2020 22:38:59 +0200
Message-Id: <20201024203900.3619498-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201024203900.3619498-1-f4bug@amsat.org>
References: <20201024203900.3619498-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extract pci_bus_change_irq_level() from pci_change_irq_level() to
make it clearer it operates on the bus.

Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 100c9381c2f..081ddcadd15 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -248,6 +248,12 @@ static inline void pci_set_irq_state(PCIDevice *d, int irq_num, int level)
         d->irq_state |= level << irq_num;
 }
 
+static void pci_bus_change_irq_level(PCIBus *bus, int irq_num, int change)
+{
+    bus->irq_count[irq_num] += change;
+    bus->set_irq(bus->irq_opaque, irq_num, bus->irq_count[irq_num] != 0);
+}
+
 static void pci_change_irq_level(PCIDevice *pci_dev, int irq_num, int change)
 {
     PCIBus *bus;
@@ -258,8 +264,7 @@ static void pci_change_irq_level(PCIDevice *pci_dev, int irq_num, int change)
             break;
         pci_dev = bus->parent_dev;
     }
-    bus->irq_count[irq_num] += change;
-    bus->set_irq(bus->irq_opaque, irq_num, bus->irq_count[irq_num] != 0);
+    pci_bus_change_irq_level(bus, irq_num, change);
 }
 
 int pci_bus_get_irq_level(PCIBus *bus, int irq_num)
-- 
2.26.2


