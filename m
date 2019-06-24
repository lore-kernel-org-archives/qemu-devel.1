Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533ACC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:40:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C3102054F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3102054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52412 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfR58-0000bR-IT
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 11:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44863)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <anthony.perard@citrix.com>) id 1hfQy1-0003WN-FC
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1hfQxz-0000MV-RR
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:33:13 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:11946)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1hfQxz-0000GL-Ec
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:33:11 -0400
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
IronPort-SDR: kQPaiIH49oII/yU/o4NKBjCSgEIJPIXZ8PW24fJT53I5h9Lwd8rU6U2sT/Cz1SJyOnE+Nr5Iwz
 ayRZdM6prlyheBn06gLPP860/3E9AzgYpjE50T9aWSY9bfoL5Ht6HVqNvrM+Bdue/aH2vXuqJM
 9qZSztspZhASrz2372T5ndQUfWzmVk0bRZQ/346Q2pl36QcLH7G+uglzWnkhEMYldjTYS9cdeg
 hiEpu2WTJSYG4ZTPJ+nEXaviFTcim9c9mAGIhvL34IQ7o4F0LGwl8IHEQiDRnJrSiMPFV5ATXo
 NwM=
X-SBRS: 2.7
X-MesageID: 2148097
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,412,1557201600"; 
   d="scan'208";a="2148097"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Date: Mon, 24 Jun 2019 16:32:52 +0100
Message-ID: <20190624153257.20163-4-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624153257.20163-1-anthony.perard@citrix.com>
References: <20190624153257.20163-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.155
Subject: [Qemu-devel] [PULL 3/8] xen-bus: allow AioContext to be specified
 for each event channel
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

This patch adds an AioContext parameter to xen_device_bind_event_channel()
and then uses aio_set_fd_handler() to set the callback rather than
qemu_set_fd_handler().

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20190408151617.13025-3-paul.durrant@citrix.com>
[Call aio_set_fd_handler() with is_external=true]
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/block/dataplane/xen-block.c |  2 +-
 hw/xen/xen-bus.c               | 10 +++++++---
 include/hw/xen/xen-bus.h       |  1 +
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 6da5c77fbb..aadca75644 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -806,7 +806,7 @@ void xen_block_dataplane_start(XenBlockDataPlane *dataplane,
     }
 
     dataplane->event_channel =
-        xen_device_bind_event_channel(xendev, event_channel,
+        xen_device_bind_event_channel(xendev, dataplane->ctx, event_channel,
                                       xen_block_dataplane_event, dataplane,
                                       &local_err);
     if (local_err) {
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 43a90cae42..2210526490 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -925,6 +925,7 @@ void xen_device_copy_grant_refs(XenDevice *xendev, bool to_domain,
 
 struct XenEventChannel {
     QLIST_ENTRY(XenEventChannel) list;
+    AioContext *ctx;
     xenevtchn_handle *xeh;
     evtchn_port_t local_port;
     XenEventHandler handler;
@@ -944,6 +945,7 @@ static void xen_device_event(void *opaque)
 }
 
 XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
+                                               AioContext *ctx,
                                                unsigned int port,
                                                XenEventHandler handler,
                                                void *opaque, Error **errp)
@@ -969,8 +971,9 @@ XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
     channel->handler = handler;
     channel->opaque = opaque;
 
-    qemu_set_fd_handler(xenevtchn_fd(channel->xeh), xen_device_event, NULL,
-                        channel);
+    channel->ctx = ctx;
+    aio_set_fd_handler(channel->ctx, xenevtchn_fd(channel->xeh), true,
+                       xen_device_event, NULL, NULL, channel);
 
     QLIST_INSERT_HEAD(&xendev->event_channels, channel, list);
 
@@ -1011,7 +1014,8 @@ void xen_device_unbind_event_channel(XenDevice *xendev,
 
     QLIST_REMOVE(channel, list);
 
-    qemu_set_fd_handler(xenevtchn_fd(channel->xeh), NULL, NULL, NULL);
+    aio_set_fd_handler(channel->ctx, xenevtchn_fd(channel->xeh), true,
+                       NULL, NULL, NULL, NULL);
 
     if (xenevtchn_unbind(channel->xeh, channel->local_port) < 0) {
         error_setg_errno(errp, errno, "xenevtchn_unbind failed");
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 3315f0de20..8183b98c7d 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -122,6 +122,7 @@ void xen_device_copy_grant_refs(XenDevice *xendev, bool to_domain,
 typedef void (*XenEventHandler)(void *opaque);
 
 XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
+                                               AioContext *ctx,
                                                unsigned int port,
                                                XenEventHandler handler,
                                                void *opaque, Error **errp);
-- 
Anthony PERARD


