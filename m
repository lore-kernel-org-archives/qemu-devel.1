Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF300C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5929F207E8
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQFofk8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5929F207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWQN2-000135-BH
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 16:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWQJm-0006XF-IG
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 16:39:14 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWQJl-00051t-0I
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 16:39:14 -0400
Received: by mail-wr1-x444.google.com with SMTP id t9so7027713wrq.11
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 13:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O2N2/d0FuVeTzYloBRKESNbHdxTyhZq/QZiQfgl/lns=;
 b=SQFofk8flRaBfN80uPi6vdIphCEzKY9C51BuiVLbhzJBnV5gANKTU7hcuvwk0Eq+tO
 WkplijFVd21BZRq1w/izhZmkhcrCbnxrTEhaA9N8z7xF0o8v/ikc4miUmO/OvNKO7Qif
 WikNZehWTNrozf+Wz+Ht3xk8TqWgJO93QagU8JXnm9nZ7FzJ5AChtJpBw59NCvuzvlfn
 SfUfuDf01d1nVEzx8/AJr/dJ5iCrrhEZIXvRz3XP84/SxMa7kkGWwnYQMXnVpgBQton+
 mSjLMt6ce+ox3yNDZl8NVmD2MQLUemPcvZTVESKsn28+cssVphzs5MLXwbyXqHGYwE1I
 QVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=O2N2/d0FuVeTzYloBRKESNbHdxTyhZq/QZiQfgl/lns=;
 b=Tk3rAgnGtiQnPPattLyLoEDn97GweQ37uAevMc0RpMqx6Fo3br88v4Hni6+VTbBjJ5
 P7UVNX5LYYyiETKtB9umDvQHqr4A30F9iFWzzv5e8wxX+LKpe5mWk8lWnzhrY24wvROE
 V77JGfx2ZicPq2ldLzqsNG4fmU+mxchQErRsuQNnewu52+rjV79m+DAAHRCf2GLdsW0s
 bNjcz7tFeTmu2Ec5J58i7F+1q4pf4tVuCtODdpNUrttXEj1W+o8yFRxB8Tz56Cqrtvzs
 GzQ2uKweSZUE/CkSMFL854h1hf9/RQcSswuqMwdpmz/8XDe8LAewBBKFAvro9h0Z238h
 sTLg==
X-Gm-Message-State: AOAM532AaG7ooyaGEAHGqiuWNpaFk0bsBub/MDhL96OTJmbk0FaW3F2o
 E0noEyI4ZpOACSUISMY82gU=
X-Google-Smtp-Source: ABdhPJyspJXGEFtYODCcdSVxxF4rHzgNYDihEGm8s7tpnd7qKiD7sFkZy+ck+1yW8X11eggn1rWWAg==
X-Received: by 2002:adf:bb43:: with SMTP id x3mr9312595wrg.250.1603571951739; 
 Sat, 24 Oct 2020 13:39:11 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id r3sm13128413wrm.51.2020.10.24.13.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2020 13:39:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] pci: Assert irqnum is between 0 and bus->nirqs in
 pci_bus_change_irq_level
Date: Sat, 24 Oct 2020 22:39:00 +0200
Message-Id: <20201024203900.3619498-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201024203900.3619498-1-f4bug@amsat.org>
References: <20201024203900.3619498-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

These assertions similar to those in the adjacent pci_bus_get_irq_level()
function ensure that irqnum lies within the valid PCI bus IRQ range.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20201011082022.3016-1-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 081ddcadd15..dc4019865be 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -250,6 +250,8 @@ static inline void pci_set_irq_state(PCIDevice *d, int irq_num, int level)
 
 static void pci_bus_change_irq_level(PCIBus *bus, int irq_num, int change)
 {
+    assert(irq_num >= 0);
+    assert(irq_num < bus->nirq);
     bus->irq_count[irq_num] += change;
     bus->set_irq(bus->irq_opaque, irq_num, bus->irq_count[irq_num] != 0);
 }
-- 
2.26.2


