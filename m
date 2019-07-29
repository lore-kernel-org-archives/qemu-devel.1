Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79F2C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 959DE2171F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="v8KfFYqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959DE2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7BD-0002no-Pt
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37812)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs77D-00048K-Id
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs77C-0004ZH-3d
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:59:07 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:48004)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs774-0004Qa-5f; Mon, 29 Jul 2019 10:58:58 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 111A496F5A;
 Mon, 29 Jul 2019 14:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OSbZBrooUlpNiqJvIw0CUPHIsdjLEeJwNlZv9K17I/0=;
 b=v8KfFYqOpQf7oIDDzN8FDe+GM3Ck5jaZZZdxx7rXVBNQP4Wzf6fg41uVbvKnJWEqSBT9l/
 2+Lk6UkdkMtimU7nGwLpBzUC+9TUOC98BdFqLH1u3PLmfecY9nRZVGAaQ+L+hcUN+pSM/a
 aVBchxm52ZEUpyW1LbwJ2gVh1JBPMRU=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:26 +0200
Message-Id: <20190729145654.14644-6-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729145654.14644-1-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OSbZBrooUlpNiqJvIw0CUPHIsdjLEeJwNlZv9K17I/0=;
 b=mepM0RO3/446PQmNi/jIsK+aRxRWVwfPQrnexUjsCJFysqtb++Nu+qZzuseswiCO+4tO5y
 2d7gAVbbD3q0weiYVqAcxlfZAt92p8HfxebPedy5s6Da41zqBfmbJ9c+lEQfFxi1BrriNV
 XYjFl3h1s88ymC91DpkVMnUuxX60A9E=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412337; a=rsa-sha256; cv=none;
 b=T+To/0nzF3o75zV9CtHv1QR9RVDEFuquB9MfCu8v8tj7rsP3LXFMKdVaAaEIKMBL7/Edlo
 5O2j2fgkvQEpsYRziu4n0DoajUkV0x21T5n7TZXrY7btonw/EBiajBNH5oUamB/4bdUVjX
 HEPhKS3upcwjLKCpOgQzGbQAnXAuqoo=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 05/33] Switch to new api in qdev/bus
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

Deprecate old reset apis and make them use the new one while they
are still used somewhere.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/core/qdev.c         | 22 +++-------------------
 include/hw/qdev-core.h | 28 ++++++++++++++++++++++------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 559ced070d..e9e5f2d5f9 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -312,25 +312,9 @@ static void device_foreach_reset_child(Object *obj, =
void (*func)(Object *))
     }
 }
=20
-static int qdev_reset_one(DeviceState *dev, void *opaque)
-{
-    device_legacy_reset(dev);
-
-    return 0;
-}
-
-static int qbus_reset_one(BusState *bus, void *opaque)
-{
-    BusClass *bc =3D BUS_GET_CLASS(bus);
-    if (bc->reset) {
-        bc->reset(bus);
-    }
-    return 0;
-}
-
 void qdev_reset_all(DeviceState *dev)
 {
-    qdev_walk_children(dev, NULL, NULL, qdev_reset_one, qbus_reset_one, =
NULL);
+    device_reset(dev, false);
 }
=20
 void qdev_reset_all_fn(void *opaque)
@@ -340,7 +324,7 @@ void qdev_reset_all_fn(void *opaque)
=20
 void qbus_reset_all(BusState *bus)
 {
-    qbus_walk_children(bus, NULL, NULL, qdev_reset_one, qbus_reset_one, =
NULL);
+    bus_reset(bus, false);
 }
=20
 void qbus_reset_all_fn(void *opaque)
@@ -922,7 +906,7 @@ static void device_set_realized(Object *obj, bool val=
ue, Error **errp)
             }
         }
         if (dev->hotplugged) {
-            device_legacy_reset(dev);
+            device_reset(dev, true);
         }
         dev->pending_deleted_event =3D false;
=20
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index eeb75611c8..1670ae41bb 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -109,6 +109,11 @@ typedef struct DeviceClass {
     bool hotpluggable;
=20
     /* callbacks */
+    /*
+     * Reset method here is deprecated and replaced by methods in the
+     * resettable class interface to implement a multi-phase reset.
+     * TODO: remove once every reset callback is unused
+     */
     DeviceReset reset;
     DeviceRealize realize;
     DeviceUnrealize unrealize;
@@ -455,19 +460,22 @@ bool bus_is_resetting(BusState *bus);
  */
 bool bus_is_reset_cold(BusState *bus);
=20
-void qdev_reset_all(DeviceState *dev);
-void qdev_reset_all_fn(void *opaque);
-
 /**
- * @qbus_reset_all:
- * @bus: Bus to be reset.
+ * qbus/qdev_reset_all:
+ * @bus/dev: Bus/Device to be reset.
  *
- * Reset @bus and perform a bus-level ("hard") reset of all devices conn=
ected
+ * Reset @bus/dev and perform a bus-level reset of all devices/buses con=
nected
  * to it, including recursive processing of all buses below @bus itself.=
  A
  * hard reset means that qbus_reset_all will reset all state of the devi=
ce.
  * For PCI devices, for example, this will include the base address regi=
sters
  * or configuration space.
+ *
+ * Theses functions are deprecated, please use device/bus_reset or
+ * resettable_reset_* instead
+ * TODO: remove them when all occurence are removed
  */
+void qdev_reset_all(DeviceState *dev);
+void qdev_reset_all_fn(void *opaque);
 void qbus_reset_all(BusState *bus);
 void qbus_reset_all_fn(void *opaque);
=20
@@ -489,9 +497,17 @@ void qdev_machine_init(void);
  * device_legacy_reset:
  *
  * Reset a single device (by calling the reset method).
+ *
+ * This function is deprecated, please use device_reset() instead.
+ * TODO: remove the function when all occurences are removed.
  */
 void device_legacy_reset(DeviceState *dev);
=20
+/**
+ * device_class_set_parent_reset:
+ * TODO: remove the function when DeviceClass's reset method
+ * is not used anymore.
+ */
 void device_class_set_parent_reset(DeviceClass *dc,
                                    DeviceReset dev_reset,
                                    DeviceReset *parent_reset);
--=20
2.22.0


