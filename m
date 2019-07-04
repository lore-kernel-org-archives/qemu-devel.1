Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AFEC46486
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 15:38:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F2EC21852
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 15:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2EC21852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj3og-0000Y9-VV
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 11:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39713)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <anthony.perard@citrix.com>) id 1hj3mp-0007Vg-1O
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1hj3mn-0004w2-RA
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:36:38 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:4708)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1hj3mn-0004uM-JD
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:36:37 -0400
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
IronPort-SDR: OoomVJH8dJBtCkqlNr34nlMSb0ETOMf1DB4fpTecWIoYdSZVEPED7EZAQtZCZNFjvZHnJipxTw
 au8z1DI4idSuypN+pDtdEIXI8Yn7Y+DuWnD8nh1ArLpVdDwxRMaEZ0L7KxLnQ1Zie3gKcEKqRt
 O4YqfTizwVI2+Ej0mk8aCHm9GLtqOmP1aTtfQKTjQ8MPpmbBb9zgoMkdLITUEwcK21U3/94yXg
 RILCkoeMcvFc1jQFTnIhHoT8miA4MUMYr1QLLFXhbDVg3wUX1i8Td/g/PXuhRHRuEGSxIMUWjT
 Oec=
X-SBRS: 2.7
X-MesageID: 2627246
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,451,1557201600"; 
   d="scan'208";a="2627246"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Date: Thu, 4 Jul 2019 16:36:05 +0100
Message-ID: <20190704153605.4140-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.175
Subject: [Qemu-devel] [PATCH] xen: Fix ring.h header
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
 Markus Armbruster <armbru@redhat.com>, Paul
 Durrant <paul.durrant@citrix.com>
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
---

Notes:
    A similar patch have been sent to the canonical version:
    https://lists.xenproject.org/archives/html/xen-devel/2019-07/msg00370.html

 include/hw/xen/interface/io/ring.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/hw/xen/interface/io/ring.h b/include/hw/xen/interface/io/ring.h
index 1adacf09f9..704990a2c9 100644
--- a/include/hw/xen/interface/io/ring.h
+++ b/include/hw/xen/interface/io/ring.h
@@ -42,12 +42,6 @@
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


