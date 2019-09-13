Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44114C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 08:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ECA42089F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 08:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ZWj7gczQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECA42089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8gvC-0001bP-16
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 04:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i8gqG-0004um-W4
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 04:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i8gqF-0002AH-VH
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 04:22:08 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:18057)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1i8gqF-00029w-OK
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 04:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1568362928;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0ObFgUX3jPgasy9ajYbOm2FMaRHg+XjQQqmPWU420IM=;
 b=ZWj7gczQACu5nmkKN+Sq+LLuWxkuKSrPFq6ForXoXnf0swYz0UnT/MCx
 ISwt0yRjPVPZIOg/rz6meugYrTNuRoOcjqosgd1MZ8shOlxR0Sa5jyZcG
 ZYfhgosqyKnvQycfq7jZsz6RuWzIct5kUHaoXZ5UJpnD1CIVRLwlugyeV g=;
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=paul.durrant@citrix.com;
 spf=Pass smtp.mailfrom=Paul.Durrant@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 paul.durrant@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="paul.durrant@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
 Paul.Durrant@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: nFiC1wyco7LKY28TNn6NTydJcCYrUiwRQUBh2NKtIcYXBkZUgbKk2FU9HeK0BuAyqur73keXtu
 U25OcFxbFH9MufBpfaCrJw842bp33DsFyLor4JYdBIzT5uPRanoPS3TqOklkWGx11sO57BQfeh
 MhOhw2qA5eyLbFUlIz9EUBhJEzofcuReQFgwhC+bI73PPbxzeNWPCVhHIcRXe6hClgYGXJJA28
 PIxv4nm+tqvpfVJlIUD7TnbLz611T2mgduUKOJonXQ3MCJ4zgcI74td4a9I/NBMNFqMk7e6GJN
 ADY=
X-SBRS: 2.7
X-MesageID: 5578877
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,500,1559534400"; 
   d="scan'208";a="5578877"
From: Paul Durrant <paul.durrant@citrix.com>
To: <qemu-devel@nongnu.org>, <xen-devel@lists.xenproject.org>
Date: Fri, 13 Sep 2019 09:21:55 +0100
Message-ID: <20190913082159.31338-1-paul.durrant@citrix.com>
X-Mailer: git-send-email 2.20.1.2.gb21ebb6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.142
Subject: [Qemu-devel] [PATCH v3 0/3] xen: fix a potential crash in xen-bus
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

This series fixes a potential segfault caused by NotifierList corruption
in xen-bus. The first two patches lay the groundwork and the third
actually fixes the problem.

Paul Durrant (3):
  xen / notify: introduce a new XenWatchList abstraction
  xen: introduce separate XenWatchList for XenDevice objects
  xen: perform XenDevice clean-up in XenBus watch handler

 hw/xen/trace-events      |   9 +-
 hw/xen/xen-bus.c         | 277 ++++++++++++++++++++++++++++-----------
 include/hw/xen/xen-bus.h |   8 +-
 include/qemu/notify.h    |   2 +
 util/notify.c            |   5 +
 5 files changed, 220 insertions(+), 81 deletions(-)
---
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
-- 
2.20.1.2.gb21ebb6


