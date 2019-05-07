Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8E5C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98599206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 06:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="okTQWr/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98599206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40799 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNtbL-0005Rz-N2
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 02:29:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVl-0000ng-AZ
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNtVj-0002fn-6m
	for qemu-devel@nongnu.org; Tue, 07 May 2019 02:23:32 -0400
Received: from ozlabs.org ([203.11.71.1]:35965)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hNtVi-0002dp-Rv; Tue, 07 May 2019 02:23:31 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44yqL25bn7z9sML; Tue,  7 May 2019 16:23:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557210202;
	bh=+v+AnRKXUc8jjabRoLJIVMUXrBjfLmwH5Dcdh6Ob0hA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=okTQWr/v7ta/OCOGjI+04z7LUFdQ5OeSKTpSUo+2+lgjvoNmGVDgPlyY7Y5qw0kAt
	rhHNMdpoLanA9Lv+Mj2QmJXOkOFsv0tahSGSYlcPa++QNB32pK9HezTILBo6lSihFk
	bAdO7qtVXoRqSeZwHu6wgfIIy4KwsMXEevv1kjtc=
Date: Tue, 7 May 2019 15:25:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@ozlabs.org>
Message-ID: <20190507052459.GJ7073@umbus.fritz.box>
References: <20190507004811.29968-1-anton@ozlabs.org>
	<20190507004811.29968-9-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2VXyA7JGja7B50zs"
Content-Disposition: inline
In-Reply-To: <20190507004811.29968-9-anton@ozlabs.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 9/9] target/ppc: Fix vsum2sws
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
Cc: ego@linux.vnet.ibm.com, sandipandas1990@gmail.com,
	mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org,
	qemu-devel@nongnu.org, f4bug@amsat.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2VXyA7JGja7B50zs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2019 at 10:48:11AM +1000, Anton Blanchard wrote:
> A recent cleanup changed the pre zeroing of the result from 64 bit
> to 32 bit operations:
>=20
> -        result.u64[i] =3D 0;
> +        result.VsrW(i) =3D 0;
>=20
> This corrupts the result.
>=20
> Fixes: 60594fea298d ("target/ppc: remove various HOST_WORDS_BIGENDIAN hac=
ks in int_helper.c")
> Signed-off-by: Anton Blanchard <anton@ozlabs.org>

Applied, thanks.

> ---
>  target/ppc/int_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index 111586c981..b8b3279f71 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -2038,7 +2038,7 @@ void helper_vsum2sws(CPUPPCState *env, ppc_avr_t *r=
, ppc_avr_t *a, ppc_avr_t *b)
>      for (i =3D 0; i < ARRAY_SIZE(r->u64); i++) {
>          int64_t t =3D (int64_t)b->VsrSW(upper + i * 2);
> =20
> -        result.VsrW(i) =3D 0;
> +        result.VsrD(i) =3D 0;
>          for (j =3D 0; j < ARRAY_SIZE(r->u64); j++) {
>              t +=3D a->VsrSW(2 * i + j);
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2VXyA7JGja7B50zs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzRFqsACgkQbDjKyiDZ
s5KwWhAAgAyJoAlTCeL+G+QObUYsf89yNN3u6ayAt8Kv+SXwytE2kkYD6pm3yvAA
embhSRlJUndddfaDhKqfvIY7iuK4t4/3ZAWshXa5npV8Yys4ciu2gbsVs8DqSy6y
WtvV8gl0oP/uMPcf85Pw2+ZgRvYXugQgEwX/rx/JqFSMzsrnIU5ERx8ndLhO/8G5
JxsmMr863h7MyQ5vRXyovzr5y94+QJdRMkwQPngIJ8WFbXkToyaf1aCldO/XCllZ
f0SKRMfWZ98O+sFNppTNGS4fP+YPSIlUHzoIzPryLK2y2+wj8vg+TXWZpGZN5co0
NtRS7pPhq4D6w/+LAjTXzqjiwpGVG6HPCQ4GXcwdHYCAZ+xMW8Mv6JJ9SHKqKvCk
7AQfgyO2RqSqb0QxfehxdgDcBmjNDsHBa77fXbb3rwD7DZZfbBbORzbvzYouqLDZ
6KF6EOeKcl1bvP1WBDe/142d+u8SK13wRJhHi8DNq6WExptRLSUBe0TswWSWquIW
kqqiC/uZmhVvLJhAI11GghGmBG7r3qzawMchn15fkkEH6OnIRltkgJS9jfqxnbLw
Qph+bp9Hm0QCsNDsjqbpvep/fqSmnXMAMIlkviqDGCk8EwLih1+qKMPpfn+Sk/b6
lkLq5ovsiTMejIYSaxdXY+8SkDhTitzJ4uyDboeADdM2WmZ+dpE=
=7Gx0
-----END PGP SIGNATURE-----

--2VXyA7JGja7B50zs--

