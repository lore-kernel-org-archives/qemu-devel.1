Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C685CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 17:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8081720679
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 17:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aZRLBAZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8081720679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOmRQ-00073Q-4m
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 13:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iOmJt-0004NE-1D
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iOmJo-0006hw-76
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:27:12 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36807 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iOmJn-0006aU-Bd; Sun, 27 Oct 2019 13:27:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 471Psw0pbjz9sPV; Mon, 28 Oct 2019 04:26:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1572197220;
 bh=aE0vFQ/p6WYTNj5cDAiWHO1SMNg8rFZGYc+EVMdE/PY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aZRLBAZ9/5b4538MqndmbdNv5ug9nb2+BzSFJxTNSpPHPofZXCnb08DBAMiCulzTH
 D5CDc6TK8hvO3A6Mlbw2qfVjeO1WQW8PqryivLYY4YHG2Z3Br2ECHZ+y28Vw6DO+ks
 tUoATcBWcHUbivoAfeyN/IQXw9XhTsDz0t8tWd2c=
Date: Sun, 27 Oct 2019 17:54:36 +0100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v5 4/7] ppc/pnv: Add a PnvChip pointer to PnvCore
Message-ID: <20191027165436.GD3552@umbus.metropole.lan>
References: <20191022163812.330-1-clg@kaod.org>
 <20191022163812.330-5-clg@kaod.org>
 <20191024023812.GO6439@umbus.fritz.box>
 <20191024193030.40ee674e@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Content-Disposition: inline
In-Reply-To: <20191024193030.40ee674e@bahia.lan>
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 07:30:30PM +0200, Greg Kurz wrote:
> On Thu, 24 Oct 2019 13:38:12 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Oct 22, 2019 at 06:38:09PM +0200, C=E9dric Le Goater wrote:
> > > We will use it to reset the interrupt presenter from the CPU reset
> > > handler.
> > >=20
> > > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > > Reviewed-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  include/hw/ppc/pnv_core.h | 3 +++
> > >  hw/ppc/pnv_core.c         | 3 ++-
> > >  2 files changed, 5 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> > > index bfbd2ec42aa6..55eee95104da 100644
> > > --- a/include/hw/ppc/pnv_core.h
> > > +++ b/include/hw/ppc/pnv_core.h
> > > @@ -31,6 +31,8 @@
> > >  #define PNV_CORE_GET_CLASS(obj) \
> > >       OBJECT_GET_CLASS(PnvCoreClass, (obj), TYPE_PNV_CORE)
> > > =20
> > > +typedef struct PnvChip PnvChip;
> > > +
> > >  typedef struct PnvCore {
> > >      /*< private >*/
> > >      CPUCore parent_obj;
> > > @@ -38,6 +40,7 @@ typedef struct PnvCore {
> > >      /*< public >*/
> > >      PowerPCCPU **threads;
> > >      uint32_t pir;
> > > +    PnvChip *chip;
> >=20
> > I don't love having this as a redundant encoding of the information
> > already in the property, since it raises the possibility of confusing
> > bugs if they ever got out of sync.
> >=20
>=20
> Ouch, we also have this pattern in xive_tctx_realize(). The XiveTCXT
> object has both a "cpu" property and a pointer to the vCPU.
>=20
> > It's not a huge deal, but it would be nice to at least to at least
> > consider either a) grabbing the property everywhere you need it (if
> > there aren't too many places) or b) customizing the property
> > definition so it's written directly into that field.
> >=20
>=20
> The pointer to the vCPU is used among other things to get the
> value of the PIR, which is needed by the presenting logic to
> match physical CAM lines. This is a _hot_ path so it's probably
> better to go for b).

Agreed.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl21y8wACgkQbDjKyiDZ
s5J3RQ/9HoGXIWU8VZ2CSKmllMdSZY6B45jDu7UFuJ0LeE3mLeLve3VgrMYIl4uk
2e/G6fhqa9xXOHI578k7pe3SGX/9mw6h53SVQb7a5Yl+5eXlFGuNxycLiVXWtjdb
RNLaHYp22ZIf4f4Iz+E2BtYzdqg7WAT/EENZHx+Ypw0LrrBJnT00cWu+iHhJp6/C
dGLdUep/BTckpdCtPZQgWjRyh09TTQPhuvplEcLBSF3QzkR1EOkuHrPOELCftNTt
AnVx/3BH0k5vopAEChoOFbkzATKI9QtJXl9/vTki50IVuYxWx+dVbCRn524Pw2qe
hhHdFHChJqQB/+EYTttU8tUMf9+6JxZyTpNcafxV0xkM81CH1j9np/onzBB3CROJ
L1j2qteEsB0OA+oIXYOmnLVYXbCOtIyIFRSzDPug8x1cbfVkj/B9n/UkzAeq8krT
LyujMwKfnv8HvIda9NhDIZvbWJf3qnqyxyMnMSOUOvCEC4IdkwvR36ZeXvy8MAH0
e9+3uH/DM33Q76/Xo79CjleT26dic/wLhOY5VCbCs1FEncpWNqU24s3nEB2P6ehM
z+JeOLsgxIJWRX/OMuf8WOQAalvQaNqWbmF8+TbTOfvEwXP3Hmc0RuR/lQ/PtLu6
roLn8oBqBbOftqN4BaqtfZfUNMcnHswGzkDK/nBX33+d2j2Lwu0=
=nInS
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--

