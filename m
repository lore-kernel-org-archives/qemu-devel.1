Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AA9C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:08:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64892064A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64892064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyKAk-0006q8-Qu
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1hyK2U-0000GG-Ho
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hyK2R-0001zh-6A
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57032)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hyK2P-0001wI-T1
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3F4118E90E;
 Thu, 15 Aug 2019 17:59:49 +0000 (UTC)
Received: from thuth.com (ovpn-116-65.ams2.redhat.com [10.36.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 735F51EA;
 Thu, 15 Aug 2019 17:59:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 19:59:21 +0200
Message-Id: <20190815175922.3475-9-thuth@redhat.com>
In-Reply-To: <20190815175922.3475-1-thuth@redhat.com>
References: <20190815175922.3475-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 15 Aug 2019 17:59:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 8/9] tests/libqtest: Make
 qtest_qmp_device_add/del independent from global_qtest
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Generic library functions like qtest_qmp_device_add() and _del()
should not depend on the global_qtest variable. Pass the test
state via parameter instead.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20190813093047.27948-6-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/cpu-plug-test.c      | 15 +++++++++------
 tests/e1000e-test.c        |  2 +-
 tests/ivshmem-test.c       |  2 +-
 tests/libqos/usb.c         |  6 +++---
 tests/libqos/usb.h         |  2 +-
 tests/libqtest.c           | 15 +++++++--------
 tests/libqtest.h           |  8 +++++---
 tests/usb-hcd-ohci-test.c  |  2 +-
 tests/usb-hcd-uhci-test.c  |  8 +++++---
 tests/usb-hcd-xhci-test.c  | 22 +++++++++++++---------
 tests/virtio-blk-test.c    |  2 +-
 tests/virtio-ccw-test.c    | 20 +++++++++++---------
 tests/virtio-net-test.c    |  2 +-
 tests/virtio-rng-test.c    |  2 +-
 tests/virtio-scsi-test.c   |  6 ++++--
 tests/virtio-serial-test.c |  4 ++--
 16 files changed, 66 insertions(+), 52 deletions(-)

diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
index 668f00144e..3049620854 100644
--- a/tests/cpu-plug-test.c
+++ b/tests/cpu-plug-test.c
@@ -77,18 +77,19 @@ static void test_plug_with_device_add_x86(gconstpointer data)
     const PlugTestData *td = data;
     char *args;
     unsigned int s, c, t;
+    QTestState *qts;
 
     args = g_strdup_printf("-machine %s -cpu %s "
                            "-smp 1,sockets=%u,cores=%u,threads=%u,maxcpus=%u",
                            td->machine, td->cpu_model,
                            td->sockets, td->cores, td->threads, td->maxcpus);
-    qtest_start(args);
+    qts = qtest_init(args);
 
     for (s = 1; s < td->sockets; s++) {
         for (c = 0; c < td->cores; c++) {
             for (t = 0; t < td->threads; t++) {
                 char *id = g_strdup_printf("id-%i-%i-%i", s, c, t);
-                qtest_qmp_device_add(td->device_model, id,
+                qtest_qmp_device_add(qts, td->device_model, id,
                                      "{'socket-id':%u, 'core-id':%u,"
                                      " 'thread-id':%u}",
                                      s, c, t);
@@ -97,7 +98,7 @@ static void test_plug_with_device_add_x86(gconstpointer data)
         }
     }
 
-    qtest_end();
+    qtest_quit(qts);
     g_free(args);
 }
 
@@ -106,20 +107,22 @@ static void test_plug_with_device_add_coreid(gconstpointer data)
     const PlugTestData *td = data;
     char *args;
     unsigned int c;
+    QTestState *qts;
 
     args = g_strdup_printf("-machine %s -cpu %s "
                            "-smp 1,sockets=%u,cores=%u,threads=%u,maxcpus=%u",
                            td->machine, td->cpu_model,
                            td->sockets, td->cores, td->threads, td->maxcpus);
-    qtest_start(args);
+    qts = qtest_init(args);
 
     for (c = 1; c < td->cores; c++) {
         char *id = g_strdup_printf("id-%i", c);
-        qtest_qmp_device_add(td->device_model, id, "{'core-id':%u}", c);
+        qtest_qmp_device_add(qts, td->device_model, id,
+                             "{'core-id':%u}", c);
         g_free(id);
     }
 
-    qtest_end();
+    qtest_quit(qts);
     g_free(args);
 }
 
diff --git a/tests/e1000e-test.c b/tests/e1000e-test.c
index 445787a7e4..93628c588d 100644
--- a/tests/e1000e-test.c
+++ b/tests/e1000e-test.c
@@ -235,7 +235,7 @@ static void test_e1000e_hotplug(void *obj, void *data, QGuestAllocator * alloc)
 {
     QTestState *qts = global_qtest;  /* TODO: get rid of global_qtest here */
 
-    qtest_qmp_device_add("e1000e", "e1000e_net", "{'addr': '0x06'}");
+    qtest_qmp_device_add(qts, "e1000e", "e1000e_net", "{'addr': '0x06'}");
     qpci_unplug_acpi_device_test(qts, "e1000e_net", 0x06);
 }
 
diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
index a467b8c03d..b76457948b 100644
--- a/tests/ivshmem-test.c
+++ b/tests/ivshmem-test.c
@@ -389,7 +389,7 @@ static void test_ivshmem_hotplug(void)
     qts = qtest_init("-object memory-backend-ram,size=1M,id=mb1");
 
     global_qtest = qts;  /* TODO: Get rid of global_qtest here */
-    qtest_qmp_device_add("ivshmem-plain", "iv1",
+    qtest_qmp_device_add(qts, "ivshmem-plain", "iv1",
                          "{'addr': %s, 'memdev': 'mb1'}",
                          stringify(PCI_SLOT_HP));
     if (strcmp(arch, "ppc64") != 0) {
diff --git a/tests/libqos/usb.c b/tests/libqos/usb.c
index 49e2f4bc0a..d7a9cb3c72 100644
--- a/tests/libqos/usb.c
+++ b/tests/libqos/usb.c
@@ -37,20 +37,20 @@ void uhci_port_test(struct qhc *hc, int port, uint16_t expect)
     g_assert((value & mask) == (expect & mask));
 }
 
-void usb_test_hotplug(const char *hcd_id, const char *port,
+void usb_test_hotplug(QTestState *qts, const char *hcd_id, const char *port,
                       void (*port_check)(void))
 {
     char *id = g_strdup_printf("usbdev%s", port);
     char *bus = g_strdup_printf("%s.0", hcd_id);
 
-    qtest_qmp_device_add("usb-tablet", id, "{'port': %s, 'bus': %s}",
+    qtest_qmp_device_add(qts, "usb-tablet", id, "{'port': %s, 'bus': %s}",
                          port, bus);
 
     if (port_check) {
         port_check();
     }
 
-    qtest_qmp_device_del(id);
+    qtest_qmp_device_del(qts, id);
 
     g_free(bus);
     g_free(id);
diff --git a/tests/libqos/usb.h b/tests/libqos/usb.h
index c506418a13..eeced39a2f 100644
--- a/tests/libqos/usb.h
+++ b/tests/libqos/usb.h
@@ -13,6 +13,6 @@ void qusb_pci_init_one(QPCIBus *pcibus, struct qhc *hc,
 void uhci_port_test(struct qhc *hc, int port, uint16_t expect);
 void uhci_deinit(struct qhc *hc);
 
-void usb_test_hotplug(const char *bus_name, const char *port,
+void usb_test_hotplug(QTestState *qts, const char *bus_name, const char *port,
                       void (*port_check)(void));
 #endif
diff --git a/tests/libqtest.c b/tests/libqtest.c
index d1aead30ed..19c1fc2e97 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -1246,7 +1246,7 @@ QDict *qtest_qmp_receive_success(QTestState *s,
 /*
  * Generic hot-plugging test via the device_add QMP command.
  */
-void qtest_qmp_device_add(const char *driver, const char *id,
+void qtest_qmp_device_add(QTestState *qts, const char *driver, const char *id,
                           const char *fmt, ...)
 {
     QDict *args, *response;
@@ -1260,7 +1260,8 @@ void qtest_qmp_device_add(const char *driver, const char *id,
     qdict_put_str(args, "driver", driver);
     qdict_put_str(args, "id", id);
 
-    response = qmp("{'execute': 'device_add', 'arguments': %p}", args);
+    response = qtest_qmp(qts, "{'execute': 'device_add', 'arguments': %p}",
+                         args);
     g_assert(response);
     g_assert(!qdict_haskey(response, "event")); /* We don't expect any events */
     g_assert(!qdict_haskey(response, "error"));
@@ -1293,19 +1294,17 @@ static void device_deleted_cb(void *opaque, const char *name, QDict *data)
  *
  * But the order of arrival may vary - so we've got to detect both.
  */
-void qtest_qmp_device_del(const char *id)
+void qtest_qmp_device_del(QTestState *qts, const char *id)
 {
     bool got_event = false;
     QDict *rsp;
 
-    qtest_qmp_send(global_qtest,
-                   "{'execute': 'device_del', 'arguments': {'id': %s}}",
+    qtest_qmp_send(qts, "{'execute': 'device_del', 'arguments': {'id': %s}}",
                    id);
-    rsp = qtest_qmp_receive_success(global_qtest, device_deleted_cb,
-                                    &got_event);
+    rsp = qtest_qmp_receive_success(qts, device_deleted_cb, &got_event);
     qobject_unref(rsp);
     if (!got_event) {
-        rsp = qtest_qmp_receive(global_qtest);
+        rsp = qtest_qmp_receive(qts);
         g_assert_cmpstr(qdict_get_try_str(rsp, "event"),
                         ==, "DEVICE_DELETED");
         qobject_unref(rsp);
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 0009b65791..d93144fb74 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -946,6 +946,7 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
 
 /**
  * qtest_qmp_device_add:
+ * @qts: QTestState instance to operate on
  * @driver: Name of the device that should be added
  * @id: Identification string
  * @fmt...: QMP message to send to qemu, formatted like
@@ -954,16 +955,17 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
  *
  * Generic hot-plugging test via the device_add QMP command.
  */
-void qtest_qmp_device_add(const char *driver, const char *id, const char *fmt,
-                          ...) GCC_FMT_ATTR(3, 4);
+void qtest_qmp_device_add(QTestState *qts, const char *driver, const char *id,
+                          const char *fmt, ...) GCC_FMT_ATTR(4, 5);
 
 /**
  * qtest_qmp_device_del:
+ * @qts: QTestState instance to operate on
  * @id: Identification string
  *
  * Generic hot-unplugging test via the device_del QMP command.
  */
-void qtest_qmp_device_del(const char *id);
+void qtest_qmp_device_del(QTestState *qts, const char *id);
 
 /**
  * qmp_rsp_is_err:
diff --git a/tests/usb-hcd-ohci-test.c b/tests/usb-hcd-ohci-test.c
index c12b892085..0cd73b7363 100644
--- a/tests/usb-hcd-ohci-test.c
+++ b/tests/usb-hcd-ohci-test.c
@@ -23,7 +23,7 @@ struct QOHCI_PCI {
 
 static void test_ohci_hotplug(void *obj, void *data, QGuestAllocator *alloc)
 {
-    usb_test_hotplug("ohci", "1", NULL);
+    usb_test_hotplug(global_qtest, "ohci", "1", NULL);
 }
 
 static void *ohci_pci_get_driver(void *obj, const char *interface)
diff --git a/tests/usb-hcd-uhci-test.c b/tests/usb-hcd-uhci-test.c
index 6d355c29da..2eef8e3d1c 100644
--- a/tests/usb-hcd-uhci-test.c
+++ b/tests/usb-hcd-uhci-test.c
@@ -43,14 +43,16 @@ static void test_port_2(void)
 
 static void test_uhci_hotplug(void)
 {
-    usb_test_hotplug("uhci", "2", test_port_2);
+    usb_test_hotplug(global_qtest, "uhci", "2", test_port_2);
 }
 
 static void test_usb_storage_hotplug(void)
 {
-    qtest_qmp_device_add("usb-storage", "usbdev0", "{'drive': 'drive0'}");
+    QTestState *qts = global_qtest;
 
-    qtest_qmp_device_del("usbdev0");
+    qtest_qmp_device_add(qts, "usb-storage", "usbdev0", "{'drive': 'drive0'}");
+
+    qtest_qmp_device_del(qts, "usbdev0");
 }
 
 int main(int argc, char **argv)
diff --git a/tests/usb-hcd-xhci-test.c b/tests/usb-hcd-xhci-test.c
index b15a51123f..01845371f9 100644
--- a/tests/usb-hcd-xhci-test.c
+++ b/tests/usb-hcd-xhci-test.c
@@ -18,30 +18,34 @@ static void test_xhci_init(void)
 
 static void test_xhci_hotplug(void)
 {
-    usb_test_hotplug("xhci", "1", NULL);
+    usb_test_hotplug(global_qtest, "xhci", "1", NULL);
 }
 
 static void test_usb_uas_hotplug(void)
 {
-    qtest_qmp_device_add("usb-uas", "uas", "{}");
-    qtest_qmp_device_add("scsi-hd", "scsihd", "{'drive': 'drive0'}");
+    QTestState *qts = global_qtest;
+
+    qtest_qmp_device_add(qts, "usb-uas", "uas", "{}");
+    qtest_qmp_device_add(qts, "scsi-hd", "scsihd", "{'drive': 'drive0'}");
 
     /* TODO:
         UAS HBA driver in libqos, to check that
         added disk is visible after BUS rescan
     */
 
-    qtest_qmp_device_del("scsihd");
-    qtest_qmp_device_del("uas");
+    qtest_qmp_device_del(qts, "scsihd");
+    qtest_qmp_device_del(qts, "uas");
 }
 
 static void test_usb_ccid_hotplug(void)
 {
-    qtest_qmp_device_add("usb-ccid", "ccid", "{}");
-    qtest_qmp_device_del("ccid");
+    QTestState *qts = global_qtest;
+
+    qtest_qmp_device_add(qts, "usb-ccid", "ccid", "{}");
+    qtest_qmp_device_del(qts, "ccid");
     /* check the device can be added again */
-    qtest_qmp_device_add("usb-ccid", "ccid", "{}");
-    qtest_qmp_device_del("ccid");
+    qtest_qmp_device_add(qts, "usb-ccid", "ccid", "{}");
+    qtest_qmp_device_del(qts, "ccid");
 }
 
 int main(int argc, char **argv)
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 882b08ae29..982ff1538c 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -690,7 +690,7 @@ static void pci_hotplug(void *obj, void *data, QGuestAllocator *t_alloc)
     QTestState *qts = dev1->pdev->bus->qts;
 
     /* plug secondary disk */
-    qtest_qmp_device_add("virtio-blk-pci", "drv1",
+    qtest_qmp_device_add(qts, "virtio-blk-pci", "drv1",
                          "{'addr': %s, 'drive': 'drive1'}",
                          stringify(PCI_SLOT_HP) ".0");
 
diff --git a/tests/virtio-ccw-test.c b/tests/virtio-ccw-test.c
index 6be4e6aaf6..9f445ef4ad 100644
--- a/tests/virtio-ccw-test.c
+++ b/tests/virtio-ccw-test.c
@@ -45,10 +45,12 @@ static void virtio_serial_nop(void)
 
 static void virtio_serial_hotplug(void)
 {
-    global_qtest = qtest_initf("-device virtio-serial-ccw");
-    qtest_qmp_device_add("virtserialport", "hp-port", "{}");
-    qtest_qmp_device_del("hp-port");
-    qtest_end();
+    QTestState *qts = qtest_initf("-device virtio-serial-ccw");
+
+    qtest_qmp_device_add(qts, "virtserialport", "hp-port", "{}");
+    qtest_qmp_device_del(qts, "hp-port");
+
+    qtest_quit(qts);
 }
 
 static void virtio_blk_nop(void)
@@ -79,16 +81,16 @@ static void virtio_scsi_nop(void)
 
 static void virtio_scsi_hotplug(void)
 {
-    global_qtest = qtest_initf("-drive if=none,id=drv0,file=null-co://,"
-                               "file.read-zeroes=on,format=raw "
+    QTestState *s = qtest_initf("-drive if=none,id=drv0,file=null-co://,"
+                                "file.read-zeroes=on,format=raw "
                                 "-drive if=none,id=drv1,file=null-co://,"
                                 "file.read-zeroes=on,format=raw "
                                 "-device virtio-scsi-ccw "
                                 "-device scsi-hd,drive=drv0");
-    qtest_qmp_device_add("scsi-hd", "scsihd", "{'drive': 'drv1'}");
-    qtest_qmp_device_del("scsihd");
+    qtest_qmp_device_add(s, "scsi-hd", "scsihd", "{'drive': 'drv1'}");
+    qtest_qmp_device_del(s, "scsihd");
 
-    qtest_end();
+    qtest_quit(s);
 }
 
 int main(int argc, char **argv)
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 1071dd82c9..840875aaae 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -174,7 +174,7 @@ static void hotplug(void *obj, void *data, QGuestAllocator *t_alloc)
     QTestState *qts = dev->pdev->bus->qts;
     const char *arch = qtest_get_arch();
 
-    qtest_qmp_device_add("virtio-net-pci", "net1",
+    qtest_qmp_device_add(qts, "virtio-net-pci", "net1",
                          "{'addr': %s}", stringify(PCI_SLOT_HP));
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
diff --git a/tests/virtio-rng-test.c b/tests/virtio-rng-test.c
index a38a0d175b..092ba13068 100644
--- a/tests/virtio-rng-test.c
+++ b/tests/virtio-rng-test.c
@@ -22,7 +22,7 @@ static void rng_hotplug(void *obj, void *data, QGuestAllocator *alloc)
 
     const char *arch = qtest_get_arch();
 
-    qtest_qmp_device_add("virtio-rng-pci", "rng1",
+    qtest_qmp_device_add(qts, "virtio-rng-pci", "rng1",
                          "{'addr': %s}", stringify(PCI_SLOT_HP));
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
index 6393272149..16481491e3 100644
--- a/tests/virtio-scsi-test.c
+++ b/tests/virtio-scsi-test.c
@@ -150,8 +150,10 @@ static QVirtioSCSIQueues *qvirtio_scsi_init(QVirtioDevice *dev)
 
 static void hotplug(void *obj, void *data, QGuestAllocator *alloc)
 {
-    qtest_qmp_device_add("scsi-hd", "scsihd", "{'drive': 'drv1'}");
-    qtest_qmp_device_del("scsihd");
+    QTestState *qts = global_qtest;
+
+    qtest_qmp_device_add(qts, "scsi-hd", "scsihd", "{'drive': 'drv1'}");
+    qtest_qmp_device_del(qts, "scsihd");
 }
 
 /* Test WRITE SAME with the lba not aligned */
diff --git a/tests/virtio-serial-test.c b/tests/virtio-serial-test.c
index 066ca61280..e584ad76e8 100644
--- a/tests/virtio-serial-test.c
+++ b/tests/virtio-serial-test.c
@@ -20,8 +20,8 @@ static void virtio_serial_nop(void *obj, void *data, QGuestAllocator *alloc)
 
 static void serial_hotplug(void *obj, void *data, QGuestAllocator *alloc)
 {
-    qtest_qmp_device_add("virtserialport", "hp-port", "{}");
-    qtest_qmp_device_del("hp-port");
+    qtest_qmp_device_add(global_qtest, "virtserialport", "hp-port", "{}");
+    qtest_qmp_device_del(global_qtest, "hp-port");
 }
 
 static void register_virtio_serial_test(void)
-- 
2.18.1


