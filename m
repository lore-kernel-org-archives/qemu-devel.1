Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5A2C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 09:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3928120771
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 09:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fxKMnCYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3928120771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js10Q-000234-Gl
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 05:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1js0zH-0000DG-VQ; Sun, 05 Jul 2020 05:31:04 -0400
Received: from ozlabs.org ([203.11.71.1]:40801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1js0zF-0007XJ-9f; Sun, 05 Jul 2020 05:31:03 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B03NJ3fVjz9sSJ; Sun,  5 Jul 2020 19:30:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1593941456;
 bh=GQa5bIfxG1YSdk/NsGYqO3bwkM/ZUihPYJY8XVnEOMI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fxKMnCYVKC1FkLrZ+fvPAq0Djji+RHG3ANW2JYyhvtKVf6dUQBT4B6HYG8VVf6HBC
 NaXCp07qkLsy6CHfVvaLsmdpJTjg88EEUlt19uZNprXIZFa34dwZiszzDZz4c5lzjZ
 PMCUV2RHNRwsein9wBVP7CJzBDH8zHa+F5N2VeHo=
Date: Sun, 5 Jul 2020 19:07:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Lijun Pan <ljp@linux.ibm.com>
Subject: Re: [PATCH v4 01/11] target/ppc: Introduce Power ISA 3.1 flag
Message-ID: <20200705090754.GC12576@umbus.fritz.box>
References: <20200701234344.91843-1-ljp@linux.ibm.com>
 <20200701234344.91843-2-ljp@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
In-Reply-To: <20200701234344.91843-2-ljp@linux.ibm.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 03:31:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: richard.henderson@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2020 at 06:43:36PM -0500, Lijun Pan wrote:
> This flag will be used for Power10 instructions.
>=20
> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>

Applied to ppc-for-5.2.

> ---
> v4: split to 01/11 and 02/11
> v2: add Power ISA 3.1 flag
>=20
>  target/ppc/cpu.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 1988b436cb..a5e9c08dcc 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2191,6 +2191,8 @@ enum {
>      PPC2_PM_ISA206     =3D 0x0000000000040000ULL,
>      /* POWER ISA 3.0                                                    =
     */
>      PPC2_ISA300        =3D 0x0000000000080000ULL,
> +    /* POWER ISA 3.1                                                    =
     */
> +    PPC2_ISA310        =3D 0x0000000000100000ULL,
> =20
>  #define PPC_TCG_INSNS2 (PPC2_BOOKE206 | PPC2_VSX | PPC2_PRCNTL | PPC2_DB=
RX | \
>                          PPC2_ISA205 | PPC2_VSX207 | PPC2_PERM_ISA206 | \

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8BmGoACgkQbDjKyiDZ
s5LCcRAAwaH43RUY6tuVW3F0p4vThuRF1DK9JW7GjOsyarrD9pAfUlyxiFSL1PSi
bkyUQwQW/0YHcvoZFN8LRYpXuijarx9sBjIhbzg66W5blGuqmZcBESUMBurJsMTK
TB6ebXh0A1O2ld3WtfKi8R6mnpiSLAfRBOU7yHfGdw8LmwGuxfZfs1xXqBKpEIkN
60gg8WGr1BczukhJ8G6sKyzUeZU/KOpVtMBbdxygu7skvUezm/3ctGDc/1Qrj7Cq
ZiIL4IDICkyMfRiJKvCtHZbo8mgECF4JTM2ttYEfFEB9G3b/Omc5jQ1TWE4IfR/i
rIl8miGJ/uXzoMKLMRi+h8aXpTTCIIkMDDWmE5OpAVNYwrpN25eDtpwSeVTlxHy/
A0TqMPU0J5FeZgTkB0Z+l+FGmtyzixg2Woz2GERqa2bPxXFUNPEL7ovdkllgUKlf
D2XOvhouWQ4370WwW+TcjXXgOrr841HQlKVwEA3lQAKZPyTTIcl2t5uOXjLcZp3s
4UavC2LL4NC9q10afigDbq7Q2R8zXz/o+9FVb5GPSNg9YmpQYuIkREqucd02tqPr
QVJ+12BUDO+ybn87ET8Wh1Y5F50G03WQQMdUJn3/LAvXpFHhppTradf6x1sy7dOY
FxIjIWZdzB9yp8Mw+wNmR/mbXdCy0qnYCjtMMJgeqsuqFuK6kSE=
=f2ia
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--

