Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575BDC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:19:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246602238E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="acrqoIQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246602238E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpnDG-0002wO-Pz
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 01:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39756)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hpnCh-00013B-TU
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hpnCg-0003qa-0P
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:19:11 -0400
Received: from ozlabs.org ([203.11.71.1]:55431)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hpnCe-0003nE-AQ; Tue, 23 Jul 2019 01:19:09 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45t6G855gMz9sNg; Tue, 23 Jul 2019 15:18:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563859136;
 bh=rsKNIvyPw46XVjWvSvB7xTAQ4fbRffos1wo6N4SvcdA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=acrqoIQgRaJ9KPuzOmK3wzSvdAfwSm8SAIoGzBcVSez/sx4/PperLampiMwh8outI
 PmfZvlZvVqrvbV6lcGBcEv9Q1F0ze0xp+pReWC+PkbYrO4h0iO+jtaanWRd/9TqLV+
 Iz3akY0jfMz/HZB/scyETyJ60tr7SZRO9B662PBs=
Date: Tue, 23 Jul 2019 13:53:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190723035330.GQ25073@umbus.fritz.box>
References: <20190720012850.14369-1-aik@ozlabs.ru>
 <20190720012850.14369-4-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5AmtYbcgdBTTPS58"
Content-Disposition: inline
In-Reply-To: <20190720012850.14369-4-aik@ozlabs.ru>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH qemu RFC 3/4] spapr: Advertise H_RTAS to
 the guest
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
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5AmtYbcgdBTTPS58
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2019 at 11:28:49AM +1000, Alexey Kardashevskiy wrote:
> Since day 1 QEMU implemented RTAS as a custom hypercall wrapped into
> a small 20 bytes blob which guest would call to enter RTAS. Although
> it works fine, it is still a separate binary image which requires signing
> at no additional benefit.
>=20
> This adds a flag into /chosen to tell a modified guest that if the flag
> is there, it can call H_RTAS directly and avoid calling into the RTAS
> blob.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  hw/ppc/spapr.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 81ad6a6f28de..b097a99951f1 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1230,6 +1230,9 @@ static void spapr_dt_chosen(SpaprMachineState *spap=
r, void *fdt)
>          _FDT(fdt_setprop_cell(fdt, chosen, "linux,pci-probe-only", 0));
>      }
> =20
> +    /* We always implemented RTAS as hcall, tell guests to call it direc=
tly */
> +    _FDT(fdt_setprop_cell(fdt, chosen, "qemu,h_rtas", 1));

Rather than creating a new property for this we could use the
qemu,hypertas-functions property which is already used to advertise
some KVM specific hcalls.

>      spapr_dt_ov5_platform_support(spapr, fdt, chosen);
> =20
>      g_free(stdout_path);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5AmtYbcgdBTTPS58
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl02hLoACgkQbDjKyiDZ
s5LqSRAAsRaSwJYaTAEhLRRFq5567JUmhyUb8RjhK27kilpWObhLVj1Fm3wJUY9H
NNlwdLB5Um7tZTJ2taIUvwjXJJz0nGEP96m2Vb+7Y0qgM3hZOKv0Vf8wmZFSKlJ6
vQEVRAmVJfjmdauOEoVq1A6elnuz8RHyQJPgsGZ97aYpmfB2R7G1PjAiRyUCPpRW
e6+PFUhgc0Xm9v35Lfowp3Y3G0NGeV6iGGsCkGLwEH/U3jtKwUcY86bh5ZSzZvC7
+6ctIiKEgw0g7F0BNrcdaxElOSFwTMN1Vi5ma2xfMyuOWkKx+PdFVXbVeXKu6hjJ
EhbYugZ8GVkZb7GwEvT0ruo2pQMeA1tPXKKyuWoKC2HIGaEngcOv/XF/jaEEjVSf
+FG8eO+IJGPc5hjvpznT2g8XwqOptTdP6lIgXg0o+o6ovCT5TVzTMlU8pfCpZBTd
ufmqeGPzv2+noPgnuIf1qECpHllRZv3FtpCcTCe9Gf8wEPvJCqAOvLKy9qTbzPnm
XC3y+2yyL7ScVVnalKo2cOnOR2pZudGayBJ/CUs+VQ1cnPUzWapnaqFZ126/TF1t
oip2lCN7o1FI1SVadLgvPPHU5PpZpkonBuYczK1u82RzOWlDo8Y8l9CRhIvbfncB
0CctZqzwYzY1StUOLoVvb1u31u24MHsOHS75NCWJCoZKoM7GS20=
=0Qz7
-----END PGP SIGNATURE-----

--5AmtYbcgdBTTPS58--

