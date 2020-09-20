Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508F5C43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 11:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B129D20EDD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 11:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJoXXiW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B129D20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJxqK-0004ts-Pb
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 07:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJxlY-0001Oc-J7
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 07:44:24 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJxlW-0000Az-TQ
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 07:44:24 -0400
Received: by mail-wm1-x342.google.com with SMTP id q9so9449775wmj.2
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 04:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fDZhs8OFrfrf0ft3+p7SBZ8r0XClNoxh4cVoI6p7qzo=;
 b=bJoXXiW1EZOomSQyJVoxt8zqTE0ZRs7sW5oOl31UvpYvuYjQTqmKNJ6VVr03VEsG95
 jqmF8m18GbJsy7BvsFRpkozw3KO2Veo0eqZI9/QzW2c6ltfQeIEF5x41M6KCjAjOx5yS
 Bcm9jpAwZm2Byp4gtJB0bmngB/sSeZpL72ckcNU3AazBLvm/WP3mCtzatAR3AUqe6KkY
 UdKhWkHNEy3XbfH4J73ANDeqVTNMNEhPp3zUeQnZ0JEyyrRQCXIGmHtduOuL/SSIS6IK
 KOOvHdnKzKIxOFunTx9R9S43rCk/S/az2ewbHhbRJ5e5cQ/7VIYVl4Y9grShrrmw+HcA
 xVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fDZhs8OFrfrf0ft3+p7SBZ8r0XClNoxh4cVoI6p7qzo=;
 b=rO3iNuK46aAre5UlQOwquni2woadjgK+ZXZQVwloErLLkN+b4m81hLdlY+kf0c0+XY
 YiPcG+GfqH82oq9lzguaf0IROeu33XE1BgP3ahDPAdD1OB8rhQe1hRAEz0hqiTmxjVnQ
 ggELfFyTBXjiAUl8k7AXlsETjKf8MFAn40Wzy5HYHiDuEEWGmbBXN4BrSmaCeBK3qB1Y
 VzxaGP/HDBgFelqNkq2dM8QCAwYnml4CfmwEWoBCZEaJDEr8PASvApLT7us/wja/SgeC
 9ThylJ/QbCwsW0oNVqBNSKuwDTWdK143cV2LJHMb0CZ/LGFaOHLe8fqaXtiGiHUALeuA
 FTaQ==
X-Gm-Message-State: AOAM533W3b5DlBNRffByULQwIobihjXxvhJwP8yFktJI/Y2F832Nfw7V
 hSQmb7aF249cWqsVT9Gg4VI=
X-Google-Smtp-Source: ABdhPJypuqaFdVNqHvBqpI9crdclAyxoTwFQkqDzODv3j/C3VX/NRNCq6A2dZPfYNEJ99K9Jv5UuUA==
X-Received: by 2002:a1c:80d7:: with SMTP id
 b206mr24808459wmd.161.1600602261568; 
 Sun, 20 Sep 2020 04:44:21 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id e18sm16415708wra.36.2020.09.20.04.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2020 04:44:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] qdev: Let BusRealize() return a boolean value to indicate
 error
Date: Sun, 20 Sep 2020 13:44:16 +0200
Message-Id: <20200920114416.353277-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200920114416.353277-1-f4bug@amsat.org>
References: <20200920114416.353277-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 9940b2cfbc0 introduced qdev_realize() and qbus_realize()
with the ability to return a boolean value if an error occured,
thus the caller does not need to check if the Error* pointer is
set.
Provide the same ability to the BusRealize type.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/qdev-core.h | 14 +++++++++++++-
 hw/hyperv/vmbus.c      |  5 +++--
 hw/nubus/nubus-bus.c   |  5 +++--
 hw/pci/pci.c           | 12 +++++++++---
 hw/xen/xen-bus.c       |  5 +++--
 5 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 02ac1c50b7f..eecfe794a71 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -32,7 +32,19 @@ typedef enum DeviceCategory {
 typedef void (*DeviceRealize)(DeviceState *dev, Error **errp);
 typedef void (*DeviceUnrealize)(DeviceState *dev);
 typedef void (*DeviceReset)(DeviceState *dev);
-typedef void (*BusRealize)(BusState *bus, Error **errp);
+/**
+ * BusRealize: Realize @bus.
+ * @bus: bus to realize
+ * @errp: pointer to error object
+ *
+ * On success, return true.
+ * On failure, store an error through @errp and return false.
+ */
+typedef bool (*BusRealize)(BusState *bus, Error **errp);
+/**
+ * BusUnrealize: Unrealize @bus.
+ * @bus: bus to unrealize
+ */
 typedef void (*BusUnrealize)(BusState *bus);
 
 /**
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 6ef895bc352..8a0452b2464 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -2487,7 +2487,7 @@ static const TypeInfo vmbus_dev_type_info = {
     .instance_init = vmbus_dev_instance_init,
 };
 
-static void vmbus_realize(BusState *bus, Error **errp)
+static bool vmbus_realize(BusState *bus, Error **errp)
 {
     int ret = 0;
     Error *local_err = NULL;
@@ -2519,7 +2519,7 @@ static void vmbus_realize(BusState *bus, Error **errp)
         goto clear_event_notifier;
     }
 
-    return;
+    return true;
 
 clear_event_notifier:
     event_notifier_cleanup(&vmbus->notifier);
@@ -2528,6 +2528,7 @@ remove_msg_handler:
 error_out:
     qemu_mutex_destroy(&vmbus->rx_queue_lock);
     error_propagate(errp, local_err);
+    return false;
 }
 
 static void vmbus_unrealize(BusState *bus)
diff --git a/hw/nubus/nubus-bus.c b/hw/nubus/nubus-bus.c
index 942a6d5342d..d20d9c0f72c 100644
--- a/hw/nubus/nubus-bus.c
+++ b/hw/nubus/nubus-bus.c
@@ -65,12 +65,13 @@ static const MemoryRegionOps nubus_super_slot_ops = {
     },
 };
 
-static void nubus_realize(BusState *bus, Error **errp)
+static bool nubus_realize(BusState *bus, Error **errp)
 {
     if (!nubus_find()) {
         error_setg(errp, "at most one %s device is permitted", TYPE_NUBUS_BUS);
-        return;
+        return false;
     }
+    return true;
 }
 
 static void nubus_init(Object *obj)
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index de0fae10ab9..f535ebac847 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -115,7 +115,7 @@ static void pcibus_machine_done(Notifier *notifier, void *data)
     }
 }
 
-static void pci_bus_realize(BusState *qbus, Error **errp)
+static bool pci_bus_realize(BusState *qbus, Error **errp)
 {
     PCIBus *bus = PCI_BUS(qbus);
 
@@ -123,13 +123,17 @@ static void pci_bus_realize(BusState *qbus, Error **errp)
     qemu_add_machine_init_done_notifier(&bus->machine_done);
 
     vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_pcibus, bus);
+
+    return true;
 }
 
-static void pcie_bus_realize(BusState *qbus, Error **errp)
+static bool pcie_bus_realize(BusState *qbus, Error **errp)
 {
     PCIBus *bus = PCI_BUS(qbus);
 
-    pci_bus_realize(qbus, errp);
+    if (!pci_bus_realize(qbus, errp)) {
+        return false;
+    }
 
     /*
      * A PCI-E bus can support extended config space if it's the root
@@ -144,6 +148,8 @@ static void pcie_bus_realize(BusState *qbus, Error **errp)
             bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
         }
     }
+
+    return true;
 }
 
 static void pci_bus_unrealize(BusState *qbus)
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 9ce1c9540b9..d7ef5d05e37 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -444,7 +444,7 @@ static void xen_bus_unrealize(BusState *bus)
     }
 }
 
-static void xen_bus_realize(BusState *bus, Error **errp)
+static bool xen_bus_realize(BusState *bus, Error **errp)
 {
     XenBus *xenbus = XEN_BUS(bus);
     unsigned int domid;
@@ -478,10 +478,11 @@ static void xen_bus_realize(BusState *bus, Error **errp)
                           "failed to set up enumeration watch: ");
     }
 
-    return;
+    return true;
 
 fail:
     xen_bus_unrealize(bus);
+    return false;
 }
 
 static void xen_bus_unplug_request(HotplugHandler *hotplug,
-- 
2.26.2


