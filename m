Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC760C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 03:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6CEB20679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 03:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cIw7C2dB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CEB20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDgP1-0004RN-HX
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 23:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jDgAp-00011M-4J
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 23:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jDgAm-0007NE-M9
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 23:12:14 -0400
Received: from ozlabs.org ([203.11.71.1]:48559)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jDgAm-0007Ap-8B; Sun, 15 Mar 2020 23:12:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48ghDS5Kq2z9sPJ; Mon, 16 Mar 2020 14:12:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584328328;
 bh=QRM+IirhiZ861gBYjVcwxKd6OTKPrvhzpdyPSNheM0Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cIw7C2dBYAbqg0hsywQaBcEENsRWYC2bxltIAbmDLyXlO3gw/KqYUBMBdCQKh21k/
 z+CBjAAOMILgWmsoLAZc8AfBMh2zad3D+gH/a8supvdD8V/NWn0aMqSKuE+c9a/j/M
 eHzCcSQLJ95cW3sz6UTqDUlV0glm3fu6TuEmdRV8=
Date: Mon, 16 Mar 2020 13:57:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Vitaly Chikunov <vt@altlinux.org>
Subject: Re: [PATCH] target/ppc: Fix rlwinm on ppc64
Message-ID: <20200316025704.GG2013@umbus.fritz.box>
References: <20200309204557.14836-1-vt@altlinux.org>
 <20200310231503.GR660117@umbus.fritz.box>
 <20200311130022.sswvce3wx3dii4mf@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bFsKbPszpzYNtEU6"
Content-Disposition: inline
In-Reply-To: <20200311130022.sswvce3wx3dii4mf@altlinux.org>
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
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, mdroth@us.ibm.com, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--bFsKbPszpzYNtEU6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2020 at 04:00:22PM +0300, Vitaly Chikunov wrote:
> David,
>=20
> On Wed, Mar 11, 2020 at 10:15:03AM +1100, David Gibson wrote:
> > On Mon, Mar 09, 2020 at 11:45:57PM +0300, Vitaly Chikunov wrote:
> > > rlwinm cannot just AND with Mask if shift value is zero on ppc64 when
> > > Mask Begin is greater than Mask End and high bits are set to 1.
> > >=20
> > > Note that PowerISA 3.0B says that for `rlwinm' ROTL32 is used, and
> > > ROTL32 is defined (in 3.3.14) so that rotated value should have two
> > > copies of lower word of the source value.
> > >=20
> > > This seems to be another incarnation of the fix from 820724d170
> > > ("target-ppc: Fix rlwimi, rlwinm, rlwnm again"), except I leave
> > > optimization when Mask value is less than 32 bits.
> > >=20
> > > Fixes: 7b4d326f47 ("target-ppc: Use the new deposit and extract ops")
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> >=20
> > Applied to ppc-for-5.0.
>=20
> Thanks! FYI, there is at least one real case of this bug:
>   https://github.com/iovisor/bcc/issues/2771
> so this is not theoretical, and, probably, should go to the stable
> too.

Adding CC to Mike Roth who looks after the stable branch.

Can you include this one, please.

>=20
> Thanks,
>=20
>=20
> >=20
> > > ---
> > >  target/ppc/translate.c | 20 +++++++++++---------
> > >  1 file changed, 11 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > > index 36fa27367c..127c82a24e 100644
> > > --- a/target/ppc/translate.c
> > > +++ b/target/ppc/translate.c
> > > @@ -1938,15 +1938,17 @@ static void gen_rlwinm(DisasContext *ctx)
> > >          me +=3D 32;
> > >  #endif
> > >          mask =3D MASK(mb, me);
> > > -        if (sh =3D=3D 0) {
> > > -            tcg_gen_andi_tl(t_ra, t_rs, mask);
> > > -        } else if (mask <=3D 0xffffffffu) {
> > > -            TCGv_i32 t0 =3D tcg_temp_new_i32();
> > > -            tcg_gen_trunc_tl_i32(t0, t_rs);
> > > -            tcg_gen_rotli_i32(t0, t0, sh);
> > > -            tcg_gen_andi_i32(t0, t0, mask);
> > > -            tcg_gen_extu_i32_tl(t_ra, t0);
> > > -            tcg_temp_free_i32(t0);
> > > +        if (mask <=3D 0xffffffffu) {
> > > +            if (sh =3D=3D 0) {
> > > +                tcg_gen_andi_tl(t_ra, t_rs, mask);
> > > +            } else {
> > > +                TCGv_i32 t0 =3D tcg_temp_new_i32();
> > > +                tcg_gen_trunc_tl_i32(t0, t_rs);
> > > +                tcg_gen_rotli_i32(t0, t0, sh);
> > > +                tcg_gen_andi_i32(t0, t0, mask);
> > > +                tcg_gen_extu_i32_tl(t_ra, t0);
> > > +                tcg_temp_free_i32(t0);
> > > +            }
> > >          } else {
> > >  #if defined(TARGET_PPC64)
> > >              tcg_gen_deposit_i64(t_ra, t_rs, t_rs, 32, 32);
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bFsKbPszpzYNtEU6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5u6wAACgkQbDjKyiDZ
s5JSQxAAsRh6FvlOquv+vAwgK1D1wZvoCmlBBesmpjj0emDJHRUb5uVQPImgW6Lo
gtc2ZyKOopzv9z4MnjQgvJGyZ2GBzdt1UZ01g4quVUQVMgHDh4U4BIc5Uf01wkVU
3Uvpyol01Vv2Us6nKuUJeCLFJIeqV9bgdYRro8HlXifgOaKCFJ2gvlb/dM5EJSmD
RVmhUarn0sDuOouTMpnWHwRjM8QNVm5tu7SL5/bKnvZpv3dfft6AYLrWQKSi3Dxe
8x2CNorWGmdn0jRShLnzOASirkbU92PXYHxc2JSr24kCcwxaG+ZuwhskU+neypzc
MFfBW1WgD9upYGvVloVBzPGA4xVoDXILRXiuDHkouJusFTKph2fMJTS8ohjCTic+
ewIBSgM4hmM7K/UDdDP8Tg7e8ahVFYzidTQC5IU6YAsq+xRQvxYEu+XAYBnPBPvy
Cc06jA5lTXXHjXc4Qz5mj80qPNKDcxItLGzb2zVr+7rzV2EzSeNscWOOOigbtadD
jyNPKiyA6KioIvI/D1CgcYQ4li+rVPdNXhzaKWA0//0HeG8+IJm9UMxpuARGl1Jl
dOaSGRSZpBPwQ1Y/sRUDQUDknzC/9W8aHXXzGXR3/BCluvt8kvsNfHepBTHx/eHC
1VsQu8Z+J2JMrZuA+qgmL3qQqVrYJMlATIF54GS1TQ1cPgtVGTE=
=8pUu
-----END PGP SIGNATURE-----

--bFsKbPszpzYNtEU6--

