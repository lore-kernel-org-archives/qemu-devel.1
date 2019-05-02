Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA239C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 04:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC3F2075E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 04:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="FfM0jRXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC3F2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44753 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM30X-0004BC-Tz
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 00:07:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hM2zd-0003oP-FY
	for qemu-devel@nongnu.org; Thu, 02 May 2019 00:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hM2zY-0002Al-FG
	for qemu-devel@nongnu.org; Thu, 02 May 2019 00:06:43 -0400
Received: from ozlabs.org ([203.11.71.1]:54311)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hM2zO-0000v1-9X; Thu, 02 May 2019 00:06:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44vhVn0Zp8z9s9T; Thu,  2 May 2019 14:05:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556769905;
	bh=u94F8fysm25VSfvlhD6GL9BEo6gxzy8yT305rWvtPag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FfM0jRXKXX+SAJ8Z0hxg29eDx/lgha/o94pNdqkO8QaAsH0anKcQuQI76QLXtc8H8
	8Q2cm6LRnaBk65M9j0k7ouyzqcY2ajHBdSw2YlTpGpcF9NVreBRO47jeT1bCubUvPR
	XdaXR5crXCSy7DlxA1+S12yEwte9OS9xlmAJByIA=
Date: Thu, 2 May 2019 14:04:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190502040459.GE13618@umbus.fritz.box>
References: <20190501223819.8584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <20190501223819.8584-1-richard.henderson@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 0/2] configure: Fix make check-tcg for
 ppc64le
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
Cc: qemu-ppc@nongnu.org, mark.cave-ayland@ilande.co.uk, alex.bennee@linaro.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502040459.I9StIknqQQX9zw3cXAyIM7eA1yZ0iQEQI74-g0ABZCI@z>


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2019 at 03:38:17PM -0700, Richard Henderson wrote:
> At present make check-tcg will produce errors like
>=20
>   RUN     tests for ppc64
>   TEST    test-mmap (default) on ppc64
> test-mmap: Invalid ELF image for this architecture
> make[2]: *** [run-test-mmap] Error 255
> make[1]: *** [run-guest-tests] Error 2
> make: *** [run-tcg-tests-ppc64-linux-user] Error 2
>=20
> which is caused by the use of the host ppc64le compiler
> in building guest ppc64(be) executables.

Thanks for looking at this.

I've staged this tentatively in ppc-for-4.1.  However while it removes
the "Invalid ELF image" message I still get:

  TEST    test-mmap (4096 byte pages) on ppc64le
test-mmap: Invalid argument
make[2]: *** [/home/dwg/qemu/tests/tcg/multiarch/Makefile.target:35: run-te=
st-mmap-4096] Error 255
make[2]: Target 'run' not remade because of errors.
make[1]: *** [/home/dwg/qemu/tests/tcg/Makefile.include:71: run-guest-tests=
] Error 2
make: *** [/home/dwg/qemu/tests/Makefile.include:1079: run-tcg-tests-ppc64l=
e-linux-user] Error 2

Running on a POWER9 host.  Do you see that as well?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzKbGgACgkQbDjKyiDZ
s5L24w//REl6xvTe5wVXIqtnzSHNRg5ICnV0AyZDD9M93o4Z6M0njqy6fEICrNTh
HOXJcExnDl9Mvn50zhYfeHghSYRyZi6PgbMfs3vVc2TBM7eOIJo9+m1suSA3V0WM
Q+yuCwaA+6+Ff2mvczd3sbFlXKPsOLieMcI9qup3ajhDp+wlHL6VtlysRh/z2P1r
JjL+Zu3M+VhUg28y1lUiAS8bnVXBjNW1YbFGm/rs0Znfr7eHYBrfpAuCA4CYd8EB
0qerJ6QuEw7AD9QTWgckXAfsSmSxPXXQ+s3he2otFg9txr9hbEpfYuXpuJlVemIv
U0kw9NkqkDEhRZlcWCj5S4nWjgnueoYreV02McPqH6NlC/bsWKz6DlCWOwVE8syB
fvHm1IT2coSTh9pQM1rgRg7VTSOAxJq8dYRqJX7hKhUP7/ddrkKUJi+gRBSpPvq3
/7daim5YQBgqoLatqY8ML1gFYlrG9LFdArew/y/Jv7RM+yE9B9m2nZx4l2ZGjiBp
z6oIupCb+P9wMCjtlpaiFotgcH0Ob8NoIK78f+6JeSi4f5oYWuF9EXwuYJVfoZkR
i2mqp05SE4ZbrYn7efQUGwttRkYr5dcA55kVnY3GuEmNbMq7JVvWTupB+9BNvtLe
jIxK5OngiFIqC0h76OZ20jh1pqVgbfjHDFH+xoVO1hKxx0cnugo=
=4hKQ
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--

