Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E7BC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 13:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61DFE2054F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 13:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ZLFL1U95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61DFE2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2beE-0000aK-Gg
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 09:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1i2bb2-0006DM-Um
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1i2bb1-0004ta-LI
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:33:16 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:9223)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1i2bb1-0004sx-9t
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1566912795;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5CoqJCQiLnVu+dsWN0Ou8DoSb81hsrlnHmMIXfN/N8w=;
 b=ZLFL1U95gLimvzb0QRhojrU4DY+2HuTZsH4IpwGLLvOmi1QJFJtWYeTK
 3X0upGqAsXPb16Jwm8mAEwPy+fl8PkbnpdTCj8ko/DgX/aglj+jENB8L/
 Kn58QZ7ejLyiFxYuipvESKZ5U8VzZ22SYR6wO43CbSSL1k4RpF6oN6uCr w=;
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
IronPort-SDR: GW8W5dlZtUCLO1Vzx2t4NsAYwjqY6hvEaixyskr+gUrAyyxApEOGhLt2RAvLY7lTiU3ZQ2ZK1U
 PzWSQGmayvN9+al2cizXAQiZhOvKvLOaSx+YeesjOCyRNFnP7kAaShNhuqDMhEFkl0Va1hYMwj
 6eHsNra41WDXZCmwUkvTe/EkkMiyqCCY6NkrYNQ2UJJwhpUrvVAF44rSOxifUwyHBeVmiEWDmx
 KAfcLAlTc2MyXw5fe1VdsnCtmSoXLjLpDhARvUAAYYDjGYS6kHuX5xLyBvc08GHm312dPB+Swn
 k4A=
X-SBRS: 2.7
X-MesageID: 4987743
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,437,1559534400"; 
   d="scan'208";a="4987743"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Date: Tue, 27 Aug 2019 14:32:58 +0100
Message-ID: <20190827133259.32084-4-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190827133259.32084-1-anthony.perard@citrix.com>
References: <20190827133259.32084-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.175
Subject: [Qemu-devel] [PULL 3/4] xen-bus: Fix backend state transition on
 device reset
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
Reviewed-by: Paul Durrant <paul.durrant@citrix.com>
Message-Id: <20190823101534.465-2-anthony.perard@citrix.com>
---
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


