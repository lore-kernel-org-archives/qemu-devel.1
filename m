Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D05C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 05:35:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C38F2078A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 05:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="neJN/YKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C38F2078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRqUS-0007R7-C8
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 01:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kRqTG-0005vB-0T; Mon, 12 Oct 2020 01:34:06 -0400
Received: from ozlabs.org ([203.11.71.1]:46897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kRqTD-0001rB-77; Mon, 12 Oct 2020 01:34:05 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C8nR918V1z9sT6; Mon, 12 Oct 2020 16:33:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602480837;
 bh=7npcZXfxoQiFV9CiabMxq6WUU2nIGOBoSxVOtkTlxLg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=neJN/YKroZBIdGm+CNE1Jpkh6F7FPvoN8niyQ/+TUGThBuegLfCVsOHw2rG+L3fa4
 lglIQKCzot6O3mPluGWFjpFYk1Uj/UtKmYFT4rN+nrpbEm4bhYsKAqYVK6Xxj48HYY
 28YNZU7D6pEduWaHscvUiURGFRcvA6SK6s3aTOYE=
Date: Mon, 12 Oct 2020 16:30:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Elena Afanasova <eafanasova@gmail.com>
Subject: Re: [PATCH] hw/net: move allocation to the heap due to very large
 stack frame
Message-ID: <20201012053001.GD4787@yekko.fritz.box>
References: <8f07132478469b35fb50a4706691e2b56b10a67b.camel@gmail.com>
 <20201010060745.GK1025389@yekko.fritz.box>
 <f505c80b88ee665a62883a69bed9d614f6ba2a66.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <f505c80b88ee665a62883a69bed9d614f6ba2a66.camel@gmail.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 01:33:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, jasowang@redhat.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2020 at 08:53:00AM -0700, Elena Afanasova wrote:
> On Sat, 2020-10-10 at 17:07 +1100, David Gibson wrote:
> > On Fri, Oct 09, 2020 at 07:02:56AM -0700, Elena Afanasova wrote:
> > > > From 09905773a00e417d3a37c12350d9e55466fdce8a Mon Sep 17 00:00:00
> > > > 2001
> > > From: Elena Afanasova <eafanasova@gmail.com>
> > > Date: Fri, 9 Oct 2020 06:41:36 -0700
> > > Subject: [PATCH] hw/net: move allocation to the heap due to very
> > > large stack
> > >  frame
> >=20
> > Patch looks fine, but some more details of the motivation would be
> > nice.  I wouldn't have thought that the size of a network packet
> > counted as a "very large" stack frame by userspace standards.
> >=20
>=20
> gcc with wstack-usage warns that stack frame size may be ~65Kbytes

AFAICT, -Wstack-usage takes a parameter giving what size it will
complain about.  What was that value, and what was the rationale for
choosing it?

>=20
> > > Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
> > > ---
> > >  hw/net/spapr_llan.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
> > > index 2093f1bad0..581320a0e7 100644
> > > --- a/hw/net/spapr_llan.c
> > > +++ b/hw/net/spapr_llan.c
> > > @@ -688,7 +688,8 @@ static target_ulong
> > > h_send_logical_lan(PowerPCCPU *cpu,
> > >      SpaprVioDevice *sdev =3D spapr_vio_find_by_reg(spapr->vio_bus,
> > > reg);
> > >      SpaprVioVlan *dev =3D VIO_SPAPR_VLAN_DEVICE(sdev);
> > >      unsigned total_len;
> > > -    uint8_t *lbuf, *p;
> > > +    uint8_t *p;
> > > +    g_autofree uint8_t *lbuf =3D NULL;
> > >      int i, nbufs;
> > >      int ret;
> > > =20
> > > @@ -729,7 +730,7 @@ static target_ulong
> > > h_send_logical_lan(PowerPCCPU *cpu,
> > >          return H_RESOURCE;
> > >      }
> > > =20
> > > -    lbuf =3D alloca(total_len);
> > > +    lbuf =3D g_malloc(total_len);
> > >      p =3D lbuf;
> > >      for (i =3D 0; i < nbufs; i++) {
> > >          ret =3D spapr_vio_dma_read(sdev, VLAN_BD_ADDR(bufs[i]),
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+D6dgACgkQbDjKyiDZ
s5J3Pw//aUEWNttjBHkVuGKgPBmSuetBuLULUQZOMkoiwXYkM8KCaQ0VZPao/Iy5
WIuaJd3EnWShLlyYFKnLFkiezprXYfGXKdbNlJwonQkqW23Wkdrl40LeAf7eJJzA
ihEFVAbnYXG9AL8F89cfXBxl+/NPe4tPtELCyUcxDmc68CYhhkMB+4M55zeVz9+A
/BXb8qk9IkrUo02nlD6MuQuCvLJkFqW+zSTbtx978rncH61l8ToaWELKAO4KBgJv
t9ylZhAS+H1nKmcfshsQkFekKxUGbnBV2MrSdJYD6Hcnl8sW8mqORnYAB5dgTj93
rKFneJyp7kueGayUjPraCJqPlElJYrQ17ISw1is4oPMbdin4IWp8fIM1opyPMNmU
uH62iIQ7f9k7g2kiN6KUGUwr37BqsIkIcKHuB0yZEVrij7xdYkm/L4cM8PyK1zdD
LL4DGlPYba9bnNX0HGScwiuTqFMNduFxPpeW7nuAKc+zp3rbrZZDmeh5XrShN983
geT0qn/VWA/UWLcLg9i2q2zJPe9Y7s6Yd4kcU23rPx7jzHT1uY2mJ1y7N0KH8KBS
d3eO91FrR5Sz7fTa4AwsOzv+PHY4ztUYqSjSV7fCQ3LXW85MQRG5FvZrtJnWFZ0L
N9q2h3RWQxYniSVCrZ9P2z+r9+W64tDSioasrfErllX5+DPHxCI=
=0Jkj
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--

