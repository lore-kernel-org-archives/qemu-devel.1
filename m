Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B17C04AAD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 16:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC3E205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 16:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC3E205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49901 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO3Br-0000w8-VR
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 12:43:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hO34G-0001EF-EH
	for qemu-devel@nongnu.org; Tue, 07 May 2019 12:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hO34F-0001nj-Ey
	for qemu-devel@nongnu.org; Tue, 07 May 2019 12:35:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hO349-0001hH-HT; Tue, 07 May 2019 12:35:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF4CD308793E;
	Tue,  7 May 2019 16:35:39 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-58.brq.redhat.com [10.40.204.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B1C273DA5;
	Tue,  7 May 2019 16:35:27 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  7 May 2019 18:34:05 +0200
Message-Id: <20190507163416.24647-6-philmd@redhat.com>
In-Reply-To: <20190507163416.24647-1-philmd@redhat.com>
References: <20190507163416.24647-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Tue, 07 May 2019 16:35:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 05/16] hw/arm/bcm2835: Use
 object_initialize() on PL011State
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Paul Burton <pburton@wavecomp.com>, Andrew Jeffery <andrew@aj.id.au>,
	Alistair Francis <alistair@alistair23.me>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Joel Stanley <joel@jms.id.au>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-arm@nongnu.org,
	Peter Chubb <peter.chubb@nicta.com.au>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To be coherent with the other peripherals contained in the
BCM2835PeripheralState structure, directly allocate the PL011State
(instead of using the pl011 uart as a pointer to a SysBusDevice).

Initialize the PL011State with object_initialize() instead of
object_new().

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/bcm2835_peripherals.c         | 14 +++++++-------
 include/hw/arm/bcm2835_peripherals.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 7ffb51b6927..2931a82a25a 100644
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
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm283=
5_peripherals.h
index 959508d57dd..e79c21771fe 100644
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
--=20
2.20.1


