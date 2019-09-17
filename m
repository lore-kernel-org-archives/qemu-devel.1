Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0366C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 00:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B3B21848
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 00:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aET2hiH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B3B21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iANUd-00016r-97
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 20:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iANTr-0000c3-T1
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 20:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iANTq-0004jm-7U
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 20:05:59 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52425 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iANTo-0004iF-RK; Tue, 17 Sep 2019 20:05:58 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46Y0cb4xLVz9sPD; Wed, 18 Sep 2019 10:05:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568765151;
 bh=nyrBVaWsTIRnt0QWIOhQR17zw+wnG3HC1a11A1iI59I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aET2hiH57ARy1vRKMklAx3Jk+n6V/r2hh+jh4ZaganBYyLjHg7Mo6DO2CmafznxL/
 G+FSAZAQM23T6SIvnvX5UUXYA3aevQF52APP7IkgD85q7VwKFmy5N8ve/Nwd5NlRw0
 lezaa80AUoqV+awkwZICSV+bssmsOaB620lgdIWk=
Date: Tue, 17 Sep 2019 21:40:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190917114006.GA2440@umbus.fritz.box>
References: <20190915211940.30427-1-f4bug@amsat.org>
 <20190916004242.GF2104@umbus.fritz.box>
 <331a9dc2-d79c-3f29-d818-3df74222425b@redhat.com>
 <87lfuo1sbp.fsf@linaro.org>
 <02b9bc89-eee6-493d-3e3c-ae75b6c24657@redhat.com>
 <20190917021952.GB8842@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <20190917021952.GB8842@umbus.fritz.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 0/6] tests/acceptance: Add
 tests for the PReP/40p machine
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>,
 qemu-ppc@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2019 at 12:19:52PM +1000, David Gibson wrote:
> On Mon, Sep 16, 2019 at 11:56:06AM +0200, Philippe Mathieu-Daud=E9 wrote:
> > On 9/16/19 11:52 AM, Alex Benn=E9e wrote:
> > >=20
> > > Philippe Mathieu-Daud=E9 <philmd@redhat.com> writes:
> > >=20
> > >> Hi David,
> > >>
> > >> On 9/16/19 2:42 AM, David Gibson wrote:
> > >>> On Sun, Sep 15, 2019 at 11:19:34PM +0200, Philippe Mathieu-Daud=E9 =
wrote:
> > >>>> Quick tests worth to avoid regressions with the 40p machine.
> > >>>> idea from the "Maintainers, please tell us how to boot your machin=
es"
> > >>>> thread:
> > >>>> https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04177.html
> > >>>>
> > >>>> v2: Split Travis job, added Herv=E9 R-b tag
> > >>>> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg05896=
=2Ehtml
> > >>>>
> > >>>> Regards,
> > >>>>
> > >>>> Phil.
> > >>>
> > >>> I'm guessing you're expecting these to go in via the testing tree, =
in
> > >>> which case
> > >>>
> > >>> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> > >>
> > >> Thanks, appreciated :)
> > >>
> > >>> Or do you want me to take them via the ppc tree?
> > >>
> > >> I think the 'testing tree' should focus on the CI/testing
> > >> infrastructure, while each subsystem maintainers should care about t=
he
> > >> tests covering their subsystem (the testing tree maintainers might n=
ot
> > >> have the required knowledge to be sure a test is correctly implement=
ed).
> > >>
> > >> In this particular case I assume you don't have much knowledge of th=
at
> > >> PPC machine, which is a hobbyist one, but since you are the PPC
> > >> maintainer, I'd rather see this going via your tree :)
> > >>
> > >> Alex/Cleber/Eduardo, any comment on this position?
> > >=20
> > > Once we have a .travis.yml I'm happy with it can go in via another tr=
ee
> > > no problem. See other thread....
> >=20
> > Good :)
> >=20
> > David can take patches 1-5 (I tagged patch 6 as RFC but messed something
> > with git-publish and lost it when I sent this series).
>=20
> Ok, I've taken patches 1-5 into my ppc-for-4.2 tree.

Hrm.  Judging by both the continued comments on this thread, and the
fact it breaks the travis build, seems like this series needs a little
more work.  I've pulled it out of ppc-for-4.2 again, and I'll wait for
the next spin.

>=20
> >=20
> > Thanks!
> >=20
> > >>>> Philippe Mathieu-Daud=E9 (6):
> > >>>>   tests/acceptance: Add test that runs NetBSD 4.0 installer on PRe=
p/40p
> > >>>>   tests/acceptance: Test Open Firmware on the PReP/40p
> > >>>>   tests/acceptance: Test OpenBIOS on the PReP/40p
> > >>>>   tests/acceptance: Test Sandalfoot initrd on the PReP/40p
> > >>>>   .travis.yml: Let the avocado job run the 40p tests
> > >>>>   .travis.yml: Split enterprise vs. hobbyist acceptance test job
> > >>>>
> > >>>>  .travis.yml                      |  18 +++-
> > >>>>  MAINTAINERS                      |   1 +
> > >>>>  tests/acceptance/ppc_prep_40p.py | 150 ++++++++++++++++++++++++++=
+++++
> > >>>>  3 files changed, 167 insertions(+), 2 deletions(-)
> > >>>>  create mode 100644 tests/acceptance/ppc_prep_40p.py
> > >>>>
> > >>>
> > >=20
> > >=20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2AxhMACgkQbDjKyiDZ
s5J/YBAA1qDE56Scm0dTtRTc3+koKzp2iQx+3XGDN3IVIgzpL22LummV2zfPMlfY
+rTYDyiyOcL9h45NA8gAeO+ca1Bs0e5UN42FEwgJ3UjJZS32v/X4K+yEOuip8nZU
QgcMul1uNHGBgMN9vOxL5HBKYYLH9BRk/8Rtvc8ufjNep0bEHvCl+VIbCuz3kops
QhgWL3eXdv0KrPLxlK5Za5zgVayVbnuo+OYZYJfVW2R2dR1Jfwc0sEz0FlfpqZ2d
L8+7ann32KTGLwjmAaNRnXz4W6hsJpju3aPmUgimYc6mRakqK63ZASMWiK22s3c0
KTz8UuFVAlJgr0QB/N5BWecWsCBJrmhsgkJDs6RM8AMW0JgtjRk5JReG0NV1l4gN
sIpgjm61sfIP5I7LbW2dWX3M6Cc4nU4I+e9crK17E3YHwiNFl5cOvq+oquBNxsia
0Pvw0k+lBjx3hKdAW1B3fRi6mFG8mNGioEWs9tWdtjTERog2br2TiiFtoCDwqm68
EWQxZvSWAZKJcqCEV50qQCLRWsg124Yb92S/XDplQXD+QrrHnIm6iY+jW+jgk7b5
VcOiZkCESgjdzvgnuD7P8npv7AE3JCBpLtx8nzjNLOR3DzhQMLOy0S59JvzQ5BZV
2F3BNjdEqDWTpFVaS2qEQJxvrpNHmQIfXDCmrTtmXscUSvcOjP8=
=V3Fe
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--

