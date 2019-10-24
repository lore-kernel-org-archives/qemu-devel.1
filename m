Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D16CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:06:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7FB205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7FB205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNa0Z-0000eU-SO
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iNZQS-00012N-43
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iNZQQ-0004DG-7i
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:29:00 -0400
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:39566)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iNZQP-0004Cj-SU
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:28:58 -0400
Received: from player730.ha.ovh.net (unknown [10.109.146.137])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 8242D1B0719
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 11:28:55 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player730.ha.ovh.net (Postfix) with ESMTPSA id 7D319B36B026;
 Thu, 24 Oct 2019 09:28:49 +0000 (UTC)
Date: Thu, 24 Oct 2019 11:28:45 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 5/6] spapr: Don't use CPU_FOREACH() in 'info pic'
Message-ID: <20191024112845.43005bae@bahia.lan>
In-Reply-To: <20191024030231.GV6439@umbus.fritz.box>
References: <157184231371.3053790.17713393349394736594.stgit@bahia.lan>
 <157184234176.3053790.8577967462603127139.stgit@bahia.lan>
 <20191024030231.GV6439@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Sw8TTc3ySUnpCs7zuV=Aa4H";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 7986852464264190438
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrledugdduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.181.248
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
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/Sw8TTc3ySUnpCs7zuV=Aa4H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Oct 2019 14:02:31 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Oct 23, 2019 at 04:52:21PM +0200, Greg Kurz wrote:
> > Now that presenter objects are parented to the interrupt controller, st=
op
> > relying on CPU_FOREACH() which can race with CPU hotplug and crash QEMU.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> So.. we might be able to go further than this.  Having the
> TYPE_INTERRUPT_STATS_PROVIDER interrupt on the machine is actually an
> spapr and pnv oddity.  In most cases that interface is on the various
> components of the interrupt controller directly.  hmp_info_irq() scans
> the whole QOM tree looking for everything with the interface to
> produce the info pic output.
>=20
> It would be nice if we can do the same for xics and xive.  The tricky
> bit is that we do have the possibility of both, in which case the
> individual components would need to know if they're currently "active"
> and minimize their output if so.
>=20

Yes but this looks like 4.3 material. If we want to fix this for 4.2,
I'm now thinking it might be safer to keep CPU_FOREACH() and check the
state.

> > ---
> >  hw/intc/spapr_xive.c  |    8 +-------
> >  hw/intc/xics.c        |   12 ++++++++++++
> >  hw/intc/xics_spapr.c  |    8 +-------
> >  hw/intc/xive.c        |   12 ++++++++++++
> >  include/hw/ppc/xics.h |    1 +
> >  include/hw/ppc/xive.h |    2 ++
> >  6 files changed, 29 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> > index d74ee71e76b4..05763a58cf5d 100644
> > --- a/hw/intc/spapr_xive.c
> > +++ b/hw/intc/spapr_xive.c
> > @@ -579,14 +579,8 @@ static void spapr_xive_set_irq(SpaprInterruptContr=
oller *intc, int irq, int val)
> >  static void spapr_xive_print_info(SpaprInterruptController *intc, Moni=
tor *mon)
> >  {
> >      SpaprXive *xive =3D SPAPR_XIVE(intc);
> > -    CPUState *cs;
> > -
> > -    CPU_FOREACH(cs) {
> > -        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > -
> > -        xive_tctx_pic_print_info(spapr_cpu_state(cpu)->tctx, mon);
> > -    }
> > =20
> > +    xive_presenter_print_info(XIVE_ROUTER(intc), mon);
> >      spapr_xive_pic_print_info(xive, mon);
> >  }
> > =20
> > diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> > index d5e4db668a4b..6e820c4851f3 100644
> > --- a/hw/intc/xics.c
> > +++ b/hw/intc/xics.c
> > @@ -88,6 +88,18 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon)
> >      }
> >  }
> > =20
> > +static int do_ics_pic_print_icp_infos(Object *child, void *opaque)
> > +{
> > +    icp_pic_print_info(ICP(child), opaque);
> > +    return 0;
> > +}
> > +
> > +void ics_pic_print_icp_infos(ICSState *ics, const char *type, Monitor =
*mon)
> > +{
> > +    object_child_foreach_type(OBJECT(ics), type, do_ics_pic_print_icp_=
infos,
> > +                              mon);
> > +}
> > +
> >  /*
> >   * ICP: Presentation layer
> >   */
> > diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> > index 080ed73aad64..7624d693c8da 100644
> > --- a/hw/intc/xics_spapr.c
> > +++ b/hw/intc/xics_spapr.c
> > @@ -400,14 +400,8 @@ static void xics_spapr_set_irq(SpaprInterruptContr=
oller *intc, int irq, int val)
> >  static void xics_spapr_print_info(SpaprInterruptController *intc, Moni=
tor *mon)
> >  {
> >      ICSState *ics =3D ICS_SPAPR(intc);
> > -    CPUState *cs;
> > -
> > -    CPU_FOREACH(cs) {
> > -        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > -
> > -        icp_pic_print_info(spapr_cpu_state(cpu)->icp, mon);
> > -    }
> > =20
> > +    ics_pic_print_icp_infos(ics, TYPE_ICP, mon);
> >      ics_pic_print_info(ics, mon);
> >  }
> > =20
> > diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> > index 8d2da4a11163..40ce43152456 100644
> > --- a/hw/intc/xive.c
> > +++ b/hw/intc/xive.c
> > @@ -547,6 +547,18 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Moni=
tor *mon)
> >      }
> >  }
> > =20
> > +static int do_xive_presenter_print_info(Object *child, void *opaque)
> > +{
> > +    xive_tctx_pic_print_info(XIVE_TCTX(child), opaque);
> > +    return 0;
> > +}
> > +
> > +void xive_presenter_print_info(XiveRouter *xrtr, Monitor *mon)
> > +{
> > +    object_child_foreach_type(OBJECT(xrtr), TYPE_XIVE_TCTX,
> > +                              do_xive_presenter_print_info, mon);
> > +}
> > +
> >  void xive_tctx_reset(XiveTCTX *tctx)
> >  {
> >      memset(tctx->regs, 0, sizeof(tctx->regs));
> > diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> > index f4827e748fd8..4de1f421c997 100644
> > --- a/include/hw/ppc/xics.h
> > +++ b/include/hw/ppc/xics.h
> > @@ -175,6 +175,7 @@ static inline bool ics_irq_free(ICSState *ics, uint=
32_t srcno)
> >  void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
> >  void icp_pic_print_info(ICPState *icp, Monitor *mon);
> >  void ics_pic_print_info(ICSState *ics, Monitor *mon);
> > +void ics_pic_print_icp_infos(ICSState *ics, const char *type, Monitor =
*mon);
> > =20
> >  void ics_resend(ICSState *ics);
> >  void icp_resend(ICPState *ss);
> > diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> > index 8fd439ec9bba..14690428a0aa 100644
> > --- a/include/hw/ppc/xive.h
> > +++ b/include/hw/ppc/xive.h
> > @@ -367,6 +367,8 @@ int xive_router_write_nvt(XiveRouter *xrtr, uint8_t=
 nvt_blk, uint32_t nvt_idx,
> >  XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, CPUState *cs);
> >  void xive_router_notify(XiveNotifier *xn, uint32_t lisn);
> > =20
> > +void xive_presenter_print_info(XiveRouter *xrtr, Monitor *mon);
> > +
> >  /*
> >   * XIVE END ESBs
> >   */
> >=20
>=20


--Sig_/Sw8TTc3ySUnpCs7zuV=Aa4H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl2xbs0ACgkQcdTV5YIv
c9ZVHg/9FR6YWDwO6IIDz/J/S2VrT/2k6oMdH0sDPPVDCmThAQpy2VQFjr9NXNib
nWsI1JPKllraVPKtC9Vk1H4VooNibUV5TEMIg5qE0KJq50cWOwGYDR/uppQ9TpQk
tHfXfqlcnC10eV60LTXYq4pud5aABHjKJ1bHVgww0AMKyVS+JQ8HVmJnBMiU++ES
+zFKyh6XVWZjy+JqlqgxNPMBirc0Cg4gSBDTBlhdnaGOwD894z3hyDtMATj0Jc8k
/Sat3Rx22tdSCOzFWwXwN/u+PdjgQwvuvP4RTOp8JOCNLykPD7wIusmJ+kDxY99V
jMtQXfVj48ejp9MzIxZUNBj6Jxsod/Da10rYYBVy9I+GtOG64VcDrnTTbz2bm4KV
4TITZFmG2QaN9SWfGIfV2p4RTJjm5V4jntzWhsM2JNle1Cx5tI2h8RvugkJgqm0B
kTW+wL7M5I+9HDacpjaaHqLUMQOfmVZsqbqMHmLC4RKpU/jSNO1r6OpP1IB96E+I
bOUcOd3AtpLe5Gc8fqAm8Gl4f6Yb/2IHQHUDFxmtBOrdKDeZGvmF20WIuD6nj46m
Nwm2+cmeAZYKNSapzpQDcOzOWaqHhc1tu40pUQsN5q9WwPgHGrV4/LaxKmaENSJL
67Bdgfsx/c7oOOimLZzzdqLFcTSHAIBIevsXzsaTtnTlplQSWiY=
=Yqop
-----END PGP SIGNATURE-----

--Sig_/Sw8TTc3ySUnpCs7zuV=Aa4H--

