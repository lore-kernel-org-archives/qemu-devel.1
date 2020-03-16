Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869CFC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 03:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F94820409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 03:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nCKzVmLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F94820409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDg62-0007iN-5f
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 23:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jDfvD-0004rL-Ux
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 22:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jDfvB-0002d6-MK
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 22:56:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38949 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jDfvA-0002YJ-SK; Sun, 15 Mar 2020 22:56:05 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48ggss6ZLHz9sPJ; Mon, 16 Mar 2020 13:56:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584327361;
 bh=qKVZ6RzExzfB8jkpmR2NI6uWxaNh3JZ2ksqTTTrmkqo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nCKzVmLKSayN+zEyKA0Wo78S/oPHyR9YZAedZJ1ut5FqbHPjcIjBc6G4QQt0ftx8A
 WYvMxhQQwK5AUt3pt+iMBqW7AGM8pLDL+wQhgdsYybeJcWKvdd3KK28LHHCDCOzK53
 GXD2S0J+mYc1MNFVcUI3/bWjwCytluE8j3I9G0CE=
Date: Mon, 16 Mar 2020 13:55:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 4/4] spapr: Fold spapr_node0_size() into its only caller
Message-ID: <20200316025556.GF2013@umbus.fritz.box>
References: <20200313040539.819138-1-david@gibson.dropbear.id.au>
 <20200313040539.819138-5-david@gibson.dropbear.id.au>
 <20200313103330.125530ee@bahia.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="b8GWCKCLzrXbuNet"
Content-Disposition: inline
In-Reply-To: <20200313103330.125530ee@bahia.home>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: qemu-ppc@nongnu.org, philmd@redhat.com, clg@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--b8GWCKCLzrXbuNet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2020 at 10:33:30AM +0100, Greg Kurz wrote:
> On Fri, 13 Mar 2020 15:05:39 +1100
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
> > index 6c32ec3c0a..6a42c0f1c9 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -295,20 +295,6 @@ static void spapr_dt_pa_features(SpaprMachineState=
 *spapr,
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
> > @@ -2631,10 +2617,24 @@ static hwaddr spapr_rma_size(SpaprMachineState =
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
> > +                hwaddr node_size =3D machine->numa_state->nodes[i].nod=
e_mem;
> > +                rma_size =3D MIN(rma_size, pow2floor(node_size));
> > +                break;
> > +            }
> > +        }
> > +    }
> > =20
> >      /*
> >       * VRMA access is via a special 1TiB SLB mapping, so the RMA can
> > @@ -2651,6 +2651,11 @@ static hwaddr spapr_rma_size(SpaprMachineState *=
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
> The patch is identical to the last spin, for which I had
> a comment already:

Ah, dangit.  It's actually not identical.  I put the pow2floor() back
in the node loop, but forgot to remove it from the bottom here.  I'll
put this one off for now.

> -----------------------------------------------------------------------
> On Wed, 4 Mar 2020 12:25:55 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
> > On Tue, Mar 03, 2020 at 11:32:49AM +0100, Greg Kurz wrote:
>=20
> [...]
>=20
> > > In any case, it would probably help to mention somewhere
> > > why the rounding is introduced by this patch.
> >=20
> > Drat.  I meant to sort out your comment on the last spin better than
> > this, but got part way through and forgot what I was doing.
> >
> -----------------------------------------------------------------------
>=20
> I still think that the rounding introduced by this patch deserves
> some explanations in the changelog...

Yeah.. turns out this is more complicated than you'd think.  It is
indeed related to that block splitting you noticed.  Except that
AFAICT that block splitting is irrelevant in most cases, and broken
for most of the remaining cases.  It seems to have been based on a
misunderstanding of how the kernel's early memory block handling
works.

My intention had been to make this patch do just the cleanup without
the rounding change, then address the rounding change another day.
Except I messed up the first part.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--b8GWCKCLzrXbuNet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5u6rwACgkQbDjKyiDZ
s5InSw/+K2fBXIheNt5Vr7AN72keVn+br+5THzkeUN+QY//YHQoYVx9O6fcpeOWz
V0WEbC2AWh8ddX5FPsxVeb0B40h6Bb9b3cn/wcUNtWN6R2Ept8WVqjbwJFyj10RW
RAEEBV81mk3R/iR3OO0aHavDMNkKEs6CnfKMK8f70krYN+xnijRX5ojC0y4nMres
tVr2R9QLDeGb47fvKm4i9YyVf0EQMu3ZDg70GmRjSMSJCUiGHh8edP2VYat3ROiR
aXr2DwrqOInAznwHSS1XSgd2g73kuRXaR+At4DOHk3c/kMt5sl1qBtTyXq+xKdLM
EoA5VsdZvunJLs1phEYt3IM6i8ec8mc8sQBSuHwSsXjgROIWtvU6Pz8ezAQF0tP/
X30gUqdmMle1tYliOpetMGnM7xgtmK+NuUL1exj6qMDPM6EBT+mDIu9OqeE3vHbE
suF02R2rr/AV2mEwypaUSi6UeAZXRtKITe5X287cs3obHF6pba2S9q82cirj7j3V
lrTBZ/iAsGwtDdwGoX4JqZ1jQ5R+YEaxvAoK/Ix+j67JudtRYmq44n33oWto/kdo
826rxDychZhGHqz6VR9fCdZ1fpRCCOGLXCgc06IeEhKC3UcwW1oPf0IUKRGjIgGe
L/V3UR2LShqCOiE4luVi2h1+HJhqt4nIa9SlnW6rnOz7DVXg0B0=
=NoIc
-----END PGP SIGNATURE-----

--b8GWCKCLzrXbuNet--

