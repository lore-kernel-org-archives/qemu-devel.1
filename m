Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819EDC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C50D204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="dzNc5o+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C50D204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Mo2-0003MP-Fa
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 05:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1i0Mn6-0002NO-Uq
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1i0Mn5-0007m5-TM
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:20:28 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:7419)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1i0Mn5-0007iC-LH; Wed, 21 Aug 2019 05:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1566379227;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BK2UfPfQnsAdpwWahhn9/K+61xT4PsE2aBOjJXllKHk=;
 b=dzNc5o+nTt70S3GIToqrIr1/+IfDW538isrj+W8exeKUu4H37ojD/a+O
 RlQZJHqmj43SyKiZROKOWnZYllgsvQKzDT2b2UOeGu4b9aBGVYGNbzhWa
 84ijbGOMRXWIYHd2KF83rb40zQpZetY7V+F+X+ercbIEkJvJrdrntk90g c=;
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
IronPort-SDR: Dre/avdhM7+LkeeYNgXPxCnkXilAmFPsNzT4qdmjCyNlv3RbAuMOhVn8Hnt589TC2ULQAyStmJ
 wztSwrqA0slgsaYkaxu90dU3UyfmxOHqd0ywcZ+98kK+RjFO9FYLuJIE8r0tRR/Gn7YVBB4lqB
 b6iSUVXUkjPwrJUtVz621eni4MLaOxm7efr/gQJaNhCkecfQ5HGEJ5VuHoNh6x87n95f+58EuQ
 1tNsyO2VabwmwuQl/amP+KFPELiUvI3GQAooAUS887cQnyBt9uPiTpot6St8gekcuXoRKO+e2D
 PLI=
X-SBRS: 2.7
X-MesageID: 4731850
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,412,1559534400"; 
   d="scan'208";a="4731850"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Date: Wed, 21 Aug 2019 10:20:19 +0100
Message-ID: <20190821092020.17952-2-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821092020.17952-1-anthony.perard@citrix.com>
References: <20190821092020.17952-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.175
Subject: [Qemu-devel] [PATCH 1/2] xen-bus: Fix backend state transition on
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
 Stefano Stabellini <sstabellini@kernel.org>, qemu-stable@nongnu.org,
 Paul Durrant <paul.durrant@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a frontend want to reset its state and the backend one, it start
with setting "Closing", then wait for the backend (QEMU) to do the same.

But when QEMU is setting "Closing" to its state, it trigger an event
(xenstore watch) that re-execute xen_device_backend_changed() and set
the backend state to "Closed". QEMU should wait for the frontend to
set "Closed" before doing the same.

Before setting "Closed" to the backend_state, we are also going to
check if the frontend was responsible for the transition to "Closing".

Fixes: b6af8926fb858c4f1426e5acb2cfc1f0580ec98a
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
Cc: qemu-stable@nongnu.org
---
 hw/xen/xen-bus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index e40500242d..982eca4533 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -540,9 +540,11 @@ static void xen_device_backend_changed(void *opaque)
     /*
      * If the toolstack (or unplug request callback) has set the backend
      * state to Closing, but there is no active frontend (i.e. the
-     * state is not Connected) then set the backend state to Closed.
+     * state is not Connected or Closing) then set the backend state
+     * to Closed.
      */
     if (xendev->backend_state == XenbusStateClosing &&
+        xendev->frontend_state != XenbusStateClosing &&
         xendev->frontend_state != XenbusStateConnected) {
         xen_device_backend_set_state(xendev, XenbusStateClosed);
     }
-- 
Anthony PERARD


