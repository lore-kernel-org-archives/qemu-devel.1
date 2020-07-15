Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342C0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 06:02:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9E4C20663
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 06:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YWtLwB8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E4C20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvaUy-0003fa-6H
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 02:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jvaUI-0003Ea-1b
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 02:01:50 -0400
Received: from ozlabs.org ([203.11.71.1]:47485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jvaUD-0007zo-J0
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 02:01:49 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B66G943FHz9sRf; Wed, 15 Jul 2020 16:01:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594792897;
 bh=mEgpZswK5gcHEurKGj/o5j3Ydh8yvimmPjGrQIAJ6hw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YWtLwB8IoI12A9H02cdxAwizUsNpD/ru3YL2TwdEfaaM8YRKxkKf6QzifHpwYpJ/S
 lVXhdgHfoxK8x6CjnN0AmBkHQBrJMAU5qyxTkPFsXinoAkq1yDRRcVrjzTmK+YNUn4
 zrD+DlSuVunBZEWBPIwA0drAPXXhi7dL+cthDSr0=
Date: Wed, 15 Jul 2020 14:06:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] .travis.yml: skip ppc64abi32-linux-user with plugins
Message-ID: <20200715040619.GG93134@umbus.fritz.box>
References: <20200714175516.5475-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+QwZB9vYiNIzNXIj"
Content-Disposition: inline
In-Reply-To: <20200714175516.5475-1-alex.bennee@linaro.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:01:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--+QwZB9vYiNIzNXIj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2020 at 06:55:16PM +0100, Alex Benn=E9e wrote:
> We actually see failures on threadcount running without plugins:
>=20
>   retry.py -n 1000 -c -- \
>     ./ppc64abi32-linux-user/qemu-ppc64abi32 \
>     ./tests/tcg/ppc64abi32-linux-user/threadcount
>=20
> which reports:
>=20
>   0: 978 times (97.80%), avg time 0.270 (0.01 varience/0.08 deviation)
>   -6: 21 times (2.10%), avg time 0.336 (0.01 varience/0.12 deviation)
>   -11: 1 times (0.10%), avg time 0.502 (0.00 varience/0.00 deviation)
>   Ran command 1000 times, 978 passes
>=20
> But when running with plugins we hit the failure a lot more often:
>=20
>   0: 91 times (91.00%), avg time 0.302 (0.04 varience/0.19 deviation)
>   -11: 9 times (9.00%), avg time 0.558 (0.01 varience/0.11 deviation)
>   Ran command 100 times, 91 passes
>=20
> The crash occurs in guest code which is the same in both pass and fail
> cases. However we see various messages reported on the console about
> corrupted memory lists which seems to imply the guest memory allocation
> is corrupted. This lines up with the seg fault being in the guest
> __libc_free function. So we think this is a guest bug which is
> exacerbated by various modes of translation. If anyone has access to
> real hardware to soak test the test case we could prove this properly.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

Honestly, AFAICT the ppc64abi32-linux-user target is pretty much
entirely broken anyway.  Many things about it appear to make no
sense, it's difficult to work out what it's even supposed to be, and I
strongly suspect no-one's actually used it in like a decade.

> ---
>  .travis.yml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index ab429500fc..6695c0620f 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -350,9 +350,10 @@ jobs:
>      # Run check-tcg against linux-user (with plugins)
>      # we skip sparc64-linux-user until it has been fixed somewhat
>      # we skip cris-linux-user as it doesn't use the common run loop
> +    # we skip ppc64abi32-linux-user as it seems to have a broken libc
>      - name: "GCC plugins check-tcg (user)"
>        env:
> -        - CONFIG=3D"--disable-system --enable-plugins --enable-debug-tcg=
 --target-list-exclude=3Dsparc64-linux-user,cris-linux-user"
> +        - CONFIG=3D"--disable-system --enable-plugins --enable-debug-tcg=
 --target-list-exclude=3Dsparc64-linux-user,cris-linux-user,ppc64abi32-linu=
x-user"
>          - TEST_BUILD_CMD=3D"make build-tcg"
>          - TEST_CMD=3D"make check-tcg"
>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+QwZB9vYiNIzNXIj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8OgLkACgkQbDjKyiDZ
s5JcBA/+LBQk1r+bwxe9VN3e0takVMZwnx3f6oA3MMumd3lH/74BSHZoKOI7SR6s
FVJdmpnGH5FZ8lvQ+LeFzaLKGq6+vAsMBZNz/2qhj4ES39slzaYxVwvGNqAhvy7Y
Eh08qUJhxi1i84ynNbsrVqUqv7LDbh1LR6+OdVTOTXrkxzu243dN6GmiPkRh16o1
VMa4Dhvf9Y/aKlfRS6gRIEqms5bn1tGZvZCZQh4G4ao/Y1H2jR7KNk+sM5BVWWSQ
4gaoz+sgXAPsbpy6QYlQXCzV6gc+XKdBDVNxDCmk5ToQQzGRYifBYLsIvKVW+3+0
t6D7ERfdzwBVY13LfuyVDsQohzOdeu8x6MoCTeOYH0zm91KaDVJRDWS+kaW58xkI
DDHQQnPNCgAcSeUQV6hRstVHq4uV+H3PXnHhPph6h1JKdqyxjXftS/zC/VxIfA/8
MUHRupVGp7/zvO0rpfj7ZTfepN+zk0TjdGZMhf/9cdVKpio8kghp6jGPRvwQNaq+
WRtJI7czTmQ0AkBkzY2z0At6P12yXSbCrvdz002xSkO/E7ApScvDADXFW1yXjEzM
JGI1Seyr5Egf2LyL5dKkhrKwuSvydRiajRnEBcurUnvYhUnmyHee7agtaEy4aN/A
WTE/omxRnulv6LArpHX/JDZc09J/PSRJacJ6GhZRJvUMwfxk0tk=
=gTlo
-----END PGP SIGNATURE-----

--+QwZB9vYiNIzNXIj--

