Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750C7C3F2C2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E99A2469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 21:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hTB5Hrd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E99A2469F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7R6i-0004tY-Ex
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 16:54:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j7R5m-0003XS-Hb
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:53:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j7R5k-0008Aj-Qi
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 16:53:14 -0500
Received: from ozlabs.org ([203.11.71.1]:55433)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j7R5k-00086I-2J; Thu, 27 Feb 2020 16:53:12 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48T5y76fW4z9sP7; Fri, 28 Feb 2020 08:53:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582840383;
 bh=76wdx+RXnESt9UFTkzE8wYWzTPdSgG10FdHTwUcTKlk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hTB5Hrd8o6w9hYzZp26YrtSug7nKNupKBkn2Z3MjYcNiDQ5SDnyWRw/JvNw5dmfVP
 55fRAuyu2KwN5/8M44ugR0z2aFS/JGAaop3kwbl9LPkmjJBle9tQisTwY9MiE38JH1
 sja6apQu+pa7/N7E07pdw4/NFbvfL/kQ13LEdEY4=
Date: Thu, 27 Feb 2020 17:04:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v6 17/18] spapr: Clean up RMA size calculation
Message-ID: <20200227060423.GM41629@umbus.fritz.box>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
 <20200224233724.46415-18-david@gibson.dropbear.id.au>
 <20200226143751.17b4bfa4@bahia.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LJm8egi4vkexsie5"
Content-Disposition: inline
In-Reply-To: <20200226143751.17b4bfa4@bahia.home>
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru, farosas@linux.ibm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--LJm8egi4vkexsie5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2020 at 02:37:51PM +0100, Greg Kurz wrote:
> On Tue, 25 Feb 2020 10:37:23 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > Move the calculation of the Real Mode Area (RMA) size into a helper
> > function.  While we're there clean it up and correct it in a few ways:
> >   * Add comments making it clearer where the various constraints come f=
rom
> >   * Remove a pointless check that the RMA fits within Node 0 (we've just
> >     clamped it so that it does)
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c | 59 ++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 35 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 6e9f15f64d..f0354b699d 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2648,6 +2648,40 @@ static PCIHostState *spapr_create_default_phb(vo=
id)
> >      return PCI_HOST_BRIDGE(dev);
> >  }
> > =20
> > +static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
> > +{
> > +    MachineState *machine =3D MACHINE(spapr);
> > +    hwaddr rma_size =3D machine->ram_size;
> > +    hwaddr node0_size =3D spapr_node0_size(machine);
> > +
> > +    /* RMA has to fit in the first NUMA node */
> > +    rma_size =3D MIN(rma_size, node0_size);
> > +
> > +    /*
> > +     * VRMA access is via a special 1TiB SLB mapping, so the RMA can
> > +     * never exceed that
> > +     */
> > +    rma_size =3D MIN(rma_size, TiB);
> > +
> > +    /*
> > +     * Clamp the RMA size based on machine type.  This is for
> > +     * migration compatibility with older qemu versions, which limited
> > +     * the RMA size for complicated and mostly bad reasons.
> > +     */
> > +    if (smc->rma_limit) {
>=20
> /home/greg/Work/qemu/qemu-ppc/hw/ppc/spapr.c: In function =E2=80=98spapr_=
rma_size=E2=80=99:
> /home/greg/Work/qemu/qemu-ppc/hw/ppc/spapr.c:2671:9: error: =E2=80=98smc=
=E2=80=99 undeclared (first use in this function)
>      if (smc->rma_limit) {

Oops.  Fixed.

>=20
> > +        spapr->rma_size =3D MIN(spapr->rma_size, smc->rma_limit);
> > +    }
> > +
> > +    if (rma_size < (MIN_RMA_SLOF * MiB)) {
> > +        error_setg(errp,
> > +"pSeries SLOF firmware requires >=3D %ldMiB guest RMA (Real Mode Area)=
",
> > +                   MIN_RMA_SLOF);
> > +        return -1;
> > +    }
> > +
> > +    return rma_size;
> > +}
> > +
> >  /* pSeries LPAR / sPAPR hardware init */
> >  static void spapr_machine_init(MachineState *machine)
> >  {
> > @@ -2660,7 +2694,6 @@ static void spapr_machine_init(MachineState *mach=
ine)
> >      int i;
> >      MemoryRegion *sysmem =3D get_system_memory();
> >      MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> > -    hwaddr node0_size =3D spapr_node0_size(machine);
> >      long load_limit, fw_size;
> >      char *filename;
> >      Error *resize_hpt_err =3D NULL;
> > @@ -2700,22 +2733,7 @@ static void spapr_machine_init(MachineState *mac=
hine)
> >          exit(1);
> >      }
> > =20
> > -    spapr->rma_size =3D node0_size;
> > -
> > -    /*
> > -     * Clamp the RMA size based on machine type.  This is for
> > -     * migration compatibility with older qemu versions, which limited
> > -     * the RMA size for complicated and mostly bad reasons.
> > -     */
> > -    if (smc->rma_limit) {
> > -        spapr->rma_size =3D MIN(spapr->rma_size, smc->rma_limit);
> > -    }
> > -
> > -    if (spapr->rma_size > node0_size) {
> > -        error_report("Numa node 0 has to span the RMA (%#08"HWADDR_PRI=
x")",
> > -                     spapr->rma_size);
> > -        exit(1);
> > -    }
> > +    spapr->rma_size =3D spapr_rma_size(spapr, &error_fatal);
> > =20
> >      /* Setup a load limit for the ramdisk leaving room for SLOF and FD=
T */
> >      load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
> > @@ -2954,13 +2972,6 @@ static void spapr_machine_init(MachineState *mac=
hine)
> >          }
> >      }
> > =20
> > -    if (spapr->rma_size < MIN_RMA_SLOF) {
> > -        error_report(
> > -            "pSeries SLOF firmware requires >=3D %ldMiB guest RMA (Rea=
l Mode Area memory)",
> > -            MIN_RMA_SLOF / MiB);
> > -        exit(1);
> > -    }
> > -
> >      if (kernel_filename) {
> >          uint64_t lowaddr =3D 0;
> > =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LJm8egi4vkexsie5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5XW+QACgkQbDjKyiDZ
s5KkkA//Yd79p3GDtiteNyjELXdYeK9CGoQtVRUZK1GU90P6g+EcZOcKvJUPAPqs
kUmJN5qUqJrrqsSeSvH2yMSPg6OlhRqpeXnhrsGV93uOGSHikp4p1CA60ua1egrR
31velERrkP5kIxn5M+yn9T5sezS3vRnobpKcU6MADgYPHqpcEz5DXm5TYX5k6C7F
kRsvFxlGXWirWD8AVTrS4AagTvC2Rzp0Doe/eOHZM/nG0sUE30Cd5h7B9cqQwgG5
bKbIhzZKLlkH9tXBfNdQLdvfM9tyWmXbh//n1fAbnzgZLvD/WlzMzhYoISsgUnjE
GL1wLOmqG3dIuAcB+7TnA1H1ziDKJLSBV6kZn2TRi1T7001gTehHgHSlhwQJgwx3
DhHLZNhErQTuSvhvCnH/KFZExpN8kz/A55zKjpb9PeNWxep87ekbkkKBYXno9Nig
7i5pfg/kgP55ueJCZEsrr0DMN/4Lp2yTA26wb0bFWV+KYYz3gokNkGKL935bk9pq
GrDEnAEg8YC1tGoxvCtxqyAUA73uvztz2ToDgoiouMFjD3NjJ6D0Z7LMgW/gnMg6
jJo9GJ2amWVF/MuIsvtQGluqYz10hF0ML/b/V1+iluheO5c3/hFQoFz9U+qcNT7+
XC7utiFvufrAsOlAm54oNFu3Xd5fhKfIggEXQk3zR1MTMIwpdMA=
=lpri
-----END PGP SIGNATURE-----

--LJm8egi4vkexsie5--

