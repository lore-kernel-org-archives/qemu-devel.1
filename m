Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8C2C35657
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A887222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgOuHREf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A887222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5CCV-00027r-Ey
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 12:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j5C8m-00064G-6G
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:31:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j5C8k-0007xw-N6
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:31:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20533
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j5C8k-0007xP-Ig
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582306261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zf2WsS+Rv67/jMvGBPvIRKzoIHeTqtx2fA55QRMOVeM=;
 b=QgOuHREf8xHII39mOydHZCcwrPCfrOCaFk90n6wNj2+wHkiow85D4zT8ml5E53bRLIAm3x
 cP/VmCPFNrMFO9oQ64Kq3t2Haa1b1Lcx3HBrdaueBVXbxMvvPGPkYE/7PGzz4S79BQOHsX
 m8mYRB4I/yDaiX0sXZYxSo4LwHoVZto=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-ZKOHCS3MO-ahAlmti-8ltg-1; Fri, 21 Feb 2020 12:31:00 -0500
X-MC-Unique: ZKOHCS3MO-ahAlmti-8ltg-1
Received: by mail-wr1-f69.google.com with SMTP id m15so1296020wrs.22
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 09:31:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kEZCU8SMVeWrFaW4f8SskHzoBJoLksHA5LudhJgZBAs=;
 b=VyFThK+uB3tfOunco8sHMx5cZHbQM8hMpEArCqQqeY9pPdxMDwAZsFHhyQs8wYEivM
 9CoJhT1DTQEIkUpioRFTXa+Bik2SYr0knFXGy3I39DP/5yk2e4nDEPFbcLx91d08Kv/6
 w7YztNwOLWWlpQhdL/MYOcNPxNDXBnr9nxncAToMXNfUwDNBop7io0SnQK6Niaz7KwON
 iv7TYJtQWB6NaDfLNfr7cOQBTObxDn8cUxTtZyYOwk73VclBHCVQ38A68M2Vsa1EbLRe
 iiKl3Tcu4KNFP6LRXIagaEANRI31JwtDdTQRs+t37spGI2g6rFRBGP/orXdI4pcTokI1
 3Vtw==
X-Gm-Message-State: APjAAAU+EcvdNhEfOLqGq1eb7MFgnEWyjJBnLu1/hakpOVxcp8lbDnp8
 CH0aFYPJSMb9M/QTW/Wu/Lb9sZOeadRwXMLKXLcKLVrSgyKva/zc/n3EhYmddG6D8LiaM4oHOR6
 haRyIEFp4EE4CTAo=
X-Received: by 2002:adf:edd0:: with SMTP id v16mr48855695wro.310.1582306259069; 
 Fri, 21 Feb 2020 09:30:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxLjsZ7pMGOPIjvUZ886X5oZJeXEr39Z4xA7MlsHceESPee+5Hs9pw7468ZjEUoGKjIVYKtFQ==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr48855657wro.310.1582306258912; 
 Fri, 21 Feb 2020 09:30:58 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id h18sm5000871wrv.78.2020.02.21.09.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 09:30:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] hw/char: Let devices own the MemoryRegion they create
Date: Fri, 21 Feb 2020 18:30:45 +0100
Message-Id: <20200221173049.18134-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200221173049.18134-1-philmd@redhat.com>
References: <20200221173049.18134-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, qemu-riscv@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Laurent Vivier <laurent@vivier.eu>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To avoid orphean memory regions being added in the /unattached
QOM container, use the memory_region_owner_nonnull.cocci script
to set the correct ownership.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/char/serial.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 9298881af9..2ab8b69e03 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -997,7 +997,7 @@ static void serial_io_realize(DeviceState *dev, Error *=
*errp)
         return;
     }
=20
-    memory_region_init_io(&s->io, NULL, &serial_io_ops, s, "serial", 8);
+    memory_region_init_io(&s->io, OBJECT(dev), &serial_io_ops, s, "serial"=
, 8);
     sysbus_init_mmio(SYS_BUS_DEVICE(sio), &s->io);
     sysbus_init_irq(SYS_BUS_DEVICE(sio), &s->irq);
 }
@@ -1106,8 +1106,9 @@ static void serial_mm_realize(DeviceState *dev, Error=
 **errp)
         return;
     }
=20
-    memory_region_init_io(&s->io, NULL, &serial_mm_ops[smm->endianness], s=
mm,
-                          "serial", 8 << smm->regshift);
+    memory_region_init_io(&s->io, OBJECT(dev),
+                          &serial_mm_ops[smm->endianness], smm, "serial",
+                          8 << smm->regshift);
     sysbus_init_mmio(SYS_BUS_DEVICE(smm), &s->io);
     sysbus_init_irq(SYS_BUS_DEVICE(smm), &smm->serial.irq);
 }
--=20
2.21.1


