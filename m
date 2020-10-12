Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3D8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 05:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0B92078A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 05:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KoQs+INX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0B92078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRqUd-0007go-4C
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 01:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kRqTG-0005vK-G9; Mon, 12 Oct 2020 01:34:06 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:44499 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kRqTD-0001rG-TM; Mon, 12 Oct 2020 01:34:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C8nR909Xhz9sTf; Mon, 12 Oct 2020 16:33:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602480837;
 bh=fJRBR9H0OeieY2l5W9ufyUHl6YiO6fQeoecx66TpFoE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KoQs+INXHCNFr7HbHzilPWf2ivIt3R7SuQciVNZXaGPLQpJ9izP1P/Mt9D2hWb3x7
 6HsINRUff2/9G1zHqMUYIteRO9trAT++0T8hqhbRi19HD8fH+8URh1lQgKLcEGT5HR
 nx2Sg5isVVy6dT7j+/ygXqMqhzuHneBCaH705RfA=
Date: Mon, 12 Oct 2020 16:28:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PATCH] hw/net: move allocation to the heap due to very large
 stack frame
Message-ID: <20201012052836.GC4787@yekko.fritz.box>
References: <8f07132478469b35fb50a4706691e2b56b10a67b.camel@gmail.com>
 <20201010060745.GK1025389@yekko.fritz.box>
 <CAKXe6S+k7b0A_wB7uvthfn-jt3Q_jXxxGhg7uy=r6=uYZvvp3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <CAKXe6S+k7b0A_wB7uvthfn-jt3Q_jXxxGhg7uy=r6=uYZvvp3w@mail.gmail.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URI_DOTEDU=0.001 autolearn=no autolearn_force=no
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
Cc: Elena Afanasova <eafanasova@gmail.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2020 at 10:23:49AM +0800, Li Qiang wrote:
> David Gibson <david@gibson.dropbear.id.au> =E4=BA=8E2020=E5=B9=B410=E6=9C=
=8810=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=882:34=E5=86=99=E9=81=93=
=EF=BC=9A
> >
> > On Fri, Oct 09, 2020 at 07:02:56AM -0700, Elena Afanasova wrote:
> > > >From 09905773a00e417d3a37c12350d9e55466fdce8a Mon Sep 17 00:00:00 20=
01
> > > From: Elena Afanasova <eafanasova@gmail.com>
> > > Date: Fri, 9 Oct 2020 06:41:36 -0700
> > > Subject: [PATCH] hw/net: move allocation to the heap due to very larg=
e stack
> > >  frame
> >
> > Patch looks fine, but some more details of the motivation would be
> > nice.  I wouldn't have thought that the size of a network packet
> > counted as a "very large" stack frame by userspace standards.
> >
>=20
> It is also a best practice to avoid large stack allocation according.
> -->https://wiki.sei.cmu.edu/confluence/display/c/MEM05-C.+Avoid+large+sta=
ck+allocations

Hm, yeah, it's not really clear what "large" means in that context.
It mostly seems to be concerned with allocations controlled by an
external attacker, in which case we could be talking up to INT_MAX.
Even with jumbo frames the most we're talking here is ~64kiB.

>=20
> Though I don't see any issue here.
>=20
> Thanks,
> Li Qiang
>=20
> > > Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
> > > ---
> > >  hw/net/spapr_llan.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
> > > index 2093f1bad0..581320a0e7 100644
> > > --- a/hw/net/spapr_llan.c
> > > +++ b/hw/net/spapr_llan.c
> > > @@ -688,7 +688,8 @@ static target_ulong h_send_logical_lan(PowerPCCPU=
 *cpu,
> > >      SpaprVioDevice *sdev =3D spapr_vio_find_by_reg(spapr->vio_bus, r=
eg);
> > >      SpaprVioVlan *dev =3D VIO_SPAPR_VLAN_DEVICE(sdev);
> > >      unsigned total_len;
> > > -    uint8_t *lbuf, *p;
> > > +    uint8_t *p;
> > > +    g_autofree uint8_t *lbuf =3D NULL;
> > >      int i, nbufs;
> > >      int ret;
> > >
> > > @@ -729,7 +730,7 @@ static target_ulong h_send_logical_lan(PowerPCCPU=
 *cpu,
> > >          return H_RESOURCE;
> > >      }
> > >
> > > -    lbuf =3D alloca(total_len);
> > > +    lbuf =3D g_malloc(total_len);
> > >      p =3D lbuf;
> > >      for (i =3D 0; i < nbufs; i++) {
> > >          ret =3D spapr_vio_dma_read(sdev, VLAN_BD_ADDR(bufs[i]),
> >
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+D6YQACgkQbDjKyiDZ
s5JuhQ//XWXc96/u1+mCdVlZpo7A+icE/HGh5fqoObfUY5Otbl0OCtdqN1a3/a8r
JtkxGVreCoFkb4hGO1i3duv469bJMApALFb1RC26KCyLoUOa5yKfnyQdyYMP1Oux
vAoYTTvsORnIG6InNxuDRm3bd9kq/kkDg22JsAS3Gx4udF2sh7rPIVy+eni9dLOs
a5vDPXYcRPC29/Mhcntjnewht6/ncglq+oTwtC2qyiIzgnwRrU0f8XF4q0a8+o5B
84ewWLr8s2bjyFVnw9FjxzGqRLA9jCox9ZRES/Sb746CyI+36CtBLsVqy5USrp4B
w4Q1PciouSwVY6x1JHiT0QRUjdjIOOhSdsJsgWj+me9a7P991MhVgKdsM4KwrOvR
j6NQxqm2jSP8ukWcnVAWTveYAieqoFB4bNOG95uQkJToIpA75gnK6bYqz+EKPuZJ
cb+c9QOQUhoxJCirfbrky8d43ZJbxOwElZNmssQ/+3FYO8HkynYl3IZROyIFe2j4
ipSw5WYROJHOAAovGGaNmKnpqxsY01uKKVuE6oxZpn4UKjypVIvHiFYktZbD8lgs
4671AY5yQAysoPEC83pSGozDB+5fxwY/vTmkq3Xi/chl7REMAfGIDAc9XpB4VXVh
1NPNpB0mZSzvetQ1uR5wR39rWei7wYJQ7L/VzznIBruXV0SDNlo=
=Pr40
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--

