Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E76FC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1712221848
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VNPG1BZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1712221848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFIw-0000RH-Kk
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iI7mY-0001MX-Lz
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 04:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iI7mX-00078D-3S
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 04:57:18 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:40845 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iI7mW-00076x-5k; Wed, 09 Oct 2019 04:57:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46p7Pz24stz9sN1; Wed,  9 Oct 2019 19:57:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570611431;
 bh=UEmG5XZLcxxMnbCkagNYfH7opXOYWdTp+28o/N19QQ4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VNPG1BZfEzLap8uOBPjGY4QCrgYRfoMWdOucRe0vDsKME1Lm7UfTsNuYtd1eNDymp
 KG86sxriUPL991R5DC/bC1ffHzfjfItsgYzdLFdfQoQQ+ICfYwHKWNHo7v+JGzPW20
 rPvDBK4XPmbIgailsmBVr0C+iye/aQx+GZc2Jgb0=
Date: Wed, 9 Oct 2019 19:52:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 19/19] spapr: Work around spurious warnings from vfio
 INTx initialization
Message-ID: <20191009085259.GA5035@umbus.fritz.box>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-20-david@gibson.dropbear.id.au>
 <20191009103738.01bc146a@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20191009103738.01bc146a@bahia.lan>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Jason Wang <jasowang@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 clg@kaod.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2019 at 10:37:38AM +0200, Greg Kurz wrote:
> On Wed,  9 Oct 2019 17:08:18 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > Traditional PCI INTx for vfio devices can only perform well if using
> > an in-kernel irqchip.  Therefore, vfio_intx_update() issues a warning
> > if an in kernel irqchip is not available.
>=20
> Can you elaborate on what doesn't "perform well" without an
> in-kernel irqchip ?

Not really, no, but Alex Williamson tells me it is soo.

> Is it a matter of performance or is it
> actually broken or something else ?

I believe it's a matter of performance, but such a big one that it
makes using it without kernel irqchip infeasible in many cases.

> What is the impact on -machine accel=3Dkvm,kernel-irqchip=3Doff which
> always spit this warning ?

It should still spit that warning.

> > We usually do have an in-kernel irqchip available for pseries machines
> > on POWER hosts.  However, because the platform allows feature
> > negotiation of what interrupt controller model to use, we don't
> > currently initialize it until machine reset.  vfio_intx_update() is
> > called (first) from vfio_realize() before that, so it can issue a
> > spurious warning, even if we will have an in kernel irqchip by the
> > time we need it.
> >=20
> > To workaround this, make a call to spapr_irq_update_active_intc() from
> > spapr_irq_init() which is called at machine realize time, before the
> > vfio realize.  This call will be pretty much obsoleted by the later
> > call at reset time, but it serves to suppress the spurious warning
> > from VFIO.
> >=20
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_irq.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index 7964e4a1b8..3aeb523f3e 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -274,6 +274,14 @@ void spapr_irq_init(SpaprMachineState *spapr, Erro=
r **errp)
> > =20
> >      spapr->qirqs =3D qemu_allocate_irqs(spapr_set_irq, spapr,
> >                                        smc->nr_xirqs + SPAPR_XIRQ_BASE);
> > +
> > +    /*
> > +     * Mostly we don't actually need this until reset, except that not
> > +     * having this set up can cause VFIO devices to issue a
> > +     * false-positive warning during realize(), because they don't yet
> > +     * have an in-kernel irq chip.
> > +     */
> > +    spapr_irq_update_active_intc(spapr);
> >  }
> > =20
> >  int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error=
 **errp)
> > @@ -429,7 +437,8 @@ void spapr_irq_update_active_intc(SpaprMachineState=
 *spapr)
> >           * this.
> >           */
> >          new_intc =3D SPAPR_INTC(spapr->xive);
> > -    } else if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> > +    } else if (spapr->ov5_cas
> > +               && spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> >          new_intc =3D SPAPR_INTC(spapr->xive);
> >      } else {
> >          new_intc =3D SPAPR_INTC(spapr->ics);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2dn+cACgkQbDjKyiDZ
s5Kg1BAAz7Ecz0EWFN8b17t6SKAzS9Q+D7m6s0Tp/J1hvm2yZbSB9yNrCoFln+mF
tjJC2rNsf44h6WV/uIjGZ4zCExYzUoAgZwDPW9f35H8zmm+mR0peIMiN7IVMzNED
jBHU4Etr0dj4ODhBKoaFKBIyIuY+lG/A+zgGRkNjoszY2TWb6BPyGnzyBSjyOJr3
95809lbcqxyQxge1kexTH6HOQess6js65RZaGzdpMow/GeAxoUrCaH01OMEr0Sft
qOF57oOnV3/noyHRvDaxEToDFnMggoB4l5OD8VYmUs3VETkcWCqwHrSMT4UoJ2qf
6Zlv1xeHaaMpm6WcL1FkWRR6WqfuTE1pJYIxs6dBFMZ+N4CwzBCqQrqQVZEmEfIe
X5vl//ehI+fQhHQjlVND+3V4tUZqZqN9QFiHdvI1x1fXlfTFQdr6B7tkJD485I8S
GbagXWWzTpKPgu64pCXiwW0S09Cbg3MJP3SOQpK53JNyx6AwOSpcry+kG7ioWAjK
jPoENFjF4dqZk6jA+rlDl14uL1JFIJxOcFG/evvJiTw5lxrvoHrz1HEPj8ZrY09Q
yO5TmfhktJhR5QhSj8sN3V+KzdjIKxLurNaIf2LMBsga3k4XUFpbKovYXxcU6VP9
gnW09ovCcpD7d4vi51lv4KTs5vERcRxE8bdzP0efNw+ljzMFKeA=
=jA2Z
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

