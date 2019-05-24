Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9649AC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F72721773
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F72721773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58871 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUFIX-0003s2-NL
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 14:52:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUFBx-0006uP-Sw
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUFBw-0006DA-4O
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:45:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hUFBv-00068n-Q1
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:45:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D7208667B;
	Fri, 24 May 2019 18:45:17 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B56531001E6F;
	Fri, 24 May 2019 18:45:14 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Fri, 24 May 2019 15:44:36 -0300
Message-Id: <20190524184447.16678-7-ehabkost@redhat.com>
In-Reply-To: <20190524184447.16678-1-ehabkost@redhat.com>
References: <20190524184447.16678-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Fri, 24 May 2019 18:45:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 06/17] hw/arm/bcm2835: Use object_initialize()
 on PL011State
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

To be coherent with the other peripherals contained in the
BCM2835PeripheralState structure, directly allocate the PL011State
(instead of using the pl011 uart as a pointer to a SysBusDevice).

Initialize the PL011State with object_initialize() instead of
object_new().

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190507163416.24647-6-philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/arm/bcm2835_peripherals.h |  2 +-
 hw/arm/bcm2835_peripherals.c         | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm283=
5_peripherals.h
index 959508d57d..e79c21771f 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -38,7 +38,7 @@ typedef struct BCM2835PeripheralState {
     MemoryRegion ram_alias[4];
     qemu_irq irq, fiq;
=20
-    SysBusDevice *uart0;
+    PL011State uart0;
     BCM2835AuxState aux;
     BCM2835FBState fb;
     BCM2835DMAState dma;
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 7ffb51b692..2931a82a25 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -46,9 +46,9 @@ static void bcm2835_peripherals_init(Object *obj)
     qdev_set_parent_bus(DEVICE(&s->ic), sysbus_get_default());
=20
     /* UART0 */
-    s->uart0 =3D SYS_BUS_DEVICE(object_new(TYPE_PL011));
-    object_property_add_child(obj, "uart0", OBJECT(s->uart0), NULL);
-    qdev_set_parent_bus(DEVICE(s->uart0), sysbus_get_default());
+    object_initialize(&s->uart0, sizeof(s->uart0), TYPE_PL011);
+    object_property_add_child(obj, "uart0", OBJECT(&s->uart0), NULL);
+    qdev_set_parent_bus(DEVICE(&s->uart0), sysbus_get_default());
=20
     /* AUX / UART1 */
     object_initialize(&s->aux, sizeof(s->aux), TYPE_BCM2835_AUX);
@@ -166,16 +166,16 @@ static void bcm2835_peripherals_realize(DeviceState=
 *dev, Error **errp)
     sysbus_pass_irq(SYS_BUS_DEVICE(s), SYS_BUS_DEVICE(&s->ic));
=20
     /* UART0 */
-    qdev_prop_set_chr(DEVICE(s->uart0), "chardev", serial_hd(0));
-    object_property_set_bool(OBJECT(s->uart0), true, "realized", &err);
+    qdev_prop_set_chr(DEVICE(&s->uart0), "chardev", serial_hd(0));
+    object_property_set_bool(OBJECT(&s->uart0), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
         return;
     }
=20
     memory_region_add_subregion(&s->peri_mr, UART0_OFFSET,
-                                sysbus_mmio_get_region(s->uart0, 0));
-    sysbus_connect_irq(s->uart0, 0,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart0), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart0), 0,
         qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
                                INTERRUPT_UART));
     /* AUX / UART1 */
--=20
2.18.0.rc1.1.g3f1ff2140


