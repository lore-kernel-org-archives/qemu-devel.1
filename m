Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D78C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2587222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cRW0pLCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2587222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii0VR-00015K-Q6
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 13:26:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ii0UH-0007uA-EY
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:25:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ii0UF-0006TJ-Jg
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:25:25 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38073
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ii0UF-0006Qb-Ab
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576779921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rGT60n5YtyUB9DqMMcSFyXjeVQmK1I0D/ZYWh4EIaF4=;
 b=cRW0pLCLAYkmshf96o07BkEiVi05K2D75XCEVVQ+ieU8/P5Z4faUsjMtJpqpXbMd0uGogp
 x5rZb9sDWFiObZ5JD7cexp2SUbDbuMbqJwM5uwR10Z8QE67tN3DPhYRzoGHPJK/wS7frA9
 IaAB2pC6QYNXDhllM3JpqkwgT5xN70c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-_ARlPYcwNPa6UVu-fWkD1Q-1; Thu, 19 Dec 2019 13:25:18 -0500
X-MC-Unique: _ARlPYcwNPa6UVu-fWkD1Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC7271005513;
 Thu, 19 Dec 2019 18:25:16 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-70.gru2.redhat.com
 [10.97.116.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 18C155C1B0;
 Thu, 19 Dec 2019 18:25:14 +0000 (UTC)
Date: Thu, 19 Dec 2019 13:25:12 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 1/5] tests/boot_linux_console: Add a quick test for the
 OrangePi PC board
Message-ID: <20191219182512.GA25306@localhost.localdomain>
References: <20191217182730.943-1-f4bug@amsat.org>
 <20191217182730.943-2-f4bug@amsat.org>
 <20191219010511.GA3582@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191219010511.GA3582@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2019 at 08:05:15PM -0500, Cleber Rosa wrote:
> On Tue, Dec 17, 2019 at 07:27:26PM +0100, Philippe Mathieu-Daud=E9 wrote:
> > This test boots a Linux kernel on a OrangePi PC board and verify
> > the serial output is working.
> >=20
> > The kernel image and DeviceTree blob are built by the Raspbian
> > project (based on Debian):
> > https://www.raspbian.org/RaspbianImages
> >=20
> > If ARM is a target being built, "make check-acceptance" will
> > automatically include this test by the use of the "arch:arm" tags.
> >=20
> > Alternatively, this test can be run using:
> >=20
> >   $ make check-venv
> >   $ ./tests/venv/bin/avocado --show=3Dconsole,app run -t machine:orange=
pi-pc tests/acceptance/boot_linux_console.py
> >   JOB ID     : 2e4d15eceb13c33672af406f08171e6e9de1414a
> >   JOB LOG    : ~/job-results/job-2019-12-17T05.46-2e4d15e/job.log
> >   (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_ar=
m_orangepi:
> >   console: Uncompressing Linux... done, booting the kernel.
> >   console: Booting Linux on physical CPU 0x0
> >   console: Linux version 4.20.7-sunxi (root@armbian.com) (gcc version 7=
.2.1 20171011 (Linaro GCC 7.2-2017.11)) #5.75 SMP Fri Feb 8 09:02:10 CET 20=
19
> >   console: CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=3D50c=
5387d
> >   console: CPU: div instructions available: patching division code
> >   console: CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instr=
uction cache
> >   console: OF: fdt: Machine model: Xunlong Orange Pi PC
> >   console: Memory policy: Data cache writealloc
> >   console: OF: reserved mem: failed to allocate memory for node 'cma@4a=
000000'
> >   console: cma: Failed to reserve 128 MiB
> >   console: psci: probing for conduit method from DT.
> >   console: psci: PSCIv0.2 detected in firmware.
> >   console: psci: Using standard PSCI v0.2 function IDs
> >   console: psci: Trusted OS migration not required
> >   console: random: get_random_bytes called from start_kernel+0x8d/0x3c2=
 with crng_init=3D0
> >   console: percpu: Embedded 18 pages/cpu @(ptrval) s41228 r8192 d24308 =
u73728
> >   console: Built 1 zonelists, mobility grouping on.  Total pages: 32480
> >   console: Kernel command line: printk.time=3D0 console=3DttyS0,115200
> >   PASS (8.59 s)
> >   JOB TIME   : 8.81 s
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > ---
> >  tests/acceptance/boot_linux_console.py | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >=20
> > diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> > index 7e41cebd47..820239e439 100644
> > --- a/tests/acceptance/boot_linux_console.py
> > +++ b/tests/acceptance/boot_linux_console.py
> > @@ -411,6 +411,32 @@ class BootLinuxConsole(Test):
> >          self.wait_for_console_pattern('Boot successful.')
> >          # TODO user command, for now the uart is stuck
> > =20
> > +    def test_arm_orangepi(self):
>=20
> Maybe rename the test to include the full machine type?  I mean,
> "test_arm_orangepi_pc"?
>=20
> > +        """
> > +        :avocado: tags=3Darch:arm
> > +        :avocado: tags=3Dmachine:orangepi-pc
> > +        """
> > +        deb_url =3D ('https://apt.armbian.com/pool/main/l/'
> > +                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armh=
f.deb')
> > +        deb_hash =3D '1334c29c44d984ffa05ed10de8c3361f33d78315'
> > +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> > +        kernel_path =3D self.extract_from_deb(deb_path,
> > +                                            '/boot/vmlinuz-4.20.7-sunx=
i')
> > +        dtb_path =3D '/usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi=
-pc.dtb'
> > +        dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
> > +
> > +        self.vm.set_machine('orangepi-pc')

Missed this on the previous message: you should drop this line, as the
machine type will be set automatically (given a machine tag exists)
since ba21bde93.

- Cleber.

> > +        self.vm.set_console()
> > +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> > +                               'console=3DttyS0,115200n8 '
> > +                               'earlycon=3Duart,mmio32,0x1c28000')
> > +        self.vm.add_args('-kernel', kernel_path,
> > +                         '-dtb', dtb_path,
> > +                         '-append', kernel_command_line)
> > +        self.vm.launch()
> > +        console_pattern =3D 'Kernel command line: %s' % kernel_command=
_line
> > +        self.wait_for_console_pattern(console_pattern)
> > +
> >      def test_s390x_s390_ccw_virtio(self):
> >          """
> >          :avocado: tags=3Darch:s390x
> > --=20
> > 2.21.0
> >=20
>=20
> Either way,
>=20
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> Tested-by: Cleber Rosa <crosa@redhat.com>



--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl37wIgACgkQZX6NM6Xy
CfNZnw//a7BYM529Tkgrssl/gkKEqJeyT0Ftz5baaz659b38cO6jsjlbAFJse7pJ
MEebW+309wuhQaXWOPdtKCc3ynzzrSg4RaK1Vp4XTwyXkEQHTg6T2pZNM/pcOrne
4wra3kMSTkxCR2yFUJ07aGHgU9rJN80N2uT1GNLvd7PUGz3rPqR473y0FWLG9Nc+
bmO8XCOnglsE+MAkCQ1n/aJHINDpMRdEZdaJgTWj2OsPDGYvg1fDL8KN9liGfDOd
2FFImZwEwRecz7qsN8xBatWvm63iry3WYq974BixmJxeYsKuDNFHoJoEcByTBIT9
39E+dlb/y8Nuqtsjn7N3plZVxnatevrGS5oC5Pj/4TkHalhD4IZ6qxGN7zAhJ6Lf
swdEnX1INuH+37SF9BBK6Zk9NThaxR5UrARKt5byzaD2I3ReFgd1aGnXn3uyRhSb
ks9oauPF32KocY6TKp/qpXch2umTeU9gKOt60er4Rp+5bI4aTigNW6ZcW/Rxzqt5
3ATWjsy9yEYvN5KJhLO2EpF6qOWukfuCgCJI/qcdAggYr5Djk1ELxZJlP5GFiIqo
uY2rfG0cG7KYy9A+acdBYoXoF9BgJ6T3Qq5kp4oGIASMHlzpGLyCiMKxYFycrHnW
fUUq7CERgCjsAK8WU1XQqWTestlwxvthA9GepOSa8X6DJiDwZNw=
=hkcH
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--


