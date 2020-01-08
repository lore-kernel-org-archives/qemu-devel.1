Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E97C33C9B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 02:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02AA320692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 02:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="O9PouYbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AA320692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59397 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip0k9-0004Wg-M7
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 21:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip0ie-0002dF-Mt
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 21:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip0id-0007h9-AS
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 21:05:12 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:39833 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ip0ic-0007ei-Ew
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 21:05:11 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47ssyV1MXlz9sPK; Wed,  8 Jan 2020 13:05:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578449106;
 bh=yX7B77BeDwyDuT79LX1ksSMfneIUQSYsS8nmXRhfZKw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=O9PouYbM/RzmVsfEl+fu5YVchqQZgNbYySlG1y4NMKS1bGgQR/Nah13I+fxYVxBD5
 0BpMeKNtol1TQUyUcb9cuHKIfty40Ocdkeur7cCDa0bMFFmvEzUwqbmthfBBv4sJkv
 lWYNMB0NoHIghMEOUNKLeZ0YipRLBasptD6IyTs0=
Date: Wed, 8 Jan 2020 12:02:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] migration-test: ppc64: fix FORTH test program
Message-ID: <20200108010243.GG2137@umbus.fritz.box>
References: <20200107163437.52139-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TeJTyD9hb8KJN2Jy"
Content-Disposition: inline
In-Reply-To: <20200107163437.52139-1-lvivier@redhat.com>
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
Cc: Wei Huang <wei@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--TeJTyD9hb8KJN2Jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 05:34:37PM +0100, Laurent Vivier wrote:
> Commit e51e711b1bef has moved the initialization of start_address and
> end_address after the definition of the command line argument,
> where the nvramrc is initialized, and thus the loop is between 0 and 0
> rather than 1 MiB and 100 MiB.
>=20
> It doesn't affect the result of the test if all the tests are run in
> sequence because the two first tests don't run the loop, so the
> values are correctly initialized when we actually need them.
>=20
> But it hangs when we ask to run only one test, for instance:
>=20
>     QTEST_QEMU_BINARY=3Dppc64-softmmu/qemu-system-ppc64 \
>     tests/migration-test -m=3Dquick -p /ppc64/migration/validate_uuid_err=
or
>=20
> Fixes: e51e711b1bef ("tests/migration: Add migration-test header file")
> Cc: wei@redhat.com
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  tests/migration-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 53afec439522..341d19092214 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -480,14 +480,14 @@ static int test_migrate_start(QTestState **from, QT=
estState **to,
>      } else if (strcmp(arch, "ppc64") =3D=3D 0) {
>          machine_opts =3D "vsmt=3D8";
>          memory_size =3D "256M";
> +        start_address =3D PPC_TEST_MEM_START;
> +        end_address =3D PPC_TEST_MEM_END;
>          arch_source =3D g_strdup_printf("-nodefaults "
>                                        "-prom-env 'use-nvramrc?=3Dtrue' -=
prom-env "
>                                        "'nvramrc=3Dhex .\" _\" begin %x %=
x "
>                                        "do i c@ 1 + i c! 1000 +loop .\" B=
\" 0 "
>                                        "until'", end_address, start_addre=
ss);
>          arch_target =3D g_strdup("");
> -        start_address =3D PPC_TEST_MEM_START;
> -        end_address =3D PPC_TEST_MEM_END;
>      } else if (strcmp(arch, "aarch64") =3D=3D 0) {
>          init_bootfile(bootpath, aarch64_kernel, sizeof(aarch64_kernel));
>          machine_opts =3D "virt,gic-version=3Dmax";

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TeJTyD9hb8KJN2Jy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4VKjMACgkQbDjKyiDZ
s5Klcw//Yk1MOnYt6TflhZ4SpYwubmD3WqG0VHqtIk/hSxG85ixu3pOZl3RmZZol
5uIrb2pMnWgALZeQn3lAxzQD7ptWLBnv5bcVr7NQ9EqZh/wMBMXGEdgmgRk/XMVK
a4bakaFLyYfCeCHo9RZK3QIPV8zY4WYm2AELMjDz1nGZCHFKgml+AMgHOk5A3GxW
Zbn8pnZBIyVjTK7B/Q6K1VvaoYdFAnS8WSSgUoip3WT4NZziiZystzTMEJq3/n7V
cGWI+8Z238Xz0babTkpxA2415U8jbNAPTDQyjEMkrHmuULuenwaYtowCMFnhkIbg
8MSFuupqXJ9TQ+sEksUin3GMq9umMAHAACKAUMvRH3ELRDXhokEJz5fkONcErgfs
S6b7yBMANGT+QCRMGbCn2Jo+gXjqA622oe5DaL5M0Fj/A7s/iGeaeGXMYIf6nH8H
upA3HrQmwx5cu0zben/X9LzJEUurrrrdJ4UABSnCc0FXIWfp59gkt9m5lC4zfE3G
bKU7DBe8MY1HucGnmbq/3CAL4/kaUjKdJSSDykhAclycSjGSP/jxInN80RLxsGAn
BCCTJ146Cr2jYsIqsKbjEE2GyvYwOBXbbaHZNbPD1BSZZ49CmU3f3SzN8ot4tX8J
uDv2byRnB6ylnkYj66xOUGsbIVT7NmJGhMjBrpzaof0Oq/7sads=
=BCE2
-----END PGP SIGNATURE-----

--TeJTyD9hb8KJN2Jy--

