Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA1DC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 08:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A818207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 08:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="cdarcDn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A818207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8gtJ-0007e0-Os
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 04:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i8gpj-0004EW-69
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 04:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i8gpi-0001xX-75
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 04:21:35 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:18028)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1i8gph-0001we-W6
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 04:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1568362895;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nU2LqeTcJ4UGTGpUsVAbgU+gAMnxLoUeRzHwo3ggLDk=;
 b=cdarcDn5vHSTATkiw+v2uUWbZBoAwXf2UaLKOrQfrDdBM+hSygHxWfAG
 1iONuQAGF2OuIAuJ9RhTSS7QZsVJzdCzMbU0+zERT8L/+EXX0zpMGOvOd
 qQC3FvMfo38Ro9tso+VE8az3Wqfa4mRki4Eih5RD9icle7FGDFIMhNpNc Q=;
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=Paul.Durrant@citrix.com;
 spf=Pass smtp.mailfrom=Paul.Durrant@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 Paul.Durrant@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com"; x-conformance=sidf_compatible
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
IronPort-SDR: AcGcbMfnmbSLmlxXiSBRbyl7Y7Zk9N9s3cPqg6q63avfWYjfqw3a26G49dkR5vMylGGqQZxbZo
 luT6xu/5Mj6irNti+L7jJREo5+Nh63uPACtubxQgzdwTVOUnsbStOt49vEoVKAx/4GFQ2yJgBg
 G6nunRjik+QE3YrrTMuAt9KB7jmTbq/aiBHONUwJfID6x5UkAf23QY/oy3wPJN3biMwUlJKxAa
 xavTdUVJ6xYHfh4t6NqRhPxAgtXGbFEq8K9MJ1tcAKDjAl2H9El5Gex+aycaUBtUThUuMOmaFH
 HwI=
X-SBRS: 2.7
X-MesageID: 5578861
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,500,1559534400"; 
   d="scan'208";a="5578861"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: Paul Durrant <Paul.Durrant@citrix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "xen-devrel@lists.xenproject.org"
 <xen-devrel@lists.xenproject.org>
Thread-Topic: [PATCH v3 0/3] xen: fix a potential crash in xen-bus
Thread-Index: AQHVagwla5OQLj6TZEGuThfiSwmwMacpREgw
Date: Fri, 13 Sep 2019 08:21:29 +0000
Message-ID: <cbf72f9bc5bd47f9b98e2b8e72673b28@AMSPEX02CL03.citrite.net>
References: <20190913082043.31288-1-paul.durrant@citrix.com>
In-Reply-To: <20190913082043.31288-1-paul.durrant@citrix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.142
Subject: Re: [Qemu-devel] [PATCH v3 0/3] xen: fix a potential crash in
 xen-bus
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
 Stefano Stabellini <sstabellini@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I typo-ed 'xen-devel'. I'll re-send.

  Paul

> -----Original Message-----
> From: Paul Durrant <paul.durrant@citrix.com>
> Sent: 13 September 2019 09:21
> To: qemu-devel@nongnu.org; xen-devrel@lists.xenproject.org
> Cc: Paul Durrant <Paul.Durrant@citrix.com>; Anthony Perard <anthony.perar=
d@citrix.com>; Stefano
> Stabellini <sstabellini@kernel.org>
> Subject: [PATCH v3 0/3] xen: fix a potential crash in xen-bus
>=20
> This series fixes a potential segfault caused by NotifierList corruption
> in xen-bus. The first two patches lay the groundwork and the third
> actually fixes the problem.
>=20
> Paul Durrant (3):
>   xen / notify: introduce a new XenWatchList abstraction
>   xen: introduce separate XenWatchList for XenDevice objects
>   xen: perform XenDevice clean-up in XenBus watch handler
>=20
>  hw/xen/trace-events      |   9 +-
>  hw/xen/xen-bus.c         | 277 ++++++++++++++++++++++++++++-----------
>  include/hw/xen/xen-bus.h |   8 +-
>  include/qemu/notify.h    |   2 +
>  util/notify.c            |   5 +
>  5 files changed, 220 insertions(+), 81 deletions(-)
> ---
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> --
> 2.20.1.2.gb21ebb6


