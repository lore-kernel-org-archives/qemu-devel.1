Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCA5C4360C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 01:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A879721A4C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 01:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eordlBRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A879721A4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFple-0001Q4-QO
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 21:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFpks-0000rk-HG
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 21:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFpkr-0006qe-0j
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 21:18:06 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:50873 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFpkp-0006lQ-Pb; Wed, 02 Oct 2019 21:18:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46kFVs2bg3z9sDB; Thu,  3 Oct 2019 11:17:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570065477;
 bh=DosQ+eUGrYc21k8YzOw2edYxN6IOZztvk7L9Q30j7+A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eordlBRYcQdb0EmBbB4VXR+SjpuTI2XDmjLtzk4TrhxdNPIi6yOGBgB+qilyuJufV
 WA8HKYjtg0FfhYraTzYDR4sPRIhlJ0W9yFu2ZpN6rwuclThcCSuOOU2TNPeTIlyDDJ
 kx1zmvi48VaagYwXtXoOvxFjDZIr5DtJh245Ap18=
Date: Thu, 3 Oct 2019 10:22:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3 30/34] spapr, xics, xive: Move SpaprIrq::reset hook
 logic into activate/deactivate
Message-ID: <20191003002222.GD11105@umbus.fritz.box>
References: <20191002025208.3487-1-david@gibson.dropbear.id.au>
 <20191002025208.3487-31-david@gibson.dropbear.id.au>
 <20191002112908.2bf1ea0b@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="h+CsNYkJBPxpZ+B/"
Content-Disposition: inline
In-Reply-To: <20191002112908.2bf1ea0b@bahia.lan>
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
 clg@kaod.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--h+CsNYkJBPxpZ+B/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2019 at 11:29:08AM +0200, Greg Kurz wrote:
> On Wed,  2 Oct 2019 12:52:04 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > It turns out that all the logic in the SpaprIrq::reset hooks (and some =
in
> > the SpaprIrq::post_load hooks) isn't really related to resetting the irq
> > backend (that's handled by the backends' own reset routines).  Rather i=
ts
> > about getting the backend ready to be the active interrupt controller or
> > stopping being the active interrupt controller - reset (and post_load) =
is
> > just the only time that changes at present.
> >=20
> > To make this flow clearer, move the logic into the explicit backend
> > activate and deactivate hooks.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/intc/spapr_xive.c       | 35 ++++++++++++++++++++
> >  hw/intc/xics_spapr.c       | 16 +++++++++
> >  hw/ppc/spapr_irq.c         | 67 ++------------------------------------
> >  include/hw/ppc/spapr_irq.h |  4 ++-
> >  4 files changed, 57 insertions(+), 65 deletions(-)
> >=20
> > diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> > index 37ffb74ca5..e8b946982c 100644
> > --- a/hw/intc/spapr_xive.c
> > +++ b/hw/intc/spapr_xive.c
> > @@ -640,6 +640,39 @@ static void spapr_xive_dt(SpaprInterruptController=
 *intc, uint32_t nr_servers,
> >                       plat_res_int_priorities, sizeof(plat_res_int_prio=
rities)));
> >  }
> > =20
> > +static void spapr_xive_activate(SpaprInterruptController *intc, Error =
**errp)
> > +{
> > +    SpaprXive *xive =3D SPAPR_XIVE(intc);
> > +    CPUState *cs;
> > +
> > +    CPU_FOREACH(cs) {
> > +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > +
> > +        /* (TCG) Set the OS CAM line of the thread interrupt context. =
*/
> > +        spapr_xive_set_tctx_os_cam(spapr_cpu_state(cpu)->tctx);
> > +    }
> > +
>=20
> I think this ^^ can go...
>=20
> > +    if (kvm_enabled()) {
> > +        if (spapr_irq_init_kvm(kvmppc_xive_connect, intc, errp) < 0) {
> > +            return;
> > +        }
> > +    }
> > +
>=20
> ... here. If which case, spapr_irq_init_kvm() could be called from
> set_active_intc() instead of being called by each backend if I get
> it right. This would avoid the frontend->backend->frontend flow.

Hm.  I don't love the idea.  KVM setup seems like an internal
implementation detail of the backend, which I'd prefer not to handle
in the frontend.

I'm not really considering spapr_irq_init_kvm() as part of the
frontend proper, but rather a helper function for use in the backend.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--h+CsNYkJBPxpZ+B/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2VPzwACgkQbDjKyiDZ
s5ILHA//UtVdxoHV4fpurHvjU+ZATuyJzUt+TpUVUAn88BZekw7IrKP8LN1xUZ2R
9fXXLyBJpi0kP4WbnKy7HgGxIFx/kIlHuW6AZroKv+gcXsbDDQWBxNggqscK2xtN
09XNGRFNvMvPjWdLJmWuovLBboF5B7l5tItrDGm3QImZYQUEjuD2FleRbnJ/vTM2
mdSjxlpamy5wGcsWqHs8e3b0JmDQtgAi0T6hyMv+URrRyVAhTOypzPD4uGJ37lLc
oyRamgP/YkoTB9Ikkz+oOc4QcYxZHtl6flpQ3tZMV4/ZeRxhhgB6EToHHPe4ix7x
U09jagr0ZR62IpAraar1IaXITa9YZ9GWx7UTpKuFYCccogldFNzyWO92hw9x3BUJ
ODNEMI8OJdBgPAgcUlr73p5XGDDbpSRyRH3fuDO9beY4s72xfXjplnQoqWVgKds3
1HIIP0KjjDbBerA2YN+DuZc5FPh8f8S4rmS27A5wU86EO+ggdHahA6mKg+Om5rmU
FqSUbf1wqp2REu/NbRKWAzEO5aRczfJPDO1u0bKy8OMH3mDh/fM0lEArS8s5+0kC
JGvgWrzc78dW1Ugx4boUMViFk0YuObIExy53JkO4+4AXaqBmfPuIARSoAp5VHl6E
rTe5djY0MYK1jcq1V/9+VirRHT3c0lg+gvIkeRLakw1ZX4nacZY=
=DgoT
-----END PGP SIGNATURE-----

--h+CsNYkJBPxpZ+B/--

