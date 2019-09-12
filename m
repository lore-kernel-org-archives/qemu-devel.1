Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F021C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:42:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B14E2075C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 11:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="etPE92ki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B14E2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8NUV-00057U-BU
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 07:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i8NTL-0004cU-DT
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1i8NTG-00007O-2Z
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:41:11 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:40872)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1i8NTF-00006D-QX
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 07:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1568288465;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oMDBHolEqeuxgWI1uGzW4fwEiGk2tgmxpUrQr3djO+0=;
 b=etPE92kiVTHlDUeM4dkxI1jpIF3A0WXJZTrcSl7H+67lmmJDjZXN4Ypv
 GRS5fiQPXvuvm6m6tSnIHvbjAZTNyofMWJW7nGwxvu0gMhuQBTeZpyTT/
 b4MDUQHFq2qEkrvQAXLaid3Diun2AWMuNnjt9yLmGUKZ9476xqIrBnFBK A=;
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=Paul.Durrant@citrix.com;
 spf=Pass smtp.mailfrom=Paul.Durrant@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 Paul.Durrant@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
 Paul.Durrant@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: 7UFeC0yvM8goqSqaKvtjr+WYt80HQ+XVv4FmDZnoPXzvtHswK4t/BV8pL7NNuWvIU93Rr7BJiU
 wlzr2cvJDnZ1z0nGE/xh9e11kWRgcJpn/OuDif210pbgJ55ZYj67rXYspX0sHve+mIbfsV6H6Q
 gbdAFOeID0sjoHlWoRkj5i8/Q0KhuG25rykgP+2bDrT2j/3AHSEZi6mj1iFlnTmF/p6wj8Udrd
 VIps+YIjYG7Rxg58xjnBa22zQUGPuJQslQNTKxHXrHPsrgcYQWdLsz/rxHvLyy/0WxzD4gOjQR
 30k=
X-SBRS: 2.7
X-MesageID: 5768288
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,495,1559534400"; 
   d="scan'208";a="5768288"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: Anthony Perard <anthony.perard@citrix.com>
Thread-Topic: [PATCH 1/3] xen / notify: introduce a new XenWatchList
 abstraction
Thread-Index: AQHVaK5IAeEfbYTL0UG7WFNcTuDh0Kcns3IAgAA49PA=
Date: Thu, 12 Sep 2019 11:40:54 +0000
Message-ID: <6af73152bb3e4028a4354a30006ad840@AMSPEX02CL03.citrite.net>
References: <20190911143618.23477-1-paul.durrant@citrix.com>
 <20190911143618.23477-2-paul.durrant@citrix.com>
 <20190912101640.GB1308@perard.uk.xensource.com>
In-Reply-To: <20190912101640.GB1308@perard.uk.xensource.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.144
Subject: Re: [Qemu-devel] [PATCH 1/3] xen / notify: introduce a new
 XenWatchList abstraction
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
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stefano
 Stabellini <sstabellini@kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Anthony PERARD <anthony.perard@citrix.com>
> Sent: 12 September 2019 11:17
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org; Stefano Stabel=
lini <sstabellini@kernel.org>
> Subject: Re: [PATCH 1/3] xen / notify: introduce a new XenWatchList abstr=
action
>=20
> On Wed, Sep 11, 2019 at 03:36:16PM +0100, Paul Durrant wrote:
> > Xenstore watch call-backs are already abstracted away from XenBus using
> > the XenWatch data structure but the associated NotifierList manipulatio=
n
> > and file handle registation is still open coded in various xen_bus_...(=
)
>                   ^ registration

Ok.

> > functions.
> > This patch creates a new XenWatchList data structure to allow these
> > interactions to be abstracted away from XenBus as well. This is in
> > preparation for a subsequent patch which will introduce separate watch =
lists
> > for XenBus and XenDevice objects.
> >
> > NOTE: This patch also introduces a new NotifierListEmpty() helper funct=
ion
>                                          ^ notifier_list_empty() ?
>=20

Oops, yes :-)

> >       for the purposes of adding an assertion that a XenWatchList is no=
t
> >       freed whilst its associated NotifierList is still occupied.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
>=20
> Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
>=20

Thanks,

  Paul

> --
> Anthony PERARD

