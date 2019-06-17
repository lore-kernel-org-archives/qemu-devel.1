Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DE2C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA0DB2084A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0DB2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49106 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcuTo-0008TT-3l
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 12:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37584)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <anthony.perard@citrix.com>) id 1hctlD-0004A2-Sj
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1hctlC-0008F1-Dd
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:41:31 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:43075)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1hctlA-00082T-AM
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 11:41:29 -0400
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
IronPort-SDR: wHzjo5RqYzLKZgmX1VIM9WWTH4C7NDFYDFwET3zmDSBfbUJrelHOdOjapYyhMLI+gijdDJCuqB
 dDZHgI7y9qV8b/uxpQ/zfxlISfJStj2t7rcR5U9AANVoikrNhtnHHjFeMySI1DjLHkSf1GPTix
 xA4WZiVvF/njwHXi2io9azkPD8YceIytBmhnC4hfaEGFThbQrW/Fe6jJlf0+BmVTpj1f+dGZUL
 /Gb7dsBHhBMb5kwW+snKEdrybT8WpXmskMLS8xT0ZRQ9bRlUeBOOlhiDAkgvw3MhuXR05qpPV6
 9vg=
X-SBRS: 2.7
X-MesageID: 1838524
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,385,1557201600"; 
   d="scan'208";a="1838524"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Date: Mon, 17 Jun 2019 16:41:01 +0100
Message-ID: <20190617154105.32323-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.155
Subject: [Qemu-devel] [PATCH 0/4] Fix build of Xen support + cleanup
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
 Paul Durrant <paul.durrant@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Fix the build in osstest and some cleanup

For reference:

Recent flight failure:
https://lists.xenproject.org/archives/html/xen-devel/2019-06/msg01022.html

Bisect result:
https://lists.xenproject.org/archives/html/xen-devel/2019-06/msg01029.html

Thanks.

Anthony PERARD (4):
  xen: Fix build with public headers
  xen: Import other xen/io/*.h
  xen: Import Xen public headers used by xen-hvm.c
  xen: Avoid VLA

 hw/9pfs/xen-9pfs.h                       |    4 +-
 hw/block/xen_blkif.h                     |    5 +-
 hw/char/xen_console.c                    |    2 +-
 hw/display/xenfb.c                       |    7 +-
 hw/i386/xen/xen-hvm.c                    |   17 +-
 hw/i386/xen/xen-mapcache.c               |    2 -
 hw/net/xen_nic.c                         |    2 +-
 hw/usb/xen-usb.c                         |    3 +-
 hw/xen/xen-legacy-backend.c              |    2 -
 include/hw/xen/interface/grant_table.h   |   36 +
 include/hw/xen/interface/hvm/e820.h      |   28 +
 include/hw/xen/interface/hvm/ioreq.h     |  101 +++
 include/hw/xen/interface/hvm/params.h    |   33 +
 include/hw/xen/interface/io/blkif.h      |  712 +++++++++++++++
 include/hw/xen/interface/io/console.h    |   46 +
 include/hw/xen/interface/io/fbif.h       |  156 ++++
 include/hw/xen/interface/io/kbdif.h      |  566 ++++++++++++
 include/hw/xen/interface/io/netif.h      | 1010 ++++++++++++++++++++++
 include/hw/xen/interface/io/protocols.h  |   42 +
 include/hw/xen/{ => interface}/io/ring.h |    0
 include/hw/xen/interface/io/usbif.h      |  254 ++++++
 include/hw/xen/interface/io/xenbus.h     |   70 ++
 include/hw/xen/xen_common.h              |    2 +-
 23 files changed, 3076 insertions(+), 24 deletions(-)
 create mode 100644 include/hw/xen/interface/grant_table.h
 create mode 100644 include/hw/xen/interface/hvm/e820.h
 create mode 100644 include/hw/xen/interface/hvm/ioreq.h
 create mode 100644 include/hw/xen/interface/hvm/params.h
 create mode 100644 include/hw/xen/interface/io/blkif.h
 create mode 100644 include/hw/xen/interface/io/console.h
 create mode 100644 include/hw/xen/interface/io/fbif.h
 create mode 100644 include/hw/xen/interface/io/kbdif.h
 create mode 100644 include/hw/xen/interface/io/netif.h
 create mode 100644 include/hw/xen/interface/io/protocols.h
 rename include/hw/xen/{ => interface}/io/ring.h (100%)
 create mode 100644 include/hw/xen/interface/io/usbif.h
 create mode 100644 include/hw/xen/interface/io/xenbus.h

-- 
Anthony PERARD


