Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAB7C3F2C6
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 02:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE5792073B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 02:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OXhbL6pw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE5792073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9KDq-0007gN-SQ
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 21:57:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j9KCd-0006oe-DC
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 21:56:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j9KCX-0000tu-BD
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 21:56:06 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:49557)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j9KCW-0000bp-6Y; Tue, 03 Mar 2020 21:56:01 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48XJRC1JpMz9sSJ; Wed,  4 Mar 2020 13:55:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583290551;
 bh=kZCwuhYhg29cWynjHyHPJ7PEKmg88R0Fi26fq1/Afds=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OXhbL6pwHU6Eet4oFhbyZ7HTPTUVHoi+q0kuvMbS1h/4uN+07j0F20CqnuWbSzUmw
 dNbW9OfM4FAo69Vl2uSsoNakWk1rxj7xAjjLIUCiFHyilw5QXgNlfQXHeThb7uK8zm
 X3Vc48p8aO17//DBE+1WrKr+8iw8dAn+mGbQAVxw=
Date: Wed, 4 Mar 2020 12:25:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v7 17/17] spapr: Fold spapr_node0_size() into its only
 caller
Message-ID: <20200304012555.GH35885@umbus.fritz.box>
References: <20200303034351.333043-1-david@gibson.dropbear.id.au>
 <20200303034351.333043-18-david@gibson.dropbear.id.au>
 <20200303113012.26a79a30@bahia.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="poemUeGtc2GQvHuH"
Content-Disposition: inline
In-Reply-To: <20200303113012.26a79a30@bahia.home>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, farosas@linux.ibm.com,
 aik@ozlabs.ru, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org, clg@kaod.org,
 Igor Mammedov <imammedo@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--poemUeGtc2GQvHuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2020 at 11:32:49AM +0100, Greg Kurz wrote:
> On Tue,  3 Mar 2020 14:43:51 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > The Real Mode Area (RMA) needs to fit within the NUMA node owning memory
> > at address 0.  That's usually node 0, but can be a later one if there a=
re
> > some nodes which have no memory (only CPUs).
> >=20
> > This is currently handled by the spapr_node0_size() helper.  It has only
> > one caller, so there's not a lot of point splitting it out.  It's also
> > extremely easy to misread the code as clamping to the size of the small=
est
> > node rather than the first node with any memory.
> >=20
> > So, fold it into the caller, and add some commentary to make it a bit
> > clearer exactly what it's doing.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c | 37 +++++++++++++++++++++----------------
> >  1 file changed, 21 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 2eb0d8f70d..d674a9f48f 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -296,20 +296,6 @@ static void spapr_populate_pa_features(SpaprMachin=
eState *spapr,
> >      _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_=
size)));
> >  }
> > =20
> > -static hwaddr spapr_node0_size(MachineState *machine)
> > -{
> > -    if (machine->numa_state->num_nodes) {
> > -        int i;
> > -        for (i =3D 0; i < machine->numa_state->num_nodes; ++i) {
> > -            if (machine->numa_state->nodes[i].node_mem) {
> > -                return MIN(pow2floor(machine->numa_state->nodes[i].nod=
e_mem),
> > -                           machine->ram_size);
> > -            }
> > -        }
> > -    }
> > -    return machine->ram_size;
> > -}
> > -
> >  static void add_str(GString *s, const gchar *s1)
> >  {
> >      g_string_append_len(s, s1, strlen(s1) + 1);
> > @@ -2653,10 +2639,24 @@ static hwaddr spapr_rma_size(SpaprMachineState =
*spapr, Error **errp)
> >      MachineState *machine =3D MACHINE(spapr);
> >      SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> >      hwaddr rma_size =3D machine->ram_size;
> > -    hwaddr node0_size =3D spapr_node0_size(machine);
> > =20
> >      /* RMA has to fit in the first NUMA node */
> > -    rma_size =3D MIN(rma_size, node0_size);
> > +    if (machine->numa_state->num_nodes) {
> > +        /*
> > +         * It's possible for there to be some zero-memory nodes first
> > +         * in the list.  We need the RMA to fit inside the memory of
> > +         * the first node which actually has some memory.
> > +         */
> > +        int i;
> > +
> > +        for (i =3D 0; i < machine->numa_state->num_nodes; ++i) {
> > +            if (machine->numa_state->nodes[i].node_mem !=3D 0) {
> > +                rma_size =3D MIN(rma_size,
> > +                               machine->numa_state->nodes[i].node_mem);
> > +                break;
> > +            }
> > +        }
> > +    }
> > =20
> >      /*
> >       * VRMA access is via a special 1TiB SLB mapping, so the RMA can
> > @@ -2673,6 +2673,11 @@ static hwaddr spapr_rma_size(SpaprMachineState *=
spapr, Error **errp)
> >          rma_size =3D MIN(rma_size, smc->rma_limit);
> >      }
> > =20
> > +    /*
> > +     * RMA size must be a power of 2
> > +     */
> > +    rma_size =3D pow2floor(rma_size);
> > +
>=20
> I saw somewhere else that the reason behind this might be
> related to:
>=20
> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D6010818c30ce9c
>=20
> commit 6010818c30ce9c796b4e22fd261fc6fea1cecbfc
> Author: Alexey Kardashevskiy <aik@ozlabs.ru>
> Date:   Thu Jul 3 13:10:05 2014 +1000
>=20
>     spapr: Split memory nodes to power-of-two blocks
>=20
> Is this the reason ?

Quite likely.

> In any case, it would probably help to mention somewhere
> why the rounding is introduced by this patch.

Drat.  I meant to sort out your comment on the last spin better than
this, but got part way through and forgot what I was doing.

I'm going to merge everything except this last patch into ppc-for-5.0
now, and try to sort out this one a bit later.

>=20
> >      if (rma_size < MIN_RMA_SLOF) {
> >          error_setg(errp,
> >  "pSeries SLOF firmware requires >=3D %ldMiB guest RMA (Real Mode Area =
memory)",
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--poemUeGtc2GQvHuH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5fA6AACgkQbDjKyiDZ
s5KpeBAArFEJqvmdCKft4jAvhRM2gSm4aDOnjcPJtfy094k0RAcHQrglJltYGBxb
sd61aTFsF15eE60cgBjqmg/pZTBR8rANpUFVO2H9q+TpzJ+ZWrfJdAss9cM2UUnO
K1m8X7ixYPAEaSJJWVZAFrRv5acxVmzfjyX5NESW/dd2ea1NElcUjzi/TobhRuJR
CtgELdwCmDe291FlYehBVw2QLTRp1jEIoAGOgW1wePowEg4fDrSt7hp5cmmS+IYt
QIlUC0kbSdeYZnqClchmJibr6g9UwFPGmJc5cIzhDK9ZutuigIGCge1oyrB2xZtk
qMLr6G78A0Be/LSKFaFhQhtNjv+xZ0frWgJRqEMbyldO9UAQTZY4ySRL70N+Ek/y
9NvNM3an1g/3nkTltRsvsL3a1oWhBwhVeZBB9eOC5ZC9/WVHM7wD3AzLANDzPNOm
x+VCiJjxDtsMUB6eG5cesXJ+ggQB0IRJJ1DJRgY8pAq114uzWlL+aHuLavx0ENrU
XNz52ake556wNHKSgJbpKVhKCz8EX5SjtLn0mjwnppD8GJXK5Pq7QAnMnNORfKKC
psb6OvsdZQUNcfmR+AsyVrH0aXNLCweka0Ehmath+75nTpt5Wgjkh6lN84WP9yTk
Nb3FZdpGc+eAmPiKcEZo7o990IY32fZxycyI0z6maWCA3WXbIE4=
=m8Sa
-----END PGP SIGNATURE-----

--poemUeGtc2GQvHuH--

