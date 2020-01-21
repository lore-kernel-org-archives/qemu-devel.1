Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93D7C33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 04:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7357322522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 04:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="I10hBHol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7357322522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itko3-0003te-O5
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 23:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1itklT-0001Cz-2i
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 23:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1itklR-0000RP-Oc
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 23:03:42 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:60539 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1itklR-0000Pm-3Y; Mon, 20 Jan 2020 23:03:41 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 481vzD0QwBz9sRK; Tue, 21 Jan 2020 15:03:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579579416;
 bh=qxCC7i66vqG1QudTFycwu7hHeDQM+dmDPpeVj6+8+58=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=I10hBHolKccSb9jbtXbSkOrGQjPU8fCnO5qRSeJeykpFLH4blVXEq1nfNtqoPxgN5
 WagdKUilAjBZs9/A/uHDvbTIHy1JQ+vY7zv3hJXkHkXSB39HiDh9KugRtU4+CquocK
 DcC7AVibdkcuezEWtpgmrzwzxA6G7lOfz2ZxE6dg=
Date: Tue, 21 Jan 2020 15:02:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v8 5/6] hw/ppc/Kconfig: Enable TPM_SPAPR as part of
 PSERIES config
Message-ID: <20200121040255.GF265522@umbus.fritz.box>
References: <20200108161012.1821385-1-stefanb@linux.ibm.com>
 <20200108161012.1821385-6-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SnV5plBeK2Ge1I9g"
Content-Disposition: inline
In-Reply-To: <20200108161012.1821385-6-stefanb@linux.ibm.com>
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
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--SnV5plBeK2Ge1I9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2020 at 11:10:11AM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index f927ec9c74..b5b3519158 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -10,6 +10,7 @@ config PSERIES
>      select XICS_SPAPR
>      select XIVE_SPAPR
>      select MSI_NONBROKEN
> +    select TPM_SPAPR
> =20
>  config SPAPR_RNG
>      bool

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SnV5plBeK2Ge1I9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4md+4ACgkQbDjKyiDZ
s5KvCw//RELt+rg71BeRDLxisycHe9E1fL0zLnOiyvVmDz/QqmC4i+NhRyzbReUm
RhGF2GA+9jxbX/yvciB3ieENbgx+zZDCE3bfKtzruXq2XIZ6mT+T8xOVkDp1Z4hr
o0p/bshiAMxeuznGj6sYVQUJt3+dygBuNFs1LcuMIX9Dx5kX9CIj/5BEC7I9Ny53
tmpR/V52uZ6iWXq+2ZQsJbtd6eMfp5OzbfLrFOfldHRkHMdIQOzleQUNYyNfsdao
AJRoaJrVCNT47PV5wZT1ox8+GOc1LpfOHHgQxRb2kdGm14JylaTumKmqr8hEosBr
Z3w/Dugpas1lv6ybOOm2SKDkjKSgI4dRse0eD87hEgQVgSdtHyMDowsQe0+qyBfV
8OvFEIOSzNt1U76RfzqMzKoD908m7Ogn/KUA67dIhznRFiDcdUO1yMHo+iBP83U7
q1QMUvH8QmBmFotllwyzQF6gRlsG10OYfk74XlVOmf2EfHrXm7Zj4h3CI7ELclE9
T53GSNNOT3a4UHjnHrXMh+I7Og/YiEAYmTbwezRv4mCwszZX4UmskMb4ik5G1a+0
4F30hLCLwUZ7tFh4Wny4KeqldojqW/K5mcClV8ImbkHi3F+MdzcpOeN5KRutUJTk
SbQDGPQnkS2O6Is3pzmobrRzWn/6y+ZslCIfibAW8tDlH1wxxOw=
=W9am
-----END PGP SIGNATURE-----

--SnV5plBeK2Ge1I9g--

