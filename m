Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AB6C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 07:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E98AB20B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 07:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98AB20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54550 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd8zN-0002N0-J2
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 03:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60756)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Paul.Durrant@citrix.com>) id 1hd8yK-0001pj-T5
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1hd8yI-0004mn-J4
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:56:04 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:39414)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1hd8yI-0004fD-5E
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:56:02 -0400
Authentication-Results: esa2.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=Paul.Durrant@citrix.com;
 spf=Pass smtp.mailfrom=Paul.Durrant@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 Paul.Durrant@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
 Paul.Durrant@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: g4xjIFtYDzVxljSqTv+EBv8/0unWDY7zahXCDuQvH6lAnfu0ouwIPaClIsGSx0GrhMoF5s2Qhc
 Q7cmH22F7STIpcqgJayZ8m0UGExgVD/HddT7tcMhK3f33uEcZjZ9kfyTb51xEoZqHCaqMoQmUL
 +7VsN3ZELke0hAdbE1O5ikfOKkVzo6eoxVq1+mkH/Afw2DIximZmbRIFcgooTzfcKXcJl8K0An
 4HKoBe8X/zifb9P6PEnXJQVs+nSa+CoDTTQ8jeX4z3jgh2sRvGqQ94bR6xqhBz2sV81qr9QfRO
 9XY=
X-SBRS: 2.7
X-MesageID: 1863943
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,388,1557201600"; 
   d="scan'208";a="1863943"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: Anthony Perard <anthony.perard@citrix.com>
Thread-Topic: [Xen-devel] [PATCH 3/4] xen: Import Xen public headers used by
 xen-hvm.c
Thread-Index: AQHVJSMVksnbyKoRC0SnNZiHFchLQ6agBEVg///oIwCAAAlbgIABFQIw
Date: Tue, 18 Jun 2019 07:55:53 +0000
Message-ID: <17fc272d31cc4e95baa3ec68a90557d1@AMSPEX02CL03.citrite.net>
References: <20190617154105.32323-1-anthony.perard@citrix.com>
 <20190617154105.32323-4-anthony.perard@citrix.com>
 <21258fd1788f418bb1a0007a43bf0250@AMSPEX02CL03.citrite.net>
 <20190617164544.GA13449@perard.uk.xensource.com>
 <20190617171913.GA15926@perard.uk.xensource.com>
In-Reply-To: <20190617171913.GA15926@perard.uk.xensource.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.153
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH 3/4] xen: Import Xen public
 headers used by xen-hvm.c
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
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 17 June 2019 18:19
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: xen-devel@lists.xenproject.org; Stefano Stabellini <sstabellini@kerne=
l.org>; qemu-devel@nongnu.org
> Subject: Re: [Xen-devel] [PATCH 3/4] xen: Import Xen public headers used =
by xen-hvm.c
>=20
> On Mon, Jun 17, 2019 at 05:45:44PM +0100, Anthony PERARD wrote:
> > On Mon, Jun 17, 2019 at 05:15:51PM +0100, Paul Durrant wrote:
> > > AFAICT the only place (apart from legacy code in xen_common.h) that
> > > params.h is necessary is in xen_suspend_notifier(). I wonder whether
> > > that would be better moved into xen_common.h too (since it's just a
> > > wrapper round xc_set_hvm_param() and then the inclusion of params.h
> > > can be moved there as well.
> >
> > :(, I didn't realised that xen_common.h needed params.h too. That patch
> > series might not build on older version of Xen. I'll move the inclusion
> > of params.h to xen_common.h, and fix params.h to have all the needed
> > #defines.
>=20
> Actually, it works fine without including hvm/params.h in xen_common.h
> because xen_common.h includes xenctrl.h which includes hvm/params.h.
>=20
> So I think instead I'll remove all includes of params.h, because
> HVM_PARAM_* are parameters for xc_hvm_param_{get,set}, which is in a
> library and not an interface with a guest. Including xenctrl.h should be
> enough.

The guest/tools separation is messy. ioreq.h is also an interface with Xen =
and not with a guest, so really I think it should be treated the same way a=
s params.h. e820.h is referring to guest memory layout, which IMO shouldn't=
 really be hardcoded at all.

  Paul

>=20
> --
> Anthony PERARD

