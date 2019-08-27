Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E52C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 13:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E188206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 13:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="TeY8K8ZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E188206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2bfw-00023V-6T
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 09:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1i2bb5-0006Fj-DO
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:33:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1i2bb0-0004ss-HR
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:33:19 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:9216)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1i2bb0-0004rj-6j
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1566912794;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=E7lWg8VZF/1XKaFjN4EjgBKL9WTiyqP571uFJ5cbJcI=;
 b=TeY8K8ZQJ3JmFxVhkYundsEgnaJf/oPeuLjYlngrrsSyIedj6X/eEITU
 vcnWqSkjqu8rXJrRge9OjNADLfjXMKG1CNUCPNW30A+czY/c/6vBPE9mt
 hqCkqfd06DlWbvEZrNJzcTWtWZHaVDdbsYOmrP3XRlWgSg6+OqknYOIGx s=;
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
IronPort-SDR: emSXTKiNX2gORp3QuaplSz8KP+U+6F+AP0AX9vjAyXYS9qsG22RdAtqZD3oy/Ore8jVf8QVPUI
 drhUX4MNGTm9jPwnd0kSqZYWUOBNxzjaVvHUkOg2k9C+b9amuOMwX0/JV0NkfPe8IS+CWKMAnR
 QtWwhUdvmJWNDH1oM8bf1ur/T4HszN9c+Vn3dbNDRSACh75GUNUdlFVGqzd5mBHmBRtdRkLnx5
 WQ0PxWBkgnRyubR6QzO5pncwYT14IfMDAWyHj20e6JIQ2g67FzECX4Z99XGBLY+/TKMoDFRwJt
 JfU=
X-SBRS: 2.7
X-MesageID: 4987739
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,437,1559534400"; 
   d="scan'208";a="4987739"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Date: Tue, 27 Aug 2019 14:32:55 +0100
Message-ID: <20190827133259.32084-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.175
Subject: [Qemu-devel] [PULL 0/4] xen queue 2019-08-27
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

The following changes since commit dac03af5d5482ec7ee9c23db467bb7230b33c0d9:

  Merge remote-tracking branch 'remotes/rth/tags/pull-axp-20190825' into staging (2019-08-27 10:00:51 +0100)

are available in the Git repository at:

  https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20190827

for you to fetch changes up to 705be570941b38cd1cbebc68f7f671ce7532ecb0:

  xen-bus: Avoid rewriting identical values to xenstore (2019-08-27 14:18:28 +0100)

----------------------------------------------------------------
Xen queue

* Fixes for xen-bus and exit cleanup.
* Build fix.

----------------------------------------------------------------
Anthony PERARD (3):
      xen: Fix ring.h header
      xen-bus: Fix backend state transition on device reset
      xen-bus: Avoid rewriting identical values to xenstore

Igor Druzhinin (1):
      xen: cleanup IOREQ server on exit

 hw/i386/xen/xen-hvm.c              |  2 ++
 hw/xen/xen-bus.c                   | 34 +++++++++++++++++++++++++++-------
 include/hw/xen/interface/io/ring.h | 13 +++++++------
 3 files changed, 36 insertions(+), 13 deletions(-)

