Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43570C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:35:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E158214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="F+AQ+7pF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E158214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCj6G-0004nt-Hf
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 07:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1iCj2L-0002P1-Bj
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1iCj2J-0005GW-PU
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:31:16 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:17965)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1iCj2J-0005G2-Fk
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1569324676;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7rCPwSSKvk2M6jbJf0UE2gfEyhfV5C3cyXczS3Hzueg=;
 b=F+AQ+7pFGmymP1TOB02g4cPifrLBwpVYWZJ4vyca8Xn88K8rRyzFqy+2
 VlCogXkoipQjYUYIZDhg4ADGy/tM2C54aqTmq3XPPEl5uiPTJt5yXWN3x
 Z/nPDbpQ/0G5Z+PZNgYL2NgjhNJE62hpHwk6tK5seJqhmOZ0BZjeohbyb A=;
Authentication-Results: esa2.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: eke+LBUkvZytegB6Sk+0JJUvlo/bUFpBhM86B1VtATWVSmGFc0DWd02S5V02djPBdpugXIYvj7
 mQ8WePuGSqIX+ipGhOy0sXY2yrAnQ3bKQrzgyo0WJ8xfzJVbTFpDrwdMoARv1ArCQ2BiPlWpF2
 YeJwObf55Dial9bB+rrSxZPW3H5gEO3MpHf2UphdEz9v9Hrar8Wcw3lV5EXLtN33FU12aIVFLX
 vHMeE+u38d2jPfljIvdufQ0vLtgofIB/yV7ca3R1pxDbLsyciYwwPZYcfnZJ84fINrt8dQXpu5
 Udk=
X-SBRS: 2.7
X-MesageID: 5977595
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,543,1559534400"; 
   d="scan'208";a="5977595"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Subject: [PULL 1/7] xen-bus: check whether the frontend is active during
 device reset...
Date: Tue, 24 Sep 2019 12:30:20 +0100
Message-ID: <20190924113026.255634-2-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190924113026.255634-1-anthony.perard@citrix.com>
References: <20190924113026.255634-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.153
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
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20190910171753.3775-1-paul.durrant@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
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
Anthony PERARD


