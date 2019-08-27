Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFE0C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 13:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 071232054F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 13:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="IIkrBS9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071232054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2beC-0000WL-6y
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 09:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1i2bb3-0006Dh-DN
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1i2bb2-0004u2-7F
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:33:17 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:9216)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1i2bb1-0004rj-SD
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1566912795;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pFwuW4Axd7YdiPFuPhw6DuqGqqdqinpa0zNIxL6MtZY=;
 b=IIkrBS9/epws5e6bi6TpPIbbQztMV1omk/ivMjF/fDANavM4SOpGXnjz
 puY6l/sqMFFBNIEq1cAlv3yGu4h2jF/HIRG/hXyQx/IWmEt7xFpiTKXHA
 e5RMJeN7ULFbdYFYF0zp0qZVK+vp3enhE6ib5eCkkegu+K8zhYN/2xCos w=;
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
IronPort-SDR: lYPEPaREY4DL5UdRC5M3ckSf4IAECkdpa878CASsb0YtKo3zvfIHnPzbLBK3Tz/Dcfq6CepxMi
 1SnFYEKZXLcoNM8+jp48NF/16gGjKaa1MGOlfox0OdIRroJWslu5iZIuXh4qEMhbO/jZkozFNf
 b2NEJuE101G5wfVQRm5jUZ+GemWqoLIyZpurJLvTrlfJWuLh6FG1iurHzk7VpLXcOa35jO8n8T
 BKmvg9LLvGfXY8DpCQZPFYNTJPrm0yqnTD7FxbdIEgDo7yTrcM7aYYpXgXhKEeospwf5sca6Y3
 UN8=
X-SBRS: 2.7
X-MesageID: 4987744
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,437,1559534400"; 
   d="scan'208";a="4987744"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Date: Tue, 27 Aug 2019 14:32:59 +0100
Message-ID: <20190827133259.32084-5-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190827133259.32084-1-anthony.perard@citrix.com>
References: <20190827133259.32084-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.175
Subject: [Qemu-devel] [PULL 4/4] xen-bus: Avoid rewriting identical values
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
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When QEMU receives a xenstore watch event suggesting that the "state"
of the frontend changed, it records this in its own state but it also
re-write the value back into xenstore even so there were no change.
This triggers an unnecessary xenstore watch event which QEMU will
process again (and maybe the frontend as well). Also QEMU could
potentially write an already old value.

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Paul Durrant <paul.durrant@citrix.com>
Message-Id: <20190823101534.465-3-anthony.perard@citrix.com>
---
 hw/xen/xen-bus.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 62c127b926..a04478ad4f 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -698,7 +698,8 @@ int xen_device_frontend_scanf(XenDevice *xendev, const char *key,
 }
 
 static void xen_device_frontend_set_state(XenDevice *xendev,
-                                          enum xenbus_state state)
+                                          enum xenbus_state state,
+                                          bool publish)
 {
     const char *type = object_get_typename(OBJECT(xendev));
 
@@ -710,7 +711,9 @@ static void xen_device_frontend_set_state(XenDevice *xendev,
                                     xs_strstate(state));
 
     xendev->frontend_state = state;
-    xen_device_frontend_printf(xendev, "state", "%u", state);
+    if (publish) {
+        xen_device_frontend_printf(xendev, "state", "%u", state);
+    }
 }
 
 static void xen_device_frontend_changed(void *opaque)
@@ -726,7 +729,7 @@ static void xen_device_frontend_changed(void *opaque)
         state = XenbusStateUnknown;
     }
 
-    xen_device_frontend_set_state(xendev, state);
+    xen_device_frontend_set_state(xendev, state, false);
 
     if (state == XenbusStateInitialising &&
         xendev->backend_state == XenbusStateClosed &&
@@ -1169,7 +1172,7 @@ static void xen_device_realize(DeviceState *dev, Error **errp)
     xen_device_frontend_printf(xendev, "backend-id", "%u",
                                xenbus->backend_id);
 
-    xen_device_frontend_set_state(xendev, XenbusStateInitialising);
+    xen_device_frontend_set_state(xendev, XenbusStateInitialising, true);
 
     xendev->exit.notify = xen_device_exit;
     qemu_add_exit_notifier(&xendev->exit);
-- 
Anthony PERARD


