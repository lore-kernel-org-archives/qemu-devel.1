Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71506C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D779820758
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwyE2jld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D779820758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOOza-0001iB-NA
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kOOyS-0000Nj-Lj
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:36:04 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kOOyQ-0003Iz-Ly
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:36:04 -0400
Received: by mail-wr1-x441.google.com with SMTP id z4so2681670wrr.4
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 10:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n/8ETOZvvibYNeWstHPm4Svp3CtDHbXvNRVqHpTs9/k=;
 b=KwyE2jldr5QD4IC5sX3hUkfZSuZsrL5GHhBCsWMjgPFlj3fMCzohrd0pmM1QroqJSa
 TIgw9MHJwowqMG3o+cUYBJiEVY8/PAqYW452dVBPqIaa7rXFqPw11GwfpVJbquHy7DQX
 vUNZycp9ZwLbmwK+04vo/F+7/qvaAEDrBZ6uas4gMKldRaPEAhUBPQfSMxu+0StgFOaj
 eNWC5xbnQatpswqP7ergFEknTeFoRQf2aK3iPXt3iqg9Q0Dr3L7CiN0CyZ8i1a+8cC6Q
 U7dFu92qWUsiesD7COIX6FTFulu3D54eWfDrEZhsruVgG6PBVLIk2QOWCWC7+knqSp+N
 ZKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=n/8ETOZvvibYNeWstHPm4Svp3CtDHbXvNRVqHpTs9/k=;
 b=CfHyyruoO8e5yWpp2eBkTLWLk1HxXM0cGr7jPpZvGReM00GAa+eGaHWBQR271XMeHp
 hIFnJlzMblLMGf8Cgw484gJWYgsQ0FI5i3rwAwGa/SkVHq6Jg46w4n0/Y06xkX7t7JJt
 Uw/6aDSe+Pkkk7WaVsC7eF+eLM7Lr+t/d6j1ONH1YWU8uEKq82iNVjK6ZxPqglm9VGKc
 tTrbzclNWhh78lBZJTrCkoQl5GxGNTEa6GL9UwepeJQ8weNMspW824thvEGEtou/NysF
 UjlNVjZ4za8tZhl99/CYh2B7jyDoc64jno7dRlVubpbvaNhZNPH6WEJR1+OZkAUuOq5z
 UuZA==
X-Gm-Message-State: AOAM531d5VvkY3t0rp01XFcVMMD49aMgock/n9Zllg385oisW+kYLiwo
 auV/0AL9aaEwvc65y+Co9pP0xSzRxvc=
X-Google-Smtp-Source: ABdhPJx8gNEJDh1Ywe8L2zkjxl6pr7ZGXc3V8SwaOCKXOwsv6OBnsAYUFMrddLxLhcdc8xrsmnLBIA==
X-Received: by 2002:adf:cd05:: with SMTP id w5mr4262387wrm.62.1601660160880;
 Fri, 02 Oct 2020 10:36:00 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:47e0:e742:75ba:b84d])
 by smtp.gmail.com with ESMTPSA id
 l8sm2516454wrx.22.2020.10.02.10.36.00 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 10:36:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 01/10] qdev: add "check if address free" callback for buses
Date: Fri,  2 Oct 2020 19:35:49 +0200
Message-Id: <20201002173558.232960-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002173558.232960-1-pbonzini@redhat.com>
References: <20201002173558.232960-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x441.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Check if an address is free on the bus before plugging in the
device.  This makes it possible to do the check without any
side effects, and to detect the problem early without having
to do it in the realize callback.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev.c         | 17 +++++++++++++++--
 hw/net/virtio-net.c    |  2 +-
 hw/sd/core.c           |  3 ++-
 include/hw/qdev-core.h | 13 ++++++++++++-
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 96772a15bd..74db78df36 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -94,13 +94,23 @@ static void bus_add_child(BusState *bus, DeviceState *child)
                              0);
 }
 
-void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
+static bool bus_check_address(BusState *bus, DeviceState *child, Error **errp)
+{
+    BusClass *bc = BUS_GET_CLASS(bus);
+    return !bc->check_address || bc->check_address(bus, child, errp);
+}
+
+bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp)
 {
     BusState *old_parent_bus = dev->parent_bus;
     DeviceClass *dc = DEVICE_GET_CLASS(dev);
 
     assert(dc->bus_type && object_dynamic_cast(OBJECT(bus), dc->bus_type));
 
+    if (!bus_check_address(bus, dev, errp)) {
+        return false;
+    }
+
     if (old_parent_bus) {
         trace_qdev_update_parent_bus(dev, object_get_typename(OBJECT(dev)),
             old_parent_bus, object_get_typename(OBJECT(old_parent_bus)),
@@ -126,6 +136,7 @@ void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
         object_unref(OBJECT(old_parent_bus));
         object_unref(OBJECT(dev));
     }
+    return true;
 }
 
 DeviceState *qdev_new(const char *name)
@@ -371,7 +382,9 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
     assert(!dev->realized && !dev->parent_bus);
 
     if (bus) {
-        qdev_set_parent_bus(dev, bus);
+        if (!qdev_set_parent_bus(dev, bus, errp)) {
+            return false;
+        }
     } else {
         assert(!DEVICE_GET_CLASS(dev)->bus_type);
     }
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7bf27b9db7..268cecc498 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3142,7 +3142,7 @@ static bool failover_replug_primary(VirtIONet *n, Error **errp)
         error_setg(errp, "virtio_net: couldn't find primary bus");
         return false;
     }
-    qdev_set_parent_bus(n->primary_dev, n->primary_bus);
+    qdev_set_parent_bus(n->primary_dev, n->primary_bus, &error_abort);
     n->primary_should_be_hidden = false;
     if (!qemu_opt_set_bool(n->primary_device_opts,
                            "partially_hotplugged", true, errp)) {
diff --git a/hw/sd/core.c b/hw/sd/core.c
index 957d116f1a..08c93b5903 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -23,6 +23,7 @@
 #include "hw/qdev-core.h"
 #include "hw/sd/sd.h"
 #include "qemu/module.h"
+#include "qapi/error.h"
 #include "trace.h"
 
 static inline const char *sdbus_name(SDBus *sdbus)
@@ -240,7 +241,7 @@ void sdbus_reparent_card(SDBus *from, SDBus *to)
     readonly = sc->get_readonly(card);
 
     sdbus_set_inserted(from, false);
-    qdev_set_parent_bus(DEVICE(card), &to->qbus);
+    qdev_set_parent_bus(DEVICE(card), &to->qbus, &error_abort);
     sdbus_set_inserted(to, true);
     sdbus_set_readonly(to, readonly);
 }
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 72064f4dd4..14d476c587 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -210,13 +210,24 @@ struct BusClass {
     /* FIXME first arg should be BusState */
     void (*print_dev)(Monitor *mon, DeviceState *dev, int indent);
     char *(*get_dev_path)(DeviceState *dev);
+
     /*
      * This callback is used to create Open Firmware device path in accordance
      * with OF spec http://forthworks.com/standards/of1275.pdf. Individual bus
      * bindings can be found at http://playground.sun.com/1275/bindings/.
      */
     char *(*get_fw_dev_path)(DeviceState *dev);
+
     void (*reset)(BusState *bus);
+
+    /*
+     * Return whether the device can be added to @bus,
+     * based on the address that was set (via device properties)
+     * before realize.  If not, on return @errp contains the
+     * human-readable error message.
+     */
+    bool (*check_address)(BusState *bus, DeviceState *dev, Error **errp);
+
     BusRealize realize;
     BusUnrealize unrealize;
 
@@ -788,7 +799,7 @@ const char *qdev_fw_name(DeviceState *dev);
 Object *qdev_get_machine(void);
 
 /* FIXME: make this a link<> */
-void qdev_set_parent_bus(DeviceState *dev, BusState *bus);
+bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp);
 
 extern bool qdev_hotplug;
 extern bool qdev_hot_removed;
-- 
2.26.2



