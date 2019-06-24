Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1783C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2DE2054F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2DE2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52416 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfR5S-0000fV-2n
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 11:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44896)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <anthony.perard@citrix.com>) id 1hfQy2-0003XX-Oi
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:33:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1hfQy0-0000Nm-Li
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:33:14 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:11946)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1hfQy0-0000GL-7O
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:33:12 -0400
Authentication-Results: esa3.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: B3wKRDHoAjpADVOFuiATXfXHImcAfgyg7BNFdetLoH3TdtHsH3YaUosadRE04AfSH31Zg9wEHq
 7+aivZYNxOifUV9NRFPB3nbSMjjQh/8AOIZcyzkucR7NEzFw2BGYlQT89rHb6Vv67eOPph3pbs
 MM+xcRSWQsLwO8nLUZ19pg7VQp/GWi8xsEg0a2qYoc41UY32w41g8DOkpksoj+HlI6z5IHBHoL
 DGpXE2o2y99Ee3BYEGog+nxL2QiwmdWI5teBBTzIBY2x6BGAU0oLyudiXVzr6PCpxM4W7CEsGO
 W8E=
X-SBRS: 2.7
X-MesageID: 2148102
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,412,1557201600"; 
   d="scan'208";a="2148102"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Date: Mon, 24 Jun 2019 16:32:51 +0100
Message-ID: <20190624153257.20163-3-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624153257.20163-1-anthony.perard@citrix.com>
References: <20190624153257.20163-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.155
Subject: [Qemu-devel] [PULL 2/8] xen-bus: use a separate fd for each event
 channel
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

To better support use of IOThread-s it will be necessary to be able to set
the AioContext for each XenEventChannel and hence it is necessary to open a
separate handle to libxenevtchan for each channel.

This patch stops using NotifierList for event channel callbacks, replacing
that construct by a list of complete XenEventChannel structures. Each of
these now has a xenevtchn_handle pointer in place of the single pointer
previously held in the XenDevice structure. The individual handles are
opened/closed in xen_device_bind/unbind_event_channel(), replacing the
single open/close in xen_device_realize/unrealize().

NOTE: This patch does not add an AioContext parameter to
      xen_device_bind_event_channel(). That will be done in a subsequent
      patch.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20190408151617.13025-2-paul.durrant@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/xen/xen-bus.c         | 79 ++++++++++++++++++++--------------------
 include/hw/xen/xen-bus.h |  6 +--
 2 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index a4416d0bcf..43a90cae42 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -924,19 +924,22 @@ void xen_device_copy_grant_refs(XenDevice *xendev, bool to_domain,
 }
 
 struct XenEventChannel {
+    QLIST_ENTRY(XenEventChannel) list;
+    xenevtchn_handle *xeh;
     evtchn_port_t local_port;
     XenEventHandler handler;
     void *opaque;
-    Notifier notifier;
 };
 
-static void event_notify(Notifier *n, void *data)
+static void xen_device_event(void *opaque)
 {
-    XenEventChannel *channel = container_of(n, XenEventChannel, notifier);
-    unsigned long port = (unsigned long)data;
+    XenEventChannel *channel = opaque;
+    unsigned long port = xenevtchn_pending(channel->xeh);
 
     if (port == channel->local_port) {
         channel->handler(channel->opaque);
+
+        xenevtchn_unmask(channel->xeh, port);
     }
 }
 
@@ -948,24 +951,39 @@ XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
     XenEventChannel *channel = g_new0(XenEventChannel, 1);
     xenevtchn_port_or_error_t local_port;
 
-    local_port = xenevtchn_bind_interdomain(xendev->xeh,
+    channel->xeh = xenevtchn_open(NULL, 0);
+    if (!channel->xeh) {
+        error_setg_errno(errp, errno, "failed xenevtchn_open");
+        goto fail;
+    }
+
+    local_port = xenevtchn_bind_interdomain(channel->xeh,
                                             xendev->frontend_id,
                                             port);
     if (local_port < 0) {
         error_setg_errno(errp, errno, "xenevtchn_bind_interdomain failed");
-
-        g_free(channel);
-        return NULL;
+        goto fail;
     }
 
     channel->local_port = local_port;
     channel->handler = handler;
     channel->opaque = opaque;
-    channel->notifier.notify = event_notify;
 
-    notifier_list_add(&xendev->event_notifiers, &channel->notifier);
+    qemu_set_fd_handler(xenevtchn_fd(channel->xeh), xen_device_event, NULL,
+                        channel);
+
+    QLIST_INSERT_HEAD(&xendev->event_channels, channel, list);
 
     return channel;
+
+fail:
+    if (channel->xeh) {
+        xenevtchn_close(channel->xeh);
+    }
+
+    g_free(channel);
+
+    return NULL;
 }
 
 void xen_device_notify_event_channel(XenDevice *xendev,
@@ -977,7 +995,7 @@ void xen_device_notify_event_channel(XenDevice *xendev,
         return;
     }
 
-    if (xenevtchn_notify(xendev->xeh, channel->local_port) < 0) {
+    if (xenevtchn_notify(channel->xeh, channel->local_port) < 0) {
         error_setg_errno(errp, errno, "xenevtchn_notify failed");
     }
 }
@@ -991,12 +1009,15 @@ void xen_device_unbind_event_channel(XenDevice *xendev,
         return;
     }
 
-    notifier_remove(&channel->notifier);
+    QLIST_REMOVE(channel, list);
 
-    if (xenevtchn_unbind(xendev->xeh, channel->local_port) < 0) {
+    qemu_set_fd_handler(xenevtchn_fd(channel->xeh), NULL, NULL, NULL);
+
+    if (xenevtchn_unbind(channel->xeh, channel->local_port) < 0) {
         error_setg_errno(errp, errno, "xenevtchn_unbind failed");
     }
 
+    xenevtchn_close(channel->xeh);
     g_free(channel);
 }
 
@@ -1005,6 +1026,7 @@ static void xen_device_unrealize(DeviceState *dev, Error **errp)
     XenDevice *xendev = XEN_DEVICE(dev);
     XenDeviceClass *xendev_class = XEN_DEVICE_GET_CLASS(xendev);
     const char *type = object_get_typename(OBJECT(xendev));
+    XenEventChannel *channel, *next;
 
     if (!xendev->name) {
         return;
@@ -1021,15 +1043,14 @@ static void xen_device_unrealize(DeviceState *dev, Error **errp)
         xendev_class->unrealize(xendev, errp);
     }
 
+    /* Make sure all event channels are cleaned up */
+    QLIST_FOREACH_SAFE(channel, &xendev->event_channels, list, next) {
+        xen_device_unbind_event_channel(xendev, channel, NULL);
+    }
+
     xen_device_frontend_destroy(xendev);
     xen_device_backend_destroy(xendev);
 
-    if (xendev->xeh) {
-        qemu_set_fd_handler(xenevtchn_fd(xendev->xeh), NULL, NULL, NULL);
-        xenevtchn_close(xendev->xeh);
-        xendev->xeh = NULL;
-    }
-
     if (xendev->xgth) {
         xengnttab_close(xendev->xgth);
         xendev->xgth = NULL;
@@ -1046,16 +1067,6 @@ static void xen_device_exit(Notifier *n, void *data)
     xen_device_unrealize(DEVICE(xendev), &error_abort);
 }
 
-static void xen_device_event(void *opaque)
-{
-    XenDevice *xendev = opaque;
-    unsigned long port = xenevtchn_pending(xendev->xeh);
-
-    notifier_list_notify(&xendev->event_notifiers, (void *)port);
-
-    xenevtchn_unmask(xendev->xeh, port);
-}
-
 static void xen_device_realize(DeviceState *dev, Error **errp)
 {
     XenDevice *xendev = XEN_DEVICE(dev);
@@ -1096,16 +1107,6 @@ static void xen_device_realize(DeviceState *dev, Error **errp)
     xendev->feature_grant_copy =
         (xengnttab_grant_copy(xendev->xgth, 0, NULL) == 0);
 
-    xendev->xeh = xenevtchn_open(NULL, 0);
-    if (!xendev->xeh) {
-        error_setg_errno(errp, errno, "failed xenevtchn_open");
-        goto unrealize;
-    }
-
-    notifier_list_init(&xendev->event_notifiers);
-    qemu_set_fd_handler(xenevtchn_fd(xendev->xeh), xen_device_event, NULL,
-                        xendev);
-
     xen_device_backend_create(xendev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 3183f10e3c..3315f0de20 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -15,6 +15,7 @@
 typedef void (*XenWatchHandler)(void *opaque);
 
 typedef struct XenWatch XenWatch;
+typedef struct XenEventChannel XenEventChannel;
 
 typedef struct XenDevice {
     DeviceState qdev;
@@ -28,8 +29,7 @@ typedef struct XenDevice {
     XenWatch *backend_online_watch;
     xengnttab_handle *xgth;
     bool feature_grant_copy;
-    xenevtchn_handle *xeh;
-    NotifierList event_notifiers;
+    QLIST_HEAD(, XenEventChannel) event_channels;
 } XenDevice;
 
 typedef char *(*XenDeviceGetName)(XenDevice *xendev, Error **errp);
@@ -119,8 +119,6 @@ void xen_device_copy_grant_refs(XenDevice *xendev, bool to_domain,
                                 XenDeviceGrantCopySegment segs[],
                                 unsigned int nr_segs, Error **errp);
 
-typedef struct XenEventChannel XenEventChannel;
-
 typedef void (*XenEventHandler)(void *opaque);
 
 XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
-- 
Anthony PERARD


