Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8349C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 08:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B90214AF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 08:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JcA5Rdu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B90214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibhCa-0003nG-GH
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 03:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ibhBl-0003IQ-51
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 03:36:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ibhBj-00015u-8B
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 03:36:12 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41851 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ibhBi-00011X-1j; Mon, 02 Dec 2019 03:36:11 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47RJNk6SDbz9sPJ; Mon,  2 Dec 2019 19:36:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575275766;
 bh=Ksi/zmdsykppnpkbUPvSkLwldt9ZBwwXXRbwXlWD9NM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JcA5Rdu9tjL4DTVX2ARax8sFsfp48ygGi6DVYa+vKDc7G1SlBqOb8D5KflBoM/CxU
 OLER+EygOHRC9Rw/NJy24tJR7PmIlAW5GCNQoOQPK7/yQ4n+K//xvBbPeK9btjXeRt
 V6NP3mVf1MKO9KxtCbEKNw2Szeue8TKMcTR94YcM=
Date: Mon, 2 Dec 2019 18:59:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [for-5.0 1/4] spapr: Don't trigger a CAS reboot for XICS/XIVE
 mode changeover
Message-ID: <20191202075943.GB37909@umbus.fritz.box>
References: <20191129053356.232413-1-david@gibson.dropbear.id.au>
 <20191129053356.232413-2-david@gibson.dropbear.id.au>
 <20191202085009.44f3909f@bahia.w3ibm.bluemix.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
In-Reply-To: <20191202085009.44f3909f@bahia.w3ibm.bluemix.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 clg@kaod.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2019 at 08:50:09AM +0100, Greg Kurz wrote:
> On Fri, 29 Nov 2019 16:33:53 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > PAPR allows the interrupt controller used on a POWER9 machine (XICS or
> > XIVE) to be selected by the guest operating system, by using the
> > ibm,client-architecture-support (CAS) feature negotiation call.
> >=20
> > Currently, if the guest selects an interrupt controller different from =
the
> > one selected at initial boot, this causes the system to be reset with t=
he
> > new model and the boot starts again.  This means we run through the SLOF
> > boot process twice, as well as any other bootloader (e.g. grub) in use
> > before the OS calls CAS.  This can be confusing and/or inconvenient for
> > users.
> >=20
> > Thanks to two fairly recent changes, we no longer need this reboot.  1)=
 we
> > now completely regenerate the device tree when CAS is called (meaning we
> > don't need special case updates for all the device tree changes caused =
by
> > the interrupt controller mode change),  2) we now have explicit code pa=
ths
> > to activate and deactivate the different interrupt controllers, rather =
than
> > just implicitly calling those at machine reset time.
> >=20
> > We can therefore eliminate the reboot for changing irq mode, simply by
> > putting a called to spapr_irq_update_active_intc() before we call
>=20
> putting a call

Fixed, thanks.

> > spapr_h_cas_compose_response() (which gives the updated device tree to =
the
> > guest firmware and OS).
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
>=20
> Convenient indeed ! :)
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> >  hw/ppc/spapr_hcall.c | 33 +++++++++++++--------------------
> >  1 file changed, 13 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 140f05c1c6..05a7ca275b 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -1767,21 +1767,10 @@ static target_ulong h_client_architecture_suppo=
rt(PowerPCCPU *cpu,
> >      }
> >      spapr->cas_pre_isa3_guest =3D !spapr_ovec_test(ov1_guest, OV1_PPC_=
3_00);
> >      spapr_ovec_cleanup(ov1_guest);
> > -    if (!spapr->cas_reboot) {
> > -        /* If spapr_machine_reset() did not set up a HPT but one is ne=
cessary
> > -         * (because the guest isn't going to use radix) then set it up=
 here. */
> > -        if ((spapr->patb_entry & PATE1_GR) && !guest_radix) {
> > -            /* legacy hash or new hash: */
> > -            spapr_setup_hpt_and_vrma(spapr);
> > -        }
> > -        spapr->cas_reboot =3D
> > -            (spapr_h_cas_compose_response(spapr, args[1], args[2],
> > -                                          ov5_updates) !=3D 0);
> > -    }
> > =20
> >      /*
> > -     * Ensure the guest asks for an interrupt mode we support; otherwi=
se
> > -     * terminate the boot.
> > +     * Ensure the guest asks for an interrupt mode we support;
> > +     * otherwise terminate the boot.
> >       */
> >      if (guest_xive) {
> >          if (!spapr->irq->xive) {
> > @@ -1797,14 +1786,18 @@ static target_ulong h_client_architecture_suppo=
rt(PowerPCCPU *cpu,
> >          }
> >      }
> > =20
> > -    /*
> > -     * Generate a machine reset when we have an update of the
> > -     * interrupt mode. Only required when the machine supports both
> > -     * modes.
> > -     */
> > +    spapr_irq_update_active_intc(spapr);
> > +
> >      if (!spapr->cas_reboot) {
> > -        spapr->cas_reboot =3D spapr_ovec_test(ov5_updates, OV5_XIVE_EX=
PLOIT)
> > -            && spapr->irq->xics && spapr->irq->xive;
> > +        /* If spapr_machine_reset() did not set up a HPT but one is ne=
cessary
> > +         * (because the guest isn't going to use radix) then set it up=
 here. */
> > +        if ((spapr->patb_entry & PATE1_GR) && !guest_radix) {
> > +            /* legacy hash or new hash: */
> > +            spapr_setup_hpt_and_vrma(spapr);
> > +        }
> > +        spapr->cas_reboot =3D
> > +            (spapr_h_cas_compose_response(spapr, args[1], args[2],
> > +                                          ov5_updates) !=3D 0);
> >      }
> > =20
> >      spapr_ovec_cleanup(ov5_updates);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3kxGwACgkQbDjKyiDZ
s5J4Ug//TJ18tfHhi1QomHXuOzx+krhRCJ3v4+ay+34I8TKMOMfMW2Pp+114UBll
lGWQ9FIdWweWpSCSTSH5OrLWuke7XxkcG4VNleHLbFuYgygi+ILE9aXdGVXimzWb
Q7C6OQh6LieTEE8i2KYWhvpu0L0SqLVwI+3vOCnscEA1CiHpByS4bU+zhx0oZRBQ
kUZuRMQtTJU1Cu3tN4qZVosTtJJvwCE8cpCCIpADMikH3AuWoVskp0/Y03+BhfXZ
oXCK0XAAiWokM7bvrD/fNXhP2OcZY/O5ImVWdOIcG5nvvoh61QIHKtG24cjOsdO3
xh+v+ye5DR5klBOPbijguHxHS755QafFdhTNOpbktJXAGrKu0FQc6KuhIVAnZ8ek
cgZ31Qpzg/VebC4pAY6twwR55tscIfZ45Vsua0ZpiH/bJUxV4I+eYWGHjk4kIs3a
XzPIyc6HtZhwPs4iNOS+KcIJzG0yAgGAAoWVsCtWk6//RHj9sNjn45B9gB91xqVC
vjtLz2CzdxvW2d3u1YJCK7idygEBr2EEfhKQiL5Xu4nnc2wRW1wnWiBMS6jcd9nk
1lfeGB48K+jsSI38XwrVdkXuPe2z9BLodn6mlTYceYkewbOROljWMKzzJ6PuIYTO
mXx5JMoMTgg5a3+Om+vq1FEoDAPLUrRnl20AmY94u74f6q6+FVI=
=z8ZF
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--

