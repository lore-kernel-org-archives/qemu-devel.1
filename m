Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A57C35257
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA6DE20758
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0GIfbyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6DE20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOP63-0007qi-RK
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kOOyW-0000Ux-82
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:36:08 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52211)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kOOyU-0003Jj-8v
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:36:07 -0400
Received: by mail-wm1-x344.google.com with SMTP id w2so2452893wmi.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 10:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vBU6G6EU3K8FuII/2jOnVZJBfwDDD7ouVQlKQ+GYXJE=;
 b=N0GIfbyI7/nweGJQHXHd8QxJIGriJlQQdKUHZHYvP2NhhbTvsMxwGo0Xn0WzkukK7X
 30EaIf01UnmUB7fc1B/LVHCqviW8G0DpIO3Rxc5psdhzc+2PHblS52y0Y/aSOijvgN0M
 HPJJY+y+jwc/xBeSvw0uv+jurLOjXRgiJGLJL829cpugEqsGGyUmixtQVgrEqouEB7Yl
 WMjYK0Ac1PqQkeraBcFU/wu0ZzJcPyVY8zWAFmyKcOXPo2pAorPfWWnYySOj6CxmW4PV
 PehP9dIwyoD13g++HmZCk2q9jjKWZjm8K5MEmG2co38u2sukDOX3ofL0vAEWWiV01Tq+
 41wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vBU6G6EU3K8FuII/2jOnVZJBfwDDD7ouVQlKQ+GYXJE=;
 b=X+xlMUSyUAf68/OxpbpHd73Op5i/GK+IUcRjPihEP/6HkZkRgm2MI+ZYcvEgNJ9GSL
 wBReSMtn2gLH0COfKkT35ThCAYrUrgU4YzTjHHLlpDPLopjzxM/UYnDR5fYcwSFX0bJS
 w7OVS+rPClEjkRgRaZ+dDDqxZG6tlmn0EkRunZzqupnYDEfDKk4zBpMfjDRhOOFY/tHZ
 og/Tnm8E+BlDxn/5GxSUzGyBmzEukqlev14D/i0EcSPdaBiusNFpHzQLwT3IA0GE2+E/
 pGAq0i7JKTt7ABIDoiYS4icDxxtVK4/OcXJuPX4/r9jxfvcCCeeslVOaIi9c3mGpY3Ql
 0BhA==
X-Gm-Message-State: AOAM531Yk0Hci1jS8fg9nNd9axIzMXmO9LaqMlQTzYJ3WIQ+JKVm1H4O
 l0sgHNwLS9tgoYsK0bU60c1WCiJKEo8=
X-Google-Smtp-Source: ABdhPJyTJmRwDUfcySw//UROlE7h1LhhQvPLoPxoW2d9KHHTWDvGcTL438SZsUR7vuSySJ0rN1fPtg==
X-Received: by 2002:a1c:7912:: with SMTP id l18mr4045879wme.124.1601660164500; 
 Fri, 02 Oct 2020 10:36:04 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:47e0:e742:75ba:b84d])
 by smtp.gmail.com with ESMTPSA id
 l8sm2516454wrx.22.2020.10.02.10.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 10:36:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 05/10] device-core: use RCU for list of children of a bus
Date: Fri,  2 Oct 2020 19:35:53 +0200
Message-Id: <20201002173558.232960-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002173558.232960-1-pbonzini@redhat.com>
References: <20201002173558.232960-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

This fixes the race between device emulation code that tries to find
a child device to dispatch the request to (e.g a scsi disk),
and hotplug of a new device to that bus.

Note that this doesn't convert all the readers of the list
but only these that might go over that list without BQL held.

This is a very small first step to make this code thread safe.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200913160259.32145-5-mlevitsk@redhat.com>
[Use RCU_READ_LOCK_GUARD in more places, adjust testcase now that
 the delay in DEVICE_DELETED due to RCU is more consistent. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/bus.c                | 28 ++++++++++++++++-----------
 hw/core/qdev.c               | 37 ++++++++++++++++++++++--------------
 hw/scsi/scsi-bus.c           | 12 +++++++++---
 hw/scsi/virtio-scsi.c        |  6 +++++-
 include/hw/qdev-core.h       |  9 +++++++++
 tests/qtest/drive_del-test.c | 10 +++-------
 6 files changed, 66 insertions(+), 36 deletions(-)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index 6b987b6946..a0483859ae 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -49,12 +49,14 @@ int qbus_walk_children(BusState *bus,
         }
     }
 
-    QTAILQ_FOREACH(kid, &bus->children, sibling) {
-        err = qdev_walk_children(kid->child,
-                                 pre_devfn, pre_busfn,
-                                 post_devfn, post_busfn, opaque);
-        if (err < 0) {
-            return err;
+    WITH_RCU_READ_LOCK_GUARD() {
+        QTAILQ_FOREACH_RCU(kid, &bus->children, sibling) {
+            err = qdev_walk_children(kid->child,
+                                     pre_devfn, pre_busfn,
+                                     post_devfn, post_busfn, opaque);
+            if (err < 0) {
+                return err;
+            }
         }
     }
 
@@ -90,8 +92,10 @@ static void bus_reset_child_foreach(Object *obj, ResettableChildCallback cb,
     BusState *bus = BUS(obj);
     BusChild *kid;
 
-    QTAILQ_FOREACH(kid, &bus->children, sibling) {
-        cb(OBJECT(kid->child), opaque, type);
+    WITH_RCU_READ_LOCK_GUARD() {
+        QTAILQ_FOREACH_RCU(kid, &bus->children, sibling) {
+            cb(OBJECT(kid->child), opaque, type);
+        }
     }
 }
 
@@ -194,9 +198,11 @@ static void bus_set_realized(Object *obj, bool value, Error **errp)
 
         /* TODO: recursive realization */
     } else if (!value && bus->realized) {
-        QTAILQ_FOREACH(kid, &bus->children, sibling) {
-            DeviceState *dev = kid->child;
-            qdev_unrealize(dev);
+        WITH_RCU_READ_LOCK_GUARD() {
+            QTAILQ_FOREACH_RCU(kid, &bus->children, sibling) {
+                DeviceState *dev = kid->child;
+                qdev_unrealize(dev);
+            }
         }
         if (bc->unrealize) {
             bc->unrealize(bus);
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 74db78df36..59e5e710b7 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -51,6 +51,12 @@ const VMStateDescription *qdev_get_vmsd(DeviceState *dev)
     return dc->vmsd;
 }
 
+static void bus_free_bus_child(BusChild *kid)
+{
+    object_unref(OBJECT(kid->child));
+    g_free(kid);
+}
+
 static void bus_remove_child(BusState *bus, DeviceState *child)
 {
     BusChild *kid;
@@ -60,15 +66,16 @@ static void bus_remove_child(BusState *bus, DeviceState *child)
             char name[32];
 
             snprintf(name, sizeof(name), "child[%d]", kid->index);
-            QTAILQ_REMOVE(&bus->children, kid, sibling);
+            QTAILQ_REMOVE_RCU(&bus->children, kid, sibling);
 
             bus->num_children--;
 
             /* This gives back ownership of kid->child back to us.  */
             object_property_del(OBJECT(bus), name);
-            object_unref(OBJECT(kid->child));
-            g_free(kid);
-            return;
+
+            /* free the bus kid, when it is safe to do so*/
+            call_rcu(kid, bus_free_bus_child, rcu);
+            break;
         }
     }
 }
@@ -83,7 +90,7 @@ static void bus_add_child(BusState *bus, DeviceState *child)
     kid->child = child;
     object_ref(OBJECT(kid->child));
 
-    QTAILQ_INSERT_HEAD(&bus->children, kid, sibling);
+    QTAILQ_INSERT_HEAD_RCU(&bus->children, kid, sibling);
 
     /* This transfers ownership of kid->child to the property.  */
     snprintf(name, sizeof(name), "child[%d]", kid->index);
@@ -672,17 +679,19 @@ DeviceState *qdev_find_recursive(BusState *bus, const char *id)
     DeviceState *ret;
     BusState *child;
 
-    QTAILQ_FOREACH(kid, &bus->children, sibling) {
-        DeviceState *dev = kid->child;
+    WITH_RCU_READ_LOCK_GUARD() {
+        QTAILQ_FOREACH_RCU(kid, &bus->children, sibling) {
+            DeviceState *dev = kid->child;
 
-        if (dev->id && strcmp(dev->id, id) == 0) {
-            return dev;
-        }
+            if (dev->id && strcmp(dev->id, id) == 0) {
+                return dev;
+            }
 
-        QLIST_FOREACH(child, &dev->child_bus, sibling) {
-            ret = qdev_find_recursive(child, id);
-            if (ret) {
-                return ret;
+            QLIST_FOREACH(child, &dev->child_bus, sibling) {
+                ret = qdev_find_recursive(child, id);
+                if (ret) {
+                    return ret;
+                }
             }
         }
     }
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 69d7c3f90c..4ab9811cd8 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -399,7 +399,10 @@ static bool scsi_target_emulate_report_luns(SCSITargetReq *r)
     id = r->req.dev->id;
     found_lun0 = false;
     n = 0;
-    QTAILQ_FOREACH(kid, &r->req.bus->qbus.children, sibling) {
+
+    RCU_READ_LOCK_GUARD();
+
+    QTAILQ_FOREACH_RCU(kid, &r->req.bus->qbus.children, sibling) {
         DeviceState *qdev = kid->child;
         SCSIDevice *dev = SCSI_DEVICE(qdev);
 
@@ -420,7 +423,7 @@ static bool scsi_target_emulate_report_luns(SCSITargetReq *r)
     memset(r->buf, 0, len);
     stl_be_p(&r->buf[0], n);
     i = found_lun0 ? 8 : 16;
-    QTAILQ_FOREACH(kid, &r->req.bus->qbus.children, sibling) {
+    QTAILQ_FOREACH_RCU(kid, &r->req.bus->qbus.children, sibling) {
         DeviceState *qdev = kid->child;
         SCSIDevice *dev = SCSI_DEVICE(qdev);
 
@@ -429,6 +432,7 @@ static bool scsi_target_emulate_report_luns(SCSITargetReq *r)
             i += 8;
         }
     }
+
     assert(i == n + 8);
     r->len = len;
     return true;
@@ -1571,7 +1575,8 @@ SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int id, int lun)
     BusChild *kid;
     SCSIDevice *target_dev = NULL;
 
-    QTAILQ_FOREACH(kid, &bus->qbus.children, sibling) {
+    RCU_READ_LOCK_GUARD();
+    QTAILQ_FOREACH_RCU(kid, &bus->qbus.children, sibling) {
         DeviceState *qdev = kid->child;
         SCSIDevice *dev = SCSI_DEVICE(qdev);
 
@@ -1590,6 +1595,7 @@ SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int id, int lun)
             }
         }
     }
+
     return target_dev;
 }
 
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 3a71ea7097..971afbb217 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -367,12 +367,16 @@ static int virtio_scsi_do_tmf(VirtIOSCSI *s, VirtIOSCSIReq *req)
     case VIRTIO_SCSI_T_TMF_I_T_NEXUS_RESET:
         target = req->req.tmf.lun[1];
         s->resetting++;
-        QTAILQ_FOREACH(kid, &s->bus.qbus.children, sibling) {
+
+        rcu_read_lock();
+        QTAILQ_FOREACH_RCU(kid, &s->bus.qbus.children, sibling) {
              d = SCSI_DEVICE(kid->child);
              if (d->channel == 0 && d->id == target) {
                 qdev_reset_all(&d->qdev);
              }
         }
+        rcu_read_unlock();
+
         s->resetting--;
         break;
 
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 14d476c587..2c6307e3ed 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -3,6 +3,8 @@
 
 #include "qemu/queue.h"
 #include "qemu/bitmap.h"
+#include "qemu/rcu.h"
+#include "qemu/rcu_queue.h"
 #include "qom/object.h"
 #include "hw/hotplug.h"
 #include "hw/resettable.h"
@@ -238,6 +240,7 @@ struct BusClass {
 };
 
 typedef struct BusChild {
+    struct rcu_head rcu;
     DeviceState *child;
     int index;
     QTAILQ_ENTRY(BusChild) sibling;
@@ -258,6 +261,12 @@ struct BusState {
     int max_index;
     bool realized;
     int num_children;
+
+    /*
+     * children is a RCU QTAILQ, thus readers must use RCU to access it,
+     * and writers must hold the big qemu lock
+     */
+
     QTAILQ_HEAD(, BusChild) children;
     QLIST_ENTRY(BusState) sibling;
     ResettableState reset;
diff --git a/tests/qtest/drive_del-test.c b/tests/qtest/drive_del-test.c
index 2d765865ce..05184124a2 100644
--- a/tests/qtest/drive_del-test.c
+++ b/tests/qtest/drive_del-test.c
@@ -15,9 +15,6 @@
 #include "libqos/virtio.h"
 #include "qapi/qmp/qdict.h"
 
-/* TODO actually test the results and get rid of this */
-#define qmp_discard_response(q, ...) qobject_unref(qtest_qmp(q, __VA_ARGS__))
-
 static void drive_add(QTestState *qts)
 {
     char *resp = qtest_hmp(qts, "drive_add 0 if=none,id=drive0");
@@ -38,12 +35,11 @@ static void device_del(QTestState *qts)
 {
     QDict *response;
 
-    /* Complication: ignore DEVICE_DELETED event */
-    qmp_discard_response(qts, "{'execute': 'device_del',"
-                         " 'arguments': { 'id': 'dev0' } }");
-    response = qtest_qmp_receive(qts);
+    response = qtest_qmp(qts, "{'execute': 'device_del',"
+                              " 'arguments': { 'id': 'dev0' } }");
     g_assert(response);
     g_assert(qdict_haskey(response, "return"));
+    qtest_qmp_eventwait(qts, "DEVICE_DELETED");
     qobject_unref(response);
 }
 
-- 
2.26.2



