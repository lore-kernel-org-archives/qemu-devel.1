Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2FECA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:19:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C2032083E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2032083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPall-0000sY-Cz
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 19:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iPaUF-0000i1-GA
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iPaUC-0004Wy-Gr
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:01:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iPaUB-0004Ul-Vb
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:01:12 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 00D873D966
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 23:01:11 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id v23so490442qth.20
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 16:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CzFv8ebrPTL3yAM5evd3C7PxrDndYE9Xv4AbmIuLYjo=;
 b=kvKsRyfydle+k7/FI3gkSYnrj0VeXvNt9enNaKZ1kvAVAlcUZCtBqGfNT/RTAvMpoU
 Vyy8Aqns3eVKztKdXg0fB78i/16No4I1UMko1kF+sKRbbVR40WABcuxtz4ZTdlYZlBed
 8cvp5K6428hd/NwHB3b5XOSwW9zL3Bkm8102dJW3SqWo9Sz4W5X6Sc6CdETAt6l17d9W
 erX1bFdPLEGZ+KsY/JhLVryPSs1YWnz9EWRlVszwonVZbv99Y3fc6UP8PuCgw3hgUvYT
 aG3PCfQ+OSn48edHKAZKoKGVLcF+iGgagevLboLw6I6cHuBwc9WDwObpPGSMiNQy2pZN
 frWw==
X-Gm-Message-State: APjAAAVY/UwtpY487pfhuCCUDOTC6WV+arRPUh/jyZUtBNFTK94ggnOL
 gElN1E50LWPsvLbSg97sCc3zQD6Txl6FxUvFeA+z9XfsKsnpPvNL2faZla/FCgZ8YJnz6IyFF2M
 XBlJoq+E0BnJndr0=
X-Received: by 2002:a05:6214:1e8:: with SMTP id
 c8mr25258913qvu.191.1572390069697; 
 Tue, 29 Oct 2019 16:01:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqysSXEaGee7RErYdhs+RKUz8Zwd4qn9XukzPldYo+8zXE4EE/wi9QTx34kxdsdzJQI0z12bVQ==
X-Received: by 2002:a05:6214:1e8:: with SMTP id
 c8mr25258854qvu.191.1572390069100; 
 Tue, 29 Oct 2019 16:01:09 -0700 (PDT)
Received: from redhat.com (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id d64sm427172qkf.83.2019.10.29.16.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 16:01:08 -0700 (PDT)
Date: Tue, 29 Oct 2019 19:01:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/14] net/virtio: add failover support
Message-ID: <20191029225932.14585-11-mst@redhat.com>
References: <20191029225932.14585-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029225932.14585-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jens Freimann <jfreimann@redhat.com>

This patch adds support to handle failover device pairs of a virtio-net
device and a (vfio-)pci device, where the virtio-net acts as the standby
device and the (vfio-)pci device as the primary.

The general idea is that we have a pair of devices, a (vfio-)pci and a
emulated (virtio-net) device. Before migration the vfio device is
unplugged and data flows to the emulated device, on the target side
another (vfio-)pci device is plugged in to take over the data-path. In the
guest the net_failover module will pair net devices with the same MAC
address.

To achieve this we need:

1. Provide a callback function for the should_be_hidden DeviceListener.
   It is called when the primary device is plugged in. Evaluate the QOpt
   passed in to check if it is the matching primary device. It returns
   if the device should be hidden or not.
   When it should be hidden it stores the device options in the VirtioNet
   struct and the device is added once the VIRTIO_NET_F_STANDBY feature is
   negotiated during virtio feature negotiation.

   If the virtio-net devices are not realized at the time the (vfio-)pci
   devices are realized, we need to connect the devices later. This way
   we make sure primary and standby devices can be specified in any
   order.

2. Register a callback for migration status notifier. When called it
   will unplug its primary device before the migration happens.

3. Register a callback for the migration code that checks if a device
   needs to be unplugged from the guest.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Message-Id: <20191029114905.6856-11-jfreimann@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS                    |   1 +
 docs/virtio-net-failover.rst   |  68 ++++++++
 hw/net/virtio-net.c            | 302 +++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-net.h |  12 ++
 include/hw/virtio/virtio.h     |   1 +
 5 files changed, 384 insertions(+)
 create mode 100644 docs/virtio-net-failover.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 325e67a04e..c958fc71ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1435,6 +1435,7 @@ S: Odd Fixes
 F: hw/net/
 F: include/hw/net/
 F: tests/virtio-net-test.c
+F: docs/virtio-net-failover.rst
 T: git https://github.com/jasowang/qemu.git net
 
 Parallel NOR Flash devices
diff --git a/docs/virtio-net-failover.rst b/docs/virtio-net-failover.rst
new file mode 100644
index 0000000000..22f64c7bc8
--- /dev/null
+++ b/docs/virtio-net-failover.rst
@@ -0,0 +1,68 @@
+========================
+QEMU virtio-net standby (net_failover)
+========================
+
+This document explains the setup and usage of virtio-net standby feature which
+is used to create a net_failover pair of devices.
+
+The general idea is that we have a pair of devices, a (vfio-)pci and a
+virtio-net device. Before migration the vfio device is unplugged and data flows
+through the virtio-net device, on the target side another vfio-pci device is
+plugged in to take over the data-path. In the guest the net_failover kernel
+module will pair net devices with the same MAC address.
+
+The two devices are called primary and standby device. The fast hardware based
+networking device is called the primary device and the virtio-net device is the
+standby device.
+
+Restrictions
+------------
+
+Currently only PCIe devices are allowed as primary devices, this restriction
+can be lifted in the future with enhanced QEMU support. Also, only networking
+devices are allowed as primary device. The user needs to ensure that primary
+and standby devices are not plugged into the same PCIe slot.
+
+Usecase
+-------
+
+  Virtio-net standby allows easy migration while using a passed-through fast
+  networking device by falling back to a virtio-net device for the duration of
+  the migration. It is like a simple version of a bond, the difference is that it
+  requires no configuration in the guest. When a guest is live-migrated to
+  another host QEMU will unplug the primary device via the PCIe based hotplug
+  handler and traffic will go through the virtio-net device.  On the target
+  system the primary device will be automatically plugged back and the
+  net_failover module registers it again as the primary device.
+
+Usage
+-----
+
+  The primary device can be hotplugged or be part of the startup configuration
+
+  -device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:6f:55:cc, \
+    bus=root2,failover=on
+
+  With the parameter failover=on the VIRTIO_NET_F_STANDBY feature will be enabled.
+
+  -device vfio-pci,host=5e:00.2,id=hostdev0,bus=root1,failover_pair_id=net1
+
+  failover_pair_id references the id of the virtio-net standby device. This
+  is only for pairing the devices within QEMU. The guest kernel module
+  net_failover will match devices with identical MAC addresses.
+
+Hotplug
+-------
+
+  Both primary and standby device can be hotplugged via the QEMU monitor.  Note
+  that if the virtio-net device is plugged first a warning will be issued that it
+  couldn't find the primary device.
+
+Migration
+---------
+
+  A new migration state wait-unplug was added for this feature. If failover primary
+  devices are present in the configuration, migration will go into this state.
+  It will wait until the device unplug is completed in the guest and then move into
+  active state. On the target system the primary devices will be automatically hotplugged
+  when the feature bit was negotiated for the virtio-net standby device.
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index d3d688a5f8..314f365e7c 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/atomic.h"
 #include "qemu/iov.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
@@ -21,6 +22,10 @@
 #include "net/tap.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
+#include "qemu/option.h"
+#include "qemu/option_int.h"
+#include "qemu/config-file.h"
+#include "qapi/qmp/qdict.h"
 #include "hw/virtio/virtio-net.h"
 #include "net/vhost_net.h"
 #include "net/announce.h"
@@ -28,11 +33,15 @@
 #include "qapi/error.h"
 #include "qapi/qapi-events-net.h"
 #include "hw/qdev-properties.h"
+#include "qapi/qapi-types-migration.h"
+#include "qapi/qapi-events-migration.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
 #include "standard-headers/linux/ethtool.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
+#include "monitor/qdev.h"
+#include "hw/pci/pci.h"
 
 #define VIRTIO_NET_VM_VERSION    11
 
@@ -746,9 +755,99 @@ static inline uint64_t virtio_net_supported_guest_offloads(VirtIONet *n)
     return virtio_net_guest_offloads_by_features(vdev->guest_features);
 }
 
+static void failover_add_primary(VirtIONet *n, Error **errp)
+{
+    Error *err = NULL;
+
+    n->primary_device_opts = qemu_opts_find(qemu_find_opts("device"),
+            n->primary_device_id);
+    if (n->primary_device_opts) {
+        n->primary_dev = qdev_device_add(n->primary_device_opts, &err);
+        if (err) {
+            qemu_opts_del(n->primary_device_opts);
+        }
+        if (n->primary_dev) {
+            n->primary_bus = n->primary_dev->parent_bus;
+            if (err) {
+                qdev_unplug(n->primary_dev, &err);
+                qdev_set_id(n->primary_dev, "");
+
+            }
+        }
+    } else {
+        error_setg(errp, "Primary device not found");
+        error_append_hint(errp, "Virtio-net failover will not work. Make "
+            "sure primary device has parameter"
+            " failover_pair_id=<virtio-net-id>\n");
+}
+    if (err) {
+        error_propagate(errp, err);
+    }
+}
+
+static int is_my_primary(void *opaque, QemuOpts *opts, Error **errp)
+{
+    VirtIONet *n = opaque;
+    int ret = 0;
+
+    const char *standby_id = qemu_opt_get(opts, "failover_pair_id");
+
+    if (standby_id != NULL && (g_strcmp0(standby_id, n->netclient_name) == 0)) {
+        n->primary_device_id = g_strdup(opts->id);
+        ret = 1;
+    }
+
+    return ret;
+}
+
+static DeviceState *virtio_net_find_primary(VirtIONet *n, Error **errp)
+{
+    DeviceState *dev = NULL;
+    Error *err = NULL;
+
+    if (qemu_opts_foreach(qemu_find_opts("device"),
+                         is_my_primary, n, &err)) {
+        if (err) {
+            error_propagate(errp, err);
+            return NULL;
+        }
+        if (n->primary_device_id) {
+            dev = qdev_find_recursive(sysbus_get_default(),
+                    n->primary_device_id);
+        } else {
+            error_setg(errp, "Primary device id not found");
+            return NULL;
+        }
+    }
+    return dev;
+}
+
+
+
+static DeviceState *virtio_connect_failover_devices(VirtIONet *n,
+                                                    DeviceState *dev,
+                                                    Error **errp)
+{
+    DeviceState *prim_dev = NULL;
+    Error *err = NULL;
+
+    prim_dev = virtio_net_find_primary(n, &err);
+    if (prim_dev) {
+        n->primary_device_id = g_strdup(prim_dev->id);
+        n->primary_device_opts = prim_dev->opts;
+    } else {
+        if (err) {
+            error_propagate(errp, err);
+        }
+    }
+
+    return prim_dev;
+}
+
 static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
+    Error *err = NULL;
     int i;
 
     if (n->mtu_bypass_backend &&
@@ -790,6 +889,28 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
     } else {
         memset(n->vlans, 0xff, MAX_VLAN >> 3);
     }
+
+    if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
+        qapi_event_send_failover_negotiated(n->netclient_name);
+        atomic_set(&n->primary_should_be_hidden, false);
+        failover_add_primary(n, &err);
+        if (err) {
+            n->primary_dev = virtio_connect_failover_devices(n, n->qdev, &err);
+            if (err) {
+                goto out_err;
+            }
+            failover_add_primary(n, &err);
+            if (err) {
+                goto out_err;
+            }
+        }
+    }
+    return;
+
+out_err:
+    if (err) {
+        warn_report_err(err);
+    }
 }
 
 static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
@@ -2650,6 +2771,150 @@ void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
     n->netclient_type = g_strdup(type);
 }
 
+static bool failover_unplug_primary(VirtIONet *n)
+{
+    HotplugHandler *hotplug_ctrl;
+    PCIDevice *pci_dev;
+    Error *err = NULL;
+
+    hotplug_ctrl = qdev_get_hotplug_handler(n->primary_dev);
+    if (hotplug_ctrl) {
+        pci_dev = PCI_DEVICE(n->primary_dev);
+        pci_dev->partially_hotplugged = true;
+        hotplug_handler_unplug_request(hotplug_ctrl, n->primary_dev, &err);
+        if (err) {
+            error_report_err(err);
+            return false;
+        }
+    } else {
+        return false;
+    }
+    return true;
+}
+
+static bool failover_replug_primary(VirtIONet *n, Error **errp)
+{
+    HotplugHandler *hotplug_ctrl;
+    PCIDevice *pdev = PCI_DEVICE(n->primary_dev);
+
+    if (!pdev->partially_hotplugged) {
+        return true;
+    }
+    if (!n->primary_device_opts) {
+        n->primary_device_opts = qemu_opts_from_qdict(
+                qemu_find_opts("device"),
+                n->primary_device_dict, errp);
+    }
+    if (n->primary_device_opts) {
+        if (n->primary_dev) {
+            n->primary_bus = n->primary_dev->parent_bus;
+        }
+        qdev_set_parent_bus(n->primary_dev, n->primary_bus);
+        n->primary_should_be_hidden = false;
+        qemu_opt_set_bool(n->primary_device_opts,
+                "partially_hotplugged", true, errp);
+        hotplug_ctrl = qdev_get_hotplug_handler(n->primary_dev);
+        if (hotplug_ctrl) {
+            hotplug_handler_pre_plug(hotplug_ctrl, n->primary_dev, errp);
+            hotplug_handler_plug(hotplug_ctrl, n->primary_dev, errp);
+        }
+        if (!n->primary_dev) {
+            error_setg(errp, "virtio_net: couldn't find primary device");
+        }
+    }
+    return *errp != NULL;
+}
+
+static void virtio_net_handle_migration_primary(VirtIONet *n,
+                                                MigrationState *s)
+{
+    bool should_be_hidden;
+    Error *err = NULL;
+
+    should_be_hidden = atomic_read(&n->primary_should_be_hidden);
+
+    if (!n->primary_dev) {
+        n->primary_dev = virtio_connect_failover_devices(n, n->qdev, &err);
+        if (!n->primary_dev) {
+            return;
+        }
+    }
+
+    if (migration_in_setup(s) && !should_be_hidden &&
+        n->primary_dev) {
+        if (failover_unplug_primary(n)) {
+            vmstate_unregister(n->primary_dev, qdev_get_vmsd(n->primary_dev),
+                    n->primary_dev);
+            qapi_event_send_unplug_primary(n->primary_device_id);
+            atomic_set(&n->primary_should_be_hidden, true);
+        } else {
+            warn_report("couldn't unplug primary device");
+        }
+    } else if (migration_has_failed(s)) {
+        /* We already unplugged the device let's plugged it back */
+        if (!failover_replug_primary(n, &err)) {
+            if (err) {
+                error_report_err(err);
+            }
+        }
+    }
+}
+
+static void virtio_net_migration_state_notifier(Notifier *notifier, void *data)
+{
+    MigrationState *s = data;
+    VirtIONet *n = container_of(notifier, VirtIONet, migration_state);
+    virtio_net_handle_migration_primary(n, s);
+}
+
+static int virtio_net_primary_should_be_hidden(DeviceListener *listener,
+            QemuOpts *device_opts)
+{
+    VirtIONet *n = container_of(listener, VirtIONet, primary_listener);
+    bool match_found;
+    bool hide;
+
+    n->primary_device_dict = qemu_opts_to_qdict(device_opts,
+            n->primary_device_dict);
+    if (n->primary_device_dict) {
+        g_free(n->standby_id);
+        n->standby_id = g_strdup(qdict_get_try_str(n->primary_device_dict,
+                    "failover_pair_id"));
+    }
+    if (device_opts && g_strcmp0(n->standby_id, n->netclient_name) == 0) {
+        match_found = true;
+    } else {
+        match_found = false;
+        hide = false;
+        g_free(n->standby_id);
+        n->primary_device_dict = NULL;
+        goto out;
+    }
+
+    n->primary_device_opts = device_opts;
+
+    /* primary_should_be_hidden is set during feature negotiation */
+    hide = atomic_read(&n->primary_should_be_hidden);
+
+    if (n->primary_device_dict) {
+        g_free(n->primary_device_id);
+        n->primary_device_id = g_strdup(qdict_get_try_str(
+                    n->primary_device_dict, "id"));
+        if (!n->primary_device_id) {
+            warn_report("primary_device_id not set");
+        }
+    }
+
+out:
+    if (match_found && hide) {
+        return 1;
+    } else if (match_found && !hide) {
+        return 0;
+    } else {
+        return -1;
+    }
+}
+
 static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -2680,6 +2945,16 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         n->host_features |= (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
     }
 
+    if (n->failover) {
+        n->primary_listener.should_be_hidden =
+            virtio_net_primary_should_be_hidden;
+        atomic_set(&n->primary_should_be_hidden, true);
+        device_listener_register(&n->primary_listener);
+        n->migration_state.notify = virtio_net_migration_state_notifier;
+        add_migration_state_change_notifier(&n->migration_state);
+        n->host_features |= (1ULL << VIRTIO_NET_F_STANDBY);
+    }
+
     virtio_net_set_config_size(n, n->host_features);
     virtio_init(vdev, "virtio-net", VIRTIO_ID_NET, n->config_size);
 
@@ -2802,6 +3077,13 @@ static void virtio_net_device_unrealize(DeviceState *dev, Error **errp)
     g_free(n->mac_table.macs);
     g_free(n->vlans);
 
+    if (n->failover) {
+        g_free(n->primary_device_id);
+        g_free(n->standby_id);
+        qobject_unref(n->primary_device_dict);
+        n->primary_device_dict = NULL;
+    }
+
     max_queues = n->multiqueue ? n->max_queues : 1;
     for (i = 0; i < max_queues; i++) {
         virtio_net_del_queue(n, i);
@@ -2839,6 +3121,23 @@ static int virtio_net_pre_save(void *opaque)
     return 0;
 }
 
+static bool primary_unplug_pending(void *opaque)
+{
+    DeviceState *dev = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIONet *n = VIRTIO_NET(vdev);
+
+    return n->primary_dev ? n->primary_dev->pending_deleted_event : false;
+}
+
+static bool dev_unplug_pending(void *opaque)
+{
+    DeviceState *dev = opaque;
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(dev);
+
+    return vdc->primary_unplug_pending(dev);
+}
+
 static const VMStateDescription vmstate_virtio_net = {
     .name = "virtio-net",
     .minimum_version_id = VIRTIO_NET_VM_VERSION,
@@ -2848,6 +3147,7 @@ static const VMStateDescription vmstate_virtio_net = {
         VMSTATE_END_OF_LIST()
     },
     .pre_save = virtio_net_pre_save,
+    .dev_unplug_pending = dev_unplug_pending,
 };
 
 static Property virtio_net_properties[] = {
@@ -2909,6 +3209,7 @@ static Property virtio_net_properties[] = {
                      true),
     DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
     DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
+    DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -2934,6 +3235,7 @@ static void virtio_net_class_init(ObjectClass *klass, void *data)
     vdc->legacy_features |= (0x1 << VIRTIO_NET_F_GSO);
     vdc->post_load = virtio_net_post_load_virtio;
     vdc->vmsd = &vmstate_virtio_net_device;
+    vdc->primary_unplug_pending = primary_unplug_pending;
 }
 
 static const TypeInfo virtio_net_info = {
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 07a9319f4b..96c68d4a92 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -18,6 +18,7 @@
 #include "standard-headers/linux/virtio_net.h"
 #include "hw/virtio/virtio.h"
 #include "net/announce.h"
+#include "qemu/option_int.h"
 
 #define TYPE_VIRTIO_NET "virtio-net-device"
 #define VIRTIO_NET(obj) \
@@ -43,6 +44,7 @@ typedef struct virtio_net_conf
     int32_t speed;
     char *duplex_str;
     uint8_t duplex;
+    char *primary_id_str;
 } virtio_net_conf;
 
 /* Coalesced packets type & status */
@@ -187,6 +189,16 @@ struct VirtIONet {
     AnnounceTimer announce_timer;
     bool needs_vnet_hdr_swap;
     bool mtu_bypass_backend;
+    QemuOpts *primary_device_opts;
+    QDict *primary_device_dict;
+    DeviceState *primary_dev;
+    BusState *primary_bus;
+    char *primary_device_id;
+    char *standby_id;
+    bool primary_should_be_hidden;
+    bool failover;
+    DeviceListener primary_listener;
+    Notifier migration_state;
 };
 
 void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 60bbc0e18a..3448d67d2a 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -160,6 +160,7 @@ typedef struct VirtioDeviceClass {
      */
     int (*post_load)(VirtIODevice *vdev);
     const VMStateDescription *vmsd;
+    bool (*primary_unplug_pending)(void *opaque);
 } VirtioDeviceClass;
 
 void virtio_instance_init_common(Object *proxy_obj, void *data,
-- 
MST


