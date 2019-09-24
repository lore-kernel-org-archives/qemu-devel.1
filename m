Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE75C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16782214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="AzWRIHCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16782214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCjE4-0004fc-Oi
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 07:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1iCj2O-0002PV-Cx
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1iCj2K-0005HA-GG
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:31:20 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:17963)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1iCj2K-0005Fj-6l
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1569324677;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=V2U8e+HabmdsYmqhlEYja60hkM+cXhexkTTFzMhph6o=;
 b=AzWRIHCzIw4jdoDl3yOfRrs5zF1grQ4fEFmi0lDvBWQaJSs/9xY6lPGF
 8pk0/keOtsqXDS61mToqqyE2rx870l2xcrmK1l8fHPn+GjoUwYUHu0zXJ
 O6yoHH4X/CIJRXDgTtJtJtZUdcbMKaVUtluTcrPIk5CBmF5x4fACF9oSs o=;
Authentication-Results: esa2.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: dTgdXBjAfZSQKKdPxguNNicmHzVINOidnNlI99CdZGJ1no/tvOOLuQmjLrEzZW3UrwZjZXNHDh
 3xCHu+LcGBgk0wjkYNN0lvqh558z5q4Z3nYwAX1PLxwe8ClA5hJk5iaboXAcQtDqaS0+S2q7ai
 4TEfUC/jzkqydd//J0Nc6qKXVa8QoCAwHds6+I3rKNxJzIqeJXbHg5Z2yqxRuxaNwUKj+MfdOx
 XOCWFcHysxuivn1dt9Nzyg0eSim+ca6zKg1zjVJtNJgZH8SpZDDBS95XHtZUmauqP1p8uxlvPO
 0xs=
X-SBRS: 2.7
X-MesageID: 5977600
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,543,1559534400"; 
   d="scan'208";a="5977600"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Subject: [PULL 3/7] xen: introduce separate XenWatchList for XenDevice objects
Date: Tue, 24 Sep 2019 12:30:22 +0100
Message-ID: <20190924113026.255634-4-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190924113026.255634-1-anthony.perard@citrix.com>
References: <20190924113026.255634-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.153
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
Cc: Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paul Durrant <paul.durrant@citrix.com>

This patch uses the XenWatchList abstraction to add a separate watch list
for each device. This is more scalable than walking a single notifier
list for all watches and is also necessary to implement a bug-fix in a
subsequent patch.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Anthony Perard <anthony.perard@citrix.com>
Message-Id: <20190913082159.31338-3-paul.durrant@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/xen/trace-events      |  2 ++
 hw/xen/xen-bus.c         | 72 ++++++++++++++++++++++++++++++++--------
 include/hw/xen/xen-bus.h |  2 ++
 3 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/hw/xen/trace-events b/hw/xen/trace-events
index ac8d9c20d2..80ce3dafad 100644
--- a/hw/xen/trace-events
+++ b/hw/xen/trace-events
@@ -29,6 +29,8 @@ xen_device_backend_changed(const char *type, char *name) "type: %s name: %s"
 xen_device_frontend_state(const char *type, char *name, const char *state) "type: %s name: %s -> %s"
 xen_device_frontend_changed(const char *type, char *name) "type: %s name: %s"
 xen_device_unplug(const char *type, char *name) "type: %s name: %s"
+xen_device_add_watch(const char *type, char *name, const char *node, const char *key) "type: %s name: %s node: %s key: %s"
+xen_device_remove_watch(const char *type, char *name, const char *node, const char *key) "type: %s name: %s node: %s key: %s"
 
 # xen-bus-helper.c
 xs_node_create(const char *node) "%s"
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 28efaccff2..810a4e2df3 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -235,11 +235,11 @@ static void watch_list_remove(XenWatchList *watch_list, XenWatch *watch,
 
 static XenWatch *xen_bus_add_watch(XenBus *xenbus, const char *node,
                                    const char *key, XenWatchHandler handler,
-                                   void *opaque, Error **errp)
+                                   Error **errp)
 {
     trace_xen_bus_add_watch(node, key);
 
-    return watch_list_add(xenbus->watch_list, node, key, handler, opaque,
+    return watch_list_add(xenbus->watch_list, node, key, handler, xenbus,
                           errp);
 }
 
@@ -433,7 +433,7 @@ static void xen_bus_realize(BusState *bus, Error **errp)
 
     xenbus->backend_watch =
         xen_bus_add_watch(xenbus, "", /* domain root node */
-                          "backend", xen_bus_enumerate, xenbus, &local_err);
+                          "backend", xen_bus_enumerate, &local_err);
     if (local_err) {
         /* This need not be treated as a hard error so don't propagate */
         error_reportf_err(local_err,
@@ -621,6 +621,31 @@ static void xen_device_backend_changed(void *opaque)
     }
 }
 
+static XenWatch *xen_device_add_watch(XenDevice *xendev, const char *node,
+                                      const char *key,
+                                      XenWatchHandler handler,
+                                      Error **errp)
+{
+    const char *type = object_get_typename(OBJECT(xendev));
+
+    trace_xen_device_add_watch(type, xendev->name, node, key);
+
+    return watch_list_add(xendev->watch_list, node, key, handler, xendev,
+                          errp);
+}
+
+static void xen_device_remove_watch(XenDevice *xendev, XenWatch *watch,
+                                    Error **errp)
+{
+    const char *type = object_get_typename(OBJECT(xendev));
+
+    trace_xen_device_remove_watch(type, xendev->name, watch->node,
+                                  watch->key);
+
+    watch_list_remove(xendev->watch_list, watch, errp);
+}
+
+
 static void xen_device_backend_create(XenDevice *xendev, Error **errp)
 {
     XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
@@ -645,9 +670,9 @@ static void xen_device_backend_create(XenDevice *xendev, Error **errp)
     }
 
     xendev->backend_state_watch =
-        xen_bus_add_watch(xenbus, xendev->backend_path,
-                          "state", xen_device_backend_changed,
-                          xendev, &local_err);
+        xen_device_add_watch(xendev, xendev->backend_path,
+                             "state", xen_device_backend_changed,
+                             &local_err);
     if (local_err) {
         error_propagate_prepend(errp, local_err,
                                 "failed to watch backend state: ");
@@ -655,9 +680,9 @@ static void xen_device_backend_create(XenDevice *xendev, Error **errp)
     }
 
     xendev->backend_online_watch =
-        xen_bus_add_watch(xenbus, xendev->backend_path,
-                          "online", xen_device_backend_changed,
-                          xendev, &local_err);
+        xen_device_add_watch(xendev, xendev->backend_path,
+                             "online", xen_device_backend_changed,
+                             &local_err);
     if (local_err) {
         error_propagate_prepend(errp, local_err,
                                 "failed to watch backend online: ");
@@ -671,12 +696,12 @@ static void xen_device_backend_destroy(XenDevice *xendev)
     Error *local_err = NULL;
 
     if (xendev->backend_online_watch) {
-        xen_bus_remove_watch(xenbus, xendev->backend_online_watch, NULL);
+        xen_device_remove_watch(xendev, xendev->backend_online_watch, NULL);
         xendev->backend_online_watch = NULL;
     }
 
     if (xendev->backend_state_watch) {
-        xen_bus_remove_watch(xenbus, xendev->backend_state_watch, NULL);
+        xen_device_remove_watch(xendev, xendev->backend_state_watch, NULL);
         xendev->backend_state_watch = NULL;
     }
 
@@ -812,8 +837,8 @@ static void xen_device_frontend_create(XenDevice *xendev, Error **errp)
     }
 
     xendev->frontend_state_watch =
-        xen_bus_add_watch(xenbus, xendev->frontend_path, "state",
-                          xen_device_frontend_changed, xendev, &local_err);
+        xen_device_add_watch(xendev, xendev->frontend_path, "state",
+                             xen_device_frontend_changed, &local_err);
     if (local_err) {
         error_propagate_prepend(errp, local_err,
                                 "failed to watch frontend state: ");
@@ -826,7 +851,8 @@ static void xen_device_frontend_destroy(XenDevice *xendev)
     Error *local_err = NULL;
 
     if (xendev->frontend_state_watch) {
-        xen_bus_remove_watch(xenbus, xendev->frontend_state_watch, NULL);
+        xen_device_remove_watch(xendev, xendev->frontend_state_watch,
+                                NULL);
         xendev->frontend_state_watch = NULL;
     }
 
@@ -1122,6 +1148,16 @@ static void xen_device_unrealize(DeviceState *dev, Error **errp)
         xendev->xgth = NULL;
     }
 
+    if (xendev->watch_list) {
+        watch_list_destroy(xendev->watch_list);
+        xendev->watch_list = NULL;
+    }
+
+    if (xendev->xsh) {
+        xs_close(xendev->xsh);
+        xendev->xsh = NULL;
+    }
+
     g_free(xendev->name);
     xendev->name = NULL;
 }
@@ -1164,6 +1200,14 @@ static void xen_device_realize(DeviceState *dev, Error **errp)
 
     trace_xen_device_realize(type, xendev->name);
 
+    xendev->xsh = xs_open(0);
+    if (!xendev->xsh) {
+        error_setg_errno(errp, errno, "failed xs_open");
+        goto unrealize;
+    }
+
+    xendev->watch_list = watch_list_create(xendev->xsh);
+
     xendev->xgth = xengnttab_open(NULL, 0);
     if (!xendev->xgth) {
         error_setg_errno(errp, errno, "failed xengnttab_open");
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 88b84e29bb..0d198148f6 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -22,6 +22,8 @@ typedef struct XenDevice {
     DeviceState qdev;
     domid_t frontend_id;
     char *name;
+    struct xs_handle *xsh;
+    XenWatchList *watch_list;
     char *backend_path, *frontend_path;
     enum xenbus_state backend_state, frontend_state;
     Notifier exit;
-- 
Anthony PERARD


