Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F37C742A5
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 01:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF77221019
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 01:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MPgZ3YUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF77221019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlkEx-00034Q-NE
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 21:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55596)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hlkEb-0001wd-8V
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 21:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hlkEZ-0003QD-3F
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 21:20:25 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52273 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hlkEV-0003IJ-E3; Thu, 11 Jul 2019 21:20:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45lFTm49nDz9sNC; Fri, 12 Jul 2019 11:20:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562894412;
 bh=ylPjztC5oACG24YcLbQv4exUPvBxICo7ZDsHz5JGzkI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MPgZ3YUZL9VlsDEQZrZttiT7t2QBBQzc99aIei0RuOGWzB19dkz0xczSFqSZHOYkX
 tAs5jW52ZK/NgAafysITl6sKyPyZgJ629S90isDeC/wLprGtN+c9qHsHZxbVNwJIpu
 p4ssmckzZODOI91vsEw2HhqGCes1/ZHe5NKnx7EA=
Date: Fri, 12 Jul 2019 11:15:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190712011527.GB2561@umbus.fritz.box>
References: <20190630204601.30574-1-clg@kaod.org>
 <20190630204601.30574-9-clg@kaod.org>
 <20190703020748.GD9442@umbus.fritz.box>
 <08faf669-72a7-8f30-d33c-2e285405005c@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <08faf669-72a7-8f30-d33c-2e285405005c@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 08/10] ppc/xive: Extend XiveTCTX with an
 router object pointer
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2019 at 07:54:57AM +0200, C=E9dric Le Goater wrote:
> On 03/07/2019 04:07, David Gibson wrote:
> > On Sun, Jun 30, 2019 at 10:45:59PM +0200, C=E9dric Le Goater wrote:
> >> This is to perform lookups in the NVT table when a vCPU is dispatched
> >> and possibly resend interrupts.
> >=20
> > I'm slightly confused by this one.  Aren't there multiple router
> > objects, each of which can deliver to any thread?  In which case what
> > router object is associated with a specific TCTX?
>=20
> when a vCPU is dispatched on a HW thread, the hypervisor does a store=20
> on the CAM line to store the VP id. At that time, it checks the IPB in=20
> the associated NVT structure and notifies the thread if an interrupt is=
=20
> pending.=20
>=20
> We need to do a NVT lookup, just like the presenter in HW, hence the=20
> router pointer. You should look at the following patch which clarifies=20
> the resend sequence.

Hm, ok.

> >> Future XIVE chip will use a different class for the model of the
> >> interrupt controller. So use an 'Object *' instead of a 'XiveRouter *'.
> >=20
> > This seems odd to me, shouldn't it be an interface pointer or
> > something in that case?
>=20
> I have duplicated most of the XIVE models for P10 because the internal=20
> structures have changed. I managed to keep the XiveSource and XiveTCTX=20
> but we now have a Xive10Router, this is the reason why.

Right, but XiveRouter and Xive10Router must have something in common
if they can both be used here.  Usually that's expressed as a shared
QOM interface - in which case you can use a pointer to the interface,
rathe than using Object * which kind of implies *anything* can go
here.

>=20
> If I was to duplicate XiveTCTX also, I will switch it back to a XiveRoute=
r=20
> pointer in the P9 version.=20
>=20
> C.
>=20
>=20
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> >> ---
> >>  include/hw/ppc/xive.h |  4 +++-
> >>  hw/intc/xive.c        | 11 ++++++++++-
> >>  hw/ppc/pnv.c          |  2 +-
> >>  hw/ppc/spapr_irq.c    |  2 +-
> >>  4 files changed, 15 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> >> index d922524982d3..b764e1e4e6d4 100644
> >> --- a/include/hw/ppc/xive.h
> >> +++ b/include/hw/ppc/xive.h
> >> @@ -321,6 +321,8 @@ typedef struct XiveTCTX {
> >>      qemu_irq    os_output;
> >> =20
> >>      uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
> >> +
> >> +    Object      *xrtr;
> >>  } XiveTCTX;
> >> =20
> >>  /*
> >> @@ -416,7 +418,7 @@ void xive_tctx_tm_write(XiveTCTX *tctx, hwaddr off=
set, uint64_t value,
> >>  uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr offset, unsigned si=
ze);
> >> =20
> >>  void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
> >> -Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
> >> +Object *xive_tctx_create(Object *cpu, Object *xrtr, Error **errp);
> >> =20
> >>  static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nv=
t_idx)
> >>  {
> >> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> >> index f7ba1c3b622f..56700681884f 100644
> >> --- a/hw/intc/xive.c
> >> +++ b/hw/intc/xive.c
> >> @@ -573,6 +573,14 @@ static void xive_tctx_realize(DeviceState *dev, E=
rror **errp)
> >>      Object *obj;
> >>      Error *local_err =3D NULL;
> >> =20
> >> +    obj =3D object_property_get_link(OBJECT(dev), "xrtr", &local_err);
> >> +    if (!obj) {
> >> +        error_propagate(errp, local_err);
> >> +        error_prepend(errp, "required link 'xrtr' not found: ");
> >> +        return;
> >> +    }
> >> +    tctx->xrtr =3D obj;
> >> +
> >>      obj =3D object_property_get_link(OBJECT(dev), "cpu", &local_err);
> >>      if (!obj) {
> >>          error_propagate(errp, local_err);
> >> @@ -657,7 +665,7 @@ static const TypeInfo xive_tctx_info =3D {
> >>      .class_init    =3D xive_tctx_class_init,
> >>  };
> >> =20
> >> -Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)
> >> +Object *xive_tctx_create(Object *cpu, Object *xrtr, Error **errp)
> >>  {
> >>      Error *local_err =3D NULL;
> >>      Object *obj;
> >> @@ -666,6 +674,7 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *=
xrtr, Error **errp)
> >>      object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort);
> >>      object_unref(obj);
> >>      object_property_add_const_link(obj, "cpu", cpu, &error_abort);
> >> +    object_property_add_const_link(obj, "xrtr", xrtr, &error_abort);
> >>      object_property_set_bool(obj, true, "realized", &local_err);
> >>      if (local_err) {
> >>          goto error;
> >> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> >> index b87e01e5b925..11916dc273c2 100644
> >> --- a/hw/ppc/pnv.c
> >> +++ b/hw/ppc/pnv.c
> >> @@ -765,7 +765,7 @@ static void pnv_chip_power9_intc_create(PnvChip *c=
hip, PowerPCCPU *cpu,
> >>       * controller object is initialized afterwards. Hopefully, it's
> >>       * only used at runtime.
> >>       */
> >> -    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(&chip9->xive), =
&local_err);
> >> +    obj =3D xive_tctx_create(OBJECT(cpu), OBJECT(&chip9->xive), &loca=
l_err);
> >>      if (local_err) {
> >>          error_propagate(errp, local_err);
> >>          return;
> >> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> >> index b2b01e850de8..5b3c3c50967b 100644
> >> --- a/hw/ppc/spapr_irq.c
> >> +++ b/hw/ppc/spapr_irq.c
> >> @@ -353,7 +353,7 @@ static void spapr_irq_cpu_intc_create_xive(SpaprMa=
chineState *spapr,
> >>      Object *obj;
> >>      SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> >> =20
> >> -    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(spapr->xive), &=
local_err);
> >> +    obj =3D xive_tctx_create(OBJECT(cpu), OBJECT(spapr->xive), &local=
_err);
> >>      if (local_err) {
> >>          error_propagate(errp, local_err);
> >>          return;
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0n3y8ACgkQbDjKyiDZ
s5KFxw//UkzbhQZ2OW8SebuSKq8jlv7JvDcAcpbxRdKlF1Prgmp2ZsX5WwK+h+js
cP9gc7afJlSbCRzLT1FJsvpHE7jj+l+G2kC4R221BrZ1+a/F7HdSH8Z/s/TYEghN
fa1NSoFtXr1tOljaKgV36kzIjuBquGVw/6iHW/Lnn1MI7sOchYuh9q9ZHmWufIDr
Ywnl5SzGQv3F6nZllf2wjf0pRsvbJOzHCZ5w4+JAE7hkA8R3kk0a2U9ZO8kU6cHA
YtFdhRcdS0Wp43aPrMMPHkf0Lb7bDIT4rMBp+BmPprUK+B4R+gE6OjkEFK9qHrQC
PPB/w4mCHLCoiRl6OlHU0cXr1CZJazpqxv9o9yUExUWxA53w2a2tPM7yw5jd1+Jd
WELJzjaMqEE5y7vkXVzXmu8ycux1BnEtHmCGNgCSpEjW2dUL3OimBHQ38MbPRT+Z
T9OlgonVtPs5i7vZ+OY5V/tWWXm7HJPYrFBSjVRPfRBSPoJpWVhU7WvHJyJuPH2L
kSGp1TpoIlqCL6/nW8BlMe9prElD7qt2VAbbZTWuHr3BQLGYcPeZqPYDXozGGFXn
qxoVFjTMD0JGvA5/Ur1sVxFPtu6YTTJore0OSLibfKOT4jX/z9wlWRqZjmxEnCx3
uzmxoYPsznkG9dcZc580nZcFSwuqXIAJoHVaHBc79kGGziqxMIk=
=kd4a
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--

