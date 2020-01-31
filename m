Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26E0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 01:12:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7691C206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 01:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yis4aFRr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7691C206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixKr4-0001j1-LP
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 20:12:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixKou-0007vN-CP
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 20:10:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixKor-00076b-Tu
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 20:10:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32165
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixKor-00072X-NP
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 20:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580432997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hTdels3lLogtY3GE7YXCvYtzkeoykd41wRZrcLAwDYA=;
 b=Yis4aFRrVu0fzrOefz++rS8J1tWa3nydnHfJp9U5JR3iSnfVQMEqWT1INsdC1JEA1It/CH
 SvqlcRuNfgRbX90eX+K8Qi0nJU/K+bC4tq+0PLQrA4h7h+pY//MuxNIe5XLuO7nb7kZ2Mu
 m1z4ewnSOLTp/4gjcU2MRUIZVMYF/YY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-qLjYAn62PW2n-jiAxeKJoA-1; Thu, 30 Jan 2020 20:09:53 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2BE413E7;
 Fri, 31 Jan 2020 01:09:51 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-34.brq.redhat.com [10.40.204.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0C1E5DA75;
 Fri, 31 Jan 2020 01:09:49 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] !fixup "hw/misc: Add limited support for AVR power device"
Date: Fri, 31 Jan 2020 02:09:40 +0100
Message-Id: <20200131010941.10636-2-philmd@redhat.com>
In-Reply-To: <20200131010941.10636-1-philmd@redhat.com>
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <20200131010941.10636-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: qLjYAn62PW2n-jiAxeKJoA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

- convert DB_PRINT() to trace-events
- fix style/indentation

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/misc/avr_power.c  | 17 +++++++++--------
 hw/misc/trace-events |  4 ++++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/hw/misc/avr_power.c b/hw/misc/avr_power.c
index 598bc7279c..65ff7c4405 100644
--- a/hw/misc/avr_power.c
+++ b/hw/misc/avr_power.c
@@ -27,9 +27,7 @@
 #include "qemu/log.h"
 #include "hw/qdev-properties.h"
 #include "hw/irq.h"
-
-#define DB_PRINT(fmt, args...) /* Nothing */
-/*#define DB_PRINT(fmt, args...) printf("%s: " fmt "\n", __func__, ## args=
)*/
+#include "trace.h"
=20
 static void avr_mask_reset(DeviceState *dev)
 {
@@ -48,19 +46,20 @@ static uint64_t avr_mask_read(void *opaque, hwaddr offs=
et, unsigned size)
     assert(offset =3D=3D 0);
     AVRMaskState *s =3D opaque;
=20
+    trace_avr_power_read(s->val);
+
     return (uint64_t)s->val;
 }
=20
 static void avr_mask_write(void *opaque, hwaddr offset,
-                              uint64_t val64, unsigned size)
+                           uint64_t val64, unsigned size)
 {
     assert(size =3D=3D 1);
     assert(offset =3D=3D 0);
     AVRMaskState *s =3D opaque;
     uint8_t val8 =3D val64;
=20
-    DB_PRINT("write %d to offset %d", val8, (uint8_t)offset);
-
+    trace_avr_power_write(val8);
     s->val =3D val8;
     for (int i =3D 0; i < 8; i++) {
         qemu_set_irq(s->irq[i], (val8 & (1 << i)) !=3D 0);
@@ -71,7 +70,9 @@ static const MemoryRegionOps avr_mask_ops =3D {
     .read =3D avr_mask_read,
     .write =3D avr_mask_write,
     .endianness =3D DEVICE_NATIVE_ENDIAN,
-    .impl =3D {.max_access_size =3D 1}
+    .impl =3D {
+        .max_access_size =3D 1,
+    },
 };
=20
 static void avr_mask_init(Object *dev)
@@ -80,7 +81,7 @@ static void avr_mask_init(Object *dev)
     SysBusDevice *busdev =3D SYS_BUS_DEVICE(dev);
=20
     memory_region_init_io(&s->iomem, dev, &avr_mask_ops, s, TYPE_AVR_MASK,
-            0x01);
+                          0x01);
     sysbus_init_mmio(busdev, &s->iomem);
=20
     for (int i =3D 0; i < 8; i++) {
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 7f0f5dff3a..f716881bb1 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -179,3 +179,7 @@ via1_rtc_cmd_pram_read(int addr, int value) "addr=3D%u =
value=3D0x%02x"
 via1_rtc_cmd_pram_write(int addr, int value) "addr=3D%u value=3D0x%02x"
 via1_rtc_cmd_pram_sect_read(int sector, int offset, int addr, int value) "=
sector=3D%u offset=3D%u addr=3D%d value=3D0x%02x"
 via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int value) =
"sector=3D%u offset=3D%u addr=3D%d value=3D0x%02x"
+
+# avr_power.c
+avr_power_read(uint8_t value) "power_reduc read value:%u"
+avr_power_write(uint8_t value) "power_reduc write value:%u"
--=20
2.21.1


