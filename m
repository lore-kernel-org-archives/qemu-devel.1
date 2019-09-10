Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2F0C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 17:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A76132168B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 17:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="AhH837WC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76132168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jn4-0002R7-NA
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 13:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i7jmG-00022W-8R
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i7jmD-0003w9-Lu
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:18:03 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:21743)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1i7jmD-0003uU-Do
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 13:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1568135881;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4EQDLX0pe4LFQBOxhQT5XctuBAJ4p4LzBN7en1w1ad8=;
 b=AhH837WCPz5BO8H15NLQohyaM5LLIoA8zr6Jgnbkfb6SmbFsKcCruDcJ
 RrZ0PtaFB8hPDNw8c6YekX8F/9H7gRU1b0pJ49HXc4TY4C4j5fDp3mxma
 zKbrbNn/og02ojFuHzuZ/1G1YGYUA7F6QrO6nazfem+KdYppVkkW3y1dk U=;
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
IronPort-SDR: 60fRz8xH9yMxgIScIxv7ojdS5kEEKjLYbuKXWJ0Fh/HOHM5kVGrC1i0S/StPNvFs+P2EmsSM5S
 gRnU8QywzNTUu7cyffCh9VUkQKJ8xk6/5emDMZWesN7xxzYcj8jhExUH9QCdhn0R7LdpYkuPSs
 9jGIGwuf3l9YWb8D6tkzkchdPrObxwBwblELi2grajzJPeIvFPePG0GIEZ8gD1NNq3QraFtLVm
 NaaiKG+k+21n6rNw31touy+remLqD9mv8QYVh/rIm1M2uYa7uaethPh2fQYI2Am6F9Ww3tAzck
 pNw=
X-SBRS: 2.7
X-MesageID: 5580743
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,490,1559534400"; 
   d="scan'208";a="5580743"
From: Paul Durrant <paul.durrant@citrix.com>
To: <qemu-devel@nongnu.org>
Date: Tue, 10 Sep 2019 18:17:53 +0100
Message-ID: <20190910171753.3775-1-paul.durrant@citrix.com>
X-Mailer: git-send-email 2.20.1.2.gb21ebb6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.168
Subject: [Qemu-devel] [PATCH] xen-bus: check whether the frontend is active
 during device reset...
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
 Stefano Stabellini <sstabellini@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

...not the backend

Commit cb323146 "xen-bus: Fix backend state transition on device reset"
contained a subtle mistake. The hunk

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

mistakenly replaced the check of 'xendev->frontend_state' with a check
(now in a helper function) of 'state', which actually equates to
'xendev->backend_state'.

This patch fixes the mistake.

Fixes: cb3231460747552d70af9d546dc53d8195bcb796
Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
---
 hw/xen/xen-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index a04478ad4f..025df5e59f 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -560,7 +560,7 @@ static void xen_device_backend_changed(void *opaque)
      * backend state to Closed.
      */
     if (xendev->backend_state == XenbusStateClosing &&
-        !xen_device_state_is_active(state)) {
+        !xen_device_state_is_active(xendev->frontend_state)) {
         xen_device_backend_set_state(xendev, XenbusStateClosed);
     }
 
-- 
2.20.1.2.gb21ebb6


