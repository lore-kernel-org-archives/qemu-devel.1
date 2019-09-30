Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F8AC4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 04:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DC332086A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 04:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iJb8aEeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC332086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEn8l-0004FU-FQ
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 00:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iEn61-0002S5-Sz
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 00:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iEn60-0001pY-8Y
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 00:15:37 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:40103 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iEn5z-0001om-RO; Mon, 30 Sep 2019 00:15:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46hTb61qm9z9sDB; Mon, 30 Sep 2019 14:15:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569816930;
 bh=ykN9rR1xPmSHhCcOBiqQnY5zUMef9ReTw6GwEvyiZmo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iJb8aEeEC2lWtwicnAIIb0wk6noshP0VF8MjPmnsmetO0ocNq9tZ4HG6r1bnE4ELJ
 4uKPsHPohBf0mW+czrNjEZcN0Yi3w03ZtshV6kDnYz+DbY4KKH49rUERrSAzrdZn5h
 rN/ln90HyAJCSNijRjAc37FiwZaYgaZAKXh9qUbs=
Date: Mon, 30 Sep 2019 11:49:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 21/33] spapr, xics, xive: Move cpu_intc_create from
 SpaprIrq to SpaprInterruptController
Message-ID: <20190930014904.GB11105@umbus.fritz.box>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-22-david@gibson.dropbear.id.au>
 <20190927121649.5b9f3db7@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
In-Reply-To: <20190927121649.5b9f3db7@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 12:16:49PM +0200, Greg Kurz wrote:
> On Fri, 27 Sep 2019 15:50:16 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > This method essentially represents code which belongs to the interrupt
> > controller, but needs to be called on all possible intcs, rather than
> > just the currently active one.  The "dual" version therefore calls
> > into the xics and xive versions confusingly.
> >=20
> > Handle this more directly, by making it instead a method on the intc
> > backend, and always calling it on every backend that exists.
> >=20
> > While we're there, streamline the error reporting a bit.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
[snip]
> > @@ -525,6 +469,30 @@ static void spapr_irq_check(SpaprMachineState *spa=
pr, Error **errp)
> >  /*
> >   * sPAPR IRQ frontend routines for devices
> >   */
> > +int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
> > +                              PowerPCCPU *cpu, Error **errp)
> > +{
> > +    if (spapr->xive) {
> > +        SpaprInterruptController *intc =3D SPAPR_INTC(spapr->xive);
> > +        SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLASS(i=
ntc);
> > +
> > +        if (sicc->cpu_intc_create(intc, cpu, errp) < 0) {
> > +            return -1;
> > +        }
> > +    }
> > +
> > +    if (spapr->ics) {
> > +        SpaprInterruptController *intc =3D SPAPR_INTC(spapr->ics);
> > +        SpaprInterruptControllerClass *sicc =3D SPAPR_INTC_GET_CLASS(i=
ntc);
> > +
> > +        if (sicc->cpu_intc_create(intc, cpu, errp) < 0) {
> > +            return -1;
> > +        }
> > +    }
> > +
>=20
> Instead of these hooks, what about open-coding spapr_xive_cpu_intc_create=
()
> and xics_spapr_cpu_intc_create() directly here, like you already did for =
the
> ICS and the XIVE objects in spapr_irq_init() ?

I'd prefer not to.  The idea is I want to treat this as basically:

	foreach_possible_intc(intc)
		intc::cpu_intc_create(...)

If I find time I might indeed replace the explicit ics and xive
pointers with just an array of SpaprInterruptController *.

init is fundamentally different though, because it needs to *create*
that list (implicit or explicit) of possible intcs, so it can't be
based on an existing one.

>=20
> > +    return 0;
> > +}
> > +
> >  void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
> >  {
> >      MachineState *machine =3D MACHINE(spapr);
> > @@ -763,7 +731,6 @@ SpaprIrq spapr_irq_xics_legacy =3D {
> >      .free        =3D spapr_irq_free_xics,
> >      .print_info  =3D spapr_irq_print_info_xics,
> >      .dt_populate =3D spapr_dt_xics,
> > -    .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
> >      .post_load   =3D spapr_irq_post_load_xics,
> >      .reset       =3D spapr_irq_reset_xics,
> >      .set_irq     =3D spapr_irq_set_irq_xics,
> > diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> > index b9398e0be3..30d660ff1e 100644
> > --- a/include/hw/ppc/spapr_irq.h
> > +++ b/include/hw/ppc/spapr_irq.h
> > @@ -43,8 +43,22 @@ typedef struct SpaprInterruptController SpaprInterru=
ptController;
> > =20
> >  typedef struct SpaprInterruptControllerClass {
> >      InterfaceClass parent;
> > +
> > +    /*
> > +     * These methods will typically be called on all intcs, active and
> > +     * inactive
> > +     */
> > +    int (*cpu_intc_create)(SpaprInterruptController *intc,
> > +                            PowerPCCPU *cpu, Error **errp);
> >  } SpaprInterruptControllerClass;
> > =20
> > +void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon);
> > +void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
> > +                  void *fdt, uint32_t phandle);
>=20
> These two ^^ seem to belong to later patches.
>=20
> > +int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
> > +                              PowerPCCPU *cpu, Error **errp);
> > +
> > +
> >  void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis);
> >  int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool a=
lign,
> >                          Error **errp);
> > @@ -61,8 +75,6 @@ typedef struct SpaprIrq {
> >      void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
> >      void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
> >                          void *fdt, uint32_t phandle);
> > -    void (*cpu_intc_create)(SpaprMachineState *spapr, PowerPCCPU *cpu,
> > -                            Error **errp);
> >      int (*post_load)(SpaprMachineState *spapr, int version_id);
> >      void (*reset)(SpaprMachineState *spapr, Error **errp);
> >      void (*set_irq)(void *opaque, int srcno, int val);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2RXxAACgkQbDjKyiDZ
s5LYTxAAylRZcmHtLpsluBcyzQsaEsiwjs5pKnBScU+Y5g1OIjb5pJczqzXiI8JJ
irYh/BIH1tPWH3FoyWctc1VhYTJAbtmajgfrP+4L+KiL2qeScT6lfBCC68NVPoPt
Mok2viTy7NcDJc2qUCScrh0bKrqGpjjAS9Hc/aAaEeyX+xOFSs21Cw1sov5OUlRj
UTO9xfVzVpbi/m9opHRtlWYGCtA+XKtdht0bqtPpv/Qz0UQ0y7ggd8Qd7mGm4JHe
1DgducuYuh3ucaNUxE6+LFKVKJwQVeytZLYJH3ja377QWIow6m69j3iuwM4UdVIC
YBRfsPKOmwnvph5LHLxGq9L2sU02BpdrC2T0/ITEb/6A4gMHs35Dzlwag3k4vXhJ
wFjfVagVfWMkJ4rT+R6p8Aoveb/kQ3d6h8BR04q1NEwA4sQgnr4hoxCu4M5RgBvA
EE9euEgseI8GBtqza5Jvjls7NTyUQ0lYfI8b/+wGve89ZJGqPnaY3R7aeiWR7AXy
1tq/xYOZz8o/KWy3SwUU+AWF0tTba1KQaL+9JObgLy6lCI0xOMZzKL4y2Qlj6C5j
pKZNHwiGVmqdYpdtbrbbVgfZCxnZeE1YTOIgUlqgcMFd7vSBbJhuYTn4WzlVGDXU
hNPerxLAVX6j15fZUqgMM+6TGd1o2qGjd90lDm+Nq+qXNhDdwIg=
=bUy/
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--

