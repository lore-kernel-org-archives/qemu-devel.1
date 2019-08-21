Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2742C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA6C22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Ws35BMEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA6C22D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Mp0-0004p6-La
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 05:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1i0Mn6-0002MT-Sh
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1i0Mn5-0007lf-Ce
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:20:28 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:7419)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1i0Mn4-0007iC-SX
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1566379226;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jU4aiKls9iM4bKNHFjEoSzHpSYRslUWzqajIBzlS5J0=;
 b=Ws35BMEwMzteHyOl3ruy1rofQEBB0dA82ldP9UZwa2VY3E72ZOnWDYVY
 qTHbGpQbfd6gCv+QXK777rwg4ANC53IL++26U/uR4p5JautDBWHSeYQ8y
 69yl0io6SosjYvmpW6EV+/SA5SyUIty4YmWm9CWRz21NxMY+tPr3/Fv69 Q=;
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
IronPort-SDR: LUJgCfHIDvzkaqsSBe5waOiBzHbnJYUznQ1vYPag6IGjbzy5VmveIGKk9bBaY8xqH9l+ZnNKvt
 KqLhMwdQW+5K8yjwCFerRRiFsiEyr9unR5DzjNspKtaMx3By18aLOcb1ao34eqUOK81TIW8xMe
 ij8flk+79+JLHBQYPuQRT4uZbuR7u+JDvMSsulgItKUiyaOun8OVLv6cyfG1DqWXtjKleDIgqo
 +l3G+4FDrZ1m5+S6btlk9MvNt97CpvwV3qYYuQ4WLVG+XY54DfIeTu7FhdimhxcbW6EVD8LjbH
 0Ys=
X-SBRS: 2.7
X-MesageID: 4731848
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,412,1559534400"; 
   d="scan'208";a="4731848"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Date: Wed, 21 Aug 2019 10:20:18 +0100
Message-ID: <20190821092020.17952-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.175
Subject: [Qemu-devel] [PATCH 0/2] Fix for the xen-bus driver
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
Cc: Anthony PERARD <anthony.perard@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cheers,

Anthony PERARD (2):
  xen-bus: Fix backend state transition on device reset
  xen-bus: Avoid rewriting identical values to xenstore

 hw/xen/xen-bus.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

-- 
Anthony PERARD


