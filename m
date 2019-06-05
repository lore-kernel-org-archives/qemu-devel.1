Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BD7C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 10:14:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F566206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 10:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F566206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38611 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYSwZ-0003NF-Dw
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 06:14:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Paul.Durrant@citrix.com>) id 1hYStx-0001yU-Ly
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 06:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Paul.Durrant@citrix.com>) id 1hYStw-0001y3-0F
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 06:12:13 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:37925)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
	id 1hYStv-0001s3-K6
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 06:12:11 -0400
Authentication-Results: esa1.hc3370-68.iphmx.com;
	dkim=none (message not signed) header.i=none;
	spf=None smtp.pra=Paul.Durrant@citrix.com;
	spf=Pass smtp.mailfrom=Paul.Durrant@citrix.com;
	spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
	authenticity information available from domain of
	Paul.Durrant@citrix.com) identity=pra;
	client-ip=23.29.105.83; receiver=esa1.hc3370-68.iphmx.com;
	envelope-from="Paul.Durrant@citrix.com";
	x-sender="Paul.Durrant@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
	Paul.Durrant@citrix.com designates 23.29.105.83 as permitted
	sender) identity=mailfrom; client-ip=23.29.105.83;
	receiver=esa1.hc3370-68.iphmx.com;
	envelope-from="Paul.Durrant@citrix.com";
	x-sender="Paul.Durrant@citrix.com";
	x-conformance=sidf_compatible; x-record-type="v=spf1";
	x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
	ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
	ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
	ip4:216.52.6.188 ip4:23.29.105.83 ip4:162.221.156.50 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
	authenticity information available from domain of
	postmaster@mail.citrix.com) identity=helo;
	client-ip=23.29.105.83; receiver=esa1.hc3370-68.iphmx.com;
	envelope-from="Paul.Durrant@citrix.com";
	x-sender="postmaster@mail.citrix.com";
	x-conformance=sidf_compatible
IronPort-SDR: SphveqOlyDw7dAsviMSOsn5WTijLDIS4d9YKw/7s1p223ETKhVS9Opu55ffCK0dDFmPMWkrNKr
	BoZJlTF9EVsCEy5Nb+3aCWOrXiYR50Q1v/9N0eiBWa6xftS9elrj7eZIqPCLdThDRZMF0IuCeD
	TquBAePixV6LsFpPcOOqtORopPXEt/X09jgznqCZsq3T5JhwHOJYxhpAkfgDtYiV2aNnq/etF0
	3tq9AjOwKGnzAdK/903dGmTuC6w+DYDkjq99cNkQy5/BFD1UXd7NaO0CQGPuGsmrVe0hWhHBJI
	Wi8=
X-SBRS: 2.7
X-MesageID: 1345887
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 23.29.105.83
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.60,550,1549947600"; 
   d="scan'208";a="1345887"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: 'Greg Kurz' <groug@kaod.org>, Anthony Perard <anthony.perard@citrix.com>
Thread-Topic: [PATCH] MAINTAINERS: Change maintership of Xen code under hw/9pfs
Thread-Index: AQHVFgjCsFUKb4oZKkW/4LQE3FHhuqaB7xcAgArRPgCAACGlQA==
Date: Wed, 5 Jun 2019 10:12:05 +0000
Message-ID: <c85d973ca2d444678e8fdc86a4cd6f4f@AMSPEX02CL03.citrite.net>
References: <155912548463.2019004.3515830305299809902.stgit@bahia.lan>
	<20190529125926.GD2126@perard.uk.xensource.com>
	<20190605121056.0e784daf@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190605121056.0e784daf@bahia.lab.toulouse-stg.fr.ibm.com>
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
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Change maintership of Xen
 code under hw/9pfs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Greg Kurz [mailto:groug@kaod.org]
> Sent: 05 June 2019 11:11
> To: Anthony Perard <anthony.perard@citrix.com>
> Cc: qemu-devel@nongnu.org; Stefano Stabellini <sstabellini@kernel.org>; P=
aul Durrant
> <Paul.Durrant@citrix.com>
> Subject: Re: [PATCH] MAINTAINERS: Change maintership of Xen code under hw=
/9pfs
>=20
> On Wed, 29 May 2019 13:59:26 +0100
> Anthony PERARD <anthony.perard@citrix.com> wrote:
>=20
> > On Wed, May 29, 2019 at 12:24:44PM +0200, Greg Kurz wrote:
> > > Xen folks are the actual maintainers for this.
> > >
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  MAINTAINERS |    3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 1f5f8b7a2c37..d00380641796 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -411,7 +411,7 @@ M: Paul Durrant <paul.durrant@citrix.com>
> > >  L: xen-devel@lists.xenproject.org
> > >  S: Supported
> > >  F: */xen*
> > > -F: hw/9pfs/xen-9p-backend.c
> > > +F: hw/9pfs/xen-9p*
> > >  F: hw/char/xen_console.c
> > >  F: hw/display/xenfb.c
> > >  F: hw/net/xen_nic.c
> > > @@ -1505,6 +1505,7 @@ virtio-9p
> > >  M: Greg Kurz <groug@kaod.org>
> > >  S: Supported
> > >  F: hw/9pfs/
> > > +X: hw/9pfs/xen-9p*
> > >  F: fsdev/
> > >  F: tests/virtio-9p-test.c
> > >  T: git https://github.com/gkurz/qemu.git 9p-next
> > >
> >
> > Acked-by: Anthony PERARD <anthony.perard@citrix.com>
> >
> > Thanks,
> >
>=20
> Ping ?
>=20
> I'd rather also get an ack from Stefano and Paul before merging this.
>=20

Fine by me...

Acked-by: Paul Durrant <paul.durrant@citrix.com>

> Cheers,
>=20
> --
> Greg

