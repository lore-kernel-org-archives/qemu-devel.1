Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C71C35249
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 00:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5DAD2073C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 00:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="FCw3SjjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5DAD2073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyPqv-0000aO-Ou
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 19:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyPqE-000893-2n
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 19:43:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyPqC-0003PV-Jr
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 19:43:53 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:32857 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iyPqB-0003MI-Bg; Sun, 02 Feb 2020 19:43:52 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 489pwd5LfDz9sRs; Mon,  3 Feb 2020 11:43:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580690625;
 bh=vHJ7qL6Y38DL8sZv/Zy5m/IekMcUKeKEt+6GM3tqNpw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FCw3SjjZvxf/vpN3gK6MTQ9dZZH1R3iCnwrnJXQXzBdEnk2G/mB7r8Z8M2vyy/j9Z
 9ueXZEOZr+ZAyRo1XZXy8M/fpHcIC9LIEorZ8xKiUVWcTZcsUswjtXm9VeVghiWaNe
 /g3VAEP3JM7woLiNG0cZAVgndRHjB4Cj1eHhbmRA=
Date: Mon, 3 Feb 2020 11:32:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH] tests: Silent various warnings with pseries
Message-ID: <20200203003240.GA52446@umbus.fritz.box>
References: <158059697130.1820292.7823434132030453110.stgit@bahia.lan>
 <alpine.BSF.2.22.395.2002021815430.56200@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2002021830010.56200@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.22.395.2002021830010.56200@zero.eik.bme.hu>
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
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 02, 2020 at 06:31:17PM +0100, BALATON Zoltan wrote:
> On Sun, 2 Feb 2020, BALATON Zoltan wrote:
> > On Sat, 1 Feb 2020, Greg Kurz wrote:
> > > Some default features of the pseries machine are only available with
> > > KVM. Warnings are printed when the pseries machine is used with anoth=
er
> > > accelerator:
> > >=20
> > > qemu-system-ppc64: warning: TCG doesn't support requested feature,
> > > cap-ccf-assist=3Don
> > > qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
> > > Interrupts(FWNMI) not supported in TCG
> > > qemu-system-ppc64: warning: TCG doesn't support requested feature,
> > > cap-ccf-assist=3Don
> > > qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
> > > Interrupts(FWNMI) not supported in TCG
> > > qemu-system-ppc64: warning: TCG doesn't support requested feature,
> > > cap-ccf-assist=3Don
> > > qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
> > > Interrupts(FWNMI) not supported in TCG
> > >=20
> > > This is annoying for CI since it usually runs without KVM. We already
> > > disable features that emit similar warnings thanks to properties of t=
he
> > > pseries machine, but this is open-coded in various places. Consolidate
> > > the set of properties in a single place. Extend it to silent the above
>=20
> Actually at least 3 places:
> - In commit title,
> - the line in commit message above,
> - and in comment below
> where typo exists.

I've patched those in my tree.

>=20
> Regards,
> BALATON Zoltan
>=20
> > > warnings. And use it in the various tests that start pseries machines.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >=20
> > > This patch fixes the warnings observed with David's latest pull reque=
st.
> > >=20
> > > tests/qtest/boot-serial-test.c    |    3 ++-
> > > tests/qtest/libqos/libqos-spapr.h |    8 ++++++++
> > > tests/qtest/prom-env-test.c       |    3 ++-
> > > tests/qtest/pxe-test.c            |    7 ++++---
> > > 4 files changed, 16 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/tests/qtest/boot-serial-test.c
> > > b/tests/qtest/boot-serial-test.c
> > > index 8e8c5b0a0f0c..85a361428697 100644
> > > --- a/tests/qtest/boot-serial-test.c
> > > +++ b/tests/qtest/boot-serial-test.c
> > > @@ -15,6 +15,7 @@
> > >=20
> > > #include "qemu/osdep.h"
> > > #include "libqtest.h"
> > > +#include "libqos/libqos-spapr.h"
> > >=20
> > > static const uint8_t kernel_mcf5208[] =3D {
> > >     0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
> > > @@ -112,7 +113,7 @@ static testdef_t tests[] =3D {
> > >     { "ppc64", "40p", "-m 192", "Memory: 192M" },
> > >     { "ppc64", "mac99", "", "PowerPC,970FX" },
> > >     { "ppc64", "pseries",
> > > -      "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken=
",
> > > +      "-machine " PSERIES_DEFAULT_CAPABILITIES,
> > >       "Open Firmware" },
> > >     { "ppc64", "powernv8", "", "OPAL" },
> > >     { "ppc64", "powernv9", "", "OPAL" },
> > > diff --git a/tests/qtest/libqos/libqos-spapr.h
> > > b/tests/qtest/libqos/libqos-spapr.h
> > > index dcb5c43ad37d..e4460d08ae6e 100644
> > > --- a/tests/qtest/libqos/libqos-spapr.h
> > > +++ b/tests/qtest/libqos/libqos-spapr.h
> > > @@ -7,4 +7,12 @@ QOSState *qtest_spapr_vboot(const char
> > > *cmdline_fmt, va_list ap);
> > > QOSState *qtest_spapr_boot(const char *cmdline_fmt, ...);
> > > void qtest_spapr_shutdown(QOSState *qs);
> > >=20
> > > +/* List of capabilities needed to silent warnings with TCG */
> >=20
> > Typo: I think it should be "to silence warnings" both here and in commit
> > message.
> >=20
> > Regards,
> > BALATON Zoltan
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl43aiUACgkQbDjKyiDZ
s5JptA/+MmCtjoPdR3cC+4KyNnHdOogMtvtOgC9vTZfT5oWgOgkVyL95FUO3xC6n
maNCj/L8i4WcWcT/DstVDfxPCGMeaBSmqwLx+P48ThNvY2s8IzNH5s0TpOqJJKxA
zKCAgitTgOJncfoRn1R1Vagi63Pb2MBY4IQF2aKdjWXyy3rSqtKYtZRs01MgnOa0
IutyN1txIkm1B37C3OKl5xJ45SQFL6JhfOIGOqqdhZ+9LB9BRh+gPcYi7uOk/nlg
k692jTgeZ7bYGxxskEJm3nMLs5BWNJma7ulzn2EWDidt1DvWxDX0ETFtd0KoVFlL
P41tnrBNgZHJcRLHgpBtWA8/F2+CorG7jeps6ft28dP8jgWBs+I9vAakxIsuFJj7
8oQumMcDfN4SBYTvSSo+nD4NFJPt6vfdoxhN3mtmRUwzuCuGsYDKVGer4JQUUfK9
oIFP43lTjyu4IiXE8wSkf0epTLOFjKx7orxYXT7BufKWGDeV/UFY+A+OuefAwobL
9FRYGqtR9n+Tra1Iry8uHKcoCpK+rhMG05qE5WOwUS0e88vvRPNwelH4263nNMYm
rwvYWkWGdsHqqoT80Q1nQKRwDPe1XT5/qTsR9CHwtCEvC/f2FnzF8gdNYWSTfuRU
5mL2XJXaaU+5lEWnHZtTehn7F4Nf8fv6BF6lSEoVcu2hUnNwHbo=
=gZ1w
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--

