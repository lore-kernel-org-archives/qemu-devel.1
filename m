Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E1EC4BA3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:19:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C24EE24699
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Guy2QMpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24EE24699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58387 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7I8d-0001oh-0D
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 07:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1j7I6F-00072e-Gx
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:17:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1j7I6D-0001BV-2Q
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:17:07 -0500
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:64917)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1j7I6C-00014m-33
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1582805824;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CDWU+sgbS+JktH9g2iumodc54MqCBgShHGQD/NQz8io=;
 b=Guy2QMpawTAtC1jHneOyUGUkoZAYBT+bhUZygmdylBDoccW5PrST/nR0
 p0uUplNSKh7lPrhHW11chjc1TfgDKXmdLcCaQNB2sR9x/F18jO9SX4TZ1
 UhQJWOh3uymJhIod5ohfFa98lGde6e4rtZ+0TtzxzpP9icfqF9XmEhJIW k=;
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: iemrAuRoNR9K59H1rtr/9irQXvzz6cNInNaTzMvS9W+79DG5k+OGII2ScMbgIg9Y2FS3BjITVZ
 q8IIDmq+XvKnOl2YCniard/b7u7bbxT69I4Dpa3uWf2Vw7nPfFTX3XruOIV08LASzDCpvHbBWK
 0Etm1FlhHaAPqT/h4Nz3IZBqujr9ARwuyhRyvXdg2ObSNIJjRvIAajjdc4oaIbchFhfBsPtioA
 1/GyRze7OCXBN75k095RovC7lb3GazLbFMlBEAJOdrzuhQhZhCkQdiaTjypP5b06p3RJnrL6mv
 l38=
X-SBRS: 2.7
X-MesageID: 13277763
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.70,492,1574139600"; d="scan'208";a="13277763"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Subject: [PULL 2/3] xen-bus/block: explicitly assign event channels to an
 AioContext
Date: Thu, 27 Feb 2020 12:16:44 +0000
Message-ID: <20200227121645.2601280-3-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227121645.2601280-1-anthony.perard@citrix.com>
References: <20200227121645.2601280-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.145.142
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
Cc: Peter Maydell <peter.maydell@linaro.org>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paul Durrant <pdurrant@amazon.com>

It is not safe to close an event channel from the QEMU main thread when
that channel's poller is running in IOThread context.

This patch adds a new xen_device_set_event_channel_context() function
to explicitly assign the channel AioContext, and modifies
xen_device_bind_event_channel() to initially assign the channel's poller
to the QEMU main thread context. The code in xen-block's dataplane is
then modified to assign the channel to IOThread context during
xen_block_dataplane_start() and de-assign it during in
xen_block_dataplane_stop(), such that the channel is always assigned
back to main thread context before it is closed. aio_set_fd_handler()
already deals with all the necessary synchronization when moving an fd
between AioContext-s so no extra code is needed to manage this.

Reported-by: Julien Grall <jgrall@amazon.com>
Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20191216143451.19024-1-pdurrant@amazon.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/block/dataplane/xen-block.c | 20 ++++++++++++++++++--
 hw/xen/xen-bus.c               | 27 +++++++++++++++++++++++----
 include/hw/xen/xen-bus.h       |  5 ++++-
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 3b9caeb2fa00..288a87a814ad 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -685,12 +685,24 @@ void xen_block_dataplane_stop(XenBlockDataPlane *dataplane)
         return;
     }
 
+    xendev = dataplane->xendev;
+
     aio_context_acquire(dataplane->ctx);
+    if (dataplane->event_channel) {
+        /* Only reason for failure is a NULL channel */
+        xen_device_set_event_channel_context(xendev, dataplane->event_channel,
+                                             qemu_get_aio_context(),
+                                             &error_abort);
+    }
     /* Xen doesn't have multiple users for nodes, so this can't fail */
     blk_set_aio_context(dataplane->blk, qemu_get_aio_context(), &error_abort);
     aio_context_release(dataplane->ctx);
 
-    xendev = dataplane->xendev;
+    /*
+     * Now that the context has been moved onto the main thread, cancel
+     * further processing.
+     */
+    qemu_bh_cancel(dataplane->bh);
 
     if (dataplane->event_channel) {
         Error *local_err = NULL;
@@ -807,7 +819,7 @@ void xen_block_dataplane_start(XenBlockDataPlane *dataplane,
     }
 
     dataplane->event_channel =
-        xen_device_bind_event_channel(xendev, dataplane->ctx, event_channel,
+        xen_device_bind_event_channel(xendev, event_channel,
                                       xen_block_dataplane_event, dataplane,
                                       &local_err);
     if (local_err) {
@@ -818,7 +830,11 @@ void xen_block_dataplane_start(XenBlockDataPlane *dataplane,
     aio_context_acquire(dataplane->ctx);
     /* If other users keep the BlockBackend in the iothread, that's ok */
     blk_set_aio_context(dataplane->blk, dataplane->ctx, NULL);
+    /* Only reason for failure is a NULL channel */
+    xen_device_set_event_channel_context(xendev, dataplane->event_channel,
+                                         dataplane->ctx, &error_abort);
     aio_context_release(dataplane->ctx);
+
     return;
 
 stop:
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 919e66162a45..18237b34ea85 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -1089,8 +1089,26 @@ static void xen_device_event(void *opaque)
     }
 }
 
+void xen_device_set_event_channel_context(XenDevice *xendev,
+                                          XenEventChannel *channel,
+                                          AioContext *ctx,
+                                          Error **errp)
+{
+    if (!channel) {
+        error_setg(errp, "bad channel");
+        return;
+    }
+
+    if (channel->ctx)
+        aio_set_fd_handler(channel->ctx, xenevtchn_fd(channel->xeh), true,
+                           NULL, NULL, NULL, NULL);
+
+    channel->ctx = ctx;
+    aio_set_fd_handler(channel->ctx, xenevtchn_fd(channel->xeh), true,
+                       xen_device_event, NULL, xen_device_poll, channel);
+}
+
 XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
-                                               AioContext *ctx,
                                                unsigned int port,
                                                XenEventHandler handler,
                                                void *opaque, Error **errp)
@@ -1116,9 +1134,10 @@ XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
     channel->handler = handler;
     channel->opaque = opaque;
 
-    channel->ctx = ctx;
-    aio_set_fd_handler(channel->ctx, xenevtchn_fd(channel->xeh), true,
-                       xen_device_event, NULL, xen_device_poll, channel);
+    /* Only reason for failure is a NULL channel */
+    xen_device_set_event_channel_context(xendev, channel,
+                                         qemu_get_aio_context(),
+                                         &error_abort);
 
     QLIST_INSERT_HEAD(&xendev->event_channels, channel, list);
 
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 3d5532258df7..c18c1372af38 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -128,10 +128,13 @@ void xen_device_copy_grant_refs(XenDevice *xendev, bool to_domain,
 typedef bool (*XenEventHandler)(void *opaque);
 
 XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
-                                               AioContext *ctx,
                                                unsigned int port,
                                                XenEventHandler handler,
                                                void *opaque, Error **errp);
+void xen_device_set_event_channel_context(XenDevice *xendev,
+                                          XenEventChannel *channel,
+                                          AioContext *ctx,
+                                          Error **errp);
 void xen_device_notify_event_channel(XenDevice *xendev,
                                      XenEventChannel *channel,
                                      Error **errp);
-- 
Anthony PERARD


