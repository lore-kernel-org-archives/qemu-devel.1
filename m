Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12FBC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 01:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B2B422314
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 01:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjclOZ88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2B422314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihkGc-0000eO-L6
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 20:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ihkFs-00008g-9l
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 20:05:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ihkFo-0002KJ-Ta
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 20:05:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38264
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ihkFo-0002IJ-CX
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 20:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576717523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=68fSqYCY47UGUagdKMmhGH8yB2hUE4pNbQBVVoPPpU0=;
 b=UjclOZ88v0Tq+ZAZRQ4oYLaOmHn+eARiHBV/z6CjBb4XKamn/Oi8Krxwhg8KMkOR6JbkyO
 4lfWwiVNwK99++s6lgTmnNfHGFI49jdZq9GOlSlmKWJyJLwBrhE2K0b+1sD+exBg7ZBQWg
 S+QHtls2fJi4o9Sdiizojh45TrAW7h4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-f-uCtzv9OWWQHgiRUfh74Q-1; Wed, 18 Dec 2019 20:05:17 -0500
X-MC-Unique: f-uCtzv9OWWQHgiRUfh74Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D62F1800D4E;
 Thu, 19 Dec 2019 01:05:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-25.gru2.redhat.com
 [10.97.116.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21EA119C58;
 Thu, 19 Dec 2019 01:05:13 +0000 (UTC)
Date: Wed, 18 Dec 2019 20:05:11 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 1/5] tests/boot_linux_console: Add a quick test for the
 OrangePi PC board
Message-ID: <20191219010511.GA3582@localhost.localdomain>
References: <20191217182730.943-1-f4bug@amsat.org>
 <20191217182730.943-2-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20191217182730.943-2-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2019 at 07:27:26PM +0100, Philippe Mathieu-Daud=E9 wrote:
> This test boots a Linux kernel on a OrangePi PC board and verify
> the serial output is working.
>=20
> The kernel image and DeviceTree blob are built by the Raspbian
> project (based on Debian):
> https://www.raspbian.org/RaspbianImages
>=20
> If ARM is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:arm" tags.
>=20
> Alternatively, this test can be run using:
>=20
>   $ make check-venv
>   $ ./tests/venv/bin/avocado --show=3Dconsole,app run -t machine:orangepi=
-pc tests/acceptance/boot_linux_console.py
>   JOB ID     : 2e4d15eceb13c33672af406f08171e6e9de1414a
>   JOB LOG    : ~/job-results/job-2019-12-17T05.46-2e4d15e/job.log
>   (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_=
orangepi:
>   console: Uncompressing Linux... done, booting the kernel.
>   console: Booting Linux on physical CPU 0x0
>   console: Linux version 4.20.7-sunxi (root@armbian.com) (gcc version 7.2=
.1 20171011 (Linaro GCC 7.2-2017.11)) #5.75 SMP Fri Feb 8 09:02:10 CET 2019
>   console: CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=3D50c53=
87d
>   console: CPU: div instructions available: patching division code
>   console: CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruc=
tion cache
>   console: OF: fdt: Machine model: Xunlong Orange Pi PC
>   console: Memory policy: Data cache writealloc
>   console: OF: reserved mem: failed to allocate memory for node 'cma@4a00=
0000'
>   console: cma: Failed to reserve 128 MiB
>   console: psci: probing for conduit method from DT.
>   console: psci: PSCIv0.2 detected in firmware.
>   console: psci: Using standard PSCI v0.2 function IDs
>   console: psci: Trusted OS migration not required
>   console: random: get_random_bytes called from start_kernel+0x8d/0x3c2 w=
ith crng_init=3D0
>   console: percpu: Embedded 18 pages/cpu @(ptrval) s41228 r8192 d24308 u7=
3728
>   console: Built 1 zonelists, mobility grouping on.  Total pages: 32480
>   console: Kernel command line: printk.time=3D0 console=3DttyS0,115200
>   PASS (8.59 s)
>   JOB TIME   : 8.81 s
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 7e41cebd47..820239e439 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -411,6 +411,32 @@ class BootLinuxConsole(Test):
>          self.wait_for_console_pattern('Boot successful.')
>          # TODO user command, for now the uart is stuck
> =20
> +    def test_arm_orangepi(self):

Maybe rename the test to include the full machine type?  I mean,
"test_arm_orangepi_pc"?

> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:orangepi-pc
> +        """
> +        deb_url =3D ('https://apt.armbian.com/pool/main/l/'
> +                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.=
deb')
> +        deb_hash =3D '1334c29c44d984ffa05ed10de8c3361f33d78315'
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        kernel_path =3D self.extract_from_deb(deb_path,
> +                                            '/boot/vmlinuz-4.20.7-sunxi'=
)
> +        dtb_path =3D '/usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-p=
c.dtb'
> +        dtb_path =3D self.extract_from_deb(deb_path, dtb_path)
> +
> +        self.vm.set_machine('orangepi-pc')
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'console=3DttyS0,115200n8 '
> +                               'earlycon=3Duart,mmio32,0x1c28000')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', dtb_path,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
> +        self.wait_for_console_pattern(console_pattern)
> +
>      def test_s390x_s390_ccw_virtio(self):
>          """
>          :avocado: tags=3Darch:s390x
> --=20
> 2.21.0
>=20

Either way,

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl36zMQACgkQZX6NM6Xy
CfOHow/5AVRnYJoVicGYtyIp9Mq6PvE+zCWD5RDQpsBlS619LYFfDdtVb3GRDIpj
fQQkbht019M2r4F+wV3G4LZRAjnbwGPXJBB1dg29yLdGwp4T3/TvnNyUiIlIonAM
HrzlyCVicOMkX35oHIMIXWVXaP26Oi8qosGr1oSTuYuJd25ay4sLmm0S0W9AODfF
RGcO3gbbiosO7Mx0oz1yy/T2ehdfVzrkJ9dr08CKEoY53BRCLhlspSCVAOztdc4a
Nh52stypvyxvp91QkS2OQraXycOYtWRPCxAZ0c0tZykOdhWJAjDF68yON2OsyoZv
pEB9NPFKKtY2b2ifPoCOHEMyhyoZ38kM1afM2XzGtWh1bM8yTtns6JW2dy6MYbLO
WjW1MyTNb7Nuyo1YanSUthxKwgcaNvJl2soqYp1oPnD4ikwyAS7aRn8CVDCFMKC7
jODmos/UDS/UmeHee8wXgvwJJySiKh9+OgXh4n2vbKj8vuywAla5iGvKjnH1sft3
ZtfTxgnO8hA17lU8gNqfqy6GbxPTAxmaSCOe0RP6bo7N/joIpqRyFd4s6unTJISd
NvUHORrDlA6nFqKSVL8i8iT5sBeEEyZTKbd8fnKF0LKm6CIxrpuwaFxPR0lAta0V
/tbz/km59QaZzPZQ6quYM3YbOA/hj8y2SnuZCsZZ+uOKIR8mm4U=
=A1AX
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--


