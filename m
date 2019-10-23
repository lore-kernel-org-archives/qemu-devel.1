Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39C7CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 20:58:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C0AB2173B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 20:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5SiAOk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0AB2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNNhw-000644-Gr
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 16:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKXx-0006Jd-Kz
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKXv-0002qP-U6
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:35:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25838
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iNKXv-0002qA-Po
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571852143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DEY8UleqA5PQOALRPQqD4BmpCvVBevCMtrHIZbidCFI=;
 b=P5SiAOk5MpmB96M0f93VpxMj9ohhDbRXYmXBy0Nwr2bjRg6npYLrkNQkSLgkBxfd26Vdfx
 Y/q040Z0O2b0LMZzB+QflyCJC08sG2LF4j39iTc4EPZHxfowzNdVFPzLyoeS5EaSrOINiR
 1cb35u4aLtijBYV24EoMwxqpowIfXMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-9RWPr3oZNpKsnY90OZRbIQ-1; Wed, 23 Oct 2019 13:35:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 605131800E01;
 Wed, 23 Oct 2019 17:35:36 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93DDF54560;
 Wed, 23 Oct 2019 17:35:30 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 31/33] omap-gpio: remove PROP_PTR
Date: Wed, 23 Oct 2019 19:31:52 +0200
Message-Id: <20191023173154.30051-32-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-1-marcandre.lureau@redhat.com>
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 9RWPr3oZNpKsnY90OZRbIQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since clocks are not QOM objects, replace PROP_PTR of clocks with
setters methods.

Move/adapt the existing TODO comment about a clock framework.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/arm/omap1.c        |  2 +-
 hw/arm/omap2.c        | 13 +++++++------
 hw/gpio/omap_gpio.c   | 42 +++++++++++++++---------------------------
 include/hw/arm/omap.h | 33 +++++++++++++++++++++++++++++----
 4 files changed, 52 insertions(+), 38 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 807e5f70d1..761cc17ea9 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -4012,7 +4012,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegio=
n *dram,
=20
     s->gpio =3D qdev_create(NULL, "omap-gpio");
     qdev_prop_set_int32(s->gpio, "mpu_model", s->mpu_model);
-    qdev_prop_set_ptr(s->gpio, "clk", omap_findclk(s, "arm_gpio_ck"));
+    omap_gpio_set_clk(OMAP1_GPIO(s->gpio), omap_findclk(s, "arm_gpio_ck"))=
;
     qdev_init_nofail(s->gpio);
     sysbus_connect_irq(SYS_BUS_DEVICE(s->gpio), 0,
                        qdev_get_gpio_in(s->ih[0], OMAP_INT_GPIO_BANK1));
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index 171e2d0472..e1c11de5ce 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -2449,13 +2449,14 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRe=
gion *sdram,
=20
     s->gpio =3D qdev_create(NULL, "omap2-gpio");
     qdev_prop_set_int32(s->gpio, "mpu_model", s->mpu_model);
-    qdev_prop_set_ptr(s->gpio, "iclk", omap_findclk(s, "gpio_iclk"));
-    qdev_prop_set_ptr(s->gpio, "fclk0", omap_findclk(s, "gpio1_dbclk"));
-    qdev_prop_set_ptr(s->gpio, "fclk1", omap_findclk(s, "gpio2_dbclk"));
-    qdev_prop_set_ptr(s->gpio, "fclk2", omap_findclk(s, "gpio3_dbclk"));
-    qdev_prop_set_ptr(s->gpio, "fclk3", omap_findclk(s, "gpio4_dbclk"));
+    omap2_gpio_set_iclk(OMAP2_GPIO(s->gpio), omap_findclk(s, "gpio_iclk"))=
;
+    omap2_gpio_set_fclk(OMAP2_GPIO(s->gpio), 0, omap_findclk(s, "gpio1_dbc=
lk"));
+    omap2_gpio_set_fclk(OMAP2_GPIO(s->gpio), 1, omap_findclk(s, "gpio2_dbc=
lk"));
+    omap2_gpio_set_fclk(OMAP2_GPIO(s->gpio), 2, omap_findclk(s, "gpio3_dbc=
lk"));
+    omap2_gpio_set_fclk(OMAP2_GPIO(s->gpio), 3, omap_findclk(s, "gpio4_dbc=
lk"));
     if (s->mpu_model =3D=3D omap2430) {
-        qdev_prop_set_ptr(s->gpio, "fclk4", omap_findclk(s, "gpio5_dbclk")=
);
+        omap2_gpio_set_fclk(OMAP2_GPIO(s->gpio), 4,
+                            omap_findclk(s, "gpio5_dbclk"));
     }
     qdev_init_nofail(s->gpio);
     busdev =3D SYS_BUS_DEVICE(s->gpio);
diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index 41e1aa798c..85c16897ae 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -40,10 +40,6 @@ struct omap_gpio_s {
     uint16_t pins;
 };
=20
-#define TYPE_OMAP1_GPIO "omap-gpio"
-#define OMAP1_GPIO(obj) \
-    OBJECT_CHECK(struct omap_gpif_s, (obj), TYPE_OMAP1_GPIO)
-
 struct omap_gpif_s {
     SysBusDevice parent_obj;
=20
@@ -212,10 +208,6 @@ struct omap2_gpio_s {
     uint8_t delay;
 };
=20
-#define TYPE_OMAP2_GPIO "omap2-gpio"
-#define OMAP2_GPIO(obj) \
-    OBJECT_CHECK(struct omap2_gpif_s, (obj), TYPE_OMAP2_GPIO)
-
 struct omap2_gpif_s {
     SysBusDevice parent_obj;
=20
@@ -747,21 +739,13 @@ static void omap2_gpio_realize(DeviceState *dev, Erro=
r **errp)
     }
 }
=20
-/* Using qdev pointer properties for the clocks is not ideal.
- * qdev should support a generic means of defining a 'port' with
- * an arbitrary interface for connecting two devices. Then we
- * could reframe the omap clock API in terms of clock ports,
- * and get some type safety. For now the best qdev provides is
- * passing an arbitrary pointer.
- * (It's not possible to pass in the string which is the clock
- * name, because this device does not have the necessary information
- * (ie the struct omap_mpu_state_s*) to do the clockname to pointer
- * translation.)
- */
+void omap_gpio_set_clk(omap_gpif *gpio, omap_clk clk)
+{
+    gpio->clk =3D clk;
+}
=20
 static Property omap_gpio_properties[] =3D {
     DEFINE_PROP_INT32("mpu_model", struct omap_gpif_s, mpu_model, 0),
-    DEFINE_PROP_PTR("clk", struct omap_gpif_s, clk),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -784,15 +768,19 @@ static const TypeInfo omap_gpio_info =3D {
     .class_init    =3D omap_gpio_class_init,
 };
=20
+void omap2_gpio_set_iclk(omap2_gpif *gpio, omap_clk clk)
+{
+    gpio->iclk =3D clk;
+}
+
+void omap2_gpio_set_fclk(omap2_gpif *gpio, uint8_t i, omap_clk clk)
+{
+    assert(i <=3D 5);
+    gpio->fclk[i] =3D clk;
+}
+
 static Property omap2_gpio_properties[] =3D {
     DEFINE_PROP_INT32("mpu_model", struct omap2_gpif_s, mpu_model, 0),
-    DEFINE_PROP_PTR("iclk", struct omap2_gpif_s, iclk),
-    DEFINE_PROP_PTR("fclk0", struct omap2_gpif_s, fclk[0]),
-    DEFINE_PROP_PTR("fclk1", struct omap2_gpif_s, fclk[1]),
-    DEFINE_PROP_PTR("fclk2", struct omap2_gpif_s, fclk[2]),
-    DEFINE_PROP_PTR("fclk3", struct omap2_gpif_s, fclk[3]),
-    DEFINE_PROP_PTR("fclk4", struct omap2_gpif_s, fclk[4]),
-    DEFINE_PROP_PTR("fclk5", struct omap2_gpif_s, fclk[5]),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 39a295ba20..6be386d0e2 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -77,6 +77,16 @@ typedef struct omap_intr_handler_s omap_intr_handler;
 /*
  * TODO: Ideally we should have a clock framework that
  * let us wire these clocks up with QOM properties or links.
+ *
+ * qdev should support a generic means of defining a 'port' with
+ * an arbitrary interface for connecting two devices. Then we
+ * could reframe the omap clock API in terms of clock ports,
+ * and get some type safety. For now the best qdev provides is
+ * passing an arbitrary pointer.
+ * (It's not possible to pass in the string which is the clock
+ * name, because this device does not have the necessary information
+ * (ie the struct omap_mpu_state_s*) to do the clockname to pointer
+ * translation.)
  */
 void omap_intc_set_iclk(omap_intr_handler *intc, omap_clk clk);
 void omap_intc_set_fclk(omap_intr_handler *intc, omap_clk clk);
@@ -87,13 +97,28 @@ void omap_intc_set_fclk(omap_intr_handler *intc, omap_c=
lk clk);
=20
 typedef struct OMAPI2CState OMAPI2CState;
=20
-/*
- * TODO: Ideally we should have a clock framework that
- * let us wire these clocks up with QOM properties or links.
- */
+/* TODO: clock framework (see above) */
 void omap_i2c_set_iclk(OMAPI2CState *i2c, omap_clk clk);
 void omap_i2c_set_fclk(OMAPI2CState *i2c, omap_clk clk);
=20
+/* omap_gpio.c */
+#define TYPE_OMAP1_GPIO "omap-gpio"
+#define OMAP1_GPIO(obj)                                         \
+    OBJECT_CHECK(struct omap_gpif_s, (obj), TYPE_OMAP1_GPIO)
+
+#define TYPE_OMAP2_GPIO "omap2-gpio"
+#define OMAP2_GPIO(obj)                                         \
+    OBJECT_CHECK(struct omap2_gpif_s, (obj), TYPE_OMAP2_GPIO)
+
+typedef struct omap_gpif_s omap_gpif;
+typedef struct omap2_gpif_s omap2_gpif;
+
+/* TODO: clock framework (see above) */
+void omap_gpio_set_clk(omap_gpif *gpio, omap_clk clk);
+
+void omap2_gpio_set_iclk(omap2_gpif *gpio, omap_clk clk);
+void omap2_gpio_set_fclk(omap2_gpif *gpio, uint8_t i, omap_clk clk);
+
 /* OMAP2 l4 Interconnect */
 struct omap_l4_s;
 struct omap_l4_region_s {
--=20
2.23.0.606.g08da6496b6


