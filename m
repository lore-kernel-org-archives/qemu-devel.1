Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33AEC2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 04:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF9020747
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 04:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="D+/+RvnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF9020747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM2XM-0005DQ-PU
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 00:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jM2We-0004hT-7o
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 00:41:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jM2Wc-0005I4-Lw
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 00:41:19 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:50795)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jM2Wb-0005E5-LJ; Wed, 08 Apr 2020 00:41:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48xs6X4zWBz9sSq; Wed,  8 Apr 2020 14:41:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1586320868;
 bh=Mni4oCH1bLQ2KSyObvT0ICIz/ZsKltGRovkWC95CZH4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D+/+RvnFRxcIFnPqKJjSpkz9r1/umkINLszCE7GrBaTj1h7lm2F3JTkcBmk3gvEFg
 91zSDHITzmcIj/S7S+JWR4uEPmEljWPgPDE6XXcQ5x2PCwfW0XRdVornLvMaJ5PUUC
 Ms9A43YJ07VJORAPxOZoovPmFZ2fBdfqdk+Yo+js=
Date: Wed, 8 Apr 2020 14:33:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH for-5.0?] linux-user/ppc: Fix padding in mcontext_t for
 ppc64
Message-ID: <20200408043349.GC304335@umbus.fritz.box>
References: <20200407032105.26711-1-richard.henderson@linaro.org>
 <20200408021006.GB44664@umbus.fritz.box>
 <d0f45182-024f-db52-440c-d2aa9b597812@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Content-Disposition: inline
In-Reply-To: <d0f45182-024f-db52-440c-d2aa9b597812@linaro.org>
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
Cc: alex.bennee@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2020 at 08:44:47PM -0700, Richard Henderson wrote:
> On 4/7/20 7:10 PM, David Gibson wrote:
> >> Should we in fact disable ppc64abi32?
> >> I can't see how it could work enough to be useful as-is.
> >=20
> > Yeah, I think so.  Last time we had a problem in this area, I couldn't
> > even figure out what ppc64abi32 was supposed to *be*, let alone what
> > the use case for it is.  Given that, it's hard to imagine it's been
> > working (whatever that means) any time recently.
>=20
> What it's *supposed* to be is a ppc32 binary running on a 64-bit cpu, e.g=
=2E a
> 32-bit binary on power7 with the kernel's compat syscalls.  You get to do
> native 64-bit arithmetic and have 32-bit pointers.

Right, I guessed that from the name, but I couldn't find anything that
explicitly confirmed that.

> I guess there's a kind of a use case there somewhere, but it's rather nic=
he,

Extremely.

> and someone has to care more than they have until now.
>=20
>=20
> r~
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6NVCwACgkQbDjKyiDZ
s5KNjw/9GtNpn6oEpTn9Ej1BrIP/zdVPjOfD+yZSSu3XNbzTMZvrvU2XYT5Hyr1+
yMeLri0cQkgNhSNh9187aEkkzfKzmKeGzs5tEWYXg4/51IjvhdM78zQX64eTrOF8
8YpQNVVOtF058MACqwpa10uR7u1qsRSaETkc/gsfuOZJAo3y0uIDHH+8IvkzS1w6
6v7pL3an8P0+4OUwy1SFHlp5wintBty0Spa0e+4vRN8gB7guObQpccTJYJZ152jA
JpfjDewrfCMhsYG1ySGGVwBJZ2iAMFwfogjZNTV1sib+TTsU7ApUgzy8b1Hd/NNJ
zqH+SW/bs9UQ5KE7QzYfZXeuqXuXLQndt1sNImuerV1n0ApW3P9hYOoYx79/S7+/
GDR0JihC27FE0K9OyJtQequaGRwqKqU7obkfYejG7DUlpfw3mYPeIpQ874iQ4B1R
fKgGQwNKpScjWEdE00lZMAISsfwecA7e+jiTCqbt2co9guinwO223w7d1CVewT7N
QZf388dq+hLp4nhTavVVzD8sano1JlFlYuDGM5nAwDJ7yiA6ASS7rpDv5X2H+url
BXQx9F0PQDt57KiJSZ+lU8HmSIObbsWZopXWVEXuZk86eGifQZVfDdFzF60C1fUN
WT5moEj04PioNV1Nh+d6c/2pabN/4gh50DuOw+AWPao0siEZe90=
=g/77
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--

