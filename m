Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B58C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 01:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1084208C0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 01:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DDNh2c+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1084208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoIAR-00086W-4P
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 21:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60403)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hoIAE-0007ag-2a
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 21:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hoIAC-0003qC-Le
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 21:58:26 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53953 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hoIAB-0003mx-Cj; Thu, 18 Jul 2019 21:58:24 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45qZ0P0ZPMz9s4Y; Fri, 19 Jul 2019 11:58:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563501493;
 bh=/KiWScIChoOQv3z6MT3HXkiDpCYFtK/R75OMVaH48W0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DDNh2c+MBADPedvCLN4Air+WYFAnu/V9+mqaehWwwaRJRTeZI8bA5lviZ63uriowM
 csTzPVlKPrGTG1gIvQ9l75mCsqHfxvZKxp1zNhtM9P5Uaz+yaNccS6rP10RKlLhHOT
 VsdizZGuB6ti4+KTLaJYXivGEH38LYBJxS3gZI88=
Date: Fri, 19 Jul 2019 11:34:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Ivan Warren <ivan@vmfacility.fr>
Message-ID: <20190719013413.GO8468@umbus.fritz.box>
References: <c3466869-e259-fe38-c974-b3ccd349345f@vmfacility.fr>
 <20190718191911.3dcb39cb@bahia.lab.toulouse-stg.fr.ibm.com>
 <58ace4b9-3ed0-2658-a914-6a2cacb52fa9@vmfacility.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+wSiqF7c0ySQ2tNi"
Content-Disposition: inline
In-Reply-To: <58ace4b9-3ed0-2658-a914-6a2cacb52fa9@vmfacility.fr>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] Allow bit 15 to be set to 1 on
 slbmfee and slbmfev
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--+wSiqF7c0ySQ2tNi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2019 at 10:15:52PM +0200, Ivan Warren wrote:
>=20
> Le 7/18/2019 =C3=A0 7:19 PM, Greg Kurz a =C3=A9crit=C2=A0:
> > We usually mention the subsystem name in the subject, ie.
> >=20
> > target/ppc: Allow bit 15 to be set to 1 on slbmfee and slbmfev
> Gotcha ! Still learning the process as I go. Next time I submit something,
> I'll follow the guidelines more accurately.
> >=20
> > On Thu, 18 Jul 2019 14:44:49 +0200
> > Ivan Warren <ivan@vmfacility.fr> wrote:
> >=20
> > > Allow bit 15 to be 1 in the slbmfee and slbmfev in TCG
> > > as per Power ISA 3.0B (Power 9) Book III pages 1029 and 1030.
> > > Per this specification, bit 15 is implementation specific
> > > so it may be 1, but can probably ne safely ignored.
>=20
> Another typo from me !
>=20
> s/ne safely/be safely/
>=20
> > >=20
> > > Power ISA 2.07B (Power 7/Power 8) indicates the bit is
> > > reserved but some none Linux operating systems do set
> > s/none Linux/non-Linux
> Thanks ! Sorry for the typo !
> >=20
> > > this bit to 1 when entering the debugger.
> > > So it is likely it is implemented on those systems
> > > but wasn't yet documented.
> > >=20
> > ISA describes things that are common to several processor types,
> > but each implementation may do some extra stuff... like giving
> > a special meaning to an invalid instruction form for example (see
> > commit fa200c95f7f99ce14b8af25ea0be478c722d3cec). This is supposed
> > to be documented in the user manual.
> >=20
> > Maybe something similar was done with the reserved bit 15, even if I
> > could fine no trace of that in the Power8 UM... of course. I'll try
> > to find clues within IBM.
> >=20
> > https://openpowerfoundation.org/?resource_lib=3Dpower8-processor-users-=
manual
> >=20
> > but it is indeed mentioned in the Power9 UM:
> >=20
> > https://openpowerfoundation.org/?resource_lib=3Dpower-processor-users-m=
anual
> >=20
> > 4.10.7.2 SLB Management Instructions
> >=20
> > The POWER9 core implements the SLB management instructions as defined i=
n the
> > Power ISA (Version 3.0B). Specifically, the following instruction detai=
ls are
> > noteworthy:
> > =E2=80=A2 The slbmfee and slbmfev instructions can read any SLB entry w=
hen UPRT =3D =E2=80=981=E2=80=99,
> >    if the L-bit in the instruction image is set to a =E2=80=981=E2=80=
=99. This is an
> >    implementation-specific feature that will only be used in the future=
 if and
> >    when the POWER9 processor core supports UPRT =3D =E2=80=981=E2=80=99=
 for HPT translation.
> >=20
> > Not sure if we support that in TCG, but it doesn't hurt to relax the ch=
eck
> > if that's enough to make AIX's debugger happy.
> Yep !
> >=20
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> >=20
> > > Signed-off-by: Ivan Warren <ivan@vmfacility.fr>
> > > ---
> > >=20
> > > The original creator of the patch is "Zhuowei Zhang"
> > > (https://twitter.com/zhuowei) but I couldn't find any e-mail address.
> > >=20
> > This is the original patch, correct ?
> >=20
> > https://github.com/zhuowei/qemu/commit/c5f305c5d0cd336b2bb31cab8a70f90b=
72905a1e
> Indeed !
> >=20
> > After speaking with some QEMU folks on irc, it is okay to ignore the la=
ck
> > of S-o-b because the patch is trivial. But the general rule is to always
> > require an S-o-b when posting someone else's patch.
>=20
> Is it good practice to add a S-o-b without the original author's consent
> and/or without an e-mail address ?

Absolutely not.

> Although I would very much doubt he would
> have complained.
>=20
> Anyway, thanks for reviewing and for the tips ! (and sorry for all the
> noise).
>=20
> >=20
> > >   =C2=A0target/ppc/translate.c | 4 ++--
> > >   =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > > index 4a5de28036..85f8b147ba 100644
> > > --- a/target/ppc/translate.c
> > > +++ b/target/ppc/translate.c
> > > @@ -7064,8 +7064,8 @@ GEN_HANDLER2(mtsr_64b, "mtsr", 0x1F, 0x12, 0x06,
> > > 0x0010F801, PPC_SEGMENT_64B),
> > >   =C2=A0GEN_HANDLER2(mtsrin_64b, "mtsrin", 0x1F, 0x12, 0x07, 0x001F00=
01,
> > >   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 PPC_SEGMENT_64B),
> > >   =C2=A0GEN_HANDLER2(slbmte, "slbmte", 0x1F, 0x12, 0x0C, 0x001F0001,
> > > PPC_SEGMENT_64B),
> > > -GEN_HANDLER2(slbmfee, "slbmfee", 0x1F, 0x13, 0x1C, 0x001F0001,
> > > PPC_SEGMENT_64B),
> > > -GEN_HANDLER2(slbmfev, "slbmfev", 0x1F, 0x13, 0x1A, 0x001F0001,
> > > PPC_SEGMENT_64B),
> > > +GEN_HANDLER2(slbmfee, "slbmfee", 0x1F, 0x13, 0x1C, 0x001E0001,
> > > PPC_SEGMENT_64B),
> > > +GEN_HANDLER2(slbmfev, "slbmfev", 0x1F, 0x13, 0x1A, 0x001E0001,
> > > PPC_SEGMENT_64B),
> > >   =C2=A0GEN_HANDLER2(slbfee_, "slbfee.", 0x1F, 0x13, 0x1E, 0x001F0000,
> > > PPC_SEGMENT_64B),
> > >   =C2=A0#endif
> > >   =C2=A0GEN_HANDLER(tlbia, 0x1F, 0x12, 0x0B, 0x03FFFC01, PPC_MEM_TLBI=
A),
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+wSiqF7c0ySQ2tNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0xHhMACgkQbDjKyiDZ
s5IU9BAAm8BcB/zUjvF5f83AlZsvQrkfbAXGMZQr2AxKF3AZ1nMbbiPC6R2pFxgQ
hXs0+a1QIgQljro9jTc+WIVmfR9Hf0uIStz0haoLV5gPDwu6Qfbio/JcI8kZTIeo
0JtjejLojDiufWHBlai18M/SXqlcWCUtVatu2ROta5zUXOIeTXGOOhXaf/sbBy/r
hmAvQkSdkgncrAhMcQOXSmbv2MH63nl9nb27unZOr93HekXs3/VFYt7nB3G9Byhd
8QqE+LCP+BK55JaWQXcojBVH+nBAYrpBk33SgIwDKh9gdI15Nk35Er18Mr+l/jG3
ha5QEgYmmQ40v13oBRuW9GmnDFcdmTOWGpztVAAB60Q+CL7zoB6/UTNiBvbaWdFZ
4xqURFpiExleJEil2UuOPg0FsY3ZpVpSzfptQioNMaXeAOxUiizda1CAPYFzQ4rf
S4EfK+ZTHoV4CopeZBy+wEOPesJD/fAV7zhTwy1lQjiyFcpzRUhKESXcwyoqivfU
8j1gzqSvyflLWcLIdtqZ7wa0Ap7Q21z+g1AyZg9sJYmTSQ+IFbsXRSdhDb6u111S
dsPEd6Qg721otPw5uh6YDnUeGME1CuaqcM/EOF5rESQyc7TXtGsINpG6Oa23m3K+
lL4wD1ijyp1Wl4JjJZfoU4tkB+R7z2LgDlQp2Wj7ADlVLlPEnwI=
=2fmB
-----END PGP SIGNATURE-----

--+wSiqF7c0ySQ2tNi--

