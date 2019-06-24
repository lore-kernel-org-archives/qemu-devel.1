Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88154C4646B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5331120663
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzqZ8ohJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5331120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54958 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfXDw-0001iC-HA
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 18:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54801)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX23-0007q4-J5
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX20-0003v2-Ta
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:46 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45418)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX1w-00036b-4x
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:42 -0400
Received: by mail-wr1-x443.google.com with SMTP id f9so15473525wre.12
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 15:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N2yUkYsSR8v9ROfwrGSPlP7dTQtRzCezFC3jdcl89BQ=;
 b=LzqZ8ohJ4FjorLBmMCHMNPYFVgcXfUlIi7wmOkKcP5nRRhWZoBgfIkWpT+SWtjX18+
 qhN4Q07RWHad1o9eyo5RH1d635AwL5DBWI8I5AmE+6CYAvglV1W1+hq94n24Rzw84A+M
 LApDZhOz56XhMqSOwBdKs9B6OJPGYSY/wz7+PvmkN4J0G9TMP7rEk6/YIyhMxF+Cs/jn
 bSf9RC+xiWvJ5sgKlG2ZXWLVa6CiCZ7B9f+dXN8ofl+dZjcElw+vS8DlDKFd22pNOUAV
 iF5QIZ1rOPvJ90BTLksJChc8ejg3dnjWws8vwiopTksJGjjA1o93wLS48xja/fzleJxo
 5YJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=N2yUkYsSR8v9ROfwrGSPlP7dTQtRzCezFC3jdcl89BQ=;
 b=J45iGsdxse4gb5anPaMeeu8JRu3DkDfgKJ62pODosesR8MV6wHBec9hsMNkjRYI05z
 waB4OxyqmBa1DHmUlxqy5SxWO9/oXd+JBwlKN2lbTDDf1gtrBzZoNbCayLntMG6wZgg6
 wPsN8/t312sUj0ZvqaV0AEvOR7RBQb58CL9CwK/iKPyb+8bvDzDMwlHTv1VVechQoiYU
 MCCc1013mQ9L82II4CAOX6TCb3x6OMHs5ujUelHbBRUGFhFjAwc2g2W7QVgp3W25ipdy
 voJ6gatbTcPT2sMFEOVZx6DXCZ+z0nP/jRlNfws4qN1fUT8um7FA14/FP48sUu6Qr7d1
 HqMA==
X-Gm-Message-State: APjAAAVV1eeK03qXB7S5+TZU/vgyyvVOQ/JbVYXMbqG3SLx9Zdl25iwV
 Iq1mcekBlDqUG7m1fzD5+ZQjgLx4
X-Google-Smtp-Source: APXvYqywH8/SFWYxb+o2WegSQa3p/IKLWnUCHoAMhCuofraffqRJq4ui95X2NVozpyt587tccqWNZA==
X-Received: by 2002:adf:b605:: with SMTP id f5mr55222878wre.305.1561413665653; 
 Mon, 24 Jun 2019 15:01:05 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id z126sm1118612wmb.32.2019.06.24.15.01.04
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 15:01:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 00:00:52 +0200
Message-Id: <20190624220056.25861-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190624220056.25861-1-f4bug@amsat.org>
References: <20190624220056.25861-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 5/9] hw/misc/empty_slot: Add a qdev property
 'name'
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
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If few commits empty_slot_init() will take 'name' as argument.
Meanwhile, initialize it as 'empty-slot'.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/empty_slot.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/misc/empty_slot.c b/hw/misc/empty_slot.c
index ef0a7b99ba..c32241a9e5 100644
--- a/hw/misc/empty_slot.c
+++ b/hw/misc/empty_slot.c
@@ -32,6 +32,7 @@ typedef struct EmptySlot {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
+    char *name;
     uint64_t size;
 } EmptySlot;
 
@@ -78,14 +79,18 @@ static void empty_slot_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "property 'size' not specified or zero");
         return;
     }
+    if (s->name == NULL) {
+        s->name = g_strdup("empty-slot");
+    }
 
     memory_region_init_io(&s->iomem, OBJECT(s), &empty_slot_ops, s,
-                          "empty-slot", s->size);
+                          s->name, s->size);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 }
 
 static Property empty_slot_properties[] = {
     DEFINE_PROP_UINT64("size", EmptySlot, size, 0),
+    DEFINE_PROP_STRING("name", EmptySlot, name),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.19.1


