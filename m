Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB335C2D0EC
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 02:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B2120730
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 02:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="M34JQJ3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B2120730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM0aT-0001LT-Mk
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 22:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jM0Za-0000Ft-1Y
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 22:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jM0ZY-0003wu-HU
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 22:36:13 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:56841 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1jM0ZW-0003mZ-4c
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 22:36:11 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48xpLD06Crz9sSj; Wed,  8 Apr 2020 12:36:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1586313364;
 bh=GavUyRU1Os05ZnO+wP19ljW1i49iDVMq0ikxbW/PeNE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M34JQJ3PHz91qYfZAjhGUR1Y9AUE8HjHMK6sm8pxz/jtKb+g3OetVlPjm5U9TNJi7
 wshbf+O3ZVXtyXmbWU7/3v3vk8691yHWeA4mKpFOlb7zSsVAd3N7EhXOwFNsv0jtS+
 v5wF1Cj20Dx82cdMhukEFgcqSl46BLFdc3Io8c4I=
Date: Wed, 8 Apr 2020 11:57:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] configure: check for bison, flex before dtc submodule
 build
Message-ID: <20200408015717.GA44664@umbus.fritz.box>
References: <20200407111618.17241-1-cfontana@suse.de>
 <CAFEAcA9SYT227B9K7yHcv_J==r4xZ1spUSNzL_bRXUpAjT5QVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9SYT227B9K7yHcv_J==r4xZ1spUSNzL_bRXUpAjT5QVA@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Alex Bennee <alex.bennee@linaro.org>, Claudio Fontana <cfontana@suse.de>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2020 at 12:20:15PM +0100, Peter Maydell wrote:
> On Tue, 7 Apr 2020 at 12:16, Claudio Fontana <cfontana@suse.de> wrote:
> >
> > if fdt is required, and the system DTC (libfdt) is not usable,
> > check for the dtc submodule requirements before trying to build it,
> > and error out with a helpful message in case the dependencies are not m=
et.
> >
> > Signed-off-by: Claudio Fontana <cfontana@suse.de>
>=20
> Does the dtc module actually need bison/flex, or does it just
> print an ugly warning about it? We only want the 'libfdt' part
> of dtc, which doesn't need the parser, we don't need to build
> the actual dtc compiler.

Assuming we're just invoking "make libfdt" within the submodule,
rather than "make" which will build dtc as well, then bison / flex
shouldn't be needed.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6NL3sACgkQbDjKyiDZ
s5JfMRAAgaTRADnNrKZ1KzMfKTGQXQ0bi4d5PqAArr8eiWPbxm96/edqZyP2LymP
X+rdvZ0G3+eYI6jWxqyaSRurwgyJsZYDeja3OzOMAY40vGsbX2ZZFnpP/AGDhlQm
dH11HrYceFeESubw5c+lIZtzBQMKY7sEQ8ey7FUsxPRnaegKtAHWCJUv6qFufdGu
4VO24FSVS35bO8TFPtpEMqGq1Z1/E7MGAJ5l6f+DMaoI+x8Kv1biP5D7baMLiM12
/KBs7A23CMbyZa9OED08Jpdlj/CtalYp0I4FiMgh/XL4VcHcHlrpg3tN6G77uf24
Th/2giFLjkI/bX6pL2fFCRRR5dSnMDIIWefBOE8ArUp3qtUWWTqhAYl90GsI2jK1
fZGOkQ9PdeSUM9WY9G1e/dJwMrq5g1cgpOvJeZ4pcFRcqCf43FPp9f3jG2RzhtNf
ZiQTJUPVmUPgQOI+A+LG2Da+wcQ+fnL2RIpTBlSbRqHCFSgUDUaN9D+/JL/6WKBm
C1ByjKnrScJh1z8SUuli3OA7FTkMXnSgG6lMOZtqIaamBi9I6af91l+IEoboIid1
qKjS5fF9OgPa9Wz4STTPrXfmMSsS3VzlEMUnsVbzVV88oTdG3I4+GV7rJdAeIZJY
xsY/jlrAPuFBmCiacaNziA6bRPhI8PLxXSEsbGKPPB9Sb1HMSQQ=
=bIei
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--

