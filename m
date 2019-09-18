Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E506DC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:59:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B039420644
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Q6E+1h+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B039420644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAYbw-0005Uo-TT
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 07:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Paul.Durrant@citrix.com>) id 1iAYak-0004Yo-W1
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1iAYaj-0007o3-QP
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:57:50 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:3394)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1iAYaj-0007n5-J2
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1568807869;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=aPsmKiHtye2Xrg7pQcqeyGPyIVJnXtNBUKlRejZK/IQ=;
 b=Q6E+1h+FgyS1gf6RZ8JoSkc2K4s6pje2WpzoJUbjxXk9mr3WjvSdu/IA
 p04SBnzMGlsgT+k4vnKOWWOKzZJ5VkGwT68vosTxflEBG/pNaGE7PSt6E
 KokQ0Z2dqrdmMUB+EENb2B1QAAgxtwKfqJkqeaCy/DJPZFI6EIuO1qU7n U=;
Authentication-Results: esa5.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=paul.durrant@citrix.com;
 spf=Pass smtp.mailfrom=Paul.Durrant@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 paul.durrant@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="paul.durrant@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
 Paul.Durrant@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: irxgnCJQB21rk51r5OjEcjMnOjAkol6pP/3RKTGsPDLYXV1Ekd1b4JXRnVoG18Z7W6gzRBpV7U
 D9gkkd7EP9bpitJAFRlXpxV1ZjQuQLGoxH+XxW6Uv5FJwTdlhV+QVN6jRHw0X6t9PqihhzVM9O
 jFTN3kEtbDEHHqYI8FAdLHG3+zq3+LQK2+caBdL3H6A0FrNzRRtFzLJ/mcMbj/pBRlib/IsfWh
 rN9cGPscvrQyUGSIF8xXyIAcUn7zxzm+pqvn1MyHwO+aRBKovpYJH6M8/y5ZCJ2HQ8x+mSk2O2
 PNA=
X-SBRS: 2.7
X-MesageID: 5924842
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,520,1559534400"; 
   d="scan'208";a="5924842"
From: Paul Durrant <paul.durrant@citrix.com>
To: <xen-devel@lists.xenproject.org>, <qemu-devel@nongnu.org>
Date: Wed, 18 Sep 2019 12:57:44 +0100
Message-ID: <20190918115745.39006-1-paul.durrant@citrix.com>
X-Mailer: git-send-email 2.20.1.2.gb21ebb671
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.168
Subject: [Qemu-devel] [PATCH] xen-bus: only set the xen device frontend
 state if it is missing
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
Cc: Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <paul.durrant@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Mark Syms <mark.syms@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mark Syms <mark.syms@citrix.com>

Some toolstack implementations will set the frontend xenstore
keys to Initialising which will then trigger the in guest PV
drivers to begin initialising and some implementations will
then set their state to Closing. If this has occurred then
device realize must not overwrite the frontend keys as then
the handshake will stall.

Signed-off-by: Mark Syms <mark.syms@citrix.com>

Also avoid creating the frontend area if it already exists.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
---
 hw/xen/xen-bus.c | 47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 55c157393d..c2ad22a42d 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -857,6 +857,13 @@ static void xen_device_frontend_changed(void *opaque)
     }
 }
 
+static bool xen_device_frontend_exists(XenDevice *xendev)
+{
+    enum xenbus_state state;
+
+    return (xen_device_frontend_scanf(xendev, "state", "%u", &state) == 1);
+}
+
 static void xen_device_frontend_create(XenDevice *xendev, Error **errp)
 {
     XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
@@ -865,19 +872,25 @@ static void xen_device_frontend_create(XenDevice *xendev, Error **errp)
 
     xendev->frontend_path = xen_device_get_frontend_path(xendev);
 
-    perms[0].id = xendev->frontend_id;
-    perms[0].perms = XS_PERM_NONE;
-    perms[1].id = xenbus->backend_id;
-    perms[1].perms = XS_PERM_READ | XS_PERM_WRITE;
+    /*
+     * The frontend area may have already been created by a legacy
+     * toolstack.
+     */
+    if (!xen_device_frontend_exists(xendev)) {
+        perms[0].id = xendev->frontend_id;
+        perms[0].perms = XS_PERM_NONE;
+        perms[1].id = xenbus->backend_id;
+        perms[1].perms = XS_PERM_READ | XS_PERM_WRITE;
 
-    g_assert(xenbus->xsh);
+        g_assert(xenbus->xsh);
 
-    xs_node_create(xenbus->xsh, XBT_NULL, xendev->frontend_path, perms,
-                   ARRAY_SIZE(perms), &local_err);
-    if (local_err) {
-        error_propagate_prepend(errp, local_err,
-                                "failed to create frontend: ");
-        return;
+        xs_node_create(xenbus->xsh, XBT_NULL, xendev->frontend_path, perms,
+                       ARRAY_SIZE(perms), &local_err);
+        if (local_err) {
+            error_propagate_prepend(errp, local_err,
+                                    "failed to create frontend: ");
+            return;
+        }
     }
 
     xendev->frontend_state_watch =
@@ -1290,12 +1303,14 @@ static void xen_device_realize(DeviceState *dev, Error **errp)
     xen_device_backend_set_online(xendev, true);
     xen_device_backend_set_state(xendev, XenbusStateInitWait);
 
-    xen_device_frontend_printf(xendev, "backend", "%s",
-                               xendev->backend_path);
-    xen_device_frontend_printf(xendev, "backend-id", "%u",
-                               xenbus->backend_id);
+    if (!xen_device_frontend_exists(xendev)) {
+        xen_device_frontend_printf(xendev, "backend", "%s",
+                                   xendev->backend_path);
+        xen_device_frontend_printf(xendev, "backend-id", "%u",
+                                   xenbus->backend_id);
 
-    xen_device_frontend_set_state(xendev, XenbusStateInitialising, true);
+        xen_device_frontend_set_state(xendev, XenbusStateInitialising, true);
+    }
 
     xendev->exit.notify = xen_device_exit;
     qemu_add_exit_notifier(&xendev->exit);
-- 
2.20.1.2.gb21ebb671


