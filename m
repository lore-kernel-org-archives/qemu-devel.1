Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491B8C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 12:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F18217D4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 12:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mrxnDTEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F18217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42008 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTQ2t-0004je-4U
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 08:08:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTQ1R-000409-P7
	for qemu-devel@nongnu.org; Wed, 22 May 2019 08:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTQ1Q-0002Qf-Ds
	for qemu-devel@nongnu.org; Wed, 22 May 2019 08:07:05 -0400
Received: from ozlabs.org ([203.11.71.1]:52165)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hTQ1O-00029S-6x; Wed, 22 May 2019 08:07:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 458BFJ4y9Xz9s9y; Wed, 22 May 2019 22:06:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558526804;
	bh=DHZ8bAnjLgFt+T/KMKgONnPGVbJnsaEGujaUWT6WBaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mrxnDTEmMqmcUg8OmRfosQ9ASbkKKC5Z3PSTIgwU8mzRjnbyT8uSn9E7qqme8xtnM
	oGjjEWk9mJ7pfRkRC6+tNwrQQuSYXDkDeXk/WAJJjhCNDhK3hOT6RG49rAYqrDclT7
	mmQYsL5eieOgo9m7Pl2MkECO/Rn02uh7d0b/lD+g=
Date: Wed, 22 May 2019 21:10:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190522111035.GI30423@umbus.fritz.box>
References: <20190522044600.16534-1-david@gibson.dropbear.id.au>
	<20190522044600.16534-22-david@gibson.dropbear.id.au>
	<20190522095829.7b688f35@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kH8JNVvasRCCW1Oz"
Content-Disposition: inline
In-Reply-To: <20190522095829.7b688f35@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PULL 21/38] spapr: Add forgotten capability to
 migration stream
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, peter.maydell@linaro.org, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--kH8JNVvasRCCW1Oz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2019 at 09:58:29AM +0200, Greg Kurz wrote:
> On Wed, 22 May 2019 14:45:43 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > spapr machine capabilities are supposed to be sent in the migration str=
eam
> > so that we can sanity check the source and destination have compatible
> > configuration.  Unfortunately, when we added the hpt-max-page-size
> > capability, we forgot to add it to the migration state.  This means tha=
t we
> > can generate spurious warnings when both ends are configured for large
> > pages, or potentially fail to warn if the source is configured for huge
> > pages, but the destination is not.
> >=20
> > Fixes: 2309832afda "spapr: Maximum (HPT) pagesize property"
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
> > ---
>=20
> Huh... we discussed that it was breaking backward migration:
>=20
> https://lists.gnu.org/archive/html/qemu-ppc/2019-05/msg00330.html
>=20
> So I'm a bit surprised to see this in the PR... is it intentional ?

Sod, no, I forgot to remove it from my tree.

Having been through the test cycle, I'd prefer not to hold up the PR
for this - as long as we fix it before the release we should be ok.

>=20
> >  hw/ppc/spapr.c         | 1 +
> >  hw/ppc/spapr_caps.c    | 1 +
> >  include/hw/ppc/spapr.h | 1 +
> >  3 files changed, 3 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 8580a8dc67..bcae30ad26 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2125,6 +2125,7 @@ static const VMStateDescription vmstate_spapr =3D=
 {
> >          &vmstate_spapr_cap_cfpc,
> >          &vmstate_spapr_cap_sbbc,
> >          &vmstate_spapr_cap_ibs,
> > +        &vmstate_spapr_cap_hpt_maxpagesize,
> >          &vmstate_spapr_irq_map,
> >          &vmstate_spapr_cap_nested_kvm_hv,
> >          &vmstate_spapr_dtb,
> > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > index 9b1c10baa6..658eb15a14 100644
> > --- a/hw/ppc/spapr_caps.c
> > +++ b/hw/ppc/spapr_caps.c
> > @@ -703,6 +703,7 @@ SPAPR_CAP_MIG_STATE(dfp, SPAPR_CAP_DFP);
> >  SPAPR_CAP_MIG_STATE(cfpc, SPAPR_CAP_CFPC);
> >  SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
> >  SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
> > +SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
> >  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
> >  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
> >  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index 7e32f309c2..9fc91c8f5e 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -849,6 +849,7 @@ extern const VMStateDescription vmstate_spapr_cap_d=
fp;
> >  extern const VMStateDescription vmstate_spapr_cap_cfpc;
> >  extern const VMStateDescription vmstate_spapr_cap_sbbc;
> >  extern const VMStateDescription vmstate_spapr_cap_ibs;
> > +extern const VMStateDescription vmstate_spapr_cap_hpt_maxpagesize;
> >  extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
> >  extern const VMStateDescription vmstate_spapr_cap_large_decr;
> >  extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kH8JNVvasRCCW1Oz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzlLikACgkQbDjKyiDZ
s5ID9hAA3+xwkQ97Ez/X74mwbzFwBhYZYE4wigJTNdDHb3/TvH1Q76L3tgRBDP21
OZd70qYqh1XIxQ5XUAPgeKKX6R2oaiUGY6fvugQFkcspTU+42/ZO1pwjUYCeGsVT
1Ba8tK0Qjg5LA5VtzcfJR5QrKJupwLDJrMS0i4XtgETgo5mksKs9sS5XkKUhpmud
cf9p0+EilmvvqCuNup8XQSe/DMeN6Pg+LKG8tutdvCQ9+r7YUQWXH8jv2phoI3xP
ZYjvq/VokMMrKMG53SnUZcNYSTuIIf7AQnY08fATd1yXa7CxUhdZ3RO3wOYnHrLp
8gxOlDxo7hio+NuazkMY/VgWRw1J4veB7U0GM6ANPEQNL/hd2/NJSMxIoMITzHVb
yv11M/l781w/hZ9RVkaE7Dy1FDU8CEUFcz1kZDk6mPwbcJGimeXnQyRYfKw+a1fB
0WYBmcGtRW/bIy/yrgdnFhWUPXRtAcU5lPgfi8cjodYq5kP1LDQMvHSAypb6yhjX
uI7Lw8OR4+eVtyV5fr4npuoxsDAtlYKuEgs4CV8Fg847oX+xI10j+/3ORfen5kIu
agAEVysbwC1a1HO2bM2JAFKrlvMq5u95+V/o04so5zcLPusYLeTA1+2WSoWNUoqF
DcjZ1ZIg3mNzAuwl5otqwbV5KkwaG0IrAFL5h5bYbuT6A24DCXA=
=rBJY
-----END PGP SIGNATURE-----

--kH8JNVvasRCCW1Oz--

