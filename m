Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22CAC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B58222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebHmD09y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B58222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii0Xh-0005Ix-7M
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 13:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ii0Rv-0004VY-0y
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:23:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ii0Rr-0003fk-Qf
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:22:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32860
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ii0Rr-0003YG-BR
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576779774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ac6Za8XAbQ8HeWSLgAeIz0eKhoGODHToUjlPHiwcjxY=;
 b=ebHmD09ybRlIVhS/QP+0V/Gmot0thMVsB7zE8WSJ1jlKxv+MuXu1cuu4/Kev87ToDeQJNl
 csFodghIGLm3n4vKGxYn5n7XPA7JMkqF+iWCzrIhABM7s5BfqbTO3zFPGAjRVL5asthl45
 kuus5Kxm4hKi9bBqOOjQCk0mvpEd5Fo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-HSv8HGNWNLWX_Lw8UQY4Fw-1; Thu, 19 Dec 2019 13:22:49 -0500
X-MC-Unique: HSv8HGNWNLWX_Lw8UQY4Fw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF4D3107ACC4;
 Thu, 19 Dec 2019 18:22:47 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-70.gru2.redhat.com
 [10.97.116.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 45B9226E6E;
 Thu, 19 Dec 2019 18:22:43 +0000 (UTC)
Date: Thu, 19 Dec 2019 13:22:39 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 2/5] tests/boot_linux_console: Add initrd test for the
 Orange Pi PC board
Message-ID: <20191219182239.GA24165@localhost.localdomain>
References: <20191217182730.943-1-f4bug@amsat.org>
 <20191217182730.943-3-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20191217182730.943-3-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2019 at 07:27:27PM +0100, Philippe Mathieu-Daud=E9 wrote:
> This test boots a Linux kernel on a OrangePi PC board and verify
> the serial output is working.
>=20
> The kernel image and DeviceTree blob are built by the Raspbian
> project (based on Debian):
> https://www.raspbian.org/RaspbianImages
>=20
> The cpio image used comes from the linux-build-test project:
> https://github.com/groeck/linux-build-test
>=20
> If ARM is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:arm" tags.
>=20
> Alternatively, this test can be run using:
>=20
>   $ avocado --show=3Dconsole run -t machine:orangepi-pc tests/acceptance/=
boot_linux_console.py
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
>   [...]
>   console: Trying to unpack rootfs image as initramfs...
>   console: Freeing initrd memory: 3256K
>   console: Freeing unused kernel memory: 1024K
>   console: Run /init as init process
>   console: mount: mounting devtmpfs on /dev failed: Device or resource bu=
sy
>   console: Starting logging: OK
>   console: Initializing random number generator... random: dd: uninitiali=
zed urandom read (512 bytes read)
>   console: done.
>   console: Starting network: OK
>   console: Found console ttyS0
>   console: Linux version 4.20.7-sunxi (root@armbian.com) (gcc version 7.2=
.1 20171011 (Linaro GCC 7.2-2017.11)) #5.75 SMP Fri Feb 8 09:02:10 CET 2019
>   console: Boot successful.
>   console: cat /proc/cpuinfo
>   console: / # cat /proc/cpuinfo
>   console: processor      : 0
>   console: model name     : ARMv7 Processor rev 5 (v7l)
>   console: BogoMIPS       : 125.00
>   console: Features       : half thumb fastmult vfp edsp neon vfpv3 tls v=
fpv4 idiva idivt vfpd32 lpae evtstrm
>   console: CPU implementer        : 0x41
>   console: CPU architecture: 7
>   console: CPU variant    : 0x0
>   console: CPU part       : 0xc07
>   console: CPU revision   : 5
>   [...]
>   console: processor      : 3
>   console: model name     : ARMv7 Processor rev 5 (v7l)
>   console: BogoMIPS       : 125.00
>   console: Features       : half thumb fastmult vfp edsp neon vfpv3 tls v=
fpv4 idiva idivt vfpd32 lpae evtstrm
>   console: CPU implementer        : 0x41
>   console: CPU architecture: 7
>   console: CPU variant    : 0x0
>   console: CPU part       : 0xc07
>   console: CPU revision   : 5
>   console: Hardware       : Allwinner sun8i Family
>   console: Revision       : 0000
>   console: Serial         : 0000000000000000
>   console: cat /proc/iomem
>   console: / # cat /proc/iomem
>   console: 01000000-010fffff : clock@1000000
>   console: 01c00000-01c00fff : system-control@1c00000
>   console: 01c02000-01c02fff : dma-controller@1c02000
>   [...]
>   console: reboot
>   console: / # reboot
>   console: / # Found console ttyS0
>   console: Stopping network: OK
>   console: hrtimer: interrupt took 21852064 ns
>   console: Saving random seed... random: dd: uninitialized urandom read (=
512 bytes read)
>   console: done.
>   console: Stopping logging: OK
>   console: umount: devtmpfs busy - remounted read-only
>   console: umount: can't unmount /: Invalid argument
>   console: The system is going down NOW!
>   console: Sent SIGTERM to all processes
>   console: Sent SIGKILL to all processes
>   console: Requesting system reboot
>   console: reboot: Restarting system
>   PASS (48.32 s)
>   JOB TIME   : 49.16 s
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  tests/acceptance/boot_linux_console.py | 41 ++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 820239e439..daabd47404 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -437,6 +437,47 @@ class BootLinuxConsole(Test):
>          console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
>          self.wait_for_console_pattern(console_pattern)
> =20
> +    def test_arm_orangepi_initrd(self):

Like in the previous patch, isn't it a good idea to name this after the exa=
ct
machine model, that is, test_arm_orangepi_pc_initrd?

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
> +        initrd_url =3D ('https://github.com/groeck/linux-build-test/raw/=
'
> +                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
> +                      'arm/rootfs-armv7a.cpio.gz')
> +        initrd_hash =3D '604b2e45cdf35045846b8bbfbf2129b1891bdc9c'
> +        initrd_path_gz =3D self.fetch_asset(initrd_url, asset_hash=3Dini=
trd_hash)
> +        initrd_path =3D os.path.join(self.workdir, 'rootfs.cpio')
> +        archive.gzip_uncompress(initrd_path_gz, initrd_path)
> +
> +        self.vm.set_machine('orangepi-pc')

There's no need to set the machine type manually since ba21bde93, the
one set by the ":avocado: tags=3Dmachine" will be used.

Tested-by: Cleber Rosa <crosa@redhat.com>

If this line is dropped:

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl37v+0ACgkQZX6NM6Xy
CfM0UQ/+KlZKFMP1Z+n+3P/dhHONJSxepUZJp83ZFVIuF+F1I10LUj6E0xCy4MYV
c+ic+zkPof0RDrx3kZg7SSxC0G1k4eJlr5rVgK5uKEIJaTHBR/oRrPXxKTj553qL
CZWk4JZy+25rPrC5jSRYm3hWv6eLFbKyir6xmHnD2f39QrBD64Ywn+9ZJD+Gg/VC
MmmVfUrOSaEEK29tI1kY7YsRsKMWny/FE/+cy6jpiq88zWx/AS2L9/+Ew6FB7hjJ
eVBNxTdt6xBxe3+fQrDE/3TxWD8GuABOqR0x4fwfo9Mv2uRzzASh0D8vv6poT8Ru
EoqZoHy2TrNTSuXFZItJ3FS3N7KcEI/nn90gQJd4XNL9s4kz3IWzhM0iFaTe0ZKW
KmWC7q+oAQBXBieIdgnqscHPS08ZdD+WMlOw2pO5YEntyAJlJ6+kzOC2ilIfosB0
AWplQE0DfGWtIfcj+UgU0Lm4AySq4lGe8T2zzbqVVIvgUK9/LuHckc8tTfvVuJ9R
sCkP9klYlkgpVy7m9zDqzd45RXX4uFxnLNrooMX24MF6kIksfIp31qDQ6vABMaSt
f1MPA4ujyMsdCLud+PG94WRQ9M5ooYwfltaIJjbje6YBuMMfnzbFMX7MHAaQvf6H
pv+uO7j87Jf4LBbOXZbPzxGcGGZpHSgMn5EIWfOrbCixjd2ytM8=
=av1r
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--


