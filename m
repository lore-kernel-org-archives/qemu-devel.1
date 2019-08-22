Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D89C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 04:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01AB922CE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 04:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eV8asxNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01AB922CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0f95-0002u8-6A
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 00:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0f81-0002GV-Ay
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 00:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0f7z-0000Pe-MZ
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 00:55:16 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:33223)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0f7y-0000JM-Gn; Thu, 22 Aug 2019 00:55:15 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46DXJs00KFz9s4Y; Thu, 22 Aug 2019 14:55:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566449709;
 bh=YlfC73C68Uf9ruou1DKbCHpB7C5kywdhAwa9G2eLi8M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eV8asxNjFeg2eo2MUh0eRGE1I4nVDRhzACINgMrAJcF9rDmbR4sEqVm6o3nHDwpxC
 7jhUHvnJQNK5NKkCo2tAxwYhaT7Hd9/luTg90QfjKqeJEBdG+0BGIdu2u3CS7ICkni
 JF3uQEBox4XzZCrwt0sXHejjuUmgBjEB6G0j3SvU=
Date: Thu, 22 Aug 2019 13:02:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190822030234.GI20890@umbus>
References: <1565983669-6886-1-git-send-email-pc@us.ibm.com>
 <CAL1e-=jy6vggskJ26rTc8dnaqtqCB0SdfpV9p-NvKdjoBk+Vkw@mail.gmail.com>
 <0cfddc22-92ef-3067-9275-8f4f22ca9805@linaro.org>
 <CAL1e-=h=Hzfm8KZ4ebwaBsS6U=KVcReXpOPT2-vy4OeBktjWkQ@mail.gmail.com>
 <20190819062817.GA24503@umbus.fritz.box>
 <CAL1e-=j0w=OasHidP4W4ND-R3p6Ui7MS0iaj7Wk+c1tVyR09+A@mail.gmail.com>
 <1b486ed4-512f-e5b3-bcd7-9385b689b1cb@us.ibm.com>
 <20190820073114.GC20890@umbus>
 <CAFEAcA-qCRH-a7oGj3K_gvBVTq_JR8LjsorZuOKOP+w4pk4G6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d6iqOn7HZPWKXx18"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-qCRH-a7oGj3K_gvBVTq_JR8LjsorZuOKOP+w4pk4G6A@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ppc: Three floating point fixes
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, Paul Clarke <pc@us.ibm.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--d6iqOn7HZPWKXx18
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2019 at 11:35:29AM +0100, Peter Maydell wrote:
> On Tue, 20 Aug 2019 at 08:36, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> > On Mon, Aug 19, 2019 at 12:13:34PM -0500, Paul Clarke wrote:
> > > These issues were found while running Glibc's test suite for "math",
> > > and there are still a *LOT* of QEMU-only FAILs, so I may be back
> > > again with suggested fixes or questions.  :-)
> >
> > That doesn't greatly surprise me, TCG's ppc target stuff is only so-so
> > tested, TBH.
>=20
> You might also consider using/extending the risu test cases for
> ppc64 -- individual checks of each insn against a known-good
> implementation can be easier to track down bugs than trying
> to figure out why a higher-level test suite like the glibc one
> has reported a failure, IME. (There are already risu patterns
> for XSCVDPSP and XSCVDPSPN, so I think that bug at least ought
> to be found by risu if you run it against the right h/w as
> known-good reference...)

Oh, I'd love to.  I tried running risu once, it failed cryptically and
I haven't had time to investigate deeper.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--d6iqOn7HZPWKXx18
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1eBcgACgkQbDjKyiDZ
s5Kegw/9FVGwQEqHjpgPQbb3briRNdLR1OXPpowCK/BFiiwSaxtZTpfAMBYuI8zW
ZXRcPmclsgZsXbHq28CbM8RJvj2JiL9wF5gQ+XHJdN0wtMreCsDAjhoQK72b77JG
E2zVD/VHZ8OGbZce9/mdzS/Bq1nViySTDE2Vb/Yu7+s5Tj1zB0LuPTRr/0rIfj4p
t9uf5wfptSFFtuaTRpiQXFaOSksJEQwDNdwoD+3Qyicz6ms2ViJ4BY+DbwltF9fL
4EBsQtDocVzgdbIEQrFfbojvcV9dj4LprbLlsWfKf7j/+GgHnz/S+M/reegWPtWb
9/p05eWcAif/mGMybf4VxzCSCTZjW2j9aKaEsb382t+e5uEH1f1/7WHtRgaQwi4W
ZB0aClBDnVEl+oOaQlKw2UI9SgV7cXEZu4f9yKeqGN4VeBsUU7DKGnqHnFHJjetf
VlzolnDc/n+qecRUyOw0Bv99crCAb40x5w1yfD70jq/mPDWZDK9tMzVLyAFJcKrX
nHl/vnVzi7/mMqaRE0hYPZl9WSLbcEIRaLutWLFTW2GiX8aa+kxmwNvDDA1lQ+Xr
1hDmC9BMf28biYuJ3dL8VosK2DKBRWJe+0OloPM2+5QwbI9MdZL+x3qXyKyr0trE
BVvgPrSmyrpj4IURZlsyBUCj8ZVvhKTUzC99xwUsuQNmNea8cbQ=
=bF1I
-----END PGP SIGNATURE-----

--d6iqOn7HZPWKXx18--

