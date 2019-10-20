Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358B2CA9EA9
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 06:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC6A8222C2
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 06:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="L2V80CxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6A8222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iM4to-0002J3-4R
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 02:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iM4sr-0001ei-Vq
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 02:40:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iM4sq-0007A3-6b
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 02:40:09 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47091 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iM4sp-00078F-Hf; Sun, 20 Oct 2019 02:40:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46wqrg6RTgz9sPL; Sun, 20 Oct 2019 17:40:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571553603;
 bh=/eEOGbV1S2m8MGPKnAYLAGT15xwV68enxcijY/vPLq0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L2V80CxDvV9D6EhcDLM9glfKh7HOSNvRxcuiYKli1D9hc/udYrhmOUV2Q2E0m5E3L
 AMX1eygK1iEMz6lnLL1kCS6IKxiUS5AD9JSIpBpuH2nRBWkCIV2+lU8avo2zYp9uHD
 vj5aB/ftBme+9d6Bee+YEZliKZklkBAN3VBj5ar8=
Date: Sun, 20 Oct 2019 17:36:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH v3 1/9] Acceptance tests: refactor wait_for_console_pattern
Message-ID: <20191020063642.GJ1960@umbus.fritz.box>
References: <20191017165239.30159-1-f4bug@amsat.org>
 <20191017165239.30159-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gBdJBemW82xJqIAr"
Content-Disposition: inline
In-Reply-To: <20191017165239.30159-2-f4bug@amsat.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
 qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--gBdJBemW82xJqIAr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2019 at 06:52:31PM +0200, Philippe Mathieu-Daud=E9 wrote:
> From: Cleber Rosa <crosa@redhat.com>
>=20
> The same utility method is already present in two different test
> files, so let's consolidate it into a single utility function.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Message-Id: <20190916164011.7653-1-crosa@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> [PMD: rebased fixing conflicts in linux_ssh_mips_malta.py]
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  tests/acceptance/avocado_qemu/__init__.py | 26 +++++++++++++
>  tests/acceptance/boot_linux_console.py    | 47 +++++++----------------
>  tests/acceptance/linux_ssh_mips_malta.py  | 18 ++-------
>  3 files changed, 42 insertions(+), 49 deletions(-)
>=20
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
> index bd41e0443c..a0fe16e47f 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -8,6 +8,7 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
> =20
> +import logging
>  import os
>  import sys
>  import uuid
> @@ -53,6 +54,31 @@ def pick_default_qemu_bin(arch=3DNone):
>          return qemu_bin_from_src_dir_path
> =20
> =20
> +def wait_for_console_pattern(test, success_message,
> +                             failure_message=3D'Kernel panic - not synci=
ng'):
> +    """
> +    Waits for messages to appear on the console, while logging the conte=
nt
> +
> +    :param test: an Avocado test containing a VM that will have its cons=
ole
> +                 read and probed for a success or failure message
> +    :type test: :class:`avocado_qemu.Test`
> +    :param success_message: if this message appears, test succeeds
> +    :param failure_message: if this message appears, test fails
> +    """
> +    console =3D test.vm.console_socket.makefile()
> +    console_logger =3D logging.getLogger('console')
> +    while True:
> +        msg =3D console.readline().strip()
> +        if not msg:
> +            continue
> +        console_logger.debug(msg)
> +        if success_message in msg:
> +            break
> +        if failure_message in msg:
> +            fail =3D 'Failure message found in console: %s' % failure_me=
ssage
> +            test.fail(fail)
> +
> +
>  class Test(avocado.Test):
>      def setUp(self):
>          self._vms =3D {}
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 8a9a314ab4..9ff2213874 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -9,12 +9,12 @@
>  # later.  See the COPYING file in the top-level directory.
> =20
>  import os
> -import logging
>  import lzma
>  import gzip
>  import shutil
> =20
>  from avocado_qemu import Test
> +from avocado_qemu import wait_for_console_pattern
>  from avocado.utils import process
>  from avocado.utils import archive
> =20
> @@ -29,31 +29,10 @@ class BootLinuxConsole(Test):
> =20
>      KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
> =20
> -    def wait_for_console_pattern(self, success_message,
> -                                 failure_message=3D'Kernel panic - not s=
yncing'):
> -        """
> -        Waits for messages to appear on the console, while logging the c=
ontent
> -
> -        :param success_message: if this message appears, test succeeds
> -        :param failure_message: if this message appears, test fails
> -        """
> -        console =3D self.vm.console_socket.makefile()
> -        console_logger =3D logging.getLogger('console')
> -        while True:
> -            msg =3D console.readline().strip()
> -            if not msg:
> -                continue
> -            console_logger.debug(msg)
> -            if success_message in msg:
> -                break
> -            if failure_message in msg:
> -                fail =3D 'Failure message found in console: %s' % failur=
e_message
> -                self.fail(fail)
> -
>      def exec_command_and_wait_for_pattern(self, command, success_message=
):
>          command +=3D '\n'
>          self.vm.console_socket.sendall(command.encode())
> -        self.wait_for_console_pattern(success_message)
> +        wait_for_console_pattern(self, success_message)
> =20
>      def extract_from_deb(self, deb, path):
>          """
> @@ -89,7 +68,7 @@ class BootLinuxConsole(Test):
>                           '-append', kernel_command_line)
>          self.vm.launch()
>          console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
> =20
>      def test_mips_malta(self):
>          """
> @@ -112,7 +91,7 @@ class BootLinuxConsole(Test):
>                           '-append', kernel_command_line)
>          self.vm.launch()
>          console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
> =20
>      def test_mips64el_malta(self):
>          """
> @@ -145,7 +124,7 @@ class BootLinuxConsole(Test):
>                           '-append', kernel_command_line)
>          self.vm.launch()
>          console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
> =20
>      def test_mips_malta_cpio(self):
>          """
> @@ -181,7 +160,7 @@ class BootLinuxConsole(Test):
>                           '-append', kernel_command_line,
>                           '-no-reboot')
>          self.vm.launch()
> -        self.wait_for_console_pattern('Boot successful.')
> +        wait_for_console_pattern(self, 'Boot successful.')
> =20
>          self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
>                                                 'BogoMIPS')
> @@ -208,7 +187,7 @@ class BootLinuxConsole(Test):
>                           '-append', kernel_command_line)
>          self.vm.launch()
>          console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
> =20
>      def test_mips_malta32el_nanomips_4k(self):
>          """
> @@ -266,7 +245,7 @@ class BootLinuxConsole(Test):
>                           '-append', kernel_command_line)
>          self.vm.launch()
>          console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
> =20
>      def test_arm_virt(self):
>          """
> @@ -287,7 +266,7 @@ class BootLinuxConsole(Test):
>                           '-append', kernel_command_line)
>          self.vm.launch()
>          console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
> =20
>      def test_arm_emcraft_sf2(self):
>          """
> @@ -314,7 +293,7 @@ class BootLinuxConsole(Test):
>                           '-drive', 'file=3D' + spi_path + ',if=3Dmtd,for=
mat=3Draw',
>                           '-no-reboot')
>          self.vm.launch()
> -        self.wait_for_console_pattern('init started: BusyBox')
> +        wait_for_console_pattern(self, 'init started: BusyBox')
> =20
>      def test_s390x_s390_ccw_virtio(self):
>          """
> @@ -335,7 +314,7 @@ class BootLinuxConsole(Test):
>                           '-append', kernel_command_line)
>          self.vm.launch()
>          console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
> =20
>      def test_alpha_clipper(self):
>          """
> @@ -357,7 +336,7 @@ class BootLinuxConsole(Test):
>                           '-append', kernel_command_line)
>          self.vm.launch()
>          console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
> =20
>      def test_ppc64_pseries(self):
>          """
> @@ -377,4 +356,4 @@ class BootLinuxConsole(Test):
>                           '-append', kernel_command_line)
>          self.vm.launch()
>          console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
> diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/=
linux_ssh_mips_malta.py
> index 25a1df5098..ffbb06f846 100644
> --- a/tests/acceptance/linux_ssh_mips_malta.py
> +++ b/tests/acceptance/linux_ssh_mips_malta.py
> @@ -13,6 +13,7 @@ import time
> =20
>  from avocado import skipUnless
>  from avocado_qemu import Test
> +from avocado_qemu import wait_for_console_pattern
>  from avocado.utils import process
>  from avocado.utils import archive
>  from avocado.utils import ssh
> @@ -40,19 +41,6 @@ class LinuxSSH(Test):
>      def setUp(self):
>          super(LinuxSSH, self).setUp()
> =20
> -    def wait_for_console_pattern(self, success_message,
> -                                 failure_message=3D'Oops'):
> -        console =3D self.vm.console_socket.makefile()
> -        console_logger =3D logging.getLogger('console')
> -        while True:
> -            msg =3D console.readline()
> -            console_logger.debug(msg.strip())
> -            if success_message in msg:
> -                break
> -            if failure_message in msg:
> -                fail =3D 'Failure message found in console: %s' % failur=
e_message
> -                self.fail(fail)
> -
>      def get_portfwd(self):
>          res =3D self.vm.command('human-monitor-command',
>                                command_line=3D'info usernet')
> @@ -109,7 +97,7 @@ class LinuxSSH(Test):
> =20
>          self.log.info('VM launched, waiting for sshd')
>          console_pattern =3D 'Starting OpenBSD Secure Shell server: sshd'
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern, 'Oops')
>          self.log.info('sshd ready')
> =20
>          self.ssh_connect('root', 'root')
> @@ -117,7 +105,7 @@ class LinuxSSH(Test):
>      def shutdown_via_ssh(self):
>          self.ssh_command('poweroff')
>          self.ssh_disconnect_vm()
> -        self.wait_for_console_pattern('Power down')
> +        wait_for_console_pattern(self, 'Power down', 'Oops')
> =20
>      def ssh_command_output_contains(self, cmd, exp):
>          stdout, _ =3D self.ssh_command(cmd)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gBdJBemW82xJqIAr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2sAHoACgkQbDjKyiDZ
s5KyVQ//Ziksnw3g8lw60Y85fP4UXwK/FRGTogWQ/5RTpb8MbpJaV23rMJPGrZHu
gTfjs6hNJjYg8WuZlJ4uoVKrHzm/Z8SJLeytEui11IucE8+OjTEzCVYqEy9O0Dnc
QLHgbBlB4jmTK/NIHdIkQcU0KkDEO6zo6k9DynMuyWnv6xOxIaTpSKX4rAbbpUaZ
plT+CN0tJr/m+TExf9k88z0+YjmJM4OGlr6yv4Ctw25WtxxyCdeXvlxjGUx8WVyI
tk9MN0znvR+dyAta7WabPC8+D14qSjEUvJTvwmidx2lKvIUuNHSSRmcQRKh2+Mf+
sbX8b3qd3MKiDs98cftQj5i9LHGExXDpY1HymUgDDMarImf24ByKACukoSEY6p1s
fYGl+/TevAJfM36sxfxBnJtW8zHGCPVdpptHQ+ZuJv6d+1N830q5MeMWdkj95CNR
5Tv9Q8mIGYAJZezCkRRCngEqcOyn+xr64VHKOeK+KB1k7zvDAjRFqBv6vIH0FPyp
ZQ35wDemW0/XQsL4HlYQ9d8f0bJxV9Y5f7W4dtx7W+SEP1HJUxh4MfhGY8q8mECu
Jb3ea4U5uGy1MWx8PoJkhrCebmuPxYt2POMP1fHtbI7pcLSfx29y2V5iojQvRHHD
4czjlcI8IAY4vuCTxWtOJuxRYboFU+V+RttQd+mHY18cqGQYEZE=
=BUPO
-----END PGP SIGNATURE-----

--gBdJBemW82xJqIAr--

