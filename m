Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BE2C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 05:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B6A2086A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 05:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XWQb1MfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B6A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFXda-0000yR-UC
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 01:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFXcI-0008QW-Lk
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 01:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFXcH-0002qD-AL
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 01:56:02 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40843 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFXcE-0002m5-RC; Wed, 02 Oct 2019 01:56:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46jlk23zf3z9sPj; Wed,  2 Oct 2019 15:55:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569995754;
 bh=Z1bwhWWIYAVdT4U0xE2M2wK0E82KIX1evAW2Zfth2OM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XWQb1MfOVYLpMNvNr6DPr2P9h2ZDWlHhGVF8Ue6Be6NfG/FnIQXbtTy8O6BkFxGao
 OAyeNJp9GQAMnwMoOGct4ZObGu9bMiLGOiCbbwj1fpS478OEtFHZ6lWTprnk+UkmoO
 xOnAtL2ePypFJshgHFgppeKqUTSdvCXxJVVMtLi0=
Date: Wed, 2 Oct 2019 15:55:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 01/34] xics: Minor fixes for XICSFabric interface
Message-ID: <20191002055551.GV11105@umbus.fritz.box>
References: <20191002025208.3487-1-david@gibson.dropbear.id.au>
 <20191002025208.3487-2-david@gibson.dropbear.id.au>
 <2297d0ee-ff47-c000-5e6d-eb6aba83c456@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SidV/bKy1CyabPX8"
Content-Disposition: inline
In-Reply-To: <2297d0ee-ff47-c000-5e6d-eb6aba83c456@kaod.org>
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--SidV/bKy1CyabPX8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2019 at 07:51:45AM +0200, C=E9dric Le Goater wrote:
> On 02/10/2019 04:51, David Gibson wrote:
> > Interface instances should never be directly dereferenced.  So, the com=
mon
> > practice is to make them incomplete types to make sure no-one does that.
> > XICSFrabric, however, had a dummy type which is less safe.
> >=20
> > We were also using OBJECT_CHECK() where we should have been using
> > INTERFACE_CHECK().
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>

Uhhh... you sent me an R-b line for Greg, not yourself...

>=20
> > ---
> >  include/hw/ppc/xics.h | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >=20
> > diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> > index 64a2c8862a..faa33ae943 100644
> > --- a/include/hw/ppc/xics.h
> > +++ b/include/hw/ppc/xics.h
> > @@ -147,13 +147,9 @@ struct ICSIRQState {
> >      uint8_t flags;
> >  };
> > =20
> > -struct XICSFabric {
> > -    Object parent;
> > -};
> > -
> >  #define TYPE_XICS_FABRIC "xics-fabric"
> >  #define XICS_FABRIC(obj)                                     \
> > -    OBJECT_CHECK(XICSFabric, (obj), TYPE_XICS_FABRIC)
> > +    INTERFACE_CHECK(XICSFabric, (obj), TYPE_XICS_FABRIC)
> >  #define XICS_FABRIC_CLASS(klass)                                     \
> >      OBJECT_CLASS_CHECK(XICSFabricClass, (klass), TYPE_XICS_FABRIC)
> >  #define XICS_FABRIC_GET_CLASS(obj)                                   \
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SidV/bKy1CyabPX8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2UO+QACgkQbDjKyiDZ
s5K4qhAAhsN2C2w3B2u6+1KdDmVM5Ff0wuY8AS6SXh3A+GJ12+Webs37aW0039iM
g75SVMIcpztncOHXOacKhdpJxW6qkivHN7r5DoFB+WlFGrsxhYOeCTlI8IFBb+uH
g2cmCPmZrcTmumhmq2rkaIWN3IKDe8+zdzYz20vLleNshC8Nn2w1oIESxx9MDHbI
HvF/JetQiht414zEtTBJfrnW4Ps/15XUWV/c34YDNiXhusAODY0N9MdRrgn1ulzW
3/y6IlFi0gUusmJE1D2j01X4SvHVItP64ntRg/iUTpxpNPvuB1lhxzAmp9G4uTot
NXgJmheDqD0sJGKmbohf3uXoko7bW0rgpXv6P3jWNDNFZx/AxCEqFFdR9C49iRkL
Dr8mhvGVK/10jePAG+qxyqS/6Gqga8FFvfuzHzU1HfHWDq8Lo3PDbmXrthE0aAD8
bWNiv+EHYrfO1xr+Kptk2bNQbxAHRKbgsQKUV4akrOCI73lxN8AGt1weQuwDgLWA
ZkewRJ0YhTZwL6K45wgjQu+hbacyEZXd+Re0CC4xQXl10ug0z+m29mJUCt8lcVfc
i6hfWE474nXQXHo88VljeElcHr4XYcwCE7oa54eqCfdDpj4K9WVZ/FUSkU2k33iF
EdmtrJWWRQcuuLqmZP1oGubFrqcFq9fSeoITrWXQ2X7pjQ2783s=
=ovPB
-----END PGP SIGNATURE-----

--SidV/bKy1CyabPX8--

