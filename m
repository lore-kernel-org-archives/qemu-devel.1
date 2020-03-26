Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40020C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 00:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0126F20737
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 00:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IHYWg/gm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0126F20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHGYO-0005Tk-0k
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 20:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jHGXK-0003lA-Fq
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 20:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jHGXJ-0002Gp-2P
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 20:38:18 -0400
Received: from ozlabs.org ([203.11.71.1]:42557)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jHGXI-0002AT-2y; Wed, 25 Mar 2020 20:38:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48nmL8122Sz9sSN; Thu, 26 Mar 2020 11:38:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585183088;
 bh=8T/eINjp4ADMRIEA0YmtmvVl7GRSdz4kg9eVsnS7j00=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IHYWg/gm20a6OQJZid9A3uvt2D5FhUO/H7vwfghR5KX3je/sb9mJW9uGD4Ud568IF
 4awo6vu30I/Cj86ZEusaLQF/4LDJsU+q0hVy3gUuugStlwLUtqKSgp6p1DsFbSGYG6
 udT/tMm08ewi+vNCuHHbim3WBRC2X9xMb6suAm8Q=
Date: Thu, 26 Mar 2020 11:12:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH for-5.0] hw/ppc/e500.c: Handle qemu_find_file() failure
Message-ID: <20200326001211.GK36889@umbus.fritz.box>
References: <20200324121216.23899-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jIYo0VRlfdMI9fLa"
Content-Disposition: inline
In-Reply-To: <20200324121216.23899-1-peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--jIYo0VRlfdMI9fLa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2020 at 12:12:16PM +0000, Peter Maydell wrote:
> If qemu_find_file() doesn't find the BIOS it returns NULL; we were
> passing that unchecked through to load_elf(), which assumes a non-NULL
> pointer and may misbehave. In practice it fails with a weird message:
>=20
>   $ qemu-system-ppc -M ppce500 -display none -kernel nonesuch
>   Bad address
>   qemu-system-ppc: could not load firmware '(null)'
>=20
> Handle the failure case better:
>=20
>   $ qemu-system-ppc -M ppce500 -display none -kernel nonesuch
>   qemu-system-ppc: could not find firmware/kernel file 'nonesuch'
>=20
> Spotted by Coverity (CID 1238954).
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Applied to ppc-for-5.0, thanks.

> ---
>  hw/ppc/e500.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 854cd3ac465..0d1f41197cf 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -1047,6 +1047,10 @@ void ppce500_init(MachineState *machine)
>      }
> =20
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, payload_name);
> +    if (!filename) {
> +        error_report("could not find firmware/kernel file '%s'", payload=
_name);
> +        exit(1);
> +    }
> =20
>      payload_size =3D load_elf(filename, NULL, NULL, NULL,
>                              &bios_entry, &loadaddr, NULL, NULL,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jIYo0VRlfdMI9fLa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5781sACgkQbDjKyiDZ
s5JPCw/9FYTqxnQ87DOyskMYfdThN7FJVD7KJ3z6s0kvqodVSZqXjihoynT3mR9m
K99PbHVOJBBXT/qmMcaUR1kV40nOww8MnviVj402/A9L2XYwTSdHgJeYf5pXaacr
CZdwBjkKZn4bOLCIvaL+jsd6MyupaXSLB4SlozIFHK2AsCIuAG7iuUOaTyMl1jpu
cAENyN9VwTLNuJ3XzI9PDBQYoR1i+beeg1NObqIKTclaY4gcp+vk8ejYk+L6+TE/
uDr93z/5+fPZH3YpOvcqSM4ZcPvY/AGovk3mmRmaNguNRAr3l4Oaadkliv6fQXzP
fMsfLbjD+2Sy9p1f92gx/ZFPOsnfwtXStHBDUspStMXAMNPVZhShAnfi5bS/Udpw
0cZh2gHxQ9i6jaDLcolGIFgi3fuwU4xxHkZEQLRahu+/gMCVKkFeuGsI94yg/kmu
EQ2VFeP2WWGXlr9DK//wkpYitciBxc1Hgnc8epvCfFgqIRm7b9ojBdz4G3wdjp5J
2d6GNiaLd2v14sgP29s8DwdE5gEUc89OiHz4aNc22mPFH8+yMu/ZzA3DtkVoN2Mt
DocOfOacyuV/JhZi2A7JwFqiXmclOKSQhH+H4ctk65vhPi5CtiBQC/koyfkMDRKl
Iyj9q0V/vodMpTv4YsewuJhQfP1jzqwrkX8m+NKfx61WcK0YZZo=
=bz6F
-----END PGP SIGNATURE-----

--jIYo0VRlfdMI9fLa--

