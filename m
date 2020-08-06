Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A6EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144F922DCC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144F922DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3cMx-0001In-I9
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 05:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1k3cKe-0005Cj-T8; Thu, 06 Aug 2020 05:37:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41100 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1k3cKa-0007WM-3w; Thu, 06 Aug 2020 05:37:04 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 503E7F36D7E3FE41B97E;
 Thu,  6 Aug 2020 17:36:51 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 6 Aug 2020 17:36:43 +0800
From: Peng Liang <liangpeng10@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH 2/5] log: Add log for each modules
Date: Thu, 6 Aug 2020 17:37:17 +0800
Message-ID: <20200806093720.2355692-3-liangpeng10@huawei.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200806093720.2355692-1-liangpeng10@huawei.com>
References: <20200806093720.2355692-1-liangpeng10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35;
 envelope-from=liangpeng10@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:36:23
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peng Liang <liangpeng10@huawei.com>, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add log for each modules.

Signed-off-by: Peng Liang <liangpeng10@huawei.com>
---
 accel/kvm/kvm-all.c         |  5 ++++-
 hw/pci/pci.c                |  1 +
 hw/usb/host-libusb.c        |  5 +++++
 hw/virtio/virtio-pci.c      |  2 ++
 hw/virtio/virtio-scsi-pci.c |  3 +++
 hw/virtio/virtio.c          | 13 +++++++++++--
 monitor/monitor.c           |  9 +++++++++
 monitor/qmp-cmds.c          |  2 ++
 os-posix.c                  |  1 +
 qapi/qmp-dispatch.c         | 17 +++++++++++++++++
 qdev-monitor.c              |  6 ++++++
 11 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 63ef6af9a1..f23e82a67d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1427,7 +1427,10 @@ void kvm_irqchip_commit_routes(KVMState *s)
     s->irq_routes->flags = 0;
     trace_kvm_irqchip_commit_routes();
     ret = kvm_vm_ioctl(s, KVM_SET_GSI_ROUTING, s->irq_routes);
-    assert(ret == 0);
+    if (ret < 0) {
+        error_report("Set GSI routing failed");
+        abort();
+    }
 }
 
 static void kvm_add_routing_entry(KVMState *s,
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index de0fae10ab..9132049f82 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2365,6 +2365,7 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
     } else {
         snprintf(name, sizeof(name), "%s.rom", object_get_typename(OBJECT(pdev)));
     }
+    info_report("add rom file: %s", name);
     pdev->has_rom = true;
     memory_region_init_rom(&pdev->rom, OBJECT(pdev), name, size, &error_fatal);
     ptr = memory_region_get_ram_ptr(&pdev->rom);
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index c474551d84..c3b85b7b2d 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -904,6 +904,8 @@ static int usb_host_open(USBHostDevice *s, libusb_device *dev, int hostfd)
 
         rc = libusb_open(dev, &s->dh);
         if (rc != 0) {
+            info_report("libusb open usb device bus %d, device %d failed",
+                        bus_num, addr);
             goto fail;
         }
     } else {
@@ -931,6 +933,7 @@ static int usb_host_open(USBHostDevice *s, libusb_device *dev, int hostfd)
 
     libusb_get_device_descriptor(dev, &s->ddesc);
     usb_host_get_port(s->dev, s->port, sizeof(s->port));
+    info_report("open a host usb device on bus %d, device %d", bus_num, addr);
 
     usb_ep_init(udev);
     usb_host_ep_update(s);
@@ -1016,6 +1019,8 @@ static int usb_host_close(USBHostDevice *s)
         usb_device_detach(udev);
     }
 
+    info_report("begin to reset the usb device, bus : %d,"
+                " device : %d", s->bus_num, s->addr);
     usb_host_release_interfaces(s);
     libusb_reset_device(s->dh);
     usb_host_attach_kernel(s);
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index ccdf54e81c..f688ded432 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1708,7 +1708,9 @@ static void virtio_pci_device_unplugged(DeviceState *d)
     VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
     bool modern = virtio_pci_modern(proxy);
     bool modern_pio = proxy->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY;
+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
 
+    info_report("device name: %s", !vdev ? "NULL" : vdev->name);
     virtio_pci_stop_ioeventfd(proxy);
 
     if (modern) {
diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.c
index c23a134202..b6285d2ffd 100644
--- a/hw/virtio/virtio-scsi-pci.c
+++ b/hw/virtio/virtio-scsi-pci.c
@@ -19,6 +19,7 @@
 #include "hw/virtio/virtio-scsi.h"
 #include "qemu/module.h"
 #include "virtio-pci.h"
+#include "qemu/error-report.h"
 
 typedef struct VirtIOSCSIPCI VirtIOSCSIPCI;
 
@@ -50,6 +51,8 @@ static void virtio_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     DeviceState *proxy = DEVICE(vpci_dev);
     char *bus_name;
 
+    info_report("virtio scsi HBA %s begin to initialize.",
+                !proxy->id ? "NULL" : proxy->id);
     if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
         vpci_dev->nvectors = vs->conf.num_queues + 3;
     }
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e983025217..f3568f5267 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1957,7 +1957,13 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
         k->set_status(vdev, val);
     }
     vdev->status = val;
-
+    if (val) {
+        info_report("%s device status is %d that means %s", vdev->name, val,
+                    (val & VIRTIO_CONFIG_S_DRIVER_OK) ? "DRIVER OK" :
+                    (val & VIRTIO_CONFIG_S_DRIVER) ? "DRIVER" :
+                    (val & VIRTIO_CONFIG_S_ACKNOWLEDGE) ? "ACKNOWLEDGE" :
+                    (val & VIRTIO_CONFIG_S_FAILED) ? "FAILED" : "UNKNOWN");
+    }
     return 0;
 }
 
@@ -2403,8 +2409,11 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
             break;
     }
 
-    if (i == VIRTIO_QUEUE_MAX || queue_size > VIRTQUEUE_MAX_SIZE)
+    if (i == VIRTIO_QUEUE_MAX || queue_size > VIRTQUEUE_MAX_SIZE) {
+        info_report("unacceptable queue_size (%d) or num (%d)",
+                    queue_size, i);
         abort();
+    }
 
     vdev->vq[i].vring.num = queue_size;
     vdev->vq[i].vring.num_default = queue_size;
diff --git a/monitor/monitor.c b/monitor/monitor.c
index b385a3d569..e57583dc10 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -30,6 +30,7 @@
 #include "qapi/qapi-visit-control.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
+#include "qapi/qmp/qjson.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "sysemu/qtest.h"
@@ -258,6 +259,7 @@ static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
 {
     Monitor *mon;
     MonitorQMP *qmp_mon;
+    QString *json;
 
     trace_monitor_protocol_event_emit(event, qdict);
     QTAILQ_FOREACH(mon, &mon_list, entry) {
@@ -268,6 +270,13 @@ static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
         qmp_mon = container_of(mon, MonitorQMP, common);
         if (qmp_mon->commands != &qmp_cap_negotiation_commands) {
             qmp_send_response(qmp_mon, qdict);
+            json = qobject_to_json(QOBJECT(qdict));
+            if (json) {
+                if (!strstr(json->string, "RTC_CHANGE")) {
+                    info_report("%s", qstring_get_str(json));
+                }
+                qobject_unref(json);
+            }
         }
     }
 }
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 864cbfa32e..4a7869512d 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -155,8 +155,10 @@ void qmp_cont(Error **errp)
     }
 
     if (runstate_check(RUN_STATE_INMIGRATE)) {
+        info_report("qmp cont is received in migration");
         autostart = 1;
     } else {
+        info_report("qmp cont is received and vm is started");
         vm_start();
     }
 }
diff --git a/os-posix.c b/os-posix.c
index 3572db3f44..ec7f3ea542 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -343,6 +343,7 @@ int os_mlock(void)
 #ifdef HAVE_MLOCKALL
     int ret = 0;
 
+    info_report("do mlockall");
     ret = mlockall(MCL_CURRENT | MCL_FUTURE);
     if (ret < 0) {
         error_report("mlockall: %s", strerror(errno));
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 79347e0864..35bc9b0c24 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -18,6 +18,8 @@
 #include "qapi/qmp/qjson.h"
 #include "sysemu/runstate.h"
 #include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qstring.h"
+#include "qemu/error-report.h"
 
 static QDict *qmp_dispatch_check_obj(QDict *dict, bool allow_oob,
                                      Error **errp)
@@ -96,6 +98,7 @@ QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
     const char *command;
     QDict *args;
     const QmpCommand *cmd;
+    QString *json;
     QDict *dict;
     QObject *id;
     QObject *ret = NULL;
@@ -152,6 +155,20 @@ QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
         args = qdict_get_qdict(dict, "arguments");
         qobject_ref(args);
     }
+
+    json = qobject_to_json(QOBJECT(args));
+    if (json) {
+        if ((strcmp(command, "query-block-jobs") != 0)
+            && (strcmp(command, "query-migrate") != 0)
+            && (strcmp(command, "query-blockstats") != 0)
+            && (strcmp(command, "query-balloon") != 0)
+            && (strcmp(command, "set_password") != 0)) {
+            info_report("qmp_cmd_name: %s, arguments: %s",
+                        command, qstring_get_str(json));
+        }
+        qobject_unref(json);
+    }
+
     cmd->fn(args, &ret, &err);
     qobject_unref(args);
     if (err) {
diff --git a/qdev-monitor.c b/qdev-monitor.c
index e9b7228480..0b974046bd 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -619,6 +619,7 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
     if (path != NULL) {
         bus = qbus_find(path, errp);
         if (!bus) {
+            info_report("can not find bus for %s", driver);
             return NULL;
         }
         if (!object_dynamic_cast(OBJECT(bus), dc->bus_type)) {
@@ -669,6 +670,8 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
 
     /* set properties */
     if (qemu_opt_foreach(opts, set_property, dev, errp)) {
+        info_report("the bus %s -driver %s set property failed",
+                    bus ? bus->name : "None", driver);
         goto err_del_dev;
     }
 
@@ -677,6 +680,9 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
         dev->opts = NULL;
         goto err_del_dev;
     }
+    info_report("add qdev %s:%s success", driver,
+                qemu_opts_id(opts) ? qemu_opts_id(opts) : "none");
+
     return dev;
 
 err_del_dev:
-- 
2.18.4


