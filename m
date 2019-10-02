Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2128EECE587
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E026420815
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MyvJTkpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E026420815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFTua-0003iL-61
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 21:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFT2t-0007mu-Vt
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 21:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFT2q-0007PG-KN
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 21:03:11 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50443 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFT2l-0007J1-Va; Tue, 01 Oct 2019 21:03:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46jdD327dcz9sPk; Wed,  2 Oct 2019 11:02:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569978179;
 bh=ToJkGaiWKKb4yJHLkhlNi2eQqGgd7t2rBI4ENm/jlOA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MyvJTkpYjtRBImIW6p8qwLZra8fTrbOoEdnN6OfISKhA8CjfDgzLy/7Y5tCT2Kdv/
 jZ8JuIiJa6JtyZnE43Jl2vezruErZmepDhPJXMQdaLaTD38VUOXBawFFXB7VOdoM48
 jSUHcpWYLZSr0uQE1zdRyxG5TyijttzZ8w69gRLo=
Date: Wed, 2 Oct 2019 11:02:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] spapr/xive: skip partially initialized vCPUs in presenter
Message-ID: <20191002010245.GT11105@umbus.fritz.box>
References: <20191001085722.32755-1-clg@kaod.org>
 <20191001130614.226ef6a2@bahia.w3ibm.bluemix.net>
 <fad6aae9-8722-498c-730d-fa204f07e3c5@kaod.org>
 <20191001185629.0b284ba1@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2wYUONsACSj9OMJp"
Content-Disposition: inline
In-Reply-To: <20191001185629.0b284ba1@bahia.lan>
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2wYUONsACSj9OMJp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2019 at 06:56:28PM +0200, Greg Kurz wrote:
> On Tue, 1 Oct 2019 13:56:10 +0200
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > On 01/10/2019 13:06, Greg Kurz wrote:
> > > On Tue,  1 Oct 2019 10:57:22 +0200
> > > C=E9dric Le Goater <clg@kaod.org> wrote:
> > >=20
> > >> When vCPUs are hotplugged, they are added to the QEMU CPU list before
> > >> being fully realized. This can crash the XIVE presenter because the
> > >> 'tctx' pointer is not necessarily initialized when looking for a
> > >> matching target.
> > >>
> > >=20
> > > Ouch... :-\
> > >=20
> > >> These vCPUs are not valid targets for the presenter. Skip them.
> > >>
> > >=20
> > > This likely fixes this specific issue, but more generally, this
> > > seems to indicate that using CPU_FOREACH() is rather fragile.
> > >=20
> > > What about tracking XIVE TM contexts with a QLIST in xive.c ?
> >=20
> > This is a good idea. =20
> >=20
> > On HW, the thread interrupt contexts belong to the XIVE presenter=20
> > subengine. This is the logic doing the CAM line matching to find
> > a target for an event notification. So we should model the context=20
> > list below the XiveRouter in QEMU which models both router and=20
> > presenter subengines. We have done without a presenter model for=20
> > the moment and I don't think we will need to introduce one. =20
> >=20
> > This would be a nice improvements of my patchset adding support
> > for xive escalations and better support of multi chip systems.=20
> > I have introduced a PNV_CHIP_CPU_FOREACH in this patchset which=20
> > would become useless with a list of tctx under the XIVE interrupt
> > controller, XiveRouter, SpaprXive, PnvXive.
> >=20
>=20
> I agree. It makes more sense to have the list below the XiveRouter,
> rather than relying on CPU_FOREACH(), which looks a bit weird from
> a device emulation code perspective.

That does sound like a better idea long term.  However, for now, I
think the NULL check is a reasonable way of fixing the real error
we're hitting, so I've applied the patch here.

Future cleanups to a different approach remain welcome, of course.

> > Next step would be to get rid of the tctx->cs pointer. In my latest
> > patches, it is only used to calculate the HW CAM line.=20
> >=20
> > There might be some consequences on the object hierarchy and it will
> > break migration.
> >=20
>=20
> This could break if the contexts were devices sitting in a bus, which
> isn't the case here. I'll try to come up with a proposal for spapr,
> and we can work out the changes on your recent XIVE series for pnv.
>=20
> > Thanks,
> >=20
> > C.
> >=20
> > >=20
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> > > index 6d38755f8459..89b9ef7f20b1 100644
> > > --- a/include/hw/ppc/xive.h
> > > +++ b/include/hw/ppc/xive.h
> > > @@ -319,6 +319,8 @@ typedef struct XiveTCTX {
> > >      qemu_irq    os_output;
> > > =20
> > >      uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
> > > +
> > > +    QTAILQ_ENTRY(XiveTCTX) next;
> > >  } XiveTCTX;
> > > =20
> > >  /*
> > > diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> > > index b7417210d817..f7721c711041 100644
> > > --- a/hw/intc/xive.c
> > > +++ b/hw/intc/xive.c
> > > @@ -568,6 +568,8 @@ static void xive_tctx_reset(void *dev)
> > >          ipb_to_pipr(tctx->regs[TM_QW3_HV_PHYS + TM_IPB]);
> > >  }
> > > =20
> > > +static QTAILQ_HEAD(, XiveTCTX) xive_tctx_list =3D QTAILQ_HEAD_INITIA=
LIZER(xive_tctx_list);
> > > +
> > >  static void xive_tctx_realize(DeviceState *dev, Error **errp)
> > >  {
> > >      XiveTCTX *tctx =3D XIVE_TCTX(dev);
> > > @@ -609,10 +611,14 @@ static void xive_tctx_realize(DeviceState *dev,=
 Error **errp)
> > >      }
> > > =20
> > >      qemu_register_reset(xive_tctx_reset, dev);
> > > +    QTAILQ_INSERT_HEAD(&xive_tctx_list, tctx, next);
> > >  }
> > > =20
> > >  static void xive_tctx_unrealize(DeviceState *dev, Error **errp)
> > >  {
> > > +    XiveTCTX *tctx =3D XIVE_TCTX(dev);
> > > +
> > > +    QTAILQ_REMOVE(&xive_tctx_list, tctx, next);
> > >      qemu_unregister_reset(xive_tctx_reset, dev);
> > >  }
> > > =20
> > > @@ -1385,15 +1391,14 @@ static bool xive_presenter_match(XiveRouter *=
xrtr, uint8_t format,
> > >                                   bool cam_ignore, uint8_t priority,
> > >                                   uint32_t logic_serv, XiveTCTXMatch =
*match)
> > >  {
> > > -    CPUState *cs;
> > > +    XiveTCTX *tctx;
> > > =20
> > >      /*
> > >       * TODO (PowerNV): handle chip_id overwrite of block field for
> > >       * hardwired CAM compares
> > >       */
> > > =20
> > > -    CPU_FOREACH(cs) {
> > > -        XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs);
> > > +    QTAILQ_FOREACH(tctx, &xive_tctx_list, next) {
> > >          int ring;
> > > =20
> > >          /*
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > >> ---
> > >>  hw/intc/xive.c | 8 ++++++++
> > >>  1 file changed, 8 insertions(+)
> > >>
> > >> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> > >> index b7417210d817..29df06df1136 100644
> > >> --- a/hw/intc/xive.c
> > >> +++ b/hw/intc/xive.c
> > >> @@ -1396,6 +1396,14 @@ static bool xive_presenter_match(XiveRouter *=
xrtr, uint8_t format,
> > >>          XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs);
> > >>          int ring;
> > >> =20
> > >> +        /*
> > >> +         * Skip partially initialized vCPUs. This can happen when
> > >> +         * vCPUs are hotplugged.
> > >> +         */
> > >> +        if (!tctx) {
> > >> +            continue;
> > >> +        }
> > >> +
> > >>          /*
> > >>           * HW checks that the CPU is enabled in the Physical Thread
> > >>           * Enable Register (PTER).
> > >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2wYUONsACSj9OMJp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2T9zMACgkQbDjKyiDZ
s5KY+g/+IAlHnz7hpfvnxWK+HBcWhakc0Zdt8nlaeAl7ZnpVwy36DmvWUvXLvpZs
PeIEp2C9ANwfkcleRV80avQttiDn3/XvzuXvBKTnNcz2gIh3RknAiQjDJGleyj0d
xjbVT3SXaJOfsudvR+OWYQ+sAn5JsYOpfaCziY3Xl/9hP/DJiG5GkEYyy78mMPXO
Bjj/Yng8uo9CHz1en8ZJCIr4SV0VHJHuC7SQ1qr+YPleh20koh/XtjbgYDIM0rtL
ei55T7C76bUfHgrjs7d76zKPA9+bp/UuKgHkVZWKiNzfKTYpGvtNzWCsR+lfATHe
MIIkt4XEFxnc2bN+Bt3DgD1Y6gzBf4HRQlIZJkxls6ckuF1303owZQZrDZPfzsYz
wk588VEn9sJgEXd95B4u3JEKj8sAWNB3pgh1u5zH8HyWcnADUWxIQDXO9RCd0nqf
2nbUCHrsM+sziDonsgeiyy7ojiQUPR+4XiJD9OW97HLjA/OBc+Mf8fxeX/aolKhQ
eCK7Yebj0gSw0CkaFCWHd/HvmNnH/hGn6IdzQ+hEUx9Cb9yBDSqooP+Nz+chjKj9
Ll2enaJedCf8hQv+ClmVWn44SK6Rqos2y2LlYxIBgj8VwvBKncUI6e1R6r331CWJ
CS9/bJt0GLd3GtCufArTB+TpDxnpFrCfr8Axn5CQ3Mvp1I6YFQ8=
=ThYT
-----END PGP SIGNATURE-----

--2wYUONsACSj9OMJp--

