Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C0AC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:44:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F37F22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="DDEdHK2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F37F22D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Tia-0000bo-BP
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 12:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1i0TZc-0006qZ-5w
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1i0TZa-0005bN-6r
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:35:00 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:36374)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1i0TZZ-0005ad-UU
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:34:58 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id A570896F52;
 Wed, 21 Aug 2019 16:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1566405297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vatH2bbSlFKH2lP1p0Ci9l3PXtnnf6vO2BL1O07qJEM=;
 b=DDEdHK2bPBiENDjLdXzKzpjfMgvuF2S971d1oS8Tfgh7cl+oc/kwwV53Ti1gyKOS8L5CA0
 ouPFrx0MFPBC5Z5ebn4qyLOvFD/iWmbl79ieIReRDVLXPMeke0LN6ycjdEfdlxestEaTp4
 UGV8yFyIBPYs9tZEnspDuTLBz9llf/U=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 18:33:34 +0200
Message-Id: <20190821163341.16309-4-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821163341.16309-1-damien.hedde@greensocs.com>
References: <20190821163341.16309-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1566405297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vatH2bbSlFKH2lP1p0Ci9l3PXtnnf6vO2BL1O07qJEM=;
 b=tr8AGmZDEiaPXnqE8kngAX2P0gI3srY6beq03kZ38NxlkHx+Ay6M8qmtEnczuHBDzxAtEC
 3jAqwiuFgYfP43PhmMqnJeCjgxkwB8HRDQqSi6ulOJ/Deow6AO5xxMymYSn9MMtXGyfPli
 WqkD0qCMAijL7FeI4vrVgsIxDjfo8+I=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1566405297; a=rsa-sha256; cv=none;
 b=jAqnOuuVCQINpupP2UA6Ps2v71+THWc3D1AEYetunAwCtaiB+OgyXA6MGMCDva3FAYKJCI
 ct7ixoftm9D2OyC3VdB89B0fUyemjP6xK2eYL6Pr2pLnxVkMvlXgQ+ZKRORbTdda6lqNEZ
 Mg/lJ0iVZG7D+epmCvt9jmkobU69Saw=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v4 03/10] hw/core: add Resettable interface in
 Bus and Device classes
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 edgar.iglesias@xilinx.com, berrange@redhat.com, ehabkost@redhat.com,
 mark.burton@greensocs.com, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement Resettable interface in BusClass and DeviceClass; it adds the
ResetState structure into BusState and DeviceState and the required metho=
ds
in the classes.

Helpers device_cold_reset and bus_cold_reset are defined to call to
use the new interface. Also add a [device|bus]_is_resetting telling if th=
e
device/bus is currently under reset.

Compatibility with existing code base is ensured; The legacy bus or devic=
e
reset method is called in the new init phase. Since this phase is called
for children before for parent in qbus hierarchy, the new reset behavior
will be the same as qdev/qbus_reset_all functions; qdev/qbus_reset_all
are now wrappers around device/bus_cold_reset functions.

Deprecate old reset apis (device_legacy_reset and qdev/qbus_reset_all).
These functions will be removed when transition to the new api is complet=
e.

At this point no migration support is required since there is no way to
held an object into reset. This will be added later on.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---

I've kept the device/bus_cold_reset name; I think that even if we don't
introduce other reset types (like warm), it has to advantage to clarify
that current reset is "cold" (it put back what is the initial state when
qemu starts).
---
 hw/core/bus.c          | 53 +++++++++++++++++++++++++++++++
 hw/core/qdev.c         | 71 +++++++++++++++++++++++++++++++-----------
 include/hw/qdev-core.h | 62 +++++++++++++++++++++++++++++++++---
 tests/Makefile.include |  1 +
 4 files changed, 164 insertions(+), 23 deletions(-)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index 7f3d2a3dbd..3be65ad041 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -22,6 +22,7 @@
 #include "qemu/ctype.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
+#include "hw/resettable.h"
=20
 void qbus_set_hotplug_handler(BusState *bus, Object *handler, Error **er=
rp)
 {
@@ -68,6 +69,34 @@ int qbus_walk_children(BusState *bus,
     return 0;
 }
=20
+void bus_cold_reset(BusState *bus)
+{
+    resettable_reset(OBJECT(bus), RESET_TYPE_COLD);
+}
+
+bool bus_is_resetting(BusState *bus)
+{
+    return resettable_is_resetting(OBJECT(bus));
+}
+
+static ResetState *bus_get_reset_state(Object *obj)
+{
+    BusState *bus =3D BUS(obj);
+    return &bus->reset;
+}
+
+static void bus_reset_foreach_child(Object *obj,
+                                    void (*func)(Object *, ResetType),
+                                    ResetType type)
+{
+    BusState *bus =3D BUS(obj);
+    BusChild *kid;
+
+    QTAILQ_FOREACH(kid, &bus->children, sibling) {
+        func(OBJECT(kid->child), type);
+    }
+}
+
 static void qbus_realize(BusState *bus, DeviceState *parent, const char =
*name)
 {
     const char *typename =3D object_get_typename(OBJECT(bus));
@@ -199,12 +228,32 @@ static char *default_bus_get_fw_dev_path(DeviceStat=
e *dev)
     return g_strdup(object_get_typename(OBJECT(dev)));
 }
=20
+/**
+ * bus_legacy_reset_wrapper:
+ * Compatibility wrapper during the transition to multi-phase reset.
+ * This function should be deleted when all buses are converted.
+ */
+static void bus_legacy_reset_wrapper(Object *obj, ResetType type)
+{
+    BusState *bus =3D BUS(obj);
+    BusClass *bc =3D BUS_GET_CLASS(obj);
+
+    if (bc->reset) {
+        bc->reset(bus);
+    }
+}
+
 static void bus_class_init(ObjectClass *class, void *data)
 {
     BusClass *bc =3D BUS_CLASS(class);
+    ResettableClass *rc =3D RESETTABLE_CLASS(class);
=20
     class->unparent =3D bus_unparent;
     bc->get_fw_dev_path =3D default_bus_get_fw_dev_path;
+
+    rc->phases.init =3D bus_legacy_reset_wrapper;
+    rc->get_state =3D bus_get_reset_state;
+    rc->foreach_child =3D bus_reset_foreach_child;
 }
=20
 static void qbus_finalize(Object *obj)
@@ -223,6 +272,10 @@ static const TypeInfo bus_info =3D {
     .instance_init =3D qbus_initfn,
     .instance_finalize =3D qbus_finalize,
     .class_init =3D bus_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_RESETTABLE_INTERFACE },
+        { }
+    },
 };
=20
 static void bus_register_types(void)
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index a95d4fa87d..85c85822fd 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -255,25 +255,9 @@ HotplugHandler *qdev_get_hotplug_handler(DeviceState=
 *dev)
     return hotplug_ctrl;
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
+    device_cold_reset(dev);
 }
=20
 void qdev_reset_all_fn(void *opaque)
@@ -283,7 +267,7 @@ void qdev_reset_all_fn(void *opaque)
=20
 void qbus_reset_all(BusState *bus)
 {
-    qbus_walk_children(bus, NULL, NULL, qdev_reset_one, qbus_reset_one, =
NULL);
+    bus_cold_reset(bus);
 }
=20
 void qbus_reset_all_fn(void *opaque)
@@ -292,6 +276,33 @@ void qbus_reset_all_fn(void *opaque)
     qbus_reset_all(bus);
 }
=20
+void device_cold_reset(DeviceState *dev)
+{
+    resettable_reset(OBJECT(dev), RESET_TYPE_COLD);
+}
+
+bool device_is_resetting(DeviceState *dev)
+{
+    return resettable_is_resetting(OBJECT(dev));
+}
+
+static ResetState *device_get_reset_state(Object *obj)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    return &dev->reset;
+}
+
+static void device_reset_foreach_child(Object *obj,
+                                       void (*func)(Object *, ResetType)=
,
+                                       ResetType type)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    BusState *bus;
+    QLIST_FOREACH(bus, &dev->child_bus, sibling) {
+        func(OBJECT(bus), type);
+    }
+}
+
 /* can be used as ->unplug() callback for the simple cases */
 void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
                                   DeviceState *dev, Error **errp)
@@ -1047,9 +1058,25 @@ static void device_unparent(Object *obj)
     }
 }
=20
+/**
+ * device_legacy_reset_wrapper:
+ * Compatibility wrapper during the transition to multi-phase reset.
+ * This function should be deleted when all devices are converted.
+ */
+static void device_legacy_reset_wrapper(Object *obj, ResetType type)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    DeviceClass *dc =3D DEVICE_GET_CLASS(dev);
+
+    if (dc->reset) {
+        dc->reset(dev);
+    }
+}
+
 static void device_class_init(ObjectClass *class, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(class);
+    ResettableClass *rc =3D RESETTABLE_CLASS(class);
=20
     class->unparent =3D device_unparent;
=20
@@ -1061,6 +1088,10 @@ static void device_class_init(ObjectClass *class, =
void *data)
      */
     dc->hotpluggable =3D true;
     dc->user_creatable =3D true;
+
+    rc->phases.init =3D device_legacy_reset_wrapper;
+    rc->get_state =3D device_get_reset_state;
+    rc->foreach_child =3D device_reset_foreach_child;
 }
=20
 void device_class_set_parent_reset(DeviceClass *dc,
@@ -1118,6 +1149,10 @@ static const TypeInfo device_type_info =3D {
     .class_init =3D device_class_init,
     .abstract =3D true,
     .class_size =3D sizeof(DeviceClass),
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_RESETTABLE_INTERFACE },
+        { }
+    },
 };
=20
 static void qdev_register_types(void)
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 09e6dfd664..2976121fbc 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -5,6 +5,7 @@
 #include "qemu/bitmap.h"
 #include "qom/object.h"
 #include "hw/hotplug.h"
+#include "hw/resettable.h"
=20
 enum {
     DEV_NVECTORS_UNSPECIFIED =3D -1,
@@ -104,6 +105,11 @@ typedef struct DeviceClass {
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
@@ -128,6 +134,7 @@ struct NamedGPIOList {
 /**
  * DeviceState:
  * @realized: Indicates whether the device has been fully constructed.
+ * @reset: ResetState for the device; handled by Resettable interface.
  *
  * This structure should not be accessed directly.  We declare it here
  * so that it can be embedded in individual device state structures.
@@ -149,6 +156,7 @@ struct DeviceState {
     int num_child_bus;
     int instance_id_alias;
     int alias_required_for_version;
+    ResetState reset;
 };
=20
 struct DeviceListener {
@@ -195,6 +203,7 @@ typedef struct BusChild {
 /**
  * BusState:
  * @hotplug_handler: link to a hotplug handler associated with bus.
+ * @reset: ResetState for the bus; handled by Resettable interface.
  */
 struct BusState {
     Object obj;
@@ -206,6 +215,7 @@ struct BusState {
     int num_children;
     QTAILQ_HEAD(, BusChild) children;
     QLIST_ENTRY(BusState) sibling;
+    ResetState reset;
 };
=20
 /**
@@ -375,22 +385,55 @@ int qdev_walk_children(DeviceState *dev,
                        qdev_walkerfn *post_devfn, qbus_walkerfn *post_bu=
sfn,
                        void *opaque);
=20
-void qdev_reset_all(DeviceState *dev);
-void qdev_reset_all_fn(void *opaque);
-
 /**
- * @qbus_reset_all:
- * @bus: Bus to be reset.
+ * qbus/qdev_reset_all:
+ * @bus (resp. @dev): Bus (resp. Device) to be reset.
  *
  * Reset @bus and perform a bus-level ("hard") reset of all devices conn=
ected
  * to it, including recursive processing of all buses below @bus itself.=
  A
  * hard reset means that qbus_reset_all will reset all state of the devi=
ce.
  * For PCI devices, for example, this will include the base address regi=
sters
  * or configuration space.
+ *
+ * These functions are deprecated and are wrappers around device_cold_re=
set and
+ * bus_cold_reset. Please use these instead.
+ * TODO: remove them when all occurrences are removed
  */
+void qdev_reset_all(DeviceState *dev);
+void qdev_reset_all_fn(void *opaque);
 void qbus_reset_all(BusState *bus);
 void qbus_reset_all_fn(void *opaque);
=20
+/**
+ * device_cold_reset:
+ * Trigger a cold reset of the device @dev.
+ *
+ * Use the Resettable interface (see hw/interface.h); it also reset the
+ * device's qdev/qbus subtree.
+ */
+void device_cold_reset(DeviceState *dev);
+
+/**
+ * bus_cold_reset:
+ * Trigger a cold reset of the bus @bus.
+ *
+ * Use the Resettable interface (see hw/interface.h); it also reset the
+ * bus's qdev/qbus subtree.
+ */
+void bus_cold_reset(BusState *bus);
+
+/**
+ * device_is_resetting:
+ * Return true if the device @dev is currently being reset.
+ */
+bool device_is_resetting(DeviceState *dev);
+
+/**
+ * bus_is_resetting:
+ * Return true if the bus @bus is currently being reset.
+ */
+bool bus_is_resetting(BusState *bus);
+
 /* This should go away once we get rid of the NULL bus hack */
 BusState *sysbus_get_default(void);
=20
@@ -409,9 +452,18 @@ void qdev_machine_init(void);
  * device_legacy_reset:
  *
  * Reset a single device (by calling the reset method).
+ *
+ * This function is deprecated, please use Resettable api instead (eg:
+ * device_cold_reset())
+ * TODO: remove the function when all occurrences are removed.
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
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 6f02dfcc01..f0b4628cc6 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -561,6 +561,7 @@ tests/fp/%:
=20
 tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
 	hw/core/qdev.o hw/core/qdev-properties.o hw/core/hotplug.o\
+	hw/core/resettable.o \
 	hw/core/bus.o \
 	hw/core/irq.o \
 	hw/core/fw-path-provider.o \
--=20
2.22.0


