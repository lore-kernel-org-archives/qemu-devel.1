Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138A0C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C256D214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ZqrN4Wb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C256D214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCj5w-0004Ym-6N
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 07:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1iCj2O-0002PT-1A
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1iCj2K-0005H2-Ai
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:31:19 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:17965)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1iCj2K-0005G2-0h
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1569324677;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lIR2elTbWvefWOC/atlkBJbCmXdX8fU6m/x2+m4hVs8=;
 b=ZqrN4Wb1qDvXHnBmEEQQsibcL7xcu8+ujm/TRnepIi5VG5qrxoDwvU8t
 bn4UhvPgyovi3rJmiIhaNJgbhe307vklxY49ep3PgtkNpcZAoq+srUOGb
 GuX/jFQo7vrv2H5/hR1xVQFlNd7NNwkeZYMR7FKqB1xVS58Nkp9YRq1wu M=;
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
IronPort-SDR: CUbIogbqBB/Yq4YHdMfJO8/LJ95sua+JzNipeshuo4hg944nYCGxylQdYlYcw3inZvmY+rLRIW
 5xMsHswU5AFfZKar2S1WfCskhwHXTI1qT6WupsGwe/AoN1eAaWTYgXVJvQMuWifv4c1Idm5rHU
 h+tGzReAVJa018Z98bSOtbWUOQyIXAQnlJvNtv07FFz3d4WhpQHU4W1r+hRauZzt7//mVqqOc1
 GqhCWyCkdK/61JipyJbgyAexOv/I+SmpR3LZlsyfSw7s6WzW8v3vePam3VdHA/nOVEluGc6PUL
 DY8=
X-SBRS: 2.7
X-MesageID: 5977598
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,543,1559534400"; 
   d="scan'208";a="5977598"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Subject: [PULL 4/7] xen: perform XenDevice clean-up in XenBus watch handler
Date: Tue, 24 Sep 2019 12:30:23 +0100
Message-ID: <20190924113026.255634-5-anthony.perard@citrix.com>
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

Cleaning up offline XenDevice objects directly in
xen_device_backend_changed() is dangerous as xen_device_unrealize() will
modify the watch list that is being walked. Even the QLIST_FOREACH_SAFE()
used in notifier_list_notify() is insufficient as *two* notifiers (for
the frontend and backend watches) are removed, thus potentially rendering
the 'next' pointer unsafe.

The solution is to use the XenBus backend_watch handler to do the clean-up
instead, as it is invoked whilst walking a separate watch list.

This patch therefore adds a new 'inactive_devices' list to XenBus, to which
offline devices are added by xen_device_backend_changed(). The XenBus
backend_watch registration is also changed to not only invoke
xen_bus_enumerate() but also a new xen_bus_cleanup() function, which will
walk 'inactive_devices' and perform the necessary actions.
For safety an extra 'online' check is also added to xen_bus_type_enumerate()
to make sure that no attempt is made to create a new XenDevice object for a
backend that is offline.

NOTE: This patch also includes some cosmetic changes:
      - substitute the local variable name 'backend_state'
        in xen_bus_type_enumerate() with 'state', since there
        is no ambiguity with any other state in that context.
      - change xen_device_state_is_active() to
        xen_device_frontend_is_active() (and pass a XenDevice directly)
        since the state tests contained therein only apply to a frontend.
      - use 'state' rather then 'xendev->backend_state' in
        xen_device_backend_changed() to shorten the code.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20190913082159.31338-4-paul.durrant@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/xen/trace-events      |  2 +
 hw/xen/xen-bus.c         | 94 +++++++++++++++++++++++++++++-----------
 include/hw/xen/xen-bus.h |  3 ++
 3 files changed, 74 insertions(+), 25 deletions(-)

diff --git a/hw/xen/trace-events b/hw/xen/trace-events
index 80ce3dafad..e6885bc751 100644
--- a/hw/xen/trace-events
+++ b/hw/xen/trace-events
@@ -17,8 +17,10 @@ xen_domid_restrict(int err) "err: %u"
 xen_bus_realize(void) ""
 xen_bus_unrealize(void) ""
 xen_bus_enumerate(void) ""
+xen_bus_cleanup(void) ""
 xen_bus_type_enumerate(const char *type) "type: %s"
 xen_bus_backend_create(const char *type, const char *path) "type: %s path: %s"
+xen_bus_device_cleanup(const char *type, char *name) "type: %s name: %s"
 xen_bus_add_watch(const char *node, const char *key) "node: %s key: %s"
 xen_bus_remove_watch(const char *node, const char *key) "node: %s key: %s"
 xen_device_realize(const char *type, char *name) "type: %s name: %s"
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 810a4e2df3..55c157393d 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -340,13 +340,18 @@ static void xen_bus_type_enumerate(XenBus *xenbus, const char *type)
     for (i = 0; i < n; i++) {
         char *backend_path = g_strdup_printf("%s/%s", domain_path,
                                              backend[i]);
-        enum xenbus_state backend_state;
+        enum xenbus_state state;
+        unsigned int online;
 
         if (xs_node_scanf(xenbus->xsh, XBT_NULL, backend_path, "state",
-                          NULL, "%u", &backend_state) != 1)
-            backend_state = XenbusStateUnknown;
+                          NULL, "%u", &state) != 1)
+            state = XenbusStateUnknown;
 
-        if (backend_state == XenbusStateInitialising) {
+        if (xs_node_scanf(xenbus->xsh, XBT_NULL, backend_path, "online",
+                          NULL, "%u", &online) != 1)
+            online = 0;
+
+        if (online && state == XenbusStateInitialising) {
             Error *local_err = NULL;
 
             xen_bus_backend_create(xenbus, type, backend[i], backend_path,
@@ -365,9 +370,8 @@ static void xen_bus_type_enumerate(XenBus *xenbus, const char *type)
     g_free(domain_path);
 }
 
-static void xen_bus_enumerate(void *opaque)
+static void xen_bus_enumerate(XenBus *xenbus)
 {
-    XenBus *xenbus = opaque;
     char **type;
     unsigned int i, n;
 
@@ -385,6 +389,45 @@ static void xen_bus_enumerate(void *opaque)
     free(type);
 }
 
+static void xen_bus_device_cleanup(XenDevice *xendev)
+{
+    const char *type = object_get_typename(OBJECT(xendev));
+    Error *local_err = NULL;
+
+    trace_xen_bus_device_cleanup(type, xendev->name);
+
+    g_assert(!xendev->backend_online);
+
+    if (!xen_backend_try_device_destroy(xendev, &local_err)) {
+        object_unparent(OBJECT(xendev));
+    }
+
+    if (local_err) {
+        error_report_err(local_err);
+    }
+}
+
+static void xen_bus_cleanup(XenBus *xenbus)
+{
+    XenDevice *xendev, *next;
+
+    trace_xen_bus_cleanup();
+
+    QLIST_FOREACH_SAFE(xendev, &xenbus->inactive_devices, list, next) {
+        g_assert(xendev->inactive);
+        QLIST_REMOVE(xendev, list);
+        xen_bus_device_cleanup(xendev);
+    }
+}
+
+static void xen_bus_backend_changed(void *opaque)
+{
+    XenBus *xenbus = opaque;
+
+    xen_bus_enumerate(xenbus);
+    xen_bus_cleanup(xenbus);
+}
+
 static void xen_bus_unrealize(BusState *bus, Error **errp)
 {
     XenBus *xenbus = XEN_BUS(bus);
@@ -433,7 +476,7 @@ static void xen_bus_realize(BusState *bus, Error **errp)
 
     xenbus->backend_watch =
         xen_bus_add_watch(xenbus, "", /* domain root node */
-                          "backend", xen_bus_enumerate, &local_err);
+                          "backend", xen_bus_backend_changed, &local_err);
     if (local_err) {
         /* This need not be treated as a hard error so don't propagate */
         error_reportf_err(local_err,
@@ -555,9 +598,9 @@ static void xen_device_backend_set_online(XenDevice *xendev, bool online)
  * Tell from the state whether the frontend is likely alive,
  * i.e. it will react to a change of state of the backend.
  */
-static bool xen_device_state_is_active(enum xenbus_state state)
+static bool xen_device_frontend_is_active(XenDevice *xendev)
 {
-    switch (state) {
+    switch (xendev->frontend_state) {
     case XenbusStateInitWait:
     case XenbusStateInitialised:
     case XenbusStateConnected:
@@ -594,30 +637,31 @@ static void xen_device_backend_changed(void *opaque)
      * state to Closing, but there is no active frontend then set the
      * backend state to Closed.
      */
-    if (xendev->backend_state == XenbusStateClosing &&
-        !xen_device_state_is_active(xendev->frontend_state)) {
+    if (state == XenbusStateClosing &&
+        !xen_device_frontend_is_active(xendev)) {
         xen_device_backend_set_state(xendev, XenbusStateClosed);
     }
 
     /*
      * If a backend is still 'online' then we should leave it alone but,
-     * if a backend is not 'online', then the device should be destroyed
-     * once the state is Closed.
+     * if a backend is not 'online', then the device is a candidate
+     * for destruction. Hence add it to the 'inactive' list to be cleaned
+     * by xen_bus_cleanup().
      */
-    if (!xendev->backend_online &&
-        (xendev->backend_state == XenbusStateClosed ||
-         xendev->backend_state == XenbusStateInitialising ||
-         xendev->backend_state == XenbusStateInitWait ||
-         xendev->backend_state == XenbusStateUnknown)) {
-        Error *local_err = NULL;
+    if (!online &&
+        (state == XenbusStateClosed ||  state == XenbusStateInitialising ||
+         state == XenbusStateInitWait || state == XenbusStateUnknown) &&
+        !xendev->inactive) {
+        XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
 
-        if (!xen_backend_try_device_destroy(xendev, &local_err)) {
-            object_unparent(OBJECT(xendev));
-        }
+        xendev->inactive = true;
+        QLIST_INSERT_HEAD(&xenbus->inactive_devices, xendev, list);
 
-        if (local_err) {
-            error_report_err(local_err);
-        }
+        /*
+         * Re-write the state to cause a XenBus backend_watch notification,
+         * resulting in a call to xen_bus_cleanup().
+         */
+        xen_device_backend_printf(xendev, "state", "%u", state);
     }
 }
 
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 0d198148f6..3d5532258d 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -32,7 +32,9 @@ typedef struct XenDevice {
     XenWatch *backend_online_watch;
     xengnttab_handle *xgth;
     bool feature_grant_copy;
+    bool inactive;
     QLIST_HEAD(, XenEventChannel) event_channels;
+    QLIST_ENTRY(XenDevice) list;
 } XenDevice;
 
 typedef char *(*XenDeviceGetName)(XenDevice *xendev, Error **errp);
@@ -68,6 +70,7 @@ typedef struct XenBus {
     struct xs_handle *xsh;
     XenWatchList *watch_list;
     XenWatch *backend_watch;
+    QLIST_HEAD(, XenDevice) inactive_devices;
 } XenBus;
 
 typedef struct XenBusClass {
-- 
Anthony PERARD


