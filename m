Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67315C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 07:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD5320767
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 07:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YwX7zGAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD5320767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9kP2-00041m-Fn
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 03:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k9kOR-0003MR-N2; Sun, 23 Aug 2020 03:26:19 -0400
Received: from ozlabs.org ([203.11.71.1]:46197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k9kOP-0003xk-0V; Sun, 23 Aug 2020 03:26:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BZ6Hk23MLz9sTS; Sun, 23 Aug 2020 17:26:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1598167570;
 bh=Taygr7WHvI0fOQO8fF+eIY5bJ5dGP6vegjaZBDNI5kQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YwX7zGAFtOHIOWrc9ix926pnUGQbn5c3qdWMdOeCgFRJd87wrYjiOWX0dvTgz2hdy
 CZCA9Ora8hKddwruiAA7agU+JznMuIY61fVJJqg7vsarPm/+a6hLeeB0PyoBQlBFGj
 DHfsOAEFI88DHyrckNTKVkYRw+N6SH5MvOWVpPCU=
Date: Sun, 23 Aug 2020 17:14:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v6 4/8] ppc/e500: Use start-powered-off CPUState property
Message-ID: <20200823071413.GB4734@yekko.fritz.box>
References: <20200819164306.625357-1-bauerman@linux.ibm.com>
 <20200819164306.625357-5-bauerman@linux.ibm.com>
 <3dd050ad-147e-c365-883a-3384130b0d2f@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
In-Reply-To: <3dd050ad-147e-c365-883a-3384130b0d2f@kaod.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 03:26:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>,
 qemu-ppc@nongnu.org, Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2020 at 10:59:56AM +0200, C=E9dric Le Goater wrote:
> Hello,
>=20
> On 8/19/20 6:43 PM, Thiago Jung Bauermann wrote:
> > Instead of setting CPUState::halted to 1 in ppce500_cpu_reset_sec(), use
> > the start-powered-off property which makes cpu_common_reset() initializ=
e it
> > to 1 in common code.
> >=20
> > Also change creation of CPU object from cpu_create() to object_new() and
> > qdev_realize_and_unref() because cpu_create() realizes the CPU and it's=
 not
> > possible to set a property after the object is realized.
> >=20
> > Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>=20
>=20
> This is breaking make check :=20
>=20
>     tests/qtest/libqtest.c:175: kill_qemu() detected QEMU death from sign=
al 11 (Segmentation fault) (core dumped)
>     ERROR boot-serial-test - too few tests run (expected 7, got 0)
>     make: *** [/home/legoater/work/qemu/qemu-powernv-5.2.git/tests/Makefi=
le.include:650: check-qtest-ppc64] Error 1
>     make: *** Waiting for unfinished jobs....
>    =20
>    =20
>     gdb --args build/ppc64-softmmu/qemu-system-ppc64  -display none   -M =
ppce500
>     ...
>     Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation faul=
t.
>     0x000055555596ebf2 in ppce500_init (machine=3D0x5555567aa6e0)
>         at /home/legoater/work/qemu/qemu-powernv-5.2.git/hw/ppc/e500.c:880
>     880	        irqs[i].irq[OPENPIC_OUTPUT_INT] =3D input[PPCE500_INPUT_I=
NT];
> =20
>    =20
>     AFAIUI, 'input is not initialized since the CPU is not yet
>     realized.

Sigh.  For future reference, Thiago, running an all-targets make check
is pretty much a minimum bar to test before posting.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9CF0MACgkQbDjKyiDZ
s5JTLQ/+Lg+3IJI8SUhL6CEBtvG7ocdZkQGhlKeJMIYI8+9KZgB+2F491dDeX8zj
VVGvwzaLB9o3TmYM9ZXy+/Z8OTm+qgpboHcgMF/BpUaYuB+/besDJ8Q/hWEEaNbw
i/Xh750DWFNjtDMfsBK7uv8jkElOzUv/bpt4OVyouZvd1EDPCZH2BsRJjeew4R+s
q/JL/S2xTVA5Yr5oCCdA8YQAECNOnbSxUzA+EZX9jNvNrxMUntGoayKLdrRF4O4P
KAOxn+le+rSthd9iHBUadk5Rb9Fe1Z2oQ1JObQj07YOtu+fpwC+KkVGyrTeiMpUp
qxvs61GivAxloCC545mxoGdqOGtHteNN3UKU25fJG5QYekLh3+Cy3LlAuoqMoJ8n
2qBZRIDKCrHEzxFS1CN5wtPSNno+0PCMvhGhqaIP648DS++kxM1gON1eFgHm6HPb
xZc8E3cVHou2pzvBRYZ3fyfhL74zAIxa0VAInWIQcz+Ni/SwqJ3BYaCRMRvw/rT7
wa2ZnnrHtX1wzaDXdyDYkQ6HktysOVv61imR8v2kjaDdA9uPqSU/kVO4HVhPwPRQ
TTurBkvpKA/PNQZbM2qIOFMYbfS0NKsyBVeVvKlW8ssEBaIPU5d//lJ4shLK1C/P
VR3lrkM82/VKP+cxuTGdc7X1kOHZIjSrYGt4gZvC/vfCbXFLOUk=
=iifx
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--

