Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F6BC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4535C21655
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="Ea3nNUHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4535C21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7SN-00047r-Hv
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39847)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs79E-0007Vr-Qs
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs79C-0006fi-TC
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:01:12 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:49068)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs78x-0005ZI-5J; Mon, 29 Jul 2019 11:00:55 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 9260497064;
 Mon, 29 Jul 2019 14:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N5wnMQEiMoszMl9iY43hRAj3emLdaJgse3RhUORv7mA=;
 b=Ea3nNUHBhop4jRADSkdTGq8pqTrpXz8GjNAW2XOEMWXYWs4wr6y+Azhd+x6TyzmtaUIa0f
 fgu1C6oh+49Zae93jKY13Chv48FFAG3Hs8IcWm1SPNlfFxrUNTNdC2Y2qBXqIs5eoB5Aql
 U8JHbKOijurENUbWe5wZMFcIbObAerg=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:51 +0200
Message-Id: <20190729145654.14644-31-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729145654.14644-1-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N5wnMQEiMoszMl9iY43hRAj3emLdaJgse3RhUORv7mA=;
 b=WvAtHFZsfTFPAyXrEStEy1QIY3iaOPPwetox0EZF1ouGR0iZA29+tV6sRjebYFOKLBM57J
 ERM5gqfvLMean5HO212vrYh/lF0WaUMObYwSA6zV0lo4Lujk1Y4YMrytvg7FPQJZD2FcFs
 x4N1AhQyvYa7aPdtUtQX/lfy7Hiuxb4=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412372; a=rsa-sha256; cv=none;
 b=yqKxTNzhj6/OkXaMKs3th7yRmN8RS62X4Voqti9rlDfKpu/d7N7Kgr3wUUWvZGqQx7x4hi
 l52Z15Xyv0LQzYmMskkshTZNNPaqY3YL/Bt+Bc5Tx19zVqit+2xIay0hRixEs7vchqGlf2
 Cas3a3jnxOwoJBCjeOsNz1N+84QeNVE=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 30/33] convert cadence_uart to 3-phases reset
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 kraxel@redhat.com, edgar.iglesias@xilinx.com, hare@suse.com,
 qemu-block@nongnu.org, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, marcandre.lureau@redhat.com, rth@twiddle.net,
 thuth@redhat.com, ehabkost@redhat.com, alistair@alistair23.me,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, clg@kaod.org, jsnow@redhat.com,
 david@gibson.dropbear.id.au, Damien Hedde <damien.hedde@greensocs.com>,
 berrange@redhat.com, cohuck@redhat.com, mark.burton@greensocs.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split the existing reset procedure into 3 phases.
Test the resetting flag to discard register accesses
and character reception.
Also adds a active high reset io.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/char/cadence_uart.c | 77 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 4 deletions(-)

diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index fa25fe24da..d7bacc44fe 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -39,6 +39,18 @@
     #define DB_PRINT(...)
 #endif
=20
+#define CADENCE_UART_CLASS(class) \
+    OBJECT_CLASS_CHECK(CadenceUartClass, (class), TYPE_CADENCE_UART)
+#define CADENCE_UART_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(CadenceUartClass, (obj), TYPE_CADENCE_UART)
+
+typedef struct CadenceUartClass {
+    /*< private >*/
+    SysBusDeviceClass parent_class;
+
+    struct ResettablePhases parent_reset_phases;
+} CadenceUartClass;
+
 #define UART_SR_INTR_RTRIG     0x00000001
 #define UART_SR_INTR_REMPTY    0x00000002
 #define UART_SR_INTR_RFUL      0x00000004
@@ -223,6 +235,10 @@ static int uart_can_receive(void *opaque)
     int ret =3D MAX(CADENCE_UART_RX_FIFO_SIZE, CADENCE_UART_TX_FIFO_SIZE=
);
     uint32_t ch_mode =3D s->r[R_MR] & UART_MR_CHMODE;
=20
+    if (device_is_resetting((DeviceState *) opaque)) {
+        return 0;
+    }
+
     if (ch_mode =3D=3D NORMAL_MODE || ch_mode =3D=3D ECHO_MODE) {
         ret =3D MIN(ret, CADENCE_UART_RX_FIFO_SIZE - s->rx_count);
     }
@@ -338,6 +354,10 @@ static void uart_receive(void *opaque, const uint8_t=
 *buf, int size)
     CadenceUARTState *s =3D opaque;
     uint32_t ch_mode =3D s->r[R_MR] & UART_MR_CHMODE;
=20
+    if (device_is_resetting((DeviceState *) opaque)) {
+        return;
+    }
+
     if (ch_mode =3D=3D NORMAL_MODE || ch_mode =3D=3D ECHO_MODE) {
         uart_write_rx_fifo(opaque, buf, size);
     }
@@ -351,6 +371,10 @@ static void uart_event(void *opaque, int event)
     CadenceUARTState *s =3D opaque;
     uint8_t buf =3D '\0';
=20
+    if (device_is_resetting((DeviceState *) opaque)) {
+        return;
+    }
+
     if (event =3D=3D CHR_EVENT_BREAK) {
         uart_write_rx_fifo(opaque, &buf, 1);
     }
@@ -383,6 +407,10 @@ static void uart_write(void *opaque, hwaddr offset,
 {
     CadenceUARTState *s =3D opaque;
=20
+    if (device_is_resetting((DeviceState *)opaque)) {
+        return;
+    }
+
     DB_PRINT(" offset:%x data:%08x\n", (unsigned)offset, (unsigned)value=
);
     offset >>=3D 2;
     if (offset >=3D CADENCE_UART_R_MAX) {
@@ -441,6 +469,10 @@ static uint64_t uart_read(void *opaque, hwaddr offse=
t,
     CadenceUARTState *s =3D opaque;
     uint32_t c =3D 0;
=20
+    if (device_is_resetting((DeviceState *)opaque)) {
+        return 0;
+    }
+
     offset >>=3D 2;
     if (offset >=3D CADENCE_UART_R_MAX) {
         c =3D 0;
@@ -460,9 +492,14 @@ static const MemoryRegionOps uart_ops =3D {
     .endianness =3D DEVICE_NATIVE_ENDIAN,
 };
=20
-static void cadence_uart_reset(DeviceState *dev)
+static void cadence_uart_reset_init(Object *obj)
 {
-    CadenceUARTState *s =3D CADENCE_UART(dev);
+    CadenceUARTState *s =3D CADENCE_UART(obj);
+    CadenceUartClass *cc =3D CADENCE_UART_GET_CLASS(obj);
+
+    if (cc->parent_reset_phases.init) {
+        cc->parent_reset_phases.init(obj);
+    }
=20
     s->r[R_CR] =3D 0x00000128;
     s->r[R_IMR] =3D 0;
@@ -471,6 +508,28 @@ static void cadence_uart_reset(DeviceState *dev)
     s->r[R_BRGR] =3D 0x0000028B;
     s->r[R_BDIV] =3D 0x0000000F;
     s->r[R_TTRIG] =3D 0x00000020;
+}
+
+static void cadence_uart_reset_hold(Object *obj)
+{
+    CadenceUARTState *s =3D CADENCE_UART(obj);
+    CadenceUartClass *cc =3D CADENCE_UART_GET_CLASS(obj);
+
+    if (cc->parent_reset_phases.hold) {
+        cc->parent_reset_phases.hold(obj);
+    }
+
+    qemu_set_irq(s->irq, 0);
+}
+
+static void cadence_uart_reset_exit(Object *obj)
+{
+    CadenceUARTState *s =3D CADENCE_UART(obj);
+    CadenceUartClass *cc =3D CADENCE_UART_GET_CLASS(obj);
+
+    if (cc->parent_reset_phases.exit) {
+        cc->parent_reset_phases.exit(obj);
+    }
=20
     uart_rx_reset(s);
     uart_tx_reset(s);
@@ -499,6 +558,8 @@ static void cadence_uart_init(Object *obj)
     sysbus_init_irq(sbd, &s->irq);
=20
     s->char_tx_time =3D (NANOSECONDS_PER_SECOND / 9600) * 10;
+
+    qdev_init_warm_reset_gpio(DEVICE(obj), "rst", DEVICE_RESET_ACTIVE_HI=
GH);
 }
=20
 static int cadence_uart_post_load(void *opaque, int version_id)
@@ -544,12 +605,19 @@ static Property cadence_uart_properties[] =3D {
 static void cadence_uart_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
+    CadenceUartClass *cc =3D CADENCE_UART_CLASS(klass);
=20
     dc->realize =3D cadence_uart_realize;
     dc->vmsd =3D &vmstate_cadence_uart;
-    dc->reset =3D cadence_uart_reset;
     dc->props =3D cadence_uart_properties;
-  }
+
+    resettable_class_set_parent_reset_phases(rc,
+                                             cadence_uart_reset_init,
+                                             cadence_uart_reset_hold,
+                                             cadence_uart_reset_exit,
+                                             &cc->parent_reset_phases);
+}
=20
 static const TypeInfo cadence_uart_info =3D {
     .name          =3D TYPE_CADENCE_UART,
@@ -557,6 +625,7 @@ static const TypeInfo cadence_uart_info =3D {
     .instance_size =3D sizeof(CadenceUARTState),
     .instance_init =3D cadence_uart_init,
     .class_init    =3D cadence_uart_class_init,
+    .class_size =3D sizeof(CadenceUartClass),
 };
=20
 static void cadence_uart_register_types(void)
--=20
2.22.0


