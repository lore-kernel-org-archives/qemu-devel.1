Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC89C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 13:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A835E20828
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 13:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="aTCuntk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A835E20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2bcg-0007Bl-Nw
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 09:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1i2bb2-0006DL-SX
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:33:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1i2bb1-0004tV-Kx
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:33:16 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:9216)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1i2bb1-0004rj-7T
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1566912795;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Evh/5LyKfZIwz6MpzK7DNYlQ6kRXiowbyoltKQb/7FM=;
 b=aTCuntk7rQZWqUDLhSBozE7dDXtkvIwfd23CrOD/SuST5KoK2HcbKFM9
 sQ7ZUAKKAzaFBYhSMLlB/+l9mbH9zoUrS2bjZsXvLWlr98r7MWxlqvh/T
 jtanQV8/AdnJTewFAh/BmcaQenBejGsz6g3pJoa8mPsUaFW9L+7LAeCJ7 A=;
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
IronPort-SDR: 7kfNZTu9scceGpJZthsMQ9YewLEBz1yUgwFlRBbfBFUikoMNgoesa8K7VsE5hwSkZRtr/RAAFx
 dHka7gqfcjMpE7J1qMp2O0YQ3oZNa/j5IWVVJNA5lDITUguAd2ONoKCSsTL6OxNWquMu9phLH9
 i3xv0CZ+KK1v7Ve2o0Ldb03FF7gUirljMBnJv2CmZbSgObT+D1WFbK9nBvnCDZJJGfFp4C7MyC
 vHJzCWtLf+x7+qZo66SglD8ipqq4zi6xFIMzPiAvFrJg/SIwHkk2yebV4ve3zflAwbIdv45+j+
 5Ok=
X-SBRS: 2.7
X-MesageID: 4987742
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,437,1559534400"; 
   d="scan'208";a="4987742"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Date: Tue, 27 Aug 2019 14:32:56 +0100
Message-ID: <20190827133259.32084-2-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190827133259.32084-1-anthony.perard@citrix.com>
References: <20190827133259.32084-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.175
Subject: [Qemu-devel] [PULL 1/4] xen: Fix ring.h header
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

The xen_[rw]?mb() macros defined in ring.h can't be used and the fact
that there are gated behind __XEN_INTERFACE_VERSION__ means that it
needs to be defined somewhere. QEMU doesn't implement interfaces with
the Xen hypervisor so defining __XEN_INTERFACE_VERSION__ is pointless.
This leads to:
    include/hw/xen/io/ring.h:47:5: error: "__XEN_INTERFACE_VERSION__"
        is not defined, evaluates to 0 [-Werror=undef]

Cleanup ring.h. The xen_*mb() macros are already defined in xenctrl.h
which is included in xen_common.h.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190704153605.4140-1-anthony.perard@citrix.com>
[aperard: Adding the comment proposed upstream]
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 include/hw/xen/interface/io/ring.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/hw/xen/interface/io/ring.h b/include/hw/xen/interface/io/ring.h
index 1adacf09f9..5d048b335c 100644
--- a/include/hw/xen/interface/io/ring.h
+++ b/include/hw/xen/interface/io/ring.h
@@ -33,6 +33,13 @@
  * - standard integers types (uint8_t, uint16_t, etc)
  * They are provided by stdint.h of the standard headers.
  *
+ * Before using the different macros, you need to provide the following
+ * macros:
+ * - xen_mb()  a memory barrier
+ * - xen_rmb() a read memory barrier
+ * - xen_wmb() a write memory barrier
+ * Example of those can be found in xenctrl.h.
+ *
  * In addition, if you intend to use the FLEX macros, you also need to
  * provide the following, before invoking the FLEX macros:
  * - size_t
@@ -42,12 +49,6 @@
  * and grant_table.h from the Xen public headers.
  */
 
-#if __XEN_INTERFACE_VERSION__ < 0x00030208
-#define xen_mb()  mb()
-#define xen_rmb() rmb()
-#define xen_wmb() wmb()
-#endif
-
 typedef unsigned int RING_IDX;
 
 /* Round a 32-bit unsigned constant down to the nearest power of two. */
-- 
Anthony PERARD


