Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E371C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:35:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E741520652
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E741520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52392 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfR0f-0005Rg-9E
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 11:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44889)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <anthony.perard@citrix.com>) id 1hfQy2-0003XC-FL
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1hfQy0-0000NZ-JM
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:33:14 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:11953)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1hfQy0-0000JY-5X
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
IronPort-SDR: 6XlC+kfUtMxsI8oTe0+5atL7DmyD1sz2vK1kvMokSAcBeJ9YpKBeTXj7eWQaYqeRNdbo2oVFc6
 g/IKHty2USXEUYbu+b/4rSFnAM02FMZXjtotfE+heHswqbdgtcVhggVxETPd/V60KyvuwSkoAY
 YfijP97pVCWU4VfN0dtQF/9kSI70yqls3WQbdt6ax7d8MkhMDT4oBMrgEDEoRgtX+sd2EOFTic
 TKdSOjLQteeW8/G6N9mv2I+6AsMdOb5P7am9sHO7rL0RFoyKcjLcOtLjVSnTnFlmwgDH6tt/TS
 Snk=
X-SBRS: 2.7
X-MesageID: 2148099
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,412,1557201600"; 
   d="scan'208";a="2148099"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Date: Mon, 24 Jun 2019 16:32:53 +0100
Message-ID: <20190624153257.20163-5-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624153257.20163-1-anthony.perard@citrix.com>
References: <20190624153257.20163-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.155
Subject: [Qemu-devel] [PULL 4/8] xen-bus / xen-block: add support for event
 channel polling
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

This patch introduces a poll callback for event channel fd-s and uses
this to invoke the channel callback function.

To properly support polling, it is necessary for the event channel callback
function to return a boolean saying whether it has done any useful work or
not. Thus xen_block_dataplane_event() is modified to directly invoke
xen_block_handle_requests() and the latter only returns true if it actually
processes any requests. This also means that the call to qemu_bh_schedule()
is moved into xen_block_complete_aio(), which is more intuitive since the
only reason for doing a deferred poll of the shared ring should be because
there were previously insufficient resources to fully complete a previous
poll.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20190408151617.13025-4-paul.durrant@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/block/dataplane/xen-block.c | 17 +++++++++--------
 hw/xen/xen-bus.c               | 11 +++++++++--
 include/hw/xen/xen-bus.h       |  2 +-
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index aadca75644..0f200c5fb0 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -318,7 +318,9 @@ static void xen_block_complete_aio(void *opaque, int ret)
     }
     xen_block_release_request(request);
 
-    qemu_bh_schedule(dataplane->bh);
+    if (dataplane->more_work) {
+        qemu_bh_schedule(dataplane->bh);
+    }
 
 done:
     aio_context_release(dataplane->ctx);
@@ -515,12 +517,13 @@ static int xen_block_get_request(XenBlockDataPlane *dataplane,
  */
 #define IO_PLUG_THRESHOLD 1
 
-static void xen_block_handle_requests(XenBlockDataPlane *dataplane)
+static bool xen_block_handle_requests(XenBlockDataPlane *dataplane)
 {
     RING_IDX rc, rp;
     XenBlockRequest *request;
     int inflight_atstart = dataplane->requests_inflight;
     int batched = 0;
+    bool done_something = false;
 
     dataplane->more_work = 0;
 
@@ -552,6 +555,7 @@ static void xen_block_handle_requests(XenBlockDataPlane *dataplane)
         }
         xen_block_get_request(dataplane, request, rc);
         dataplane->rings.common.req_cons = ++rc;
+        done_something = true;
 
         /* parse them */
         if (xen_block_parse_request(request) != 0) {
@@ -603,10 +607,7 @@ static void xen_block_handle_requests(XenBlockDataPlane *dataplane)
         blk_io_unplug(dataplane->blk);
     }
 
-    if (dataplane->more_work &&
-        dataplane->requests_inflight < dataplane->max_requests) {
-        qemu_bh_schedule(dataplane->bh);
-    }
+    return done_something;
 }
 
 static void xen_block_dataplane_bh(void *opaque)
@@ -618,11 +619,11 @@ static void xen_block_dataplane_bh(void *opaque)
     aio_context_release(dataplane->ctx);
 }
 
-static void xen_block_dataplane_event(void *opaque)
+static bool xen_block_dataplane_event(void *opaque)
 {
     XenBlockDataPlane *dataplane = opaque;
 
-    qemu_bh_schedule(dataplane->bh);
+    return xen_block_handle_requests(dataplane);
 }
 
 XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 2210526490..7503eea9e9 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -932,13 +932,20 @@ struct XenEventChannel {
     void *opaque;
 };
 
+static bool xen_device_poll(void *opaque)
+{
+    XenEventChannel *channel = opaque;
+
+    return channel->handler(channel->opaque);
+}
+
 static void xen_device_event(void *opaque)
 {
     XenEventChannel *channel = opaque;
     unsigned long port = xenevtchn_pending(channel->xeh);
 
     if (port == channel->local_port) {
-        channel->handler(channel->opaque);
+        xen_device_poll(channel);
 
         xenevtchn_unmask(channel->xeh, port);
     }
@@ -973,7 +980,7 @@ XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
 
     channel->ctx = ctx;
     aio_set_fd_handler(channel->ctx, xenevtchn_fd(channel->xeh), true,
-                       xen_device_event, NULL, NULL, channel);
+                       xen_device_event, NULL, xen_device_poll, channel);
 
     QLIST_INSERT_HEAD(&xendev->event_channels, channel, list);
 
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 8183b98c7d..1c2d9dfdb8 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -119,7 +119,7 @@ void xen_device_copy_grant_refs(XenDevice *xendev, bool to_domain,
                                 XenDeviceGrantCopySegment segs[],
                                 unsigned int nr_segs, Error **errp);
 
-typedef void (*XenEventHandler)(void *opaque);
+typedef bool (*XenEventHandler)(void *opaque);
 
 XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
                                                AioContext *ctx,
-- 
Anthony PERARD


