Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1734C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 06:33:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E9A52238C
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 06:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZLuNsWbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9A52238C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpoMn-0000HA-Ir
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 02:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56001)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hpoMc-0008K7-4S
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 02:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hpoMa-0003LP-Hs
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 02:33:29 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41881 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hpoMZ-0003Et-1G; Tue, 23 Jul 2019 02:33:28 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45t7w30TyPz9sBt; Tue, 23 Jul 2019 16:33:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563863603;
 bh=1mIWOXVPwaz3rfHeXEyyTfqN3kvKOPcZVZfW7eNMT8U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZLuNsWbW3Bj2Gdf+cIu+6AOlXpS2A8pyLMadi9uR7jYo4l8RwGLYwt7WYHn6Pvgw8
 razCiyXxKYJCRz0v7XhiOyYuB+nwRhW1pr3Ihzm+sr4/c7UNsy9tw1G7/3DJuL4PzP
 8jfQaCBD8WN3p/uUwSZf6ksTMeDK8Z56S7s+Eal4=
Date: Tue, 23 Jul 2019 16:14:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190723061443.GS25073@umbus.fritz.box>
References: <20190720012850.14369-1-aik@ozlabs.ru>
 <20190720012850.14369-4-aik@ozlabs.ru>
 <20190723035330.GQ25073@umbus.fritz.box>
 <181b65ae-866f-7e0b-1042-7695e7c2ddda@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ABd7dauUP597Mpr3"
Content-Disposition: inline
In-Reply-To: <181b65ae-866f-7e0b-1042-7695e7c2ddda@ozlabs.ru>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH qemu RFC 3/4] spapr: Advertise H_RTAS to
 the guest
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
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ABd7dauUP597Mpr3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2019 at 03:48:34PM +1000, Alexey Kardashevskiy wrote:
>=20
>=20
> On 23/07/2019 13:53, David Gibson wrote:
> > On Sat, Jul 20, 2019 at 11:28:49AM +1000, Alexey Kardashevskiy wrote:
> > > Since day 1 QEMU implemented RTAS as a custom hypercall wrapped into
> > > a small 20 bytes blob which guest would call to enter RTAS. Although
> > > it works fine, it is still a separate binary image which requires sig=
ning
> > > at no additional benefit.
> > >=20
> > > This adds a flag into /chosen to tell a modified guest that if the fl=
ag
> > > is there, it can call H_RTAS directly and avoid calling into the RTAS
> > > blob.
> > >=20
> > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > ---
> > >   hw/ppc/spapr.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 81ad6a6f28de..b097a99951f1 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -1230,6 +1230,9 @@ static void spapr_dt_chosen(SpaprMachineState *=
spapr, void *fdt)
> > >           _FDT(fdt_setprop_cell(fdt, chosen, "linux,pci-probe-only", =
0));
> > >       }
> > > +    /* We always implemented RTAS as hcall, tell guests to call it d=
irectly */
> > > +    _FDT(fdt_setprop_cell(fdt, chosen, "qemu,h_rtas", 1));
> >=20
> > Rather than creating a new property for this we could use the
> > qemu,hypertas-functions property which is already used to advertise
> > some KVM specific hcalls.
>=20
> True, this is another way of doing it. We will also need a proper number =
for
> it rather that custom 0xf000,

So, I take from this you're considering making this a supported method
of operation, maybe even incorporating it into PAPR?

> Paul suggested we could tell the guest this
> number via the "qemu,h_rtas" property.

Hm, we could, but introducing dynamic hypercall numbers for this seems
an odd thing to do; both PAPR standardized and qemu specific
hypercalls we currently operate on the guest just knowing the numbers.

It seems to me that the obvious way to handle this is to have a tag in
qemu,hypertas-functions which indicates the presence of the existing
0xf00 H_RTAS.  If/when we have a PAPR (or pseudo-PAPR) standardized
number, that would get a tag in ibm,hypertas-functions to advertise
it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ABd7dauUP597Mpr3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl02pdAACgkQbDjKyiDZ
s5LnChAAtnXE41jd0AM7TZNW4uu6kBWacSc07h/hgyTe4iTQK2trvwqZVfQbdFg/
yPyevfzdxtPUVx9JmkjaDo+UCXaZ+voirTaxO4FIhPR1vVEYkOGi7jOtEUuX/OUn
z+Ll/CCS3dQmdqzOKH1q/txwOQIiv//aj11dOCtX/IDkuWgd4NX34gd7LVMls37n
M+QmdNDxocqV0tngCQKJMt7o/8FngbKtTJJ51EIPb6WB3FEHA7N4Yx9TNlzvSTXY
wdGf/5W038dDozLGCbSUjn6joHDZEZuWpPoAXfg2GT2p2oP6tU1hki3K4VJHELFr
W2x2RizhZnO2RNnXmAexYe9eRwQ62i7fHtLvcau1/fwHxOcFBYTrfFNa2MFaPWrs
BTA7PVwWGF4/ZCdDTmefJsEDJQE7RcK15TDWhPF32Eim9xnOkUlxjMgHgmnPBqey
dRhyvcNBhnWBJsIjsfP2Yg6G5ehAaSDUQZ2AStky5zLHtVUZZYSLYNruLtXCpTLh
K8Gx8H1AQpLWqvmGgVdfT0WJGhsYu3j2e3yv+CoJZzenTJN+QOBHR2FQd4/naraS
0q60q6uo3SGTk0KhJcmtHxbtzXBlfZpbm+UruFE0u/9c3YvoGIUXY3Gez8UGYnX5
iuDtNiT+wgiAEwDd9+9fZxauVTEfNmIg8rzoeOXE59iJfzKvBhg=
=oX5m
-----END PGP SIGNATURE-----

--ABd7dauUP597Mpr3--

