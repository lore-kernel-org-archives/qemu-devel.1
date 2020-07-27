Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CF2C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 03:33:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CC79206D8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 03:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fzjfPkvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC79206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jztss-0000Cd-AA
	for qemu-devel@archiver.kernel.org; Sun, 26 Jul 2020 23:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jztsE-00087a-VU; Sun, 26 Jul 2020 23:32:23 -0400
Received: from ozlabs.org ([203.11.71.1]:42421)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jztsC-0007mi-70; Sun, 26 Jul 2020 23:32:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BFQN70JDVz9sRR; Mon, 27 Jul 2020 13:32:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595820727;
 bh=uJn5ORwu0qPSWmqnRqmzpk9jmmLyYU1l667TuWDKoX8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fzjfPkvVnsMS90UtfM3HBijPkTNj4eWRAc39fp5vKb/U3IINMWQdobUapaE2CMr23
 HM7HL2aKQui4nnNDGbvXjBn3xN51d4sDEaQp020fwGQ64j0VumLzBek4RJlGQZtq2P
 LCeK/1NsB8CSVaxWKSK5Wbb7AducT25iNHNlc47Y=
Date: Mon, 27 Jul 2020 13:29:04 +1000
From: "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
To: Matthieu Bucchianeri <matthieu.bucchianeri@leostella.com>
Subject: Re: [PATCH] target/ppc: Fix SPE unavailable exception triggering
Message-ID: <20200727032904.GD84173@umbus.fritz.box>
References: <20200725191436.31828-1-matthieu.bucchianeri@leostella.com>
 <alpine.BSF.2.22.395.2007261202050.35472@zero.eik.bme.hu>
 <SN5P110MB05433223A83842B1686867CB84750@SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Content-Disposition: inline
In-Reply-To: <SN5P110MB05433223A83842B1686867CB84750@SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/26 23:32:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2020 at 04:59:16PM +0000, Matthieu Bucchianeri wrote:
> Hello Balaton,
>=20
> Thank you for your thorough review! See my response below.
>=20
> > > static inline void gen_evmwsmiaa(DisasContext *ctx) {
> > > -    TCGv_i64 acc =3D tcg_temp_new_i64();
> > > -    TCGv_i64 tmp =3D tcg_temp_new_i64();
> > > +    TCGv_i64 acc;
> > > +    TCGv_i64 tmp;
> > > +
> > > +    if (unlikely(!ctx->spe_enabled)) {
> > > +        gen_exception(ctx, POWERPC_EXCP_SPEU);
> > > +        return;
> > > +    }
> >
> > Isn't this missing here:
> >
> > acc =3D tcg_temp_new_i64();
> > tmp =3D tcg_temp_new_i64();
> >
> > You've removed allocating temps but this hunk does not add it back afte=
r the
> > exception unlike others in this patch.
>=20
> I should have probably mentioned somewhere that this patch also
> fixes a resource leak in that function. It is not very obvious
> when looking at it as a patch, but if you take a look at the
> original code, you will see that I removed these allocations on
> purpose:
>=20
>
>https://github.com/qemu/qemu/blob/d577dbaac7553767232faabb6a3e291aebd348ae=
/target/ppc/translate/spe-impl.inc.c#L532

Ok, can you please split the memory leak fix into a separate patch to
make this easier to review.

>=20
> > static inline void gen_evmwsmiaa(DisasContext *ctx)
> > {
> >     TCGv_i64 acc =3D tcg_temp_new_i64();
> >     TCGv_i64 tmp =3D tcg_temp_new_i64();
> >
> >     gen_evmwsmi(ctx);           /* rD :=3D rA * rB */
> >
> >     acc =3D tcg_temp_new_i64();
> >     tmp =3D tcg_temp_new_i64();
>=20
> I apologize for not making this any more clear in my description.
>=20
> Let me know if this looks correct now, with the full context in mind.
>=20
> Thanks.
>=20
> LeoStella, LLC
> A joint venture of Thales Alenia Space and Spaceflight Industries
>=20
> 12501 E Marginal Way S =E2=80=A2 Tukwila, WA 98168
>=20
> Proprietary Document: This document may contain trade secrets or otherwis=
e proprietary and confidential information owned by LeoStella LLC. It is in=
tended only for the individual addressee and may not be copied, distributed=
, or otherwise disclosed without LeoStella LLC express prior written author=
ization.
> Export Controlled: This document may contain technical data whose export =
is restricted by the Arms Export Control Act (Title 22, U.S.C., Sec 2751 et=
 seq.) or the Export Administration Act of 1979, as amended, Title 50,U.S.C=
=2E, app 2401 et seq. Violation of these export laws are subject to severe =
criminal penalties. Recipient shall not export, re-export, or otherwise tra=
nsfer or share this document to any foreign person (as defined by U.S. expo=
rt laws) without advance written authorization from LeoStella LLC.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8eSf0ACgkQbDjKyiDZ
s5KP1A//QJAVt3wEuta/P2NaO3xXXLZhUfLkRTss75JLQbqQ6LZQ93RLbObw+AXS
BHNDwLkr8SF+9clIO6SgyfYsy16pGXGXAgo1F6Pcx+OYfzZcmXrqr4yzVLYNQ2zF
T+e7THPQ5sYKn+2hWi2x0QcFBmzH+mLtjRGtA/A30S3Ix8i0IjVLyZVh5mfSJP/w
LoeQBUw0FIMx6AuLyBR2/8nfH412S/ZsDEUpMKkJXh4Njhw/qj12W91GUVMplPZ2
MM4bEGE6CIY6C5I2Baim+r9BeQ24xcG+zaeG7H9G2+I/ryCyeSCnJQjzbDJv0W8q
0hTiwdiNtfdDpOLj9n5COhJqEqIhIitESefR7GHEcA03Z/PuEHp4p9GZWaKrl1ia
hVrPKxGCbJzM5wdW2KWeb34uwafztBtvZRevdRWDIK2czjLao3tJ+sQLA2zH2/rd
bJTBqMrU6hiUQRtokBtcyaF7zisI1Z2dHMHpC6O99QjmqewWPnGLTM01OuQROD+R
WzRJjagFkMBajIA/AHuerrlhoEOUSosG2PvP2JBLX+s/NPgDPnALvezs1vUTOX1L
Cr5JPwnBX3KRqkmLv0wsGDi20HRC1PxU7c8oBdJPIqV/6DglCH9ti2MzpbldaiWs
+/7q/tpSAAUBl0Fs7fVymsk4PEtsEZynezDG5UnuBTIxJ83kMbA=
=mM0x
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--

