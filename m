Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21238C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 00:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF53220663
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 00:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YVqPCs+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF53220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibvyt-0004IM-4L
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 19:23:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ibvxK-0002uE-8O
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 19:22:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ibvxH-0001p1-J9
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 19:22:17 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:38763)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ibvx4-0001b3-JL; Mon, 02 Dec 2019 19:22:05 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47RjN22lNWz9sPL; Tue,  3 Dec 2019 11:21:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575332514;
 bh=UtK4MZTFX5Ll0DXboYjXPnFFAe2D7Fp1y5zVX5+Q3ZY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YVqPCs+L2aR5OdrZPNE1791xeM+P8UTLF2nm6pneJP2rtg06ktc2HWlx6Sw+NS5Jh
 QxcZnlr9OcZj7PqR6TarySOK4U8byKmNkvs7ZfXtd6X23AbY5p8f9w8XsdAj/NztrK
 OcjB1Nxe+TmTvSxBM/XL3atLc+Tb9DQEJLMXsjTE=
Date: Tue, 3 Dec 2019 11:21:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCHv3] exynos4210_gic: Suppress gcc9 format-truncation warnings
Message-ID: <20191203002143.GD37909@umbus.fritz.box>
References: <20191202060806.77968-1-david@gibson.dropbear.id.au>
 <8b490fbe-2b09-2a2c-16a8-6739ce6a847d@linaro.org>
 <CAFEAcA-W74ZGVEat3A1cmgCGrGY9gF_7T-w9DK0TSPEXc4Cm_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-W74ZGVEat3A1cmgCGrGY9gF_7T-w9DK0TSPEXc4Cm_g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2019 at 05:44:11PM +0000, Peter Maydell wrote:
> On Mon, 2 Dec 2019 at 16:08, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 12/1/19 6:08 AM, David Gibson wrote:
> > >
> > > -    for (i =3D 0; i < s->num_cpu; i++) {
> > > +    /*
> > > +     * This clues in gcc that our on-stack buffers do, in fact have
> > > +     * enough room for the cpu numbers.  gcc 9.2.1 on 32-bit x86
> > > +     * doesn't figure this out, otherwise and gives spurious warning=
s.
> > > +     */
> > > +    assert(n <=3D EXYNOS4210_NCPUS);
> > > +    for (i =3D 0; i < n; i++) {
> > > +
> > >          /* Map CPU interface per SMP Core */
> >
> > Watch out for the extra line added at the start of the block.  Otherwis=
e,
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>=20
> I thought about putting this in rc4 but eventually decided
> against it. Queued for 5.0 (with the stray extra blank line
> removed).

Great!

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3lqpUACgkQbDjKyiDZ
s5KuEg//UFgKQhzaHfjvcBROlr7x4twHsRWOLWgBcDPDwdlpNTIjs1PBdgOtMs7/
VsBl2BmLDsOFqrZ5ZRdXCnEkqqTnwDiDJOSDBd/RDm+TE+HSFXOZ8sgi1N8BPeee
Pwnu/bCDt4OkfkZc6iIE4QWE0zbz7GwLZG7B+9S43Ymoc0lnEukXHRab35sasw4W
vUU9CFosmI8X8jS2eH39HLr8eBgjktmq8wnmK9kY8FobcUWuX/vWtk19ivpMjuER
KcsOUywiDTCk64XcForkJwRym0s3R+8DivVYk2r17YDq1bA5Bk9mluRsJz/BEJ60
aPu7CfO7vBfKNgNyhfX0y8dps83ghK3sdKJKwDlPvg61l3/b5uxGHWBV5n3tXpLP
oEmgSpMJUCO395ONvCD6l9gjZARUHiRodk4uoQD9R5y1ripqFqA3zp0F9fixfHgX
3dp8u80HnZz992SZOjBVTy5O4lL5Ne2enDNMBowAkEFS2hJs/qYO22wOag4C0lrI
HR82DNuy38oRvbTsQ8O4VDPO3G1v24QB7Gcz1EqsJNSeJ4MrkoxfaPxwi+uvYsrW
72ULRh2h2yDfyt1Lea8V4Gd1oGVPrXUQ8KqgYl0NSMePgmKztqvuTgyCk5Kvnopy
GpvzBpHrOGxas/+G8bnpjhnYvaBEVYMgeT2SUaAe63zBnOhkpHM=
=jc2+
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--

