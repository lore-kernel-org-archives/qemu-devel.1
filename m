Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E15EC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:34:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A7A214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="YCYszaQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A7A214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCj5k-0004Py-9z
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 07:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1iCj2L-0002Oy-5X
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1iCj2J-0005GD-FY
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:31:16 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:17963)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1iCj2J-0005Fj-3R
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1569324676;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1fLJMTliI1vK08faPR4VUIwhEhfNNpZZbP4jagQup3M=;
 b=YCYszaQBpYeVnlO6Dn9zWntPpySIzAVfUPaTNXf+pPHSQbnK6MmAv0Ms
 IBahwY9hKqiDJr37zhi4Nm21Dp8Aw2gzGGxmHDSLe1g53+XQQRzo89862
 mJxk0Qch8bH1t1g4D6sacxgv7YidJ/ueHsrpKL8szkFZRZ7R+nDH+6M2o c=;
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
IronPort-SDR: zQ+7TjXT5X9FCZjSpRAdICG/WkfHuexnxj8DB6Vb0CEetuZMn4DZCFhNOZuy7URZhkhqw1ffep
 i1teA1hYmyKHswVZq9Ny+lS492y3fRXUsmiUL5alaiJlwNFcNsKG39/KPveoo+qVEYr+qDTBE/
 mwSozZ7jgrqWvVKjMoXwG31kmDi0kf10eP4KQ4q0SJTqg4cvdAqEfeifrql1kcn3KeaRrNRM64
 uYgi6j2urGYObf1XtgmJY7474pey+1aAXalMIGxVoIbwDxJ/wkFjkmDwRbN2GmYNTGkeNuHHiM
 rR8=
X-SBRS: 2.7
X-MesageID: 5977594
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,543,1559534400"; 
   d="scan'208";a="5977594"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Subject: [PULL 0/7] xen queue 2019-09-24
Date: Tue, 24 Sep 2019 12:30:19 +0100
Message-ID: <20190924113026.255634-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.23.0
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

The following changes since commit 2f93a3ecdd3bb060bd04f698ccafe66efd98563a:

  Merge remote-tracking branch 'remotes/davidhildenbrand/tags/s390x-tcg-2019-09-23' into staging (2019-09-23 15:44:52 +0100)

are available in the Git repository at:

  https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20190924

for you to fetch changes up to 6bd6b955c0b2666263700d39db153ab43c5e0c9e:

  xen-bus: only set the xen device frontend state if it is missing (2019-09-24 12:21:29 +0100)

----------------------------------------------------------------
Xen queue

* Update of maintainer email address
* Fixes for xen-bus and xen-block

----------------------------------------------------------------
Mark Syms (1):
      xen-bus: only set the xen device frontend state if it is missing

Paul Durrant (6):
      xen-bus: check whether the frontend is active during device reset...
      xen / notify: introduce a new XenWatchList abstraction
      xen: introduce separate XenWatchList for XenDevice objects
      xen: perform XenDevice clean-up in XenBus watch handler
      MAINTAINERS: update my email address
      xen-block: treat XenbusStateUnknown the same as XenbusStateClosed

 MAINTAINERS              |   2 +-
 hw/block/xen-block.c     |   1 +
 hw/xen/trace-events      |   9 +-
 hw/xen/xen-bus.c         | 316 ++++++++++++++++++++++++++++++++++-------------
 include/hw/xen/xen-bus.h |   8 +-
 include/qemu/notify.h    |   2 +
 util/notify.c            |   5 +
 7 files changed, 249 insertions(+), 94 deletions(-)

