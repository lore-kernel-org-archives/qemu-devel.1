Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342D6C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095B02054F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095B02054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52472 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfR8W-0004SI-5z
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 11:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44912)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <anthony.perard@citrix.com>) id 1hfQy3-0003Ya-Nq
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1hfQy1-0000PJ-Lh
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:33:15 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:11946)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1hfQy1-0000GL-1g
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:33:13 -0400
Authentication-Results: esa3.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: 8a/f3n8FrzsCNMdKRAJOtwsqjTiA0a4FLq3A2XI0xZ1DlDQZvuVaC/p1tV6/EnLfA1kf33mOz5
 1uslDhMrijaO7GqLdogyXwL6HQZwIV+qmYliRtpRp1Xzb4W8cLVNbQH+uJJ0v7EqfB4j06/kBt
 bVklUXfDvjjFgkLrvN3FMPmByYOg8KBRgluadUaH9LXz5HeI0+2GdEvQKYpuvue96rDucnQdko
 8Rle0HnjzCkMnvZQx0971bA7WoNY8ngDjF0HenocJ33ZIhzxLQd6uagwUxZW5G0LrYEqmOxPne
 g+Y=
X-SBRS: 2.7
X-MesageID: 2148104
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,412,1557201600"; 
   d="scan'208";a="2148104"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Date: Mon, 24 Jun 2019 16:32:56 +0100
Message-ID: <20190624153257.20163-8-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624153257.20163-1-anthony.perard@citrix.com>
References: <20190624153257.20163-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.155
Subject: [Qemu-devel] [PULL 7/8] Revert xen/io/ring.h of "Clean up a few
 header guard symbols"
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

This reverts changes to include/hw/xen/io/ring.h from commit
37677d7db39a3c250ad661d00fb7c3b59d047b1f.

Following 37677d7db3 "Clean up a few header guard symbols", QEMU start
to fail to build:

In file included from ~/xen/tools/../tools/include/xen/io/blkif.h:31:0,
                 from ~/xen/tools/qemu-xen-dir/hw/block/xen_blkif.h:5,
                 from ~/xen/tools/qemu-xen-dir/hw/block/xen-block.c:22:
~/xen/tools/../tools/include/xen/io/ring.h:68:0: error: "__CONST_RING_SIZE" redefined [-Werror]
 #define __CONST_RING_SIZE(_s, _sz) \

In file included from ~/xen/tools/qemu-xen-dir/hw/block/xen_blkif.h:4:0,
                 from ~/xen/tools/qemu-xen-dir/hw/block/xen-block.c:22:
~/xen/tools/qemu-xen-dir/include/hw/xen/io/ring.h:66:0: note: this is the location of the previous definition
 #define __CONST_RING_SIZE(_s, _sz) \

The issue is that some public xen headers have been imported (by
f65eadb639 "xen: import ring.h from xen") but not all. With the change
in the guards symbole, the ring.h header start to be imported twice.

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Paul Durrant <paul.durrant@citrix.com>
Message-Id: <20190621105441.3025-2-anthony.perard@citrix.com>
---
 include/hw/xen/io/ring.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/xen/io/ring.h b/include/hw/xen/io/ring.h
index 62abfd7a6e..1adacf09f9 100644
--- a/include/hw/xen/io/ring.h
+++ b/include/hw/xen/io/ring.h
@@ -24,8 +24,8 @@
  * Tim Deegan and Andrew Warfield November 2004.
  */
 
-#ifndef XEN_PUBLIC_IO_RING_H
-#define XEN_PUBLIC_IO_RING_H
+#ifndef __XEN_PUBLIC_IO_RING_H__
+#define __XEN_PUBLIC_IO_RING_H__
 
 /*
  * When #include'ing this header, you need to provide the following
@@ -469,7 +469,7 @@ struct name##_data_intf {                                                     \
 };                                                                            \
 DEFINE_XEN_FLEX_RING(name)
 
-#endif /* XEN_PUBLIC_IO_RING_H */
+#endif /* __XEN_PUBLIC_IO_RING_H__ */
 
 /*
  * Local variables:
-- 
Anthony PERARD


