Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46405C432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143202146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="INBoDTDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143202146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCjH0-0007sx-Re
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 07:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1iCj2N-0002P7-HA
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1iCj2K-0005HO-RZ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:31:18 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:17965)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1iCj2K-0005G2-Gu
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1569324677;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cVm1E9SWn59HiRBpcK9hd5UAXK2JM4SVNjHe+W2XCbI=;
 b=INBoDTDBmfqp+z03s1DCgOrKz+D/pyGW6W0MrgjioFc7YmwIHUw2GNLX
 TeQyoEs2GOHKwqE4euMghvv+lQhn5Vj6q3NLrNmNnjts785zIPHnaAo8c
 Yq80av2tn1B8bQcNkFQLlxmT6P7A17jxc4hwTw4Ycqv3PxIjW/gvw67/x o=;
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
IronPort-SDR: g1E08A7/TG9MA9xEBIV2QzhKpXyy+CjQC6yimgr4WuSbjTXUzfI/Mtcb+a5KWb/Vw/9sZFZyyN
 GhHZ5A8aPuFPV4BUW7qeE7qKf00OWceeburPZujocYAROIWca+9C+jVEZ0dbJYwG2qczAH/Ewp
 /ryEzvkUonppPXniep5zlonqRt5is266W+cHn/sRf9Eg1M4D8z0xb/o+hAhdzd6f/iiVOXg+w1
 AAkba9mtClJ0YcWWUX1w8SeIbdlUtZ7pfqPuo6HO9gT7TA9/kCgvVKKl09xNcM+vEJUSWsOkvt
 o+k=
X-SBRS: 2.7
X-MesageID: 5977601
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,543,1559534400"; 
   d="scan'208";a="5977601"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Subject: [PULL 6/7] xen-block: treat XenbusStateUnknown the same as
 XenbusStateClosed
Date: Tue, 24 Sep 2019 12:30:25 +0100
Message-ID: <20190924113026.255634-7-anthony.perard@citrix.com>
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

When a frontend gracefully disconnects from an offline backend, it will
set its own state to XenbusStateClosed. The code in xen-block.c correctly
deals with this and sets the backend into XenbusStateClosed. Unfortunately
it is possible for toolstack to actually delete the frontend area
before the state key has been read, leading to an apparent frontend state
of XenbusStateUnknown. This prevents the backend state from transitioning
to XenbusStateClosed and hence leaves it limbo.

This patch simply treats a frontend state of XenbusStateUnknown the same
as XenbusStateClosed, which will unblock the backend in these circumstances.

Reported-by: Mark Syms <mark.syms@citrix.com>
Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-Id: <20190918115702.38959-1-paul.durrant@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/block/xen-block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index f77343db60..879fc310a4 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -313,6 +313,7 @@ static void xen_block_frontend_changed(XenDevice *xendev,
         break;
 
     case XenbusStateClosed:
+    case XenbusStateUnknown:
         xen_block_disconnect(xendev, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
-- 
Anthony PERARD


