Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF1AC4CEC7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 05:02:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A32B206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 05:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XquB5mjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A32B206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9j9L-0006UG-9j
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 01:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i9j6L-0005F7-Cl
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 00:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i9j6J-0001M4-UA
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 00:59:00 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47167 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i9j6I-0001Ji-Pv; Mon, 16 Sep 2019 00:58:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46WvCg4sFGz9sNT; Mon, 16 Sep 2019 14:58:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568609935;
 bh=rAsE8qYHVdc7U29dsj6YbBAur49fdEgRiBH0/CmT+EY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XquB5mjtIVM4cKG0RT/2zSikV/V1faS+A7wna5ZawaoDzmPZa3oZrL41f1UpglkR4
 9EvnRZDRG4c901XiQ81OdOblB6rDGM5xPgHWTRi0UDGZUxW45R9Y/+cFU0hy08oQFD
 bY5EmpPUTrhz25eopo1V93jRfiuM7hg3uluimTSQ=
Date: Mon, 16 Sep 2019 11:48:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190916014858.GH2104@umbus.fritz.box>
References: <20190911093951.6244-1-alex.bennee@linaro.org>
 <8f76ef47-0cf8-c662-0100-d416f5f2e0c1@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZPDwMsyfds7q4mrK"
Content-Disposition: inline
In-Reply-To: <8f76ef47-0cf8-c662-0100-d416f5f2e0c1@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: fix signal delivery
 for ppc64abi32
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
Cc: qemu-ppc@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZPDwMsyfds7q4mrK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2019 at 10:33:45AM -0400, Richard Henderson wrote:
> On 9/11/19 5:39 AM, Alex Benn=E9e wrote:
> > We were incorrectly setting NIP resulting in a segfault. This fixes
> > linux-test for this ABI.
>=20
> Perhaps better:
> We were incorrectly using the 64-bit AIX ABI instead of the 32-bit SYSV A=
BI for
> setting NIP for the signal handler.

Applied to ppc-for-4.2, with Richard's updated description.

For future reference, it's better to directly CC me on such patches.
I only barely keep on top of the mailing lists, so if you just send it
there it's likely to be some time before I pick it up, or even get
lost entirely.

>=20
> ?
>=20
> >=20
> > Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> > ---
> >  linux-user/ppc/signal.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> Anyway,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZPDwMsyfds7q4mrK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1+6gcACgkQbDjKyiDZ
s5KBdg/+MxxEaQLH/kOZ6XzZpKrUnBMktwMzn7vbhqqaZxmHhlhAMx5swttejVmQ
W0xGR0Wy+Q9jsELCCduvy/MkSEE8vUfVAZaoE3HSxygFUTa1MWTM4ox8aNuuuWnv
WPGqPFfAPHIV2LIDMmeL49o0lcWcOzSMXeebRXXxi4Mb0LidW3g0jPVIWj4Dyh7k
Y4rXgVyNAxCuvlZTDgfuqABAu/CK1AdQETZMh5lU47O2/p/3eeWUc5fKNAMzUdjj
Lw+40DI4nzym7SaHqkoBh/+IDRS2b4pvsRPe9lNOEr5E3N+tP3PLxI3apozNP+R9
qtLVqrM3F9w3ofYuZB5qTyJ8G8ifZwtY4eH2sZQTpMxFppsLJXO83eoCYFiQeacr
87HHG0E/C46ztZiRIk3BOSufeNMDlqeAdoL7wPJkgTc1fkWHnSCcMgyEmERLJX73
9FPjk0V6W9w/XYm2y0vCyISBmLOwYbl91oovwT4WTTMvYFhx4CJVz3+cwSs2E4Gg
B7lDjh28hCRiphxf11EQiSDqjKwEFJxrKZ/bmStuwAD0W69VSArg1zmRPNoJnnd1
o0WmdXZbzA78thrqNC21gZNL+JlYdOQbcvVEkf/HCqsHI9LQv+WTqTJiyUxPBtp+
C7/aBUQUDXRBV9TZQz1EgThCerPCMqLrMqS1F9fLrmfYFFtk+EE=
=c83x
-----END PGP SIGNATURE-----

--ZPDwMsyfds7q4mrK--

