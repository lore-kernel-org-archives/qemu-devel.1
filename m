Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7662C3524C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 00:44:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A62242073C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 00:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="i+snR5Ur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62242073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyPqw-0000c9-Ol
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 19:44:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyPqE-000894-77
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 19:43:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyPqC-0003PJ-FM
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 19:43:53 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:43903 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iyPqB-0003MK-9J; Sun, 02 Feb 2020 19:43:52 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 489pwd6zP8z9sS9; Mon,  3 Feb 2020 11:43:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580690625;
 bh=+d0IlzMzrC4G7P2hgMkXP8HAi1jLsoZoZ5lVrOrCbuA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i+snR5UrUIlLPPbtHhWBGT5msUV3w5zQQcIouQ6wuhqs5R2rc1g1XVfAEMioRrfFU
 10tB/flK2XmJQG7obnIdxzVUKI+7gSOVOgwsvGWG/+aDF88Ttm6ixV8J0qOKOUEZ8p
 ktA0NFL4SVuxnBrLIlXI0sX847OWjX769RicUqas=
Date: Mon, 3 Feb 2020 11:33:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] tests: Silent various warnings with pseries
Message-ID: <20200203003328.GB52446@umbus.fritz.box>
References: <158059697130.1820292.7823434132030453110.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <158059697130.1820292.7823434132030453110.stgit@bahia.lan>
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 01, 2020 at 11:46:16PM +0100, Greg Kurz wrote:
> Some default features of the pseries machine are only available with
> KVM. Warnings are printed when the pseries machine is used with another
> accelerator:
>=20
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-ccf-assist=3Don
> qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
> Interrupts(FWNMI) not supported in TCG
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-ccf-assist=3Don
> qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
> Interrupts(FWNMI) not supported in TCG
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-ccf-assist=3Don
> qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
> Interrupts(FWNMI) not supported in TCG
>=20
> This is annoying for CI since it usually runs without KVM. We already
> disable features that emit similar warnings thanks to properties of the
> pseries machine, but this is open-coded in various places. Consolidate
> the set of properties in a single place. Extend it to silent the above
> warnings. And use it in the various tests that start pseries machines.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.0.

> ---
>=20
> This patch fixes the warnings observed with David's latest pull request.
>=20
>  tests/qtest/boot-serial-test.c    |    3 ++-
>  tests/qtest/libqos/libqos-spapr.h |    8 ++++++++
>  tests/qtest/prom-env-test.c       |    3 ++-
>  tests/qtest/pxe-test.c            |    7 ++++---
>  4 files changed, 16 insertions(+), 5 deletions(-)
>=20
> diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-tes=
t.c
> index 8e8c5b0a0f0c..85a361428697 100644
> --- a/tests/qtest/boot-serial-test.c
> +++ b/tests/qtest/boot-serial-test.c
> @@ -15,6 +15,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
> +#include "libqos/libqos-spapr.h"
> =20
>  static const uint8_t kernel_mcf5208[] =3D {
>      0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
> @@ -112,7 +113,7 @@ static testdef_t tests[] =3D {
>      { "ppc64", "40p", "-m 192", "Memory: 192M" },
>      { "ppc64", "mac99", "", "PowerPC,970FX" },
>      { "ppc64", "pseries",
> -      "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken",
> +      "-machine " PSERIES_DEFAULT_CAPABILITIES,
>        "Open Firmware" },
>      { "ppc64", "powernv8", "", "OPAL" },
>      { "ppc64", "powernv9", "", "OPAL" },
> diff --git a/tests/qtest/libqos/libqos-spapr.h b/tests/qtest/libqos/libqo=
s-spapr.h
> index dcb5c43ad37d..e4460d08ae6e 100644
> --- a/tests/qtest/libqos/libqos-spapr.h
> +++ b/tests/qtest/libqos/libqos-spapr.h
> @@ -7,4 +7,12 @@ QOSState *qtest_spapr_vboot(const char *cmdline_fmt, va_=
list ap);
>  QOSState *qtest_spapr_boot(const char *cmdline_fmt, ...);
>  void qtest_spapr_shutdown(QOSState *qs);
> =20
> +/* List of capabilities needed to silent warnings with TCG */
> +#define PSERIES_DEFAULT_CAPABILITIES             \
> +    "cap-cfpc=3Dbroken,"                           \
> +    "cap-sbbc=3Dbroken,"                           \
> +    "cap-ibs=3Dbroken,"                            \
> +    "cap-ccf-assist=3Doff,"                        \
> +    "cap-fwnmi-mce=3Doff"
> +
>  #endif
> diff --git a/tests/qtest/prom-env-test.c b/tests/qtest/prom-env-test.c
> index 9be52c766fe3..60e6ec315335 100644
> --- a/tests/qtest/prom-env-test.c
> +++ b/tests/qtest/prom-env-test.c
> @@ -21,6 +21,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
> +#include "libqos/libqos-spapr.h"
> =20
>  #define MAGIC   0xcafec0de
>  #define ADDRESS 0x4000
> @@ -54,7 +55,7 @@ static void test_machine(const void *machine)
>       */
>      if (strcmp(machine, "pseries") =3D=3D 0) {
>          extra_args =3D "-nodefaults"
> -            " -machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbro=
ken";
> +            " -machine " PSERIES_DEFAULT_CAPABILITIES;
>      }
> =20
>      qts =3D qtest_initf("-M %s -accel tcg %s -prom-env 'use-nvramrc?=3Dt=
rue' "
> diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
> index f68d0aadbb4d..1161a773a4a7 100644
> --- a/tests/qtest/pxe-test.c
> +++ b/tests/qtest/pxe-test.c
> @@ -17,6 +17,7 @@
>  #include "qemu-common.h"
>  #include "libqtest.h"
>  #include "boot-sector.h"
> +#include "libqos/libqos-spapr.h"
> =20
>  #define NETNAME "net0"
> =20
> @@ -46,15 +47,15 @@ static testdef_t x86_tests_slow[] =3D {
> =20
>  static testdef_t ppc64_tests[] =3D {
>      { "pseries", "spapr-vlan",
> -      "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken,vsm=
t=3D8" },
> +      "-machine vsmt=3D8," PSERIES_DEFAULT_CAPABILITIES },
>      { "pseries", "virtio-net-pci",
> -      "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken,vsm=
t=3D8" },
> +      "-machine vsmt=3D8," PSERIES_DEFAULT_CAPABILITIES },
>      { NULL },
>  };
> =20
>  static testdef_t ppc64_tests_slow[] =3D {
>      { "pseries", "e1000",
> -      "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken,vsm=
t=3D8" },
> +      "-machine vsmt=3D8," PSERIES_DEFAULT_CAPABILITIES },
>      { NULL },
>  };
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl43algACgkQbDjKyiDZ
s5JVtg//ap93Tep9avrYZvRjz0IdmKM5KwrHsywr7DokNGIOcwUD7P2hnA9zN4Ni
H4dx4YFpNPzKvsFXop7sBrlc99CBuohDoEB6XSN79cDwT3hK7VNFnk8wyxY3oTYu
6F0rPNAhBuQfLnOuoawD+31tlzTXo9ojDzeXl8lFyVAZJkxYPBAWlTMrbV7gPj70
OP3EdaDQ7iFuES5XvfwtFMETQC5zlqcAwEx92FszHP1x3oXzkYFCKt90cpy9oHsL
W0srkzoMULUN/SJ/C4Uq1htX/nOBvHPvEQdu9eUAkPdzrxZy0VglJPv7vIIAcpVP
EpfRSV/KUddC+CDj6XLDhDyFrbL3Xu9JfVx3CWyxL6qFnbRoyZvLoIQewkOeepPT
I9hH/UJdL8urMcQIIEZnPpoMZp6dqJyOCiiayPdhxOMpZfkHzWtiAaYqHEBJ1bSv
bYreShucGulaZnI1xRe7TH6AwsuTmngYpX8C4cwVw5FUGjls/mJX5CXhwnOjqRU7
aDn/qKlzMPOl1BarC5h555hMnwEDi/4oArnDBO6Vzto+1A+oYplL2Oqhenz29mUi
gG5rO3c2kWFomtIPG6+TfHsJro9lQ8BJM7oo2oUnhKPuFEak1+X5Jro0vauHudEb
z8TH6tApPP+8j1yX4dmnLYI4ZJCFP+WZZrkD0BjdBK+WgHAyPoA=
=Xm4P
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--

