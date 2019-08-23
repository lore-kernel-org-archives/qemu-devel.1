Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F500C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 10:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3D021726
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 10:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ERg+PA8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3D021726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i16gr-00055N-0i
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 06:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1i16bm-0008HS-V1
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 06:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1i16bh-0004Ez-4H
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 06:15:48 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:12656)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1i16bg-0004Dx-Jl; Fri, 23 Aug 2019 06:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1566555345;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=X1XvM8CMt3Oe1WMwqnuj+nuos2M8xn2yAGimqZ6nzIE=;
 b=ERg+PA8P40KuqazfcsbL1HoIMzlOnFML7EmbB/MYaD6KVAezV+E786V4
 wvFBgtyWJH99kYgeDbhSvdd/gQj2NA126BCSMhuTDevgX6pKp8LSCaivO
 02qzwE3Xt4R4NVjWk7dKCnhi9dq3L8XUHJtg9JmhnyQjp3tAF2UZPCfBa I=;
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
IronPort-SDR: NWMLEnhoWu1IGDRVUxUzlhnxVQXUUvE0LXTYSHLVN2dfjQGP8cAZrA8Z/TMkiFe9+qvAxxwuDh
 GVBZJchi8a1f/hL98sIzSu853Sn8XzdzuO+Q+dHVIlYqFXrXM8uqSncWNxJ1I4NmjUnmoV/u9c
 uY52GiGvycKH6fQkM/Lc6Xyp9sWRhAdt+h9fXfZLvjhEPzRLSyOROMkqNyi4eOxSyB9FYTRerc
 mWY5ZsTjqOJmSqfgV0bF50b2xglWligVaJIvxN6BQku8+Kl3b5MkCapEV27paO5z3ASXl6q28f
 VKk=
X-SBRS: 2.7
X-MesageID: 4640483
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,420,1559534400"; 
   d="scan'208";a="4640483"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Date: Fri, 23 Aug 2019 11:15:33 +0100
Message-ID: <20190823101534.465-2-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190823101534.465-1-anthony.perard@citrix.com>
References: <20190823101534.465-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.155
Subject: [Qemu-devel] [PATCH v2 1/2] xen-bus: Fix backend state transition
 on device reset
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
 Stefano Stabellini <sstabellini@kernel.org>, qemu-stable@nongnu.org,
 Paul Durrant <paul.durrant@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a frontend wants to reset its state and the backend one, it
starts with setting "Closing", then waits for the backend (QEMU) to do
the same.

But when QEMU is setting "Closing" to its state, it triggers an event
(xenstore watch) that re-execute xen_device_backend_changed() and set
the backend state to "Closed". QEMU should wait for the frontend to
set "Closed" before doing the same.

Before setting "Closed" to the backend_state, we are also going to
check if there is a frontend. If that the case, when the backend state
is set to "Closing" the frontend should react and sets its state to
"Closing" then "Closed". The backend should wait for that to happen.

Fixes: b6af8926fb858c4f1426e5acb2cfc1f0580ec98a
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
Cc: qemu-stable@nongnu.org
---

Notes:
    v2:
    - use a helper
    - Add InitWait and Initialised to the list of active state

 hw/xen/xen-bus.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index e40500242d..62c127b926 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -516,6 +516,23 @@ static void xen_device_backend_set_online(XenDevice *xendev, bool online)
     xen_device_backend_printf(xendev, "online", "%u", online);
 }
 
+/*
+ * Tell from the state whether the frontend is likely alive,
+ * i.e. it will react to a change of state of the backend.
+ */
+static bool xen_device_state_is_active(enum xenbus_state state)
+{
+    switch (state) {
+    case XenbusStateInitWait:
+    case XenbusStateInitialised:
+    case XenbusStateConnected:
+    case XenbusStateClosing:
+        return true;
+    default:
+        return false;
+    }
+}
+
 static void xen_device_backend_changed(void *opaque)
 {
     XenDevice *xendev = opaque;
@@ -539,11 +556,11 @@ static void xen_device_backend_changed(void *opaque)
 
     /*
      * If the toolstack (or unplug request callback) has set the backend
-     * state to Closing, but there is no active frontend (i.e. the
-     * state is not Connected) then set the backend state to Closed.
+     * state to Closing, but there is no active frontend then set the
+     * backend state to Closed.
      */
     if (xendev->backend_state == XenbusStateClosing &&
-        xendev->frontend_state != XenbusStateConnected) {
+        !xen_device_state_is_active(state)) {
         xen_device_backend_set_state(xendev, XenbusStateClosed);
     }
 
-- 
Anthony PERARD


