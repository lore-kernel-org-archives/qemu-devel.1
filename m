Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD396C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76934218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SziYyjow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76934218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZYI-0004Nd-Kq
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0L-0003hN-Gd
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0H-0003ZP-CB
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:01 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:39218)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z0H-0003YQ-4f
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:57 -0500
Received: by mail-wm1-x331.google.com with SMTP id c84so2883249wme.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z+oRtC/n9wy+AzsoNa8bIYoHlANn/uzBMWqr8FqYh4M=;
 b=SziYyjow/o0i4p2vup4j7busEqX07uiymHOG3oIS9Pbq5sb5ILq9VaYpTiYsj9sMFC
 CRyl7e6Geq11nvX+InybCY9L9r8Ue8ODnuJRcxPuuO4LLG7LxYUyts60vscBSYUYy3st
 qKxWlKnTzEHRQkaojt41jrvmeMtOPtCzcCa+pWZVVgrQk4QaKFEsisFhrCwLqCrZNjNf
 Uk/cxYyc5D7j4RTstW2ism1/11Tl0jzfhoUcZ2GTvMhw3oomRsMGR6KWrYMh7esBpqZK
 8cx+omiP3wsT0BkJniu1YzjO6g+BQTjR4A5oVjVTf0pv6VO4+EMvYMlhbvFqnZUIl6/q
 VHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=z+oRtC/n9wy+AzsoNa8bIYoHlANn/uzBMWqr8FqYh4M=;
 b=Z1OHxUoQ93j2pjRBxNcNiAN6P5zgu58abkH3KPpLeRXEvGYuZnfktd+giD7S145k5o
 GcaNP5Th/NmxahG9G4qfu1OFdjFDh1pqP5XUF7EeLlZLo7g/PEFF09vOpVPBQ+VZ+ho4
 yqpbPTdjxEaBQ7yxHx64w4VArBkYPSmA56cDMTdtcP2kUDkwP0mjXa7LoRm4tF52gaOd
 HmNYM8DIKU4knxf6d8BY2M+CzBZLqdqjGzslmH34dY7yoiEumA9GO445AYmBP2W1Noqw
 AJnIY6C0Ch9Ak+INYxiEcsK6AEr4zSqwhOuZx81QTHraeflNBAxjkUjrb5VFToyXX3vd
 TSzA==
X-Gm-Message-State: APjAAAUmpSyqse2XaDJq2LktkutHf8Xksv4mtcNSFBMKA0sU0UbjMM0d
 KIzkOlu1y6PAImYpLDLiVlGTaknK
X-Google-Smtp-Source: APXvYqwIwW5slrriXg2+JRSHLxDrWvCBMyfS8Vg9mVNLfeyeO2a7RfKHmSs1R51Cl3gKGFzRqmj0ZQ==
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr4885751wmk.131.1582632475620; 
 Tue, 25 Feb 2020 04:07:55 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.07.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:07:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 122/136] hw/char: Let devices own the MemoryRegion they create
Date: Tue, 25 Feb 2020 13:07:20 +0100
Message-Id: <1582632454-16491-20-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Avoid orphan memory regions being added in the /unattached QOM
container.

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-25-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 hw/char/serial.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 9298881..2ab8b69 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -997,7 +997,7 @@ static void serial_io_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    memory_region_init_io(&s->io, NULL, &serial_io_ops, s, "serial", 8);
+    memory_region_init_io(&s->io, OBJECT(dev), &serial_io_ops, s, "serial", 8);
     sysbus_init_mmio(SYS_BUS_DEVICE(sio), &s->io);
     sysbus_init_irq(SYS_BUS_DEVICE(sio), &s->irq);
 }
@@ -1106,8 +1106,9 @@ static void serial_mm_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    memory_region_init_io(&s->io, NULL, &serial_mm_ops[smm->endianness], smm,
-                          "serial", 8 << smm->regshift);
+    memory_region_init_io(&s->io, OBJECT(dev),
+                          &serial_mm_ops[smm->endianness], smm, "serial",
+                          8 << smm->regshift);
     sysbus_init_mmio(SYS_BUS_DEVICE(smm), &s->io);
     sysbus_init_irq(SYS_BUS_DEVICE(smm), &smm->serial.irq);
 }
-- 
1.8.3.1



