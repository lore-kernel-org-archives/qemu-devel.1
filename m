Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254F2CA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 17:37:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E397820679
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 17:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Pfc7xYAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E397820679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOmUD-00044y-1x
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 13:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iOmJt-0004Nl-U4
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iOmJs-0006mf-CZ
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:27:13 -0400
Received: from ozlabs.org ([203.11.71.1]:48973)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iOmJr-0006iO-Uk; Sun, 27 Oct 2019 13:27:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 471Psw4XL2z9sPk; Mon, 28 Oct 2019 04:26:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1572197220;
 bh=G+AiNmC/Q6bUTpqHaRfmdj0D0YKshC8kv1JCL8mzxww=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Pfc7xYAoTLBNzo0NyCZtr2RawuzYAe2WWHr7OlLHVgOYBLWHw22GP1BYse3LB2zHk
 qSwUX1V+RX+mKisBA4NAr5sskcQbrDQQ2atDGpn4yms9JLtj5PuKHpqdxb8HGsAeJk
 Gxse+egpDq9pj4UFc3EY2kB5Jd5FGVIOYPy41XMI=
Date: Sun, 27 Oct 2019 18:01:49 +0100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 5/6] spapr: Don't use CPU_FOREACH() in 'info pic'
Message-ID: <20191027170149.GF3552@umbus.metropole.lan>
References: <157184231371.3053790.17713393349394736594.stgit@bahia.lan>
 <157184234176.3053790.8577967462603127139.stgit@bahia.lan>
 <20191024030231.GV6439@umbus.fritz.box>
 <20191024112845.43005bae@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Content-Disposition: inline
In-Reply-To: <20191024112845.43005bae@bahia.lan>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 11:28:45AM +0200, Greg Kurz wrote:
> On Thu, 24 Oct 2019 14:02:31 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Oct 23, 2019 at 04:52:21PM +0200, Greg Kurz wrote:
> > > Now that presenter objects are parented to the interrupt controller, =
stop
> > > relying on CPU_FOREACH() which can race with CPU hotplug and crash QE=
MU.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> >=20
> > So.. we might be able to go further than this.  Having the
> > TYPE_INTERRUPT_STATS_PROVIDER interrupt on the machine is actually an
> > spapr and pnv oddity.  In most cases that interface is on the various
> > components of the interrupt controller directly.  hmp_info_irq() scans
> > the whole QOM tree looking for everything with the interface to
> > produce the info pic output.
> >=20
> > It would be nice if we can do the same for xics and xive.  The tricky
> > bit is that we do have the possibility of both, in which case the
> > individual components would need to know if they're currently "active"
> > and minimize their output if so.
> >=20
>=20
> Yes but this looks like 4.3 material. If we want to fix this for 4.2,
> I'm now thinking it might be safer to keep CPU_FOREACH() and check the
> state.

Yeah, for 4.2 that sounds like a good idea.

>=20
> > > ---
> > >  hw/intc/spapr_xive.c  |    8 +-------
> > >  hw/intc/xics.c        |   12 ++++++++++++
> > >  hw/intc/xics_spapr.c  |    8 +-------
> > >  hw/intc/xive.c        |   12 ++++++++++++
> > >  include/hw/ppc/xics.h |    1 +
> > >  include/hw/ppc/xive.h |    2 ++
> > >  6 files changed, 29 insertions(+), 14 deletions(-)
> > >=20
> > > diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> > > index d74ee71e76b4..05763a58cf5d 100644
> > > --- a/hw/intc/spapr_xive.c
> > > +++ b/hw/intc/spapr_xive.c
> > > @@ -579,14 +579,8 @@ static void spapr_xive_set_irq(SpaprInterruptCon=
troller *intc, int irq, int val)
> > >  static void spapr_xive_print_info(SpaprInterruptController *intc, Mo=
nitor *mon)
> > >  {
> > >      SpaprXive *xive =3D SPAPR_XIVE(intc);
> > > -    CPUState *cs;
> > > -
> > > -    CPU_FOREACH(cs) {
> > > -        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > > -
> > > -        xive_tctx_pic_print_info(spapr_cpu_state(cpu)->tctx, mon);
> > > -    }
> > > =20
> > > +    xive_presenter_print_info(XIVE_ROUTER(intc), mon);
> > >      spapr_xive_pic_print_info(xive, mon);
> > >  }
> > > =20
> > > diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> > > index d5e4db668a4b..6e820c4851f3 100644
> > > --- a/hw/intc/xics.c
> > > +++ b/hw/intc/xics.c
> > > @@ -88,6 +88,18 @@ void ics_pic_print_info(ICSState *ics, Monitor *mo=
n)
> > >      }
> > >  }
> > > =20
> > > +static int do_ics_pic_print_icp_infos(Object *child, void *opaque)
> > > +{
> > > +    icp_pic_print_info(ICP(child), opaque);
> > > +    return 0;
> > > +}
> > > +
> > > +void ics_pic_print_icp_infos(ICSState *ics, const char *type, Monito=
r *mon)
> > > +{
> > > +    object_child_foreach_type(OBJECT(ics), type, do_ics_pic_print_ic=
p_infos,
> > > +                              mon);
> > > +}
> > > +
> > >  /*
> > >   * ICP: Presentation layer
> > >   */
> > > diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> > > index 080ed73aad64..7624d693c8da 100644
> > > --- a/hw/intc/xics_spapr.c
> > > +++ b/hw/intc/xics_spapr.c
> > > @@ -400,14 +400,8 @@ static void xics_spapr_set_irq(SpaprInterruptCon=
troller *intc, int irq, int val)
> > >  static void xics_spapr_print_info(SpaprInterruptController *intc, Mo=
nitor *mon)
> > >  {
> > >      ICSState *ics =3D ICS_SPAPR(intc);
> > > -    CPUState *cs;
> > > -
> > > -    CPU_FOREACH(cs) {
> > > -        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > > -
> > > -        icp_pic_print_info(spapr_cpu_state(cpu)->icp, mon);
> > > -    }
> > > =20
> > > +    ics_pic_print_icp_infos(ics, TYPE_ICP, mon);
> > >      ics_pic_print_info(ics, mon);
> > >  }
> > > =20
> > > diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> > > index 8d2da4a11163..40ce43152456 100644
> > > --- a/hw/intc/xive.c
> > > +++ b/hw/intc/xive.c
> > > @@ -547,6 +547,18 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Mo=
nitor *mon)
> > >      }
> > >  }
> > > =20
> > > +static int do_xive_presenter_print_info(Object *child, void *opaque)
> > > +{
> > > +    xive_tctx_pic_print_info(XIVE_TCTX(child), opaque);
> > > +    return 0;
> > > +}
> > > +
> > > +void xive_presenter_print_info(XiveRouter *xrtr, Monitor *mon)
> > > +{
> > > +    object_child_foreach_type(OBJECT(xrtr), TYPE_XIVE_TCTX,
> > > +                              do_xive_presenter_print_info, mon);
> > > +}
> > > +
> > >  void xive_tctx_reset(XiveTCTX *tctx)
> > >  {
> > >      memset(tctx->regs, 0, sizeof(tctx->regs));
> > > diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> > > index f4827e748fd8..4de1f421c997 100644
> > > --- a/include/hw/ppc/xics.h
> > > +++ b/include/hw/ppc/xics.h
> > > @@ -175,6 +175,7 @@ static inline bool ics_irq_free(ICSState *ics, ui=
nt32_t srcno)
> > >  void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
> > >  void icp_pic_print_info(ICPState *icp, Monitor *mon);
> > >  void ics_pic_print_info(ICSState *ics, Monitor *mon);
> > > +void ics_pic_print_icp_infos(ICSState *ics, const char *type, Monito=
r *mon);
> > > =20
> > >  void ics_resend(ICSState *ics);
> > >  void icp_resend(ICPState *ss);
> > > diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> > > index 8fd439ec9bba..14690428a0aa 100644
> > > --- a/include/hw/ppc/xive.h
> > > +++ b/include/hw/ppc/xive.h
> > > @@ -367,6 +367,8 @@ int xive_router_write_nvt(XiveRouter *xrtr, uint8=
_t nvt_blk, uint32_t nvt_idx,
> > >  XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs);
> > >  void xive_router_notify(XiveNotifier *xn, uint32_t lisn);
> > > =20
> > > +void xive_presenter_print_info(XiveRouter *xrtr, Monitor *mon);
> > > +
> > >  /*
> > >   * XIVE END ESBs
> > >   */
> > >=20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl21zX0ACgkQbDjKyiDZ
s5L3dg//SfamaBPCU1y2PnLSmHkWyH+U2ligqMMD2vv0Aq1rFWmfb0krwIIy4Skq
nhhgVpraaT3/qAKMdvPJhiAlFlaCq0tQex8GadNxX4HPspBBkCoZTF9UnIxCn3qq
TITxl1na3r6oanCMX3qeGcBSYJgRxsTb3OASjTKscACWgN6QNARTif5jI8D7gtp/
vqsc9KrsYE7KxTSZlvpu9TN9o9rIHXHMc8iid3EJRDE6VcOP+3Rnk3Pkk5OW4WSi
uTRLVP4clgxtYwIEICh6T9dRj7fCjjpl1rnu9sjQcBdOgf0nXx9ScEK6QdXEqpUs
uTGKteTellHvnyHJmcfoEl7q3QaShOiby1j1t6Bhle3NTCPnBRXyqYJLCVyfo633
HyQoORGbEySzY6GxcdMEk3Jq+L8qFmlEa5g8owlGXLErgElZLgKHEc6oUyw7atZX
vWlz6qdasmWTI3Z9QcVQGN9bHTKzt54KXtg4doUwpu/rOV9mjAvu8Lm5/y4PqvWG
fKJe+Rf6Puhjo2qokK60p2F3bS7GIssjyEKcSG3JTH3Oc64W55/BqFPx69gcL7mx
/ZfWeh/pDcZO6t3G0w+l0tEqGQkEaFXkMMA/LGrdafGAvGmfPOJIOdYUH3D3eO5R
SzPRNgShl3bmz4bwzS36OYtqM6gadj7wZMp+3TG9IzCzpNarWMU=
=aT1w
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--

