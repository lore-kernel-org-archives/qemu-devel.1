Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_FUZZY_SPRM,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AADC04AAB
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 03:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B92B2082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 03:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Ochfvdpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B92B2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49687 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNUTX-0001b4-Ja
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 23:39:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNURt-0000ha-9o
	for qemu-devel@nongnu.org; Sun, 05 May 2019 23:37:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNURs-0006r7-7o
	for qemu-devel@nongnu.org; Sun, 05 May 2019 23:37:53 -0400
Received: from ozlabs.org ([203.11.71.1]:59499)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hNURq-0006ne-3O; Sun, 05 May 2019 23:37:52 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44y7jD0d82z9s9G; Mon,  6 May 2019 13:37:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557113856;
	bh=JNseCk6QRr3SIPgq8OZxfui37skWHrqU/WiFN2PM6T8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OchfvdpweQYBr+/rh0RVbZLmemkK9KFJFq4BVeq9KB6eCPTnG414vYG30zgK3mQm2
	CJIZNorClOCUK/p5yGYkH2c3OmQSnyhCrA9gkhKbKgCYZmOM56g/M+75TbPmtwA2Mp
	ICWvAafMopr8wDeNlNhw86P5WR4cDTncWTf7YLnM=
Date: Mon, 6 May 2019 13:23:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190506032304.GB6790@umbus.fritz.box>
References: <20190506014803.21299-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <20190506014803.21299-1-sjitindarsingh@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH] target/ppc: Add ibm,
 purr and ibm, spurr device-tree properties
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
Cc: paulus@ozlabs.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2019 at 11:48:03AM +1000, Suraj Jitindar Singh wrote:
> The ibm,purr and ibm,spurr device tree properties are used to indicate
> that the processor implements the Processor Utilisation of Resources
> Register (PURR) and Scaled Processor Utilisation of Resources Registers
> (SPURR), respectively. Each property has a single value which represents
> the level of architecture supported. A value of 1 for ibm,purr means
> support for the version of the PURR defined in book 3 in version 2.02 of
> the architecture. A value of 1 for ibm,spurr means support for the
> version of the SPURR defined in version 2.05 of the architecture.
>=20
> Add these properties for all processors for which the PURR and SPURR
> registers are generated.

So.. what does the current empty property mean?  Is it just wrong by
spec, or does it actually mean something incorrect?

>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  hw/ppc/spapr.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2ef3ce4362..8580a8dc67 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -500,7 +500,10 @@ static void spapr_populate_cpu_dt(CPUState *cs, void=
 *fdt, int offset,
>      _FDT((fdt_setprop(fdt, offset, "64-bit", NULL, 0)));
> =20
>      if (env->spr_cb[SPR_PURR].oea_read) {
> -        _FDT((fdt_setprop(fdt, offset, "ibm,purr", NULL, 0)));
> +        _FDT((fdt_setprop_cell(fdt, offset, "ibm,purr", 1)));
> +    }
> +    if (env->spr_cb[SPR_SPURR].oea_read) {
> +        _FDT((fdt_setprop_cell(fdt, offset, "ibm,spurr", 1)));
>      }
> =20
>      if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzPqJgACgkQbDjKyiDZ
s5L8MRAAhflQ8iicYwFPiF5h4OstDYsPiY6F9/6b5+F+U+7+uv6P9r2HVJeRKKYG
N4ZMH4NE4zUnjnX1Ju+czjzIy87EO2p8pnb9b4hbYC7SGb1G/sWwnGkjyzXbFAw6
2A+5xmLqzPWvLwl5AwQXgygJIYcRfsQ+OQNyi/gd1qufcbVSlxSK8wzZYrVcVTVb
G+DnnErdp7l4FPINi9Y8Clzng9euajwYuOdNm3/bsKAx04Kkf3m1QFikPMU4SRyu
6hHb4+KjVGKRO922LLB8BImEFWVR3+Qfve/bPXFSCfbP9gk3cDh4S6cg3nSGm7Hl
Ch4CNBlhhxZOHDpzo1+1quwEttSTQ8Q3Y++/llDKi8W5pTVTvpd4bkSuZb480lRo
OBW1EhpJtIDpciQ+3C+v51yA0JRmGUW6JjKMGE92lodTNefeEX4bRJmdKX79l+eZ
xkH+k37Jy8YU0ERnB1MVDKHtw32r/Fm3J65a7DtLp4aXcOGVCyIqy33yc0gn7TuL
DYQnka+uvEAaBX9utq+d7iDJRs0mC0IhH7BlhRoZVuWIGANODDAdAOD2rD3zezO1
M83xQHeHj1gWV7AMHnz3oEeEC92rMkp5xCZ7fc0efmHlfjFkV5L6swArO8hxuc//
+WCUaouHjKE1jMStrW1MPcZULQqS9Sql0qNZ0ceQQc+9wuYqSZo=
=JPy7
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--

