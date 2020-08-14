Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C622C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 04:02:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A6220715
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 04:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="QNdhp10t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A6220715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6QvL-0003XC-C0
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 00:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6Qtj-0002IU-2I; Fri, 14 Aug 2020 00:00:55 -0400
Received: from ozlabs.org ([203.11.71.1]:34997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k6Qte-0001Q5-G1; Fri, 14 Aug 2020 00:00:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BSV8m6lcyz9sR4; Fri, 14 Aug 2020 14:00:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597377640;
 bh=zXIfcgBzxOpRrD+l0claEEOPK4TesCg69zKtJEnPVXs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QNdhp10tH8pC015HEjf+6j3mD0V4qEkvE+6ikF4DME7/WIq5pkllE2Rq3oD1Z1siC
 84MS5eGTEq2bfh2mKXOPxrpu2bykNHF/H11EHZw3WYt4g1bWegY3OnHmFuCoVUjnyM
 TgF373EUvYMR2VbZ6gq9GrLvvh/8/8H4qf+Nl510=
Date: Fri, 14 Aug 2020 13:36:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Gustavo Romero <gromero@linux.vnet.ibm.com>
Subject: Re: [PATCH] spapr/xive: Use xive_source_esb_len()
Message-ID: <20200814033617.GD12805@yekko.fritz.box>
References: <159733969034.320580.6571451425779179477.stgit@bahia.lan>
 <b5cfd02b-abf7-8d03-7ae2-1f483bf7b0bc@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rqzD5py0kzyFAOWN"
Content-Disposition: inline
In-Reply-To: <b5cfd02b-abf7-8d03-7ae2-1f483bf7b0bc@linux.vnet.ibm.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 00:00:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2020 at 05:38:59PM -0300, Gustavo Romero wrote:
> Hi Greg,
>=20
> On 8/13/20 2:28 PM, Greg Kurz wrote:
> > static inline size_t xive_source_esb_len(XiveSource *xsrc)
> > {
> >      return (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
> > }
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > Follow-up on "ppc/xive: Rework setup of XiveSource::esb_mmio"
> > http://patchwork.ozlabs.org/project/qemu-devel/patch/159679992680.87629=
4.7520540158586170894.stgit@bahia.lan/
> > ---
> >   hw/intc/spapr_xive.c     |    2 +-
> >   hw/intc/spapr_xive_kvm.c |    2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> > index 3c84f64dc464..4bd0d606ba17 100644
> > --- a/hw/intc/spapr_xive.c
> > +++ b/hw/intc/spapr_xive.c
> > @@ -336,7 +336,7 @@ static void spapr_xive_realize(DeviceState *dev, Er=
ror **errp)
> >       sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
> >       /* Set the mapping address of the END ESB pages after the source =
ESBs */
> > -    xive->end_base =3D xive->vc_base + (1ull << xsrc->esb_shift) * xsr=
c->nr_irqs;
> > +    xive->end_base =3D xive->vc_base + xive_source_esb_len(xsrc);
> >       /*
> >        * Allocate the routing tables
> > diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> > index 82a6f99f022d..3263b982239a 100644
> > --- a/hw/intc/spapr_xive_kvm.c
> > +++ b/hw/intc/spapr_xive_kvm.c
> > @@ -831,7 +831,7 @@ void kvmppc_xive_disconnect(SpaprInterruptControlle=
r *intc)
> >       /* Clear the KVM mapping */
> >       xsrc =3D &xive->source;
> > -    esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
> > +    esb_len =3D xive_source_esb_len(xsrc);
>=20
> hrm I'd like to not add another level of indirection here.
> In this specific case I think it's more clear to read just
>=20
> 1ull << xsrc->esb_shift) * xsrc->nr_irqs
>=20
> and get the idea of one IRQ per ESB page (or pair of pages,
> for trigger and management), than one having to look at
> what is inside "a box" called xive_source_esb_len().
>=20
> Wrapping it under another function doesn't help more when
> reading the code, XIVE is already tricky enough :)

Given that we're already using it in some places, I'd prefer to use it
in all the places that it's correct to do so.

Applied to ppc-for-5.2.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rqzD5py0kzyFAOWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl82BrAACgkQbDjKyiDZ
s5KRGRAApVJbfQrMcN7oPvZLkhA24Prk/d2y7OFTwXj86YmKdQ+dhiUo51S7ct36
ff5gTcwAZ4uPr1xkFsWCycPyuSuFipbpHjAaHRpNqOrHdPARC8gPC1a3OAwJ8y+3
/kBsmPge1DQvbjX/WWxxnw62Q/22PvV1oj6jrav8O3cYswakzCyAoHvrI9Xs4Ipt
G2UGZKISIiHisBkzE9/43c1pZU76ZQUo1C6CXhkFGNzC+xGEs02A3KoyqOrhMouf
dC4BXI3SRFsnbVG1xyHKiaqSlNRQkakI/RBlcigNocdAg+cuBMnlWluZV8zuIl+o
5WmH/kFsaSLkK/f7u8CY9jX8pztzrhp0HcZoJqYr6KquBrhaOzJ5PRYfncMXJYKG
epthbP46yt5yvmdGfnUhJtsV/KuWDORSrhVP3oSOuGp0E+ysZoFPSa8QVj9alHY1
Lg2fPKJbUB4TlI2wrQ8D3O5NskzHvlZe8rOY8jDx4iNGYE+eix719oWXI+PWsCeS
6Ro+GvaI4EE1ORodpaLahd6PuR17tudp8Ir2gC/E7N3oypjM1Nm7yTUlDCjJBOvi
nmMA/tEoH8gY4o24UOJsc1xG0a8hBOTO0pOmbieetIPT9du6BmilL8Qx0mgLarrk
oxWRFJzcuEyKi94fld3OmgEZ+nSl9LMCruFvZ4csnx5hpW4HM/U=
=dc5p
-----END PGP SIGNATURE-----

--rqzD5py0kzyFAOWN--

