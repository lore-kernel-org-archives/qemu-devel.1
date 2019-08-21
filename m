Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4CAC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 249B722D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ZOEQzcVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249B722D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0MpD-00057S-Ay
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 05:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1i0Mn7-0002OP-LC
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1i0Mn6-0007mR-Au
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:20:29 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:7419)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1i0Mn6-0007iC-3N
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1566379227;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LKkFWbEHVRRLGoXttk3iW00wagoE0ctWHxQjhYL3ir4=;
 b=ZOEQzcVTl8WR1zIlt0EqxDM3vknwtHjp2viwUaZkSxTGR7DmgXBidKVX
 +ZDQTQ4jmTSWv6Ayt6xn68mRnmemO95Dxe9ob6weyxgSm6S8zxkDzMzCi
 pdoIL1ZzvUoyX4ZMzAyD3dZODbZuQiJEVea7pagNOSI46Fzz0hl1lcriV o=;
Authentication-Results: esa6.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa6.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: WfjGDj2DQFiJy54qdsaOgrVkQw3aWiHlsoBLNpBt2U248THIHc0Y8riEu/v4C7ZiixdnbUtqVz
 P7C55PalBoVq1dTW8NTiC5YMfvoghAdjR2vZ6Yh5i85o7QDyyJwMdXJ6dadkZnMRRbvp3Su9Tm
 vpSAc+zamMqDQnOWIQP8lN9v9z673ja0WxAsyn+0WrJLMuVRwWD5q38ilHA7g+zWEkWxsH8aIi
 Z3hE7/sV4H3dBg/eeYjP6eNDuE4NkHWj3Ojfia/zOWkQmdPryzHwrzvyCQ0FvIISAUydX0ytaB
 ZFM=
X-SBRS: 2.7
X-MesageID: 4731852
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,412,1559534400"; 
   d="scan'208";a="4731852"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Date: Wed, 21 Aug 2019 10:20:20 +0100
Message-ID: <20190821092020.17952-3-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821092020.17952-1-anthony.perard@citrix.com>
References: <20190821092020.17952-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.175
Subject: [Qemu-devel] [PATCH 2/2] xen-bus: Avoid rewriting identical values
 to xenstore
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
 Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul.durrant@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When QEMU receive a xenstore watch event suggesting that the "state" or
"online" status of the frontend or the backend changed, it record this
in its own state but it also re-write the value back into xenstore even
so there were no changed. This trigger an unnecessary xenstore watch
event which QEMU will process again (and maybe the frontend as well).

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/xen/xen-bus.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 982eca4533..c83f07424a 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -481,20 +481,27 @@ static int xen_device_backend_scanf(XenDevice *xendev, const char *key,
     return rc;
 }
 
-void xen_device_backend_set_state(XenDevice *xendev,
-                                  enum xenbus_state state)
+static bool xen_device_backend_record_state(XenDevice *xendev,
+                                            enum xenbus_state state)
 {
     const char *type = object_get_typename(OBJECT(xendev));
 
     if (xendev->backend_state == state) {
-        return;
+        return false;
     }
 
     trace_xen_device_backend_state(type, xendev->name,
                                    xs_strstate(state));
 
     xendev->backend_state = state;
-    xen_device_backend_printf(xendev, "state", "%u", state);
+    return true;
+}
+
+void xen_device_backend_set_state(XenDevice *xendev,
+                                  enum xenbus_state state)
+{
+    if (xen_device_backend_record_state(xendev, state))
+        xen_device_backend_printf(xendev, "state", "%u", state);
 }
 
 enum xenbus_state xen_device_backend_get_state(XenDevice *xendev)
@@ -502,7 +509,8 @@ enum xenbus_state xen_device_backend_get_state(XenDevice *xendev)
     return xendev->backend_state;
 }
 
-static void xen_device_backend_set_online(XenDevice *xendev, bool online)
+static void xen_device_backend_set_online(XenDevice *xendev, bool online,
+                                          bool export)
 {
     const char *type = object_get_typename(OBJECT(xendev));
 
@@ -513,7 +521,8 @@ static void xen_device_backend_set_online(XenDevice *xendev, bool online)
     trace_xen_device_backend_online(type, xendev->name, online);
 
     xendev->backend_online = online;
-    xen_device_backend_printf(xendev, "online", "%u", online);
+    if (export)
+        xen_device_backend_printf(xendev, "online", "%u", online);
 }
 
 static void xen_device_backend_changed(void *opaque)
@@ -529,13 +538,13 @@ static void xen_device_backend_changed(void *opaque)
         state = XenbusStateUnknown;
     }
 
-    xen_device_backend_set_state(xendev, state);
+    xen_device_backend_record_state(xendev, state);
 
     if (xen_device_backend_scanf(xendev, "online", "%u", &online) != 1) {
         online = 0;
     }
 
-    xen_device_backend_set_online(xendev, !!online);
+    xen_device_backend_set_online(xendev, !!online, false);
 
     /*
      * If the toolstack (or unplug request callback) has set the backend
@@ -683,7 +692,8 @@ int xen_device_frontend_scanf(XenDevice *xendev, const char *key,
 }
 
 static void xen_device_frontend_set_state(XenDevice *xendev,
-                                          enum xenbus_state state)
+                                          enum xenbus_state state,
+                                          bool export)
 {
     const char *type = object_get_typename(OBJECT(xendev));
 
@@ -695,7 +705,8 @@ static void xen_device_frontend_set_state(XenDevice *xendev,
                                     xs_strstate(state));
 
     xendev->frontend_state = state;
-    xen_device_frontend_printf(xendev, "state", "%u", state);
+    if (export)
+        xen_device_frontend_printf(xendev, "state", "%u", state);
 }
 
 static void xen_device_frontend_changed(void *opaque)
@@ -711,7 +722,7 @@ static void xen_device_frontend_changed(void *opaque)
         state = XenbusStateUnknown;
     }
 
-    xen_device_frontend_set_state(xendev, state);
+    xen_device_frontend_set_state(xendev, state, false);
 
     if (state == XenbusStateInitialising &&
         xendev->backend_state == XenbusStateClosed &&
@@ -1146,7 +1157,7 @@ static void xen_device_realize(DeviceState *dev, Error **errp)
                               xendev->frontend_id);
     xen_device_backend_printf(xendev, "hotplug-status", "connected");
 
-    xen_device_backend_set_online(xendev, true);
+    xen_device_backend_set_online(xendev, true, true);
     xen_device_backend_set_state(xendev, XenbusStateInitWait);
 
     xen_device_frontend_printf(xendev, "backend", "%s",
@@ -1154,7 +1165,7 @@ static void xen_device_realize(DeviceState *dev, Error **errp)
     xen_device_frontend_printf(xendev, "backend-id", "%u",
                                xenbus->backend_id);
 
-    xen_device_frontend_set_state(xendev, XenbusStateInitialising);
+    xen_device_frontend_set_state(xendev, XenbusStateInitialising, true);
 
     xendev->exit.notify = xen_device_exit;
     qemu_add_exit_notifier(&xendev->exit);
-- 
Anthony PERARD


