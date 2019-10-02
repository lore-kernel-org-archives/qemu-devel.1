Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ACCC35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 14:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF6F3215EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 14:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6F3215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFfWu-0005LV-0S
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 10:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iFfVr-0004Mi-3R
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 10:21:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iFfVp-00055T-Ao
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 10:21:54 -0400
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:46101)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iFfVp-00053F-3f
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 10:21:53 -0400
Received: from player759.ha.ovh.net (unknown [10.109.160.23])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 23EED10CCC9
 for <qemu-devel@nongnu.org>; Wed,  2 Oct 2019 16:21:48 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player759.ha.ovh.net (Postfix) with ESMTPSA id 15BC1A867E10;
 Wed,  2 Oct 2019 14:21:44 +0000 (UTC)
Date: Wed, 2 Oct 2019 16:21:42 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] spapr/xive: skip partially initialized vCPUs in presenter
Message-ID: <20191002162142.7ce18dcb@bahia.lan>
In-Reply-To: <20191002010245.GT11105@umbus.fritz.box>
References: <20191001085722.32755-1-clg@kaod.org>
 <20191001130614.226ef6a2@bahia.w3ibm.bluemix.net>
 <fad6aae9-8722-498c-730d-fa204f07e3c5@kaod.org>
 <20191001185629.0b284ba1@bahia.lan>
 <20191002010245.GT11105@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j2.Mqap+/iKgTsK6KMCJWew";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 12861154639510804966
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeeigdejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.39.154
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
Cc: qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/j2.Mqap+/iKgTsK6KMCJWew
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Oct 2019 11:02:45 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Oct 01, 2019 at 06:56:28PM +0200, Greg Kurz wrote:
> > On Tue, 1 Oct 2019 13:56:10 +0200
> > C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >=20
> > > On 01/10/2019 13:06, Greg Kurz wrote:
> > > > On Tue,  1 Oct 2019 10:57:22 +0200
> > > > C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> > > >=20
> > > >> When vCPUs are hotplugged, they are added to the QEMU CPU list bef=
ore
> > > >> being fully realized. This can crash the XIVE presenter because the
> > > >> 'tctx' pointer is not necessarily initialized when looking for a
> > > >> matching target.
> > > >>
> > > >=20
> > > > Ouch... :-\
> > > >=20
> > > >> These vCPUs are not valid targets for the presenter. Skip them.
> > > >>
> > > >=20
> > > > This likely fixes this specific issue, but more generally, this
> > > > seems to indicate that using CPU_FOREACH() is rather fragile.
> > > >=20
> > > > What about tracking XIVE TM contexts with a QLIST in xive.c ?
> > >=20
> > > This is a good idea. =20
> > >=20
> > > On HW, the thread interrupt contexts belong to the XIVE presenter=20
> > > subengine. This is the logic doing the CAM line matching to find
> > > a target for an event notification. So we should model the context=20
> > > list below the XiveRouter in QEMU which models both router and=20
> > > presenter subengines. We have done without a presenter model for=20
> > > the moment and I don't think we will need to introduce one. =20
> > >=20
> > > This would be a nice improvements of my patchset adding support
> > > for xive escalations and better support of multi chip systems.=20
> > > I have introduced a PNV_CHIP_CPU_FOREACH in this patchset which=20
> > > would become useless with a list of tctx under the XIVE interrupt
> > > controller, XiveRouter, SpaprXive, PnvXive.
> > >=20
> >=20
> > I agree. It makes more sense to have the list below the XiveRouter,
> > rather than relying on CPU_FOREACH(), which looks a bit weird from
> > a device emulation code perspective.
>=20
> That does sound like a better idea long term.  However, for now, I
> think the NULL check is a reasonable way of fixing the real error
> we're hitting, so I've applied the patch here.
>=20

Fair enough.

Reviewed-by: Greg Kurz <groug@kaod.org>

> Future cleanups to a different approach remain welcome, of course.
>=20

I've started to look. This should simplify Cedric's "add XIVE support
for KVM guests" series, but I'll wait for your massive cleanup series
to get merged first.

> > > Next step would be to get rid of the tctx->cs pointer. In my latest
> > > patches, it is only used to calculate the HW CAM line.=20
> > >=20
> > > There might be some consequences on the object hierarchy and it will
> > > break migration.
> > >=20
> >=20
> > This could break if the contexts were devices sitting in a bus, which
> > isn't the case here. I'll try to come up with a proposal for spapr,
> > and we can work out the changes on your recent XIVE series for pnv.
> >=20
> > > Thanks,
> > >=20
> > > C.
> > >=20
> > > >=20
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > > > diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> > > > index 6d38755f8459..89b9ef7f20b1 100644
> > > > --- a/include/hw/ppc/xive.h
> > > > +++ b/include/hw/ppc/xive.h
> > > > @@ -319,6 +319,8 @@ typedef struct XiveTCTX {
> > > >      qemu_irq    os_output;
> > > > =20
> > > >      uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
> > > > +
> > > > +    QTAILQ_ENTRY(XiveTCTX) next;
> > > >  } XiveTCTX;
> > > > =20
> > > >  /*
> > > > diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> > > > index b7417210d817..f7721c711041 100644
> > > > --- a/hw/intc/xive.c
> > > > +++ b/hw/intc/xive.c
> > > > @@ -568,6 +568,8 @@ static void xive_tctx_reset(void *dev)
> > > >          ipb_to_pipr(tctx->regs[TM_QW3_HV_PHYS + TM_IPB]);
> > > >  }
> > > > =20
> > > > +static QTAILQ_HEAD(, XiveTCTX) xive_tctx_list =3D QTAILQ_HEAD_INIT=
IALIZER(xive_tctx_list);
> > > > +
> > > >  static void xive_tctx_realize(DeviceState *dev, Error **errp)
> > > >  {
> > > >      XiveTCTX *tctx =3D XIVE_TCTX(dev);
> > > > @@ -609,10 +611,14 @@ static void xive_tctx_realize(DeviceState *de=
v, Error **errp)
> > > >      }
> > > > =20
> > > >      qemu_register_reset(xive_tctx_reset, dev);
> > > > +    QTAILQ_INSERT_HEAD(&xive_tctx_list, tctx, next);
> > > >  }
> > > > =20
> > > >  static void xive_tctx_unrealize(DeviceState *dev, Error **errp)
> > > >  {
> > > > +    XiveTCTX *tctx =3D XIVE_TCTX(dev);
> > > > +
> > > > +    QTAILQ_REMOVE(&xive_tctx_list, tctx, next);
> > > >      qemu_unregister_reset(xive_tctx_reset, dev);
> > > >  }
> > > > =20
> > > > @@ -1385,15 +1391,14 @@ static bool xive_presenter_match(XiveRouter=
 *xrtr, uint8_t format,
> > > >                                   bool cam_ignore, uint8_t priority,
> > > >                                   uint32_t logic_serv, XiveTCTXMatc=
h *match)
> > > >  {
> > > > -    CPUState *cs;
> > > > +    XiveTCTX *tctx;
> > > > =20
> > > >      /*
> > > >       * TODO (PowerNV): handle chip_id overwrite of block field for
> > > >       * hardwired CAM compares
> > > >       */
> > > > =20
> > > > -    CPU_FOREACH(cs) {
> > > > -        XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs);
> > > > +    QTAILQ_FOREACH(tctx, &xive_tctx_list, next) {
> > > >          int ring;
> > > > =20
> > > >          /*
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > > >=20
> > > >> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > > >> ---
> > > >>  hw/intc/xive.c | 8 ++++++++
> > > >>  1 file changed, 8 insertions(+)
> > > >>
> > > >> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> > > >> index b7417210d817..29df06df1136 100644
> > > >> --- a/hw/intc/xive.c
> > > >> +++ b/hw/intc/xive.c
> > > >> @@ -1396,6 +1396,14 @@ static bool xive_presenter_match(XiveRouter=
 *xrtr, uint8_t format,
> > > >>          XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs);
> > > >>          int ring;
> > > >> =20
> > > >> +        /*
> > > >> +         * Skip partially initialized vCPUs. This can happen when
> > > >> +         * vCPUs are hotplugged.
> > > >> +         */
> > > >> +        if (!tctx) {
> > > >> +            continue;
> > > >> +        }
> > > >> +
> > > >>          /*
> > > >>           * HW checks that the CPU is enabled in the Physical Thre=
ad
> > > >>           * Enable Register (PTER).
> > > >=20
> > >=20
> >=20
>=20


--Sig_/j2.Mqap+/iKgTsK6KMCJWew
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl2UsnYACgkQcdTV5YIv
c9ZF3A//aSfvAdnhmwPXsXpL6psgK3Z1NMLTPaYOSP/raX1mY0hIJDJ1fnQQUyLk
LHabTDSa1zUBe9aefeKYSdxb0VHVH091XGoWCPMl0F1jVu9LPvkjFY4TcFEGjhbV
qpIwgtTev8684kanKhEOOp2BSEiOSTzFEa/OuBd26UL7QZE/Ppvb2rMP8syCmpN9
/kx9WZGmN9ifHqxb42cWXg6UYZyOnYguLYEPmxnrs828DmRlkNCCDenOy9JUMPYG
HZ8rfhEI74u4B6/rHS23GaFbgiVfb7d+9cMbXLZZf+ANYvYIhxLTQFTzOZmm6878
YuNGunWCOG6lLRVDm2sq0mIiILEM+F2/3TuBx2YJ51wGaOxC1vCFPfrwcBz4Kqkq
y2RMSCLF/zNewE6wwNyNQCpWejMRl7wKIGKrMBNjDPywhLFvpRu2VBI7yP01yF5m
kZP9HAXapKa2qidhk8Wh220TTMHBj+04bCREuoy0sDSbHtMSbqYRnGraWb1ldJis
wDpTnGT7sI70pB2ojYMcvGwa43xRySCiIBU/sVcsEG5sH59crwSV/pFhtHLWGogL
VF958nZ5XuhIleyBnun/cnGYpIOpCOLxUlD0fzyi6KereVX/VTyZ+zpsGBwAJI1J
9/2h7Oe6261Ir6i31Rql9ly9LLzlEzIzcgiWiw2wdPplbw/MNxY=
=LYji
-----END PGP SIGNATURE-----

--Sig_/j2.Mqap+/iKgTsK6KMCJWew--

