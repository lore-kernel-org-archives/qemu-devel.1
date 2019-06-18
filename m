Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EF5C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2213A2082C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2213A2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55714 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdCJ2-0006C8-FB
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 07:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44062)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <anthony.perard@citrix.com>) id 1hdCDZ-0001sg-Uc
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1hdCDQ-00074G-EL
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:23:58 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:11328)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1hdCDO-000714-Vi
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:23:52 -0400
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: OcJzgzlo3IL+pq/7CWnXhz+sREFwNVBJeXlnOdmmpNoIinHrL60jbWq6F+AsxmGCJwTS79wgB5
 sY21hff+x2wajYBwOU/PP/fqYsvCoHGITr1FmHrtvA8WEQ/OlJ9FleIe1CWpv825Dc7r1u81Ps
 YIDUtPJcvDu5OU5Xc4niwoYu6Ys1YMKF6V6xVN1H7AKn8tafJ6czECiw1lsKXVEkIbXUDt5Ch2
 aVLHGbfweJiU++DpAufBN+d5IjAZhFpVe1EphbfOF+KBfivJPBBM+gq5oXPS/xv9E/Zve1iFAC
 /BU=
X-SBRS: 2.7
X-MesageID: 1889152
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,389,1557201600"; 
   d="scan'208";a="1889152"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Date: Tue, 18 Jun 2019 12:23:40 +0100
Message-ID: <20190618112341.513-4-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190618112341.513-1-anthony.perard@citrix.com>
References: <20190618112341.513-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.142
Subject: [Qemu-devel] [PATCH v2 3/4] xen: Drop includes of xen/hvm/params.h
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
 Paul Durrant <paul.durrant@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

xen-mapcache.c doesn't needs params.h.

xen-hvm.c uses defines available in params.h but so is xen_common.h
which is included before. HVM_PARAM_* flags are only needed to make
xc_hvm_param_{get,set} calls so including only xenctrl.h, which is
where the definition the function is, should be enough.
(xenctrl.h does include params.h)

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---

Notes:
    v2:
    - new patch replacing "xen: Import Xen public headers used by xen-hvm.c"
    - only drop includes of params.h, and don't import the other two;
    ioreq.h is an interface with Xen; e820.h is just used by QEMU to figure
    out the guest memory layout without proper communication with the Xen
    toolstacks or something like that.

 hw/i386/xen/xen-hvm.c      | 1 -
 hw/i386/xen/xen-mapcache.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 2939122e7c..ae3deb4ef3 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -27,7 +27,6 @@
 #include "exec/address-spaces.h"
 
 #include <xen/hvm/ioreq.h>
-#include <xen/hvm/params.h>
 #include <xen/hvm/e820.h>
 
 //#define DEBUG_XEN_HVM
diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index 254759f776..dc73c86c61 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -17,8 +17,6 @@
 #include "hw/xen/xen-legacy-backend.h"
 #include "qemu/bitmap.h"
 
-#include <xen/hvm/params.h>
-
 #include "sysemu/xen-mapcache.h"
 #include "trace.h"
 
-- 
Anthony PERARD


