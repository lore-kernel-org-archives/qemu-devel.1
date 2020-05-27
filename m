Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204B3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 03:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB18A2073B
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 03:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="N3Cdz195"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB18A2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdmZi-0003vL-37
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 23:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdmYV-000278-UM; Tue, 26 May 2020 23:16:35 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:51979 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdmYR-00009n-NE; Tue, 26 May 2020 23:16:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49Www41y3Pz9sSd; Wed, 27 May 2020 13:16:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590549380;
 bh=BZkQL3QRcclK3i1HhJaa7ebNzlXSHK9ubyEOnZTi6tY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=N3Cdz1958+YCcNQYA5zZ4TkdHzc69Wvm1EK4JiROOnQO1NcojSs3RCujEM+ItNSCH
 qzVViaXpA0ZY8jQ52WBNgSHaSmohXqTR/p6FzXwrUDvl3NUuottt4vM9CgF0lwj8Qd
 7AAaSuqTOcelsWeAR82LUziiuek0P79CURR4F//Y=
Date: Wed, 27 May 2020 10:40:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] target/ppc: Fix argument to
 ppc_radix64_partition_scoped_xlate() again
Message-ID: <20200527004032.GG23110@umbus.fritz.box>
References: <159051003729.407106.10610703877543955831.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TdkiTnkLhLQllcMS"
Content-Disposition: inline
In-Reply-To: <159051003729.407106.10610703877543955831.stgit@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--TdkiTnkLhLQllcMS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2020 at 06:20:37PM +0200, Greg Kurz wrote:
> The penultimate argument of function ppc_radix64_partition_scoped_xlate()
> has the bool type.
>=20
> Fixes: d04ea940c597 "target/ppc: Add support for Radix partition-scoped t=
ranslation"
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>=20
> A patch fixing the same issue in other places was merged recently in
> ppc-for-5.1. Maybe worth squashing the two patches into one ?

I haven't done this, because it ran into some conflicts that I didn't
want to spend time resolving.

>=20
> commit 372ef6e9b803ef10c3200c45311d218e2c97b218
> Author: Greg Kurz <groug@kaod.org>
> Date:   Thu May 14 00:57:13 2020 +0200
>=20
>     target/ppc: Fix arguments to ppc_radix64_partition_scoped_xlate()
> ---
>  target/ppc/mmu-radix64.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index 0d3922537c4c..c60bf3135734 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -513,7 +513,7 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr e=
addr, int rwx,
> =20
>              ret =3D ppc_radix64_partition_scoped_xlate(cpu, rwx, eaddr, =
g_raddr,
>                                                       pate, raddr, &prot,=
 &psize,
> -                                                     0, guest_visible);
> +                                                     false, guest_visibl=
e);
>              if (ret) {
>                  return ret;
>              }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TdkiTnkLhLQllcMS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7Ntv0ACgkQbDjKyiDZ
s5K8BQ//Z0A+DH2/2XL03R2aM66lpNK5CXHioIj4J3BVfSHour7vZuWWOIQOjoC+
urcv6tuzNbA/+oWgHQ1IivJb2zOvGv93uBuGoNgh7zoSEbAX1W4EF4B4lwZIPqwd
rdgELWyptjdM0L+DtSo5VjhN3mgiSfBbyy4TdJP5CwdhBwGMdaxEkBNSEyZYl82W
AD2M3EenYsNYakKVhW0E93DIsmgMzD8rSn4wFEzuuFdW6XBAxjrh+NtqNoOeM/uV
ic40hHqQn6a3/Z7SlXG24EYWYt+z3lmMklRPM9lxpPmLp/dX/T9RCMmUZJwVWN2K
xm4oVfiwyu23yZM2dAlmaZjBsLfQEZalA+h75hCoZQ9CWHcXjokhA8HKfdjq2c74
U9UQo1ttIAOqfuovQ7wmIaFs9CtkF8GoPZ12h1b5DkP6BRk93vdt1bp20VptMV1Z
GCWJk4YPgpDRiuGcll0hMs1ns0/mGf3fYYoFZNcx+TPY/M1kBjnU6fx4aderBDjn
1+nMDKj7pjkt6rhulv+wjtOqSaGaY3+s5HlJ7R0Wj+uWkhRKYcO7G+HIYQKtUJ+C
DFgxwNtgPC/5IBOx3iBfoLTPpuOLcEc+vl7xoM28QJBGjo/Tl0sFOg6xmx8G6EVN
8Ebbvv//yyHq4OCfggJl0z6lgqc/RHG1DZh9ugmXbV/euIli2Ek=
=u2hR
-----END PGP SIGNATURE-----

--TdkiTnkLhLQllcMS--

