Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD31C2BA2B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:24:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC5F02074F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="fBP35TLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5F02074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLq5x-0003CC-4s
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 11:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1jLq42-0008E5-OE
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1jLq41-0000Vh-TD
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:22:58 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:13489)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1jLq41-0000TJ-LK
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1586272978;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zpD/qULcUWjnXe5Pei47zmPvZSaeufrHyKCovEQ8IY0=;
 b=fBP35TLK1W/7PZUQGPLuBQDyE/1dS3G8hMgq+nJfTCgrE2B8oNJ+B30z
 5zTkLiCo/P1IFfN2L7Mj9WkQ4zCYhByMmsmKqzAW5b2v2ZKVPIblSkG/Y
 GUG6+MICz7W/hpKtC+l5Pl2kHsE6rJULOcbrNMuiT5X4NglJXI93mzfoP I=;
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
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: kIpJUdp/ueeziAdKh5CGN0J6Of7NJxXM7lkAmrFurtwL8Nti4/kW70mNzCLO/YPcuUrkSBnyju
 hOF6Jspwi3Xkj/jXa0FPpfunPEQRgsAup8Eto8FuPJqlIK/0knMN1H429JH7VaUHURz/KgN/Ea
 XkzvyPWPQZ+Up7cJv2GF+q9Hh27bPlEZxtTGJyjkroE/fsDBaWYSEoVsuZggKe23bYe1EDPO1h
 JgFukRRiHec3wCj2Fjqoe8xuvbxriSu1WnXngqD3AbMNLELlA7KKs70KShHxsWTh9Saf1EMVzV
 PKk=
X-SBRS: 2.7
X-MesageID: 15534906
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,355,1580792400"; d="scan'208";a="15534906"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Subject: [PULL 3/3] MAINTAINERS: Add xen-usb.c to Xen section
Date: Tue, 7 Apr 2020 16:22:37 +0100
Message-ID: <20200407152237.1468704-4-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407152237.1468704-1-anthony.perard@citrix.com>
References: <20200407152237.1468704-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.145.142
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
Cc: Peter Maydell <peter.maydell@linaro.org>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Acked-by: Paul Durrant <paul@xen.org>
Message-Id: <20200406165043.1447837-1-anthony.perard@citrix.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d156d73b31e..839959f7e4ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -440,6 +440,7 @@ F: hw/9pfs/xen-9p*
 F: hw/char/xen_console.c
 F: hw/display/xenfb.c
 F: hw/net/xen_nic.c
+F: hw/usb/xen-usb.c
 F: hw/block/xen*
 F: hw/block/dataplane/xen*
 F: hw/xen/
-- 
Anthony PERARD


