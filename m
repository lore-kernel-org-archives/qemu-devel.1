Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEFDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 06:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB8F20758
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 06:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="E9Rxxqrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB8F20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7YPH-00016C-8O
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 02:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7YOR-0000OM-Eo; Mon, 17 Aug 2020 02:13:15 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:59499 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7YOO-0003nP-BM; Mon, 17 Aug 2020 02:13:15 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BVNy76qYLz9sTK; Mon, 17 Aug 2020 16:13:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597644783;
 bh=2VsOB1rFWMjvmOy/yXsE08WLYTHphvBiQBWgM+ZDD9U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=E9RxxqrcGHrkzn7h8qVi8r3QeGOMlsauyuXI4WsO1JXGo7MEycQhoLvMIo0MvjJSa
 6EMsyyZd7U/kWcs32OO6As5yNSfnasJd4OESK7YMyiku4gpbLCCITQhuAn5Gc2R/dV
 qrNvxaa8F259A1yDA6iAn6LSoWmR/b/0fAjD/ok8=
Date: Mon, 17 Aug 2020 15:43:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 0/8] Generalize start-powered-off property from ARM
Message-ID: <20200817054306.GL12805@yekko.fritz.box>
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
 <20200817044730.GK12805@yekko.fritz.box>
 <83ebefab-8bdf-2584-53e6-e4fa0f540109@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hdW7zL/qDS6RXdAL"
Content-Disposition: inline
In-Reply-To: <83ebefab-8bdf-2584-53e6-e4fa0f540109@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--hdW7zL/qDS6RXdAL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2020 at 07:24:43AM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 8/17/20 6:47 AM, David Gibson wrote:
> > On Wed, Jul 22, 2020 at 11:56:49PM -0300, Thiago Jung Bauermann wrote:
> >> The ARM code has a start-powered-off property in ARMCPU, which is a
> >> subclass of CPUState. This property causes arm_cpu_reset() to set
> >> CPUState::halted to 1, signalling that the CPU should start in a halted
> >> state. Other architectures also have code which aim to achieve the same
> >> effect, but without using a property.
> >>
> >> The ppc/spapr version has a bug where QEMU does a KVM_RUN on the vcpu
> >> before cs->halted is set to 1, causing the vcpu to run while it's stil=
l in
> >> an unitialized state (more details in patch 3).
> >>
> >> Peter Maydell mentioned the ARM start-powered-off property and
> >> Eduardo=C2=A0Habkost suggested making it generic, so this patch series=
 does
> >> that, for all cases which I was able to find via grep in the code.
> >>
> >> The only problem is that I was only able to test these changes on a pp=
c64le
> >> pseries KVM guest, so except for patches 2 and 3, all others are only
> >> build-tested. Also, my grasp of QOM lifecycle is basically non-existan=
t so
> >> please be aware of that when reviewing this series.
> >>
> >> The last patch may be wrong, as pointed out by Eduardo, so I marked it=
 as
> >> RFC. It may make sense to drop it.
> >>
> >> Applies cleanly on yesterday's master.
> >=20
> > This series appears to break the Travis build for a MIPS target:
> >=20
> > Unexpected error in qdev_prop_set_after_realize() at /home/travis/build=
/dgibson/qemu/hw/core/qdev-properties.c:30:
> > qemu-system-mips64el: Attempt to set property 'start-powered-off' on an=
onymous device (type 'I6400-mips64-cpu') after it was realized
> > Broken pipe
> > /home/travis/build/dgibson/qemu/tests/qtest/libqtest.c:175: kill_qemu()=
 detected QEMU death from signal 6 (Aborted) (core dumped)
> > Aborted (core dumped)
> > ERROR qom-test - too few tests run (expected 8, got 0)
> > /home/travis/build/dgibson/qemu/tests/Makefile.include:650: recipe for =
target 'check-qtest-mips64el' failed
>=20
> Good catch. hw/mips/cps.c, hw/ppc/e500.c and hw/sparc/sun4m.c are
> incorrectly setting the property after the cpu is realized because
> the cpu is created with cpu_create(). We need to create them with
> object_initialize_child() and realize them manually with qdev_realize().

Thiago, can you fix that up and repost please.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hdW7zL/qDS6RXdAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl86GOgACgkQbDjKyiDZ
s5Kk0RAAzUX7OUyh7MDEbNxNR3sWIUe+gOjFWWBb+ryDkbluHYAeJxaQIijJkpA+
a2LpVis2NWxh9dBw1u/kGn/lQljxfY5DKQUfSU5zrrS392MqdROsjGfFUlicUthH
QRhNYmPMSTHQ4fyYykGknI04Xxl6ynt8gcCtIfV1eVbvsvVXBrPnyL570U0D+6y/
b9zlMHdRfRlP3DC+xZN8AmKfXaiDlMD5uNpdrd6na2AmaqIYZZy/aJ21V8Xj3ivB
dDsN6rtBCzed4dsYoOpkIpokeCB4PVBK9MOs+yY988vWE+2qnhCYw0Djf11+KdYZ
OX3Uti293iC9K+frBoh5M4lhl3AYSQsY/OLjZZTgt6aovOElU8yDmv5h1tlBblTH
/5ikOZyarrUQuDWvoY5sZIkHJbympLUi8p8xRluC3JPkTSB1NptipN11qR9ls05Q
/ZQONetrt+p/DoGoWiPv27m3bHLH3pEGUAetP0xOOWAWeicLoiJ8EMHawPOY4SiN
KstOnasfPslPczslvmHVEBVxZH99qf44EAj3DhPVte5aMHsYblxGgiIO1tzKQygF
0DCIjjiYpJmlFux4fV418FKMxkwy06eorfSIe4DIUaFBSif2NVAgZQpRkET1yxkS
Jte0+lW7/IQ0PLfV1kfqsDKF/S4rZCHyFHHF1DJaw0rA4vOwg6Q=
=3lpU
-----END PGP SIGNATURE-----

--hdW7zL/qDS6RXdAL--

