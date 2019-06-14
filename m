Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9833AC31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 08:20:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6436020866
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 08:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6436020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49212 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbhRg-0006CX-NF
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 04:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52279)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Paul.Durrant@citrix.com>) id 1hbhQQ-00055l-Ii
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1hbhQJ-0002FB-S8
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:19:02 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:15538)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1hbhQF-0002Bi-QU
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:18:56 -0400
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
IronPort-SDR: cpKxG7AL2RjJXDLUJNozppCawp7/tx/HKBjsJ0VSAtSGhvWgY3Sc/lxbTvdLRp4nmNKQa3VI99
 w8uSDehkwU4LwSuQaRyGrdqoumk9SkgAEsxOQd23cRja6Otb5prNNeU55WVw/tWfVxlpjyi/6a
 vibeEvhm74R5QxWjkLHcbS01rto3gRy4rcL1ewzlFxOfyUocfNBhJPl7dgmSqig+9QbKrEBn+R
 irA4dEFsf/NwCvDEvJ7KF5qdg/9ngzNxyPDDgC3IEwUz29d+gqFi0Cv0ERRIfilelNLSh2VJ/u
 G+Y=
X-SBRS: 2.7
X-MesageID: 1731507
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,372,1557201600"; 
   d="scan'208";a="1731507"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: 'Greg Kurz' <groug@kaod.org>
Thread-Topic: [PATCH] MAINTAINERS: Change maintership of Xen code under hw/9pfs
Thread-Index: AQHVFgjCsFUKb4oZKkW/4LQE3FHhuqaB7xcAgArRPgCAACGlQIAN41OAgAAh38A=
Date: Fri, 14 Jun 2019 08:18:47 +0000
Message-ID: <c2c63dd46c684b1bb0f2e342a085d93d@AMSPEX02CL03.citrite.net>
References: <155912548463.2019004.3515830305299809902.stgit@bahia.lan>
 <20190529125926.GD2126@perard.uk.xensource.com>
 <20190605121056.0e784daf@bahia.lab.toulouse-stg.fr.ibm.com>
 <c85d973ca2d444678e8fdc86a4cd6f4f@AMSPEX02CL03.citrite.net>
 <20190614101621.098742e2@bahia.lan>
In-Reply-To: <20190614101621.098742e2@bahia.lan>
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
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Change maintership of Xen
 code under hw/9pfs
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
 Stefano Stabellini <sstabellini@kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Greg Kurz [mailto:groug@kaod.org]
> Sent: 14 June 2019 09:16
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: Anthony Perard <anthony.perard@citrix.com>; qemu-devel@nongnu.org; St=
efano Stabellini
> <sstabellini@kernel.org>
> Subject: Re: [PATCH] MAINTAINERS: Change maintership of Xen code under hw=
/9pfs
>=20
> On Wed, 5 Jun 2019 10:12:05 +0000
> Paul Durrant <Paul.Durrant@citrix.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Greg Kurz [mailto:groug@kaod.org]
> > > Sent: 05 June 2019 11:11
> > > To: Anthony Perard <anthony.perard@citrix.com>
> > > Cc: qemu-devel@nongnu.org; Stefano Stabellini <sstabellini@kernel.org=
>; Paul Durrant
> > > <Paul.Durrant@citrix.com>
> > > Subject: Re: [PATCH] MAINTAINERS: Change maintership of Xen code unde=
r hw/9pfs
> > >
> > > On Wed, 29 May 2019 13:59:26 +0100
> > > Anthony PERARD <anthony.perard@citrix.com> wrote:
> > >
> > > > On Wed, May 29, 2019 at 12:24:44PM +0200, Greg Kurz wrote:
> > > > > Xen folks are the actual maintainers for this.
> > > > >
> > > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > > ---
> > > > >  MAINTAINERS |    3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index 1f5f8b7a2c37..d00380641796 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -411,7 +411,7 @@ M: Paul Durrant <paul.durrant@citrix.com>
> > > > >  L: xen-devel@lists.xenproject.org
> > > > >  S: Supported
> > > > >  F: */xen*
> > > > > -F: hw/9pfs/xen-9p-backend.c
> > > > > +F: hw/9pfs/xen-9p*
> > > > >  F: hw/char/xen_console.c
> > > > >  F: hw/display/xenfb.c
> > > > >  F: hw/net/xen_nic.c
> > > > > @@ -1505,6 +1505,7 @@ virtio-9p
> > > > >  M: Greg Kurz <groug@kaod.org>
> > > > >  S: Supported
> > > > >  F: hw/9pfs/
> > > > > +X: hw/9pfs/xen-9p*
> > > > >  F: fsdev/
> > > > >  F: tests/virtio-9p-test.c
> > > > >  T: git https://github.com/gkurz/qemu.git 9p-next
> > > > >
> > > >
> > > > Acked-by: Anthony PERARD <anthony.perard@citrix.com>
> > > >
> > > > Thanks,
> > > >
> > >
> > > Ping ?
> > >
> > > I'd rather also get an ack from Stefano and Paul before merging this.
> > >
> >
> > Fine by me...
> >
> > Acked-by: Paul Durrant <paul.durrant@citrix.com>
> >
>=20
> Hi,
>=20
> I'd prefer to also get an ack from Stefano but it seems that he hasn't po=
sted
> anything to qemu-devel@ since last January... Any suggestion how I should=
 go
> forward with this ?
>=20

Yes, I think it would be prudent to get an ack from Stefano. I'll ping him =
on IRC and see if I can get a response.

  Cheers,

    Paul

> Cheers,
>=20
> --
> Greg
>=20
> > > Cheers,
> > >
> > > --
> > > Greg


