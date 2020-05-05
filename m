Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21032C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB3B920658
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="a8T3WzsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3B920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxY1-000455-2q
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jVxWB-0001KK-B3; Tue, 05 May 2020 09:21:51 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:42085)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jVxW9-0005Gk-4Z; Tue, 05 May 2020 09:21:50 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49GgNk6Q42z9sSW; Tue,  5 May 2020 23:21:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588684903;
 bh=PUTsjPhduyvC2ZKBTGR6sZ0iw0VQlw/rumIfug5o038=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a8T3WzsUgmW7sPOpVhsCAE4QSpjbfICwcykpEdUmzlloUEC9LvODR0mUY4cE4Vz+9
 Ka+sNUs5XyNno+44hopGFqYTZP2SWQj/CWPcfTHjN3ncD1IFxDkfXgR5Rkzs4ZPav2
 uCWeT31sUbRhA4xrr4g9SMPZ9VQjD9qY18GoafjE=
Date: Tue, 5 May 2020 22:37:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniele Buono <dbuono@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] target-ppc: fix rlwimi, rlwinm, rlwnm for Clang-9
Message-ID: <20200505123715.GE218517@umbus.fritz.box>
References: <20200501190913.25008-1-dbuono@linux.vnet.ibm.com>
 <20200501190913.25008-2-dbuono@linux.vnet.ibm.com>
 <20200505050815.GC218517@umbus.fritz.box>
 <6bce4a90-21c8-0533-e9c2-22fd770da3ee@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Content-Disposition: inline
In-Reply-To: <6bce4a90-21c8-0533-e9c2-22fd770da3ee@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, dbuono@us.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2020 at 08:26:48AM -0400, Daniele Buono wrote:
> On 5/5/2020 1:08 AM, David Gibson wrote:
> > On Fri, May 01, 2020 at 03:09:13PM -0400, Daniele Buono wrote:
> > > Starting with Clang v9, -Wtype-limits is implemented and triggers a
> > > few "result of comparison is always true" errors when compiling PPC32
> > > targets.
> > >=20
> > > The comparisons seem to be necessary only on PPC64, since the
> > > else branch in PPC32 only has a "g_assert_not_reached();" in all case=
s.
> > >=20
> > > This patch restructures the code so that PPC32 does not execute the
> > > check, while PPC64 works like before
> > >=20
> > > Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
> >=20
> > Urgh.  #ifdefs intertangled with if statements gets pretty ugly.  But,
> > then, it's already pretty ugly, so, applied.
> >=20
> Agreed, it's very ugly. After I sent the patch I thought of an alternative
> that looks like this:
>=20
> bool mask_in_32b =3D true;
>=20
> #if defined(TARGET_PPC64)
> if (mask > 0xffffffffu)
>   mask_in_32b =3D false;
> #endif
>=20
> if (mask_in_32b) {
> /* Original if-else untouched using mask_in_32b instead of mask*/
>=20
> It does have an additional if, but with a bit of luck the compiler may
> optimize it out (at least for the 32bit case).
> If you think the final outcome may be better, let me know and I'll send a
> patch v2 like that.

Yeah, that would be a bit nicer.  Please send the v2.

>=20
> > > ---
> > >   target/ppc/translate.c | 34 +++++++++++++++++++---------------
> > >   1 file changed, 19 insertions(+), 15 deletions(-)
> > >=20
> > > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > > index 807d14faaa..9400fa2c7c 100644
> > > --- a/target/ppc/translate.c
> > > +++ b/target/ppc/translate.c
> > > @@ -1882,6 +1882,7 @@ static void gen_rlwimi(DisasContext *ctx)
> > >           tcg_gen_deposit_tl(t_ra, t_ra, t_rs, sh, me - mb + 1);
> > >       } else {
> > >           target_ulong mask;
> > > +        TCGv_i32 t0;
> > >           TCGv t1;
> > >   #if defined(TARGET_PPC64)
> > > @@ -1891,20 +1892,20 @@ static void gen_rlwimi(DisasContext *ctx)
> > >           mask =3D MASK(mb, me);
> > >           t1 =3D tcg_temp_new();
> > > +#if defined(TARGET_PPC64)
> > >           if (mask <=3D 0xffffffffu) {
> > > -            TCGv_i32 t0 =3D tcg_temp_new_i32();
> > > +#endif
> > > +            t0 =3D tcg_temp_new_i32();
> > >               tcg_gen_trunc_tl_i32(t0, t_rs);
> > >               tcg_gen_rotli_i32(t0, t0, sh);
> > >               tcg_gen_extu_i32_tl(t1, t0);
> > >               tcg_temp_free_i32(t0);
> > > -        } else {
> > >   #if defined(TARGET_PPC64)
> > > +        } else {
> > >               tcg_gen_deposit_i64(t1, t_rs, t_rs, 32, 32);
> > >               tcg_gen_rotli_i64(t1, t1, sh);
> > > -#else
> > > -            g_assert_not_reached();
> > > -#endif
> > >           }
> > > +#endif
> > >           tcg_gen_andi_tl(t1, t1, mask);
> > >           tcg_gen_andi_tl(t_ra, t_ra, ~mask);
> > > @@ -1938,7 +1939,9 @@ static void gen_rlwinm(DisasContext *ctx)
> > >           me +=3D 32;
> > >   #endif
> > >           mask =3D MASK(mb, me);
> > > +#if defined(TARGET_PPC64)
> > >           if (mask <=3D 0xffffffffu) {
> > > +#endif
> > >               if (sh =3D=3D 0) {
> > >                   tcg_gen_andi_tl(t_ra, t_rs, mask);
> > >               } else {
> > > @@ -1949,15 +1952,13 @@ static void gen_rlwinm(DisasContext *ctx)
> > >                   tcg_gen_extu_i32_tl(t_ra, t0);
> > >                   tcg_temp_free_i32(t0);
> > >               }
> > > -        } else {
> > >   #if defined(TARGET_PPC64)
> > > +        } else {
> > >               tcg_gen_deposit_i64(t_ra, t_rs, t_rs, 32, 32);
> > >               tcg_gen_rotli_i64(t_ra, t_ra, sh);
> > >               tcg_gen_andi_i64(t_ra, t_ra, mask);
> > > -#else
> > > -            g_assert_not_reached();
> > > -#endif
> > >           }
> > > +#endif
> > >       }
> > >       if (unlikely(Rc(ctx->opcode) !=3D 0)) {
> > >           gen_set_Rc0(ctx, t_ra);
> > > @@ -1972,6 +1973,9 @@ static void gen_rlwnm(DisasContext *ctx)
> > >       TCGv t_rb =3D cpu_gpr[rB(ctx->opcode)];
> > >       uint32_t mb =3D MB(ctx->opcode);
> > >       uint32_t me =3D ME(ctx->opcode);
> > > +    TCGv_i32 t0;
> > > +    TCGv_i32 t1;
> > > +
> > >       target_ulong mask;
> > >   #if defined(TARGET_PPC64)
> > > @@ -1980,9 +1984,11 @@ static void gen_rlwnm(DisasContext *ctx)
> > >   #endif
> > >       mask =3D MASK(mb, me);
> > > +#if defined(TARGET_PPC64)
> > >       if (mask <=3D 0xffffffffu) {
> > > -        TCGv_i32 t0 =3D tcg_temp_new_i32();
> > > -        TCGv_i32 t1 =3D tcg_temp_new_i32();
> > > +#endif
> > > +        t0 =3D tcg_temp_new_i32();
> > > +        t1 =3D tcg_temp_new_i32();
> > >           tcg_gen_trunc_tl_i32(t0, t_rb);
> > >           tcg_gen_trunc_tl_i32(t1, t_rs);
> > >           tcg_gen_andi_i32(t0, t0, 0x1f);
> > > @@ -1990,17 +1996,15 @@ static void gen_rlwnm(DisasContext *ctx)
> > >           tcg_gen_extu_i32_tl(t_ra, t1);
> > >           tcg_temp_free_i32(t0);
> > >           tcg_temp_free_i32(t1);
> > > -    } else {
> > >   #if defined(TARGET_PPC64)
> > > +    } else {
> > >           TCGv_i64 t0 =3D tcg_temp_new_i64();
> > >           tcg_gen_andi_i64(t0, t_rb, 0x1f);
> > >           tcg_gen_deposit_i64(t_ra, t_rs, t_rs, 32, 32);
> > >           tcg_gen_rotl_i64(t_ra, t_ra, t0);
> > >           tcg_temp_free_i64(t0);
> > > -#else
> > > -        g_assert_not_reached();
> > > -#endif
> > >       }
> > > +#endif
> > >       tcg_gen_andi_tl(t_ra, t_ra, mask);
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6xXfgACgkQbDjKyiDZ
s5IXbQ/+O90Mk+9l8lELvX92xtpyu6Hwk9lxaSgc3O1kuC7RnaD4YUTpomKxHQjl
4j7Md15yXogshhr44qyCV1Ab65UJ9Taye0uQpa8qqc+FKwzSD4nD8LhNsOCQ3gUP
E95TXTe2ywANFI8iqxrjHpotD+o30kdfSFcMTlIffij1y11qFuxm7+HpSArlHBOK
sy53EGNwPa0y/wA1x/Kdlr1YqqVt46A9UzEKog3agtd6Ioba4rSa/TRyes0PtuK+
DxO0TJPHfCQbNMiopwnRSN3/GCk8CwImB2pJ6KoNXQcf6WpqSvN6StaTevn/xtNY
ayIQWt3AGtBbPuJCFpQqpP+ewNst0w6lELxP4sBmkeUN3HceXqy54yUR3tE3tJkF
9uzNIUnQYc725RdXBrXPuqZwWmk8q6O+fYTpiwNtweMt7fR1a8UIIR1X5WbjyLkz
dB27KV0Fw2/nRDdAehhr1SMywk5U9ODLrZ+CO24tCmiTs0FOEo8ucFbm8UQAAWEm
IeunhZ+6nPobB8rgD4pwvlNCCmyq76XR5Yir6mwEVm/Zqns1cRi8kR+DzX9FfkT1
vdPr9AFieP32tw4cMzUm11qRkfd9qTRv+r8gObAPYdVIkw2yKsFIGp4bdiSAe31E
xWAWuSIk/j5TczILHKncFup/VzdCAsjs7gQMU1WK6Z5ybGcXOmY=
=UxsX
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--

