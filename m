Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5710EC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 240092081E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfXfGLpb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240092081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51789 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ior1I-0005GR-Vn
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ioqVv-0002Ly-I5
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:11:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ioqVt-00075m-7i
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:11:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28613
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ioqVt-000754-3y
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:11:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578409880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DqceyMqd2uvvSzYv6snj5s7OKUZlxIFSqgq0blE3mxE=;
 b=PfXfGLpbz3R5OTv/GJnGkNPrk6AfDxtHibmilF4zIzjEBD5ff4Ah6j3sUhqWgRZjQjTABK
 QN2LCdTBErNJuDjITtx9OHp14k5W0EAU7A3brMOF5txPEcLcWfyZVtODpnJKv7ZIZ4uhiR
 mBKFRVKngS2Q23f1eiXAANmakNZUu64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-CreEn2TOMj-wcYxOUl1yfw-1; Tue, 07 Jan 2020 10:11:19 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC1F8801E72;
 Tue,  7 Jan 2020 15:11:18 +0000 (UTC)
Received: from localhost (ovpn-112-42.ams2.redhat.com [10.36.112.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAD681001925;
 Tue,  7 Jan 2020 15:11:11 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 33/37] omap-i2c: remove PROP_PTR
Date: Tue,  7 Jan 2020 19:04:38 +0400
Message-Id: <20200107150442.1727958-34-marcandre.lureau@redhat.com>
In-Reply-To: <20200107150442.1727958-1-marcandre.lureau@redhat.com>
References: <20200107150442.1727958-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: CreEn2TOMj-wcYxOUl1yfw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since clocks are not QOM objects, replace PROP_PTR of clocks with
setters methods.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/arm/omap.h | 13 +++++++++++++
 hw/arm/omap1.c        |  2 +-
 hw/arm/omap2.c        |  8 ++++----
 hw/i2c/omap_i2c.c     | 19 ++++++++++++-------
 4 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index bcecf19f89..39a295ba20 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -81,6 +81,19 @@ typedef struct omap_intr_handler_s omap_intr_handler;
 void omap_intc_set_iclk(omap_intr_handler *intc, omap_clk clk);
 void omap_intc_set_fclk(omap_intr_handler *intc, omap_clk clk);
=20
+/* omap_i2c.c */
+#define TYPE_OMAP_I2C "omap_i2c"
+#define OMAP_I2C(obj) OBJECT_CHECK(OMAPI2CState, (obj), TYPE_OMAP_I2C)
+
+typedef struct OMAPI2CState OMAPI2CState;
+
+/*
+ * TODO: Ideally we should have a clock framework that
+ * let us wire these clocks up with QOM properties or links.
+ */
+void omap_i2c_set_iclk(OMAPI2CState *i2c, omap_clk clk);
+void omap_i2c_set_fclk(OMAPI2CState *i2c, omap_clk clk);
+
 /* OMAP2 l4 Interconnect */
 struct omap_l4_s;
 struct omap_l4_region_s {
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 1afd1d3d7f..807e5f70d1 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -4030,7 +4030,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegio=
n *dram,
=20
     s->i2c[0] =3D qdev_create(NULL, "omap_i2c");
     qdev_prop_set_uint8(s->i2c[0], "revision", 0x11);
-    qdev_prop_set_ptr(s->i2c[0], "fclk", omap_findclk(s, "mpuper_ck"));
+    omap_i2c_set_fclk(OMAP_I2C(s->i2c[0]), omap_findclk(s, "mpuper_ck"));
     qdev_init_nofail(s->i2c[0]);
     busdev =3D SYS_BUS_DEVICE(s->i2c[0]);
     sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(s->ih[1], OMAP_INT_I2C)=
);
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index 1d7cc435ef..171e2d0472 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -2425,8 +2425,8 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegi=
on *sdram,
=20
     s->i2c[0] =3D qdev_create(NULL, "omap_i2c");
     qdev_prop_set_uint8(s->i2c[0], "revision", 0x34);
-    qdev_prop_set_ptr(s->i2c[0], "iclk", omap_findclk(s, "i2c1.iclk"));
-    qdev_prop_set_ptr(s->i2c[0], "fclk", omap_findclk(s, "i2c1.fclk"));
+    omap_i2c_set_iclk(OMAP_I2C(s->i2c[0]), omap_findclk(s, "i2c1.iclk"));
+    omap_i2c_set_fclk(OMAP_I2C(s->i2c[0]), omap_findclk(s, "i2c1.fclk"));
     qdev_init_nofail(s->i2c[0]);
     busdev =3D SYS_BUS_DEVICE(s->i2c[0]);
     sysbus_connect_irq(busdev, 0,
@@ -2437,8 +2437,8 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegi=
on *sdram,
=20
     s->i2c[1] =3D qdev_create(NULL, "omap_i2c");
     qdev_prop_set_uint8(s->i2c[1], "revision", 0x34);
-    qdev_prop_set_ptr(s->i2c[1], "iclk", omap_findclk(s, "i2c2.iclk"));
-    qdev_prop_set_ptr(s->i2c[1], "fclk", omap_findclk(s, "i2c2.fclk"));
+    omap_i2c_set_iclk(OMAP_I2C(s->i2c[1]), omap_findclk(s, "i2c2.iclk"));
+    omap_i2c_set_fclk(OMAP_I2C(s->i2c[1]), omap_findclk(s, "i2c2.fclk"));
     qdev_init_nofail(s->i2c[1]);
     busdev =3D SYS_BUS_DEVICE(s->i2c[1]);
     sysbus_connect_irq(busdev, 0,
diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index 3ba965a58f..3ccbd5cc2c 100644
--- a/hw/i2c/omap_i2c.c
+++ b/hw/i2c/omap_i2c.c
@@ -28,10 +28,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
=20
-#define TYPE_OMAP_I2C "omap_i2c"
-#define OMAP_I2C(obj) OBJECT_CHECK(OMAPI2CState, (obj), TYPE_OMAP_I2C)
-
-typedef struct OMAPI2CState {
+struct OMAPI2CState {
     SysBusDevice parent_obj;
=20
     MemoryRegion iomem;
@@ -56,7 +53,7 @@ typedef struct OMAPI2CState {
     uint8_t divider;
     uint8_t times[2];
     uint16_t test;
-} OMAPI2CState;
+};
=20
 #define OMAP2_INTR_REV=090x34
 #define OMAP2_GC_REV=090x34
@@ -504,10 +501,18 @@ static void omap_i2c_realize(DeviceState *dev, Error =
**errp)
     }
 }
=20
+void omap_i2c_set_iclk(OMAPI2CState *i2c, omap_clk clk)
+{
+    i2c->iclk =3D clk;
+}
+
+void omap_i2c_set_fclk(OMAPI2CState *i2c, omap_clk clk)
+{
+    i2c->fclk =3D clk;
+}
+
 static Property omap_i2c_properties[] =3D {
     DEFINE_PROP_UINT8("revision", OMAPI2CState, revision, 0),
-    DEFINE_PROP_PTR("iclk", OMAPI2CState, iclk),
-    DEFINE_PROP_PTR("fclk", OMAPI2CState, fclk),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
--=20
2.25.0.rc1.20.g2443f3f80d


