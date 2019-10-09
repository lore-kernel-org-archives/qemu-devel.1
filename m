Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C865C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A96A206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A96A206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIIYI-0002D7-Gr
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 16:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iIFa8-0005he-RG
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 13:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iIFa6-0001lb-F7
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 13:17:00 -0400
Received: from 6.mo178.mail-out.ovh.net ([46.105.53.132]:47062)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iIFa5-0001jA-Au
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 13:16:58 -0400
Received: from player738.ha.ovh.net (unknown [10.109.143.208])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 0BAF17B24E
 for <qemu-devel@nongnu.org>; Wed,  9 Oct 2019 19:16:54 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id 67E4AAE53814;
 Wed,  9 Oct 2019 17:16:41 +0000 (UTC)
Date: Wed, 9 Oct 2019 19:16:39 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 19/19] spapr: Work around spurious warnings from vfio
 INTx initialization
Message-ID: <20191009191639.4055f811@bahia.lan>
In-Reply-To: <20191009085259.GA5035@umbus.fritz.box>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-20-david@gibson.dropbear.id.au>
 <20191009103738.01bc146a@bahia.lan>
 <20191009085259.GA5035@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//SDFP6flH=KkWGUDf0s+7ag";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 1586955919533316582
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedriedugdekkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.53.132
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
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_//SDFP6flH=KkWGUDf0s+7ag
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Oct 2019 19:52:59 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Oct 09, 2019 at 10:37:38AM +0200, Greg Kurz wrote:
> > On Wed,  9 Oct 2019 17:08:18 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > Traditional PCI INTx for vfio devices can only perform well if using
> > > an in-kernel irqchip.  Therefore, vfio_intx_update() issues a warning
> > > if an in kernel irqchip is not available.
> >=20
> > Can you elaborate on what doesn't "perform well" without an
> > in-kernel irqchip ?
>=20
> Not really, no, but Alex Williamson tells me it is soo.
>=20
> > Is it a matter of performance or is it
> > actually broken or something else ?
>=20
> I believe it's a matter of performance, but such a big one that it
> makes using it without kernel irqchip infeasible in many cases.
>=20
> > What is the impact on -machine accel=3Dkvm,kernel-irqchip=3Doff which
> > always spit this warning ?
>=20
> It should still spit that warning.
>=20

Yeah of course it does, but it is expected that we cannot setup
the irqfd since we deliberately don't have an in-kernel irqchip,
isn't it ? Why spit a warning in this case ? Or is it just a not
very user friendly way of saying "you will have poor performance
if the VFIO device uses PCI INTx" ?

> > > We usually do have an in-kernel irqchip available for pseries machines
> > > on POWER hosts.  However, because the platform allows feature
> > > negotiation of what interrupt controller model to use, we don't
> > > currently initialize it until machine reset.  vfio_intx_update() is
> > > called (first) from vfio_realize() before that, so it can issue a
> > > spurious warning, even if we will have an in kernel irqchip by the
> > > time we need it.
> > >=20
> > > To workaround this, make a call to spapr_irq_update_active_intc() from
> > > spapr_irq_init() which is called at machine realize time, before the
> > > vfio realize.  This call will be pretty much obsoleted by the later
> > > call at reset time, but it serves to suppress the spurious warning
> > > from VFIO.
> > >=20
> > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> > >=20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > ---
> > >  hw/ppc/spapr_irq.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > > index 7964e4a1b8..3aeb523f3e 100644
> > > --- a/hw/ppc/spapr_irq.c
> > > +++ b/hw/ppc/spapr_irq.c
> > > @@ -274,6 +274,14 @@ void spapr_irq_init(SpaprMachineState *spapr, Er=
ror **errp)
> > > =20
> > >      spapr->qirqs =3D qemu_allocate_irqs(spapr_set_irq, spapr,
> > >                                        smc->nr_xirqs + SPAPR_XIRQ_BAS=
E);
> > > +
> > > +    /*
> > > +     * Mostly we don't actually need this until reset, except that n=
ot
> > > +     * having this set up can cause VFIO devices to issue a
> > > +     * false-positive warning during realize(), because they don't y=
et
> > > +     * have an in-kernel irq chip.
> > > +     */
> > > +    spapr_irq_update_active_intc(spapr);
> > >  }
> > > =20
> > >  int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Err=
or **errp)
> > > @@ -429,7 +437,8 @@ void spapr_irq_update_active_intc(SpaprMachineSta=
te *spapr)
> > >           * this.
> > >           */
> > >          new_intc =3D SPAPR_INTC(spapr->xive);
> > > -    } else if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> > > +    } else if (spapr->ov5_cas
> > > +               && spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT))=
 {
> > >          new_intc =3D SPAPR_INTC(spapr->xive);
> > >      } else {
> > >          new_intc =3D SPAPR_INTC(spapr->ics);
> >=20
>=20


--Sig_//SDFP6flH=KkWGUDf0s+7ag
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl2eFfcACgkQcdTV5YIv
c9ZnJhAAsrS5hhsajvEAxfSWQcnWe+p1Ept5tSY4P/TgT8Rx9YtoT68JjE9nwjzJ
O4TqMb73DPOjwekTVMSibOAXjeL9JGRbkXYw0W122qDIFS7BVyNz1jTwUIWbR++Z
NKzdVQzghTQqdX12oR+u6D+oqYAf87wAcN71lycldFSef4/RjBYGirNQXEJ+Na9w
FnMlH0rjPDsX4PALaqp51fLlV/x1VwKf5ZSaCKzS26ICuwB4oSEPcIDI23Jjy/CB
qdcyPC7IdjI06FVkUYRE6JOpEz/uqnwS9/J+coqnrGJEsMxMGa/gSDDzH3KKB7Of
rxVPVm0kvBePXY9QGeqS+2LdXyOyuNhkOEZtrW/2+3dYoOtgQ7BzUirLfRrZXb4r
XtykeuYgOABAeoLq7xnS2nJ8RNMlZt5jHDSAhMbOKtPSd8g6TOAJxVvwTXEt7Zzu
9p9Whz+rQpPxj52SD+lvGh2REH6NfGQtv8/P+AUAaVKO0RYQ5olWsR0ygqYwTpFV
7K7QdkIWSlfnTWPaByZzbG0oYclEZ7rgw996mZ1ZuOiukYRUTAzovF4VfRL41tFu
T2SOU8W63/DjR0KaiKorxgzoLK94/8TQXTZzcMW7ES90k4ET5dQ0cizbyWkZD6Om
IV80/WGYbiRWe4q45DfrmyDD5dX9nUy8+3zy/ydXVULVLC5NYR4=
=kKFx
-----END PGP SIGNATURE-----

--Sig_//SDFP6flH=KkWGUDf0s+7ag--

