Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47ECDC4646B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:35:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 215A520652
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215A520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52390 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfR0S-0005PL-5L
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 11:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44850)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <anthony.perard@citrix.com>) id 1hfQy0-0003VK-IO
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:33:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1hfQxz-0000Kv-1J
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:33:12 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:11946)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1hfQxy-0000GL-LO
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:33:10 -0400
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
IronPort-SDR: w5lZWeFNe0Mt5GGtO6902sMa5nS1nV2xADuKuRQrGBgAgx31QkWiqGQGMdacZW9phAMfUm4Igl
 VQ/s9CQ17PbJ//+BE+ma5u8bgbEkNykZamyaiR/otO1OIOv/zsrJmFZ3ulhFI99vBlEuzIMBxT
 eHF0PBSjMjLE+7dKSKxBxQxLeHBVcOdp0ZOgSywvs5ALd/nd6BzDaIt0i4PibR3ivjWcOKn4+T
 lSjhuICS/xIdcNcEI0rSAEJzZtZ7wPq1VIsV8u9r2DGszoHxXG4+FN6LR3Zo/4MehbVzUyiWYq
 G5g=
X-SBRS: 2.7
X-MesageID: 2148093
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,412,1557201600"; 
   d="scan'208";a="2148093"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Date: Mon, 24 Jun 2019 16:32:49 +0100
Message-ID: <20190624153257.20163-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.155
Subject: [Qemu-devel] [PULL 0/8] xen queue 2019-06-24
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

The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-2019' into staging (2019-06-21 15:40:50 +0100)

are available in the Git repository at:

  https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20190624

for you to fetch changes up to a3434a2d56aee3018f4a0f55c7e0f0cda11f3d9e:

  xen: Import other xen/io/*.h (2019-06-24 10:42:30 +0100)

----------------------------------------------------------------
Xen queue

* Fix build
* xen-block: support feature-large-sector-size
* xen-block: Support IOThread polling for PV shared rings
* Avoid usage of a VLA
* Cleanup Xen headers usage

----------------------------------------------------------------
Anthony PERARD (4):
      xen: Avoid VLA
      xen: Drop includes of xen/hvm/params.h
      Revert xen/io/ring.h of "Clean up a few header guard symbols"
      xen: Import other xen/io/*.h

Paul Durrant (4):
      xen-block: support feature-large-sector-size
      xen-bus: use a separate fd for each event channel
      xen-bus: allow AioContext to be specified for each event channel
      xen-bus / xen-block: add support for event channel polling

 hw/9pfs/xen-9pfs.h                       |    4 +-
 hw/block/dataplane/xen-block.c           |   44 +-
 hw/block/dataplane/xen-block.h           |    3 +-
 hw/block/xen-block.c                     |   38 +-
 hw/block/xen_blkif.h                     |    5 +-
 hw/char/xen_console.c                    |    2 +-
 hw/display/xenfb.c                       |    7 +-
 hw/i386/xen/xen-hvm.c                    |   16 +-
 hw/i386/xen/xen-mapcache.c               |    2 -
 hw/net/xen_nic.c                         |    2 +-
 hw/usb/xen-usb.c                         |    3 +-
 hw/xen/xen-bus.c                         |   92 +--
 hw/xen/xen-legacy-backend.c              |    2 -
 include/hw/xen/interface/grant_table.h   |   36 ++
 include/hw/xen/interface/io/blkif.h      |  712 +++++++++++++++++++++
 include/hw/xen/interface/io/console.h    |   46 ++
 include/hw/xen/interface/io/fbif.h       |  156 +++++
 include/hw/xen/interface/io/kbdif.h      |  566 +++++++++++++++++
 include/hw/xen/interface/io/netif.h      | 1010 ++++++++++++++++++++++++++++++
 include/hw/xen/interface/io/protocols.h  |   42 ++
 include/hw/xen/{ => interface}/io/ring.h |    6 +-
 include/hw/xen/interface/io/usbif.h      |  254 ++++++++
 include/hw/xen/interface/io/xenbus.h     |   70 +++
 include/hw/xen/xen-bus.h                 |    9 +-
 include/hw/xen/xen_common.h              |    2 +-
 25 files changed, 3023 insertions(+), 106 deletions(-)
 create mode 100644 include/hw/xen/interface/grant_table.h
 create mode 100644 include/hw/xen/interface/io/blkif.h
 create mode 100644 include/hw/xen/interface/io/console.h
 create mode 100644 include/hw/xen/interface/io/fbif.h
 create mode 100644 include/hw/xen/interface/io/kbdif.h
 create mode 100644 include/hw/xen/interface/io/netif.h
 create mode 100644 include/hw/xen/interface/io/protocols.h
 rename include/hw/xen/{ => interface}/io/ring.h (99%)
 create mode 100644 include/hw/xen/interface/io/usbif.h
 create mode 100644 include/hw/xen/interface/io/xenbus.h

