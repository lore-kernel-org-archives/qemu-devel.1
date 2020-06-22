Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD83C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58326206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DAB+J14D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58326206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnHYl-0003Bk-La
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 04:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jnHXN-0001s2-Uk; Mon, 22 Jun 2020 04:10:41 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:60537 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jnHXJ-0006Fd-KP; Mon, 22 Jun 2020 04:10:41 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49r2CS4lcvz9sSd; Mon, 22 Jun 2020 18:10:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1592813428;
 bh=Rn0WlC5NdVJOxpVIEIKwBJEf5DsssHRiGOqgtD6ip0M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DAB+J14DyD696nbBF0rFxt0S5Bgv03kpFbNpRriiIDmIaMtwTOtmLntV4uqARvlSy
 KngmoXYAt1hgTfSHuJEPl0O5LaECO9pe9I/iAVD25zDTwdYnWAkT5OO3EQ9e7lin61
 GQZkL4aDFQiWJUk0WMLrQtox7NyI2FzI+3xqeNeI=
Date: Mon, 22 Jun 2020 17:50:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] ppc/pnv: Silence missing BMC warning with qtest
Message-ID: <20200622075059.GS17085@umbus.fritz.box>
References: <159280903824.485572.831378159272329707.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="A3RWl4qWgABmkY4K"
Content-Disposition: inline
In-Reply-To: <159280903824.485572.831378159272329707.stgit@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Cc: qemu-ppc@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--A3RWl4qWgABmkY4K
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 08:57:18AM +0200, Greg Kurz wrote:
> The device introspect test in qtest emits some warnings with the
> the pnv machine types during the "nodefaults" phase:
>=20
> TEST check-qtest-ppc64: tests/qtest/device-introspect-test
> qemu-system-ppc64: warning: machine has no BMC device. Use '-device
> ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10' to define
> one
> qemu-system-ppc64: warning: machine has no BMC device. Use '-device
> ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10' to define
> one
> qemu-system-ppc64: warning: machine has no BMC device. Use '-device
> ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10' to define
> one
>=20
> This is expected since the pnv machine doesn't create the internal
> BMC simulator fallback when "-nodefaults" is passed on the command
> line, but these warnings appear in ci logs and confuse people.
>=20
> Not having a BMC isn't recommended but it is still a supported
> configuration, so a straightforward fix is to just silent this
> warning when qtest is enabled.
>=20
> Fixes: 25f3170b0654 ("ppc/pnv: Create BMC devices only when defaults are =
enabled")
> Reported-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.1, thanks.

> ---
>  hw/ppc/pnv.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 806a5d9a8d34..1622d29b4ba7 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -21,6 +21,7 @@
>  #include "qemu-common.h"
>  #include "qemu/units.h"
>  #include "qapi/error.h"
> +#include "sysemu/qtest.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/numa.h"
>  #include "sysemu/reset.h"
> @@ -587,9 +588,11 @@ static void pnv_reset(MachineState *machine)
>      bmc =3D pnv_bmc_find(&error_fatal);
>      if (!pnv->bmc) {
>          if (!bmc) {
> -            warn_report("machine has no BMC device. Use '-device "
> -                        "ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=
=3Dbmc0,irq=3D10' "
> -                        "to define one");
> +            if (!qtest_enabled()) {
> +                warn_report("machine has no BMC device. Use '-device "
> +                            "ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,=
bmc=3Dbmc0,irq=3D10' "
> +                            "to define one");
> +            }
>          } else {
>              pnv_bmc_set_pnor(bmc, pnv->pnor);
>              pnv->bmc =3D bmc;
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--A3RWl4qWgABmkY4K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7wYuEACgkQbDjKyiDZ
s5JGmw/9HGJP8EC44LkaUmadz174zyRx9n1UmUnueaBEH3OpdFVcQBAct/Q7zrl2
Fnc2+NORWUy21L/Ec/hb/GZClqK02QX1gNoxX7X16dsHbobw7i2Ghy0EH/fFRDU6
TDHZw25jOm+SFeLGjR7T0XRkZ4DWpS4oFaN1o9C31T/FCqDKGQssv1tvZdcjAbed
CBpZYdcuSqQJM1g2HiAvVWskWjobi1WuvJmmOsm8G3Oc7xrHB0DQrdSNz/A6BZoL
i2Kiic8ejicBY7yMhRvuLP8jQFh5y4mmBDtN2g/OWPjIdWGmxRGQ4kbMGYtr5Q9q
ALF3O2qBbBLEo3/19YEF+Vm89u0W7r5Z4Yw+Fuss2daLtAGEkOiGjxchAd4xgDur
VOgQZVocFV8g2RRpCrzSs7n15qyl0NYXYCtEGNdaFjS9f6AFa/3qAGwpTchisNlP
Nxao+Q+RIvAqwL1o4IrKsgxmRIO6l4DEYVFluY5LrLQcOQSCj8aQL62XJ75LfOND
6vUip5ZMgTqTF8qnxzxsk4KIa1Dg//tRZ1TPZx2MMPkaJNc/tXJmzZV97plFjZsp
WvU5YSESxGYD5MCgGA918EtvqBWDMFLWz5rwoShK5W27m4KDTXZQGh7tD17rKMvI
mWBe4cED5DkK8qDdFNvj08hJCR/59sS83nk/Vt75htim8KEXSpY=
=xKEo
-----END PGP SIGNATURE-----

--A3RWl4qWgABmkY4K--

