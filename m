Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACC8C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 01:40:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0611220730
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 01:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WYMUpcvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0611220730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXbS9-0000uM-3f
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 20:40:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXbR7-0008OB-5W
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 20:39:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXbR5-0006Qh-G4
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 20:39:08 -0500
Received: from ozlabs.org ([203.11.71.1]:38223)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1iXbR4-0006OO-OW
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 20:39:07 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47JMfZ2jmxz9sPV; Thu, 21 Nov 2019 12:39:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574300342;
 bh=3RWkHYwhMluUL1KdAL2uSn7QZlQszsw+t+2wFzycclU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WYMUpcvfKizE+Nj4iuqvLi4e4LUTsbbrysyBINEiuB3DCXYtITMRpTqggaDLegb53
 c0EyhX/jLKXg6097DvHM2uPWqbgbwWrS7vRnU37/09+HL4Uyg5JcaghX0I6IjNbpNz
 zEaMIie2CzVa3R9XgeiDeoyclhH+PmRXkrqZJ0x0=
Date: Thu, 21 Nov 2019 12:26:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] pseries: fix migration-test and pxe-test
Message-ID: <20191121012628.GO5582@umbus.fritz.box>
References: <20191120142539.236279-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+qeiGE2Ip5triyhT"
Content-Disposition: inline
In-Reply-To: <20191120142539.236279-1-lvivier@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--+qeiGE2Ip5triyhT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2019 at 03:25:39PM +0100, Laurent Vivier wrote:
> Commit 29cb4187497d ("spapr: Set VSMT to smp_threads by default")
> has introduced a new default value for VSMT that is not supported
> by old kernels (before 4.13 kernel) and this breaks "make check"
> on these kernels.
>=20
> To fix that, explicitly set in the involved tests the value that was
> used as the default value before the change.
>=20
> Cc: Greg Kurz <groug@kaod.org>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Applied to ppc-for-4.2, thanks.

> ---
>  tests/migration-test.c | 4 ++--
>  tests/pxe-test.c       | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index ac780dffdaad..ebd77a581aff 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -614,7 +614,7 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
>          end_address =3D S390_TEST_MEM_END;
>      } else if (strcmp(arch, "ppc64") =3D=3D 0) {
>          extra_opts =3D use_shmem ? get_shmem_opts("256M", shmem_path) : =
NULL;
> -        cmd_src =3D g_strdup_printf("-machine accel=3D%s -m 256M -nodefa=
ults"
> +        cmd_src =3D g_strdup_printf("-machine accel=3D%s,vsmt=3D8 -m 256=
M -nodefaults"
>                                    " -name source,debug-threads=3Don"
>                                    " -serial file:%s/src_serial"
>                                    " -prom-env 'use-nvramrc?=3Dtrue' -pro=
m-env "
> @@ -623,7 +623,7 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
>                                    "until' %s %s",  accel, tmpfs, end_add=
ress,
>                                    start_address, extra_opts ? extra_opts=
 : "",
>                                    opts_src);
> -        cmd_dst =3D g_strdup_printf("-machine accel=3D%s -m 256M"
> +        cmd_dst =3D g_strdup_printf("-machine accel=3D%s,vsmt=3D8 -m 256=
M"
>                                    " -name target,debug-threads=3Don"
>                                    " -serial file:%s/dest_serial"
>                                    " -incoming %s %s %s",
> diff --git a/tests/pxe-test.c b/tests/pxe-test.c
> index 948b0fbdc727..aaae54f7550d 100644
> --- a/tests/pxe-test.c
> +++ b/tests/pxe-test.c
> @@ -46,15 +46,15 @@ static testdef_t x86_tests_slow[] =3D {
> =20
>  static testdef_t ppc64_tests[] =3D {
>      { "pseries", "spapr-vlan",
> -      "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken" },
> +      "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken,vsm=
t=3D8" },
>      { "pseries", "virtio-net-pci",
> -      "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken" },
> +      "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken,vsm=
t=3D8" },
>      { NULL },
>  };
> =20
>  static testdef_t ppc64_tests_slow[] =3D {
>      { "pseries", "e1000",
> -      "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken" },
> +      "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken,vsm=
t=3D8" },
>      { NULL },
>  };
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+qeiGE2Ip5triyhT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3V58EACgkQbDjKyiDZ
s5JKPBAA1T3RWyHkWADFnbUaE5IkDPSKryODrU7Gz6b/XKECw31xDcPYWmCpk0Le
I+TfYhCyfLjPKwOSCJ22JOG7CMxKcEI1mVHgIjovotCG5lYxgslbCuyFRir/9Gqj
7PKtwsv9rGIbgjQfoTS/OSCLzA78tl16JeIo9ce9+H6ECNypKGMR+Om0LRIFPXQ3
l4W8jvFFsqNEIdedmAnlp+gEZjkCEl+14UVv2bl9/K3Di9XJ9Ijf7dj0kpjogKCf
Sj18/1hnreYB0UOsqSpbqriKaix3LrFb/SitGO6E4zfuK2IGGWtYPJJKc7SmRGAR
xJuGsbeRdS6wXcGi0NEU6TLzuYN80UKjcSPbN5dHbORjyK2PTQKhmgjo6ClaT6ZK
YLk533/pQ586I54Qlf3s0jacv582cbbNGaN0E+hWyyN+8rnksmcJKYtaqfAbRNl9
O/vcbKmhtEYoT+vRXm3N7OlbdcPWmDYt1FFKyymBXQYJnVtMuGC4kRU7mO+RzehE
NqvKP2Hh0+gTD2MpWwNcVoyTmx80EB6PstmPR95FSmImnXO4+a9O2DKBqJuXj7jo
ijEAMlm2l7k34OztOPaInlNIx9WrxiRBrVYPJC5bxnCxLZPfhk5UWU5YpHPy26Hx
uFpMyEdwP5AslluqNj1MRAVGbCibz/se733OvKHB1Xdwq4JqSx4=
=1LA6
-----END PGP SIGNATURE-----

--+qeiGE2Ip5triyhT--

