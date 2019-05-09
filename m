Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC68C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 05:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88E12053B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 05:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XRgNzj4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88E12053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48312 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hObq7-0004Ph-VL
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 01:43:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOboe-0003PS-OK
	for qemu-devel@nongnu.org; Thu, 09 May 2019 01:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hObod-0001eY-NY
	for qemu-devel@nongnu.org; Thu, 09 May 2019 01:42:00 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45357 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hOboc-0001ZE-EQ; Thu, 09 May 2019 01:41:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4502KB4MDXz9s9T; Thu,  9 May 2019 15:41:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557380510;
	bh=tXm3lezdxbT3V4gm9pF7Fa/ClfAaKdaWIJYjbznMKSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XRgNzj4DU0+XU+gNmOQlJHHEYajwUpmg+EO4CUVbKtgXlLVCQo+yA1aCx3D70iflU
	ssvBglLyVB/lDcZzMyM0vCgMWXv7e0BvLJky/VHlAEhYI/0vhb/ZpKiNc4jYstd/S7
	KwThqwMt4a/V7z+JYIGqWExUvMLC4h6WzweY40ok=
Date: Thu, 9 May 2019 15:35:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@ozlabs.org>
Message-ID: <20190509053522.GR7073@umbus.fritz.box>
References: <20190507004811.29968-1-anton@ozlabs.org>
	<20190507004811.29968-4-anton@ozlabs.org>
	<20190507052815.GK7073@umbus.fritz.box>
	<c69c4513-417b-8415-c48b-61d0a05c1680@ilande.co.uk>
	<20190509103324.7ce48de7@kryten>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5xr6Gr0irOxp3+3c"
Content-Disposition: inline
In-Reply-To: <20190509103324.7ce48de7@kryten>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 4/9] target/ppc: Fix lxvw4x,
 lxvh8x and lxvb16x
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
Cc: ego@linux.vnet.ibm.com, sandipandas1990@gmail.com,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	richard.henderson@linaro.org, qemu-devel@nongnu.org,
	f4bug@amsat.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5xr6Gr0irOxp3+3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2019 at 10:33:24AM +1000, Anton Blanchard wrote:
> Hi Mark,
>=20
> > Following on from this I've just gone through the load/store
> > operations once again and spotted two things:
> >=20
> >=20
> > 1) VSX_LOAD_SCALAR_DS has an extra get_cpu_vsrh() which can be removed
> >=20
> > diff --git a/target/ppc/translate/vsx-impl.inc.c
> > b/target/ppc/translate/vsx-impl.inc.c index 11d9b75d01..004ea56c4f
> > 100644 --- a/target/ppc/translate/vsx-impl.inc.c
> > +++ b/target/ppc/translate/vsx-impl.inc.c
> > @@ -329,7 +329,6 @@ static void gen_##name(DisasContext
> > *ctx)                         \
> > return;
> > \ }                                                             \ xth
> > =3D tcg_temp_new_i64();                                     \
> > -    get_cpu_vsrh(xth, rD(ctx->opcode) + 32);                      \
> >      gen_set_access_type(ctx, ACCESS_INT);                         \
> >      EA =3D tcg_temp_new();                                          \
> >      gen_addr_imm_index(ctx, EA, 0x03);                            \
>=20
> Looks good. I also noticed we had two stores that needed to be fixed:
>=20
> VSX_LOAD_SCALAR_DS(stxsd, st64_i64)
> VSX_LOAD_SCALAR_DS(stxssp, st32fs)
>=20
> > 2) VSX_VECTOR_LOAD_STORE is confusing and should be split into
> > separate VSX_VECTOR_LOAD and VSX_VECTOR_STORE macros
>=20
> Good idea. I also removed (what I assume) are redundant set_cpu_vsr*
> and get_cpu_vsr* calls.
>=20
> > Does that sound reasonable? I'm also thinking that we should consider
> > adding a CC to stable for patches 4, 5 and 9 in this series since
> > these are genuine regressions.
>=20
> Fine with me. If David agrees, I'm not sure if he can rebase them or
> if I can send them manually if they have been already committed.

Usually going to stable is just a matter of pinging Mike Roth and
getting him to include it.  I can queue if somewhere if you like, but
the stable cadance is so slow it tends to get forgotten a bit.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5xr6Gr0irOxp3+3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzTvBoACgkQbDjKyiDZ
s5J15w//SLsEV9m4a4/iZmVJdEZM1ZgSx44kVtHIX/LFaZ3+u9eB3ZbXwTa9cEYq
7sJAIAYSzsZDOhICgfuANEQTeT91x8bVpDYC+XJaEfGpGu++NyjV1ae0WASAj8tc
MDaORexv8b18MZIvJcYAxTT5sCu/Zwp/7RW4ILZ7S1NFXzTramg9i6JhTjur4H2p
HK/A7njFBUHBUEVYPyRmL1SOK8kmq2xgakzRnuDTQXrv49r7OAQPyyXXcSg8GEXf
m3oLmg/l6arO4cUd7SrPgGwUxl1A68PtjS9HWS4Kple/XDI6KhRQrzlBaX/qsGXK
YhADlCfXxwqW6Ifdgkk33X9Pd3G4ehzfWYgdEnX3kdXLxDZ0RAYiX/1nODLQXjjU
xuOjE1kLcca5tn+yQ3KDwoosVf0jCW6NNlWbvZdbJH/7ptb+8MB07y0C0DmlJ4NZ
ROI5NdWWTVymb85x7Ty7xmueKjDJuw0Olq0+xWq3GfEdQi3SSHiQlJjx5A23Cwjl
PQXqkREyjJIjph/IaNc2azknk9jmI6QhFT4HEFeGigkkmaoDFbry10LgMoDpYgkp
C7oFnMmqVZWPTcBxyOPC/8Xp/CCKBRNK7XWOMrHzoZmKDoH0tps1sfE+UH3s39tl
awfTYllWVdYiMVkL8P098fkievCfQf9T4u56k2MnJMHCjURru/E=
=gBVa
-----END PGP SIGNATURE-----

--5xr6Gr0irOxp3+3c--

