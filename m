Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16835C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 23:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D888620866
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 23:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BL6rnnt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D888620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy3Ar-00022r-UP
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 19:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1hy39e-0000zn-0I
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 19:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hy39c-0002ZN-IQ
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 19:58:09 -0400
Received: from ozlabs.org ([203.11.71.1]:33471)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hy39b-0002VZ-BP; Wed, 14 Aug 2019 19:58:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46863C5bjJz9sND; Thu, 15 Aug 2019 09:57:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565827079;
 bh=W6MmsI53PDhhfYFi/pORl8TUDoShaZOCrOIb3F89Xk4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BL6rnnt46OR7U/0HdUagIlOq2Ock2wGuNAwrBt5GYiwJrH0ijt2AdVA/RWApGV8JS
 IPHJWfVVkuokYiyvJ5MWA1hi/RMlcZ5Gc/BdEDAdq76gM4KkQI25IJ9kCxLC/8bsFJ
 96p2a8ENZSlrNYo59GTvcdVEhTRFM4eZtYxdgrgM=
Date: Thu, 15 Aug 2019 09:57:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Clarke <pc@us.ibm.com>
Message-ID: <20190814235740.GB13050@umbus.fritz.box>
References: <156580023314.3056.6268901484469396279@5dec9699b7de>
 <3ff4c0cd-b757-55e3-c675-cbfd74a7f76e@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
In-Reply-To: <3ff4c0cd-b757-55e3-c675-cbfd74a7f76e@us.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v3] ppc: Add support for 'mffsl' instruction
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
Cc: qemu-ppc@nongnu.org, richard.henderson@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2019 at 11:34:13AM -0500, Paul Clarke wrote:
> Should these 'checkpatch' ERRORs be addressed, even if it will diverge th=
e code style from the existing, surrounding code?
>=20
> On 8/14/19 11:30 AM, no-reply@patchew.org wrote:
> > This series seems to have some coding style problems. See output below =
for
> > more information:
>=20
> > =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> > ERROR: code indent should never use tabs
> > #54: FILE: disas/ppc.c:5004:
> > +{ "mffsl",   XRA(63,583,12), XRARB_MASK,^IPOWER9,^I{ FRT } },$
> >=20
> > ERROR: space required after that ',' (ctx:VxV)
> > #54: FILE: disas/ppc.c:5004:
> > +{ "mffsl",   XRA(63,583,12), XRARB_MASK,       POWER9, { FRT } },
> >                     ^
> >=20
> > ERROR: space required after that ',' (ctx:VxV)
> > #54: FILE: disas/ppc.c:5004:
> > +{ "mffsl",   XRA(63,583,12), XRARB_MASK,       POWER9, { FRT } },

The ones above, no.

> > ERROR: braces {} are necessary for all arms of this statement
> > #148: FILE: target/ppc/translate/fp-impl.inc.c:625:
> > +    if (unlikely(!(ctx->insns_flags2 & PPC2_ISA300)))

But this one, yes.

> > [...]
> >=20
> > total: 4 errors, 0 warnings, 115 lines checked
> >=20
> > Commit c51c0f894525 (ppc: Add support for 'mffsl' instruction) has styl=
e problems, please review.  If any of these errors
> > are false positives report them to the maintainer, see
> > CHECKPATCH in MAINTAINERS.
> > =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> PC
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1Un/QACgkQbDjKyiDZ
s5IuSRAAoW1a0ySeoj75ye8u9yTEv60q5OUoGe/YmTS7mmlqPJJkcjWLMK4AHKyI
eQoDZApuec05yj4X3qDvZ8K2XLYrox6hrnfWAspEfLUWwcdxt/WBJHijWx4OsAp7
J/NJr1jDWoyLN7qLXBL00jEXHpdqIwvYFOH36xL3tSOIf4PohNTxN1bXM1gzM7K8
mgBblepXU1FY0TeVF5zOGwtvzUyY3o84dVk7Uyssttc1itlJp/WxzvIH7RFVSxA4
4DdqZlCwBuDrWIzgw2j9vq/sUzuBAh/I+aIKiGiGR+9/d+TddIK7jRxYcaSlvmmW
fveHBlieOkDw2ZvZNhOe/3pj5uzh/EPwA6ydUOIk0HNJXgQwHa6OQ9Antl6oNHDD
lmdjwRE606AuIpsyOgITiikbUzHXW7YCJZbKDSqbvR1/AWsn0G7zDeilx6EVUKAP
r/YJg2s14wFInBvbkZvq7vyIYj/5SLZyLyJxiDJxvVlroSe6JhES80RMLdB/embf
0pexLFTMoQhNbPvrIR9lcni+ye4Rndi86b2CLePmgO0M8OrANU95oIOulyW/pfKl
at4xofx87iWwDlXSFDGPsHDvN2PNy+02vEzHTj0g58YhBQs6B1JEeXwRQ3B2XSQ5
ND/JsxxVlgSOysLDw5mPGxphZAxfuALSHFvgq2L6fhrHeJjx0Yo=
=6UQC
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--

