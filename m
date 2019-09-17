Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86393C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 02:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EFAF206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 02:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="SsLbkPUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFAF206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA38L-0002mF-HM
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 22:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iA376-0002B8-NQ
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 22:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iA374-0007sI-Ti
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 22:21:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55559 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iA373-0007mO-Ud; Mon, 16 Sep 2019 22:21:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46XRfy6LXBz9sNf; Tue, 17 Sep 2019 12:20:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568686858;
 bh=rguvgPna7oX1gFj57iuJvztTRnDgs1ufFLjHuh7RDqc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SsLbkPUQI4XBQ1bymDq+R+nwfd5u1BE3plq3HlK0Rppbh3FMd8x6GD6tnoWaV9/a2
 09qTuPFqkIsqc1/T+CD6KNpCOUaGynRj7DVBGzMoFUmslqC8nZgzESdnZF7Dp4MjCc
 zI6pyj91B0DFOpijQZoTybd4YCSA21LhdZzDfxv8=
Date: Tue, 17 Sep 2019 12:19:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190917021952.GB8842@umbus.fritz.box>
References: <20190915211940.30427-1-f4bug@amsat.org>
 <20190916004242.GF2104@umbus.fritz.box>
 <331a9dc2-d79c-3f29-d818-3df74222425b@redhat.com>
 <87lfuo1sbp.fsf@linaro.org>
 <02b9bc89-eee6-493d-3e3c-ae75b6c24657@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
In-Reply-To: <02b9bc89-eee6-493d-3e3c-ae75b6c24657@redhat.com>
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


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2019 at 11:56:06AM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 9/16/19 11:52 AM, Alex Benn=E9e wrote:
> >=20
> > Philippe Mathieu-Daud=E9 <philmd@redhat.com> writes:
> >=20
> >> Hi David,
> >>
> >> On 9/16/19 2:42 AM, David Gibson wrote:
> >>> On Sun, Sep 15, 2019 at 11:19:34PM +0200, Philippe Mathieu-Daud=E9 wr=
ote:
> >>>> Quick tests worth to avoid regressions with the 40p machine.
> >>>> idea from the "Maintainers, please tell us how to boot your machines"
> >>>> thread:
> >>>> https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04177.html
> >>>>
> >>>> v2: Split Travis job, added Herv=E9 R-b tag
> >>>> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg05896.h=
tml
> >>>>
> >>>> Regards,
> >>>>
> >>>> Phil.
> >>>
> >>> I'm guessing you're expecting these to go in via the testing tree, in
> >>> which case
> >>>
> >>> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> >>
> >> Thanks, appreciated :)
> >>
> >>> Or do you want me to take them via the ppc tree?
> >>
> >> I think the 'testing tree' should focus on the CI/testing
> >> infrastructure, while each subsystem maintainers should care about the
> >> tests covering their subsystem (the testing tree maintainers might not
> >> have the required knowledge to be sure a test is correctly implemented=
).
> >>
> >> In this particular case I assume you don't have much knowledge of that
> >> PPC machine, which is a hobbyist one, but since you are the PPC
> >> maintainer, I'd rather see this going via your tree :)
> >>
> >> Alex/Cleber/Eduardo, any comment on this position?
> >=20
> > Once we have a .travis.yml I'm happy with it can go in via another tree
> > no problem. See other thread....
>=20
> Good :)
>=20
> David can take patches 1-5 (I tagged patch 6 as RFC but messed something
> with git-publish and lost it when I sent this series).

Ok, I've taken patches 1-5 into my ppc-for-4.2 tree.

>=20
> Thanks!
>=20
> >>>> Philippe Mathieu-Daud=E9 (6):
> >>>>   tests/acceptance: Add test that runs NetBSD 4.0 installer on PRep/=
40p
> >>>>   tests/acceptance: Test Open Firmware on the PReP/40p
> >>>>   tests/acceptance: Test OpenBIOS on the PReP/40p
> >>>>   tests/acceptance: Test Sandalfoot initrd on the PReP/40p
> >>>>   .travis.yml: Let the avocado job run the 40p tests
> >>>>   .travis.yml: Split enterprise vs. hobbyist acceptance test job
> >>>>
> >>>>  .travis.yml                      |  18 +++-
> >>>>  MAINTAINERS                      |   1 +
> >>>>  tests/acceptance/ppc_prep_40p.py | 150 ++++++++++++++++++++++++++++=
+++
> >>>>  3 files changed, 167 insertions(+), 2 deletions(-)
> >>>>  create mode 100644 tests/acceptance/ppc_prep_40p.py
> >>>>
> >>>
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2AQsgACgkQbDjKyiDZ
s5KROw/+JGD76EeTglxkrK18hlqWMm67BzjSGFYMLogHaoBK0stn8dc/dne5qtpR
i7tb1fhclqH2QSBNgKEyUfjwFgL3XAsAmc+lIStXohIVbd66KM5pvlNJlCbyzdW9
audjyj4ClYCFOsFKOO1BAL1H1oVGw8HglHyrR6hj47UXlpQafnEmz/4yeWDdI35R
+GjbffuAqfTbmwEnQLZihJTDLMRw4FU0gAGUfIv2sURmybTjZr4NHSFtHo7ETuU3
tmv2k6c2zqtumaYvQv884hjGyrv98m2amuYw4DBc0R1UnlBSHbiWLJgEvzISD2ti
NihTExyD+B+b+8OYh4TVoj6xlE+wSeYCELFvyV/plQrDho8+Kynf7CrgxMUl0Csf
ZXeKQUrtPJlsemPm4xL+Wt0Pqej6YQ3NMK4hpEodQFDEPM2r6NzhnmJtHhm+gMkz
EvxP621bpprIKxwke7XULn+kS2lE17A7F8eTz49GLWPHbZgibdTeElMXl8j8vLTU
zTIXVBRpN4GbbXmQvql4oY3XPQQqXTbsth333VWgOFRTcvJ8qmKp97Abl1Cxo1vh
dDWuu88WZUrvaK4iomEVn1w0xHyjWNQNlhVNbioO6Ux+7+8U14N75VkcX4b+NGxJ
a2AiJTDsfBTD8vqWhQvIp68ICEgrb+KyVhkq0sq727Jy+QZcixM=
=w849
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--

