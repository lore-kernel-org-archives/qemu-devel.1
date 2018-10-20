Received: from eggs.gnu.org ([2001:4830:134:3::10]:45356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDejU-0006X9-Fi
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 20:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDejR-00084w-7J
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 20:03:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gDejP-0007hN-14
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 20:03:03 -0400
References: <20181013151545.3731-1-f4bug@amsat.org>
	<20181013151545.3731-7-f4bug@amsat.org>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <e2703556-b61d-f8f8-3d31-bc5cac5c7ac9@redhat.com>
Date: Fri, 19 Oct 2018 20:02:55 -0400
MIME-Version: 1.0
In-Reply-To: <20181013151545.3731-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v3 6/6] tests/acceptance: Add
 test_sh4_r2d in BootLinuxTracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, Magnus Damm <magnus.damm@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>



On 10/13/18 11:15 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Similar to the test_x86_64_pc test, this boots a Linux kernel on a
> R2D board (SH4 little-endian) and verify the usb is working by looking
> at the usb trace events. Thus this test requires the QEMU binary to be
> compiled with:
>=20
>   $ configure ... --enable-trace-backends=3Dlog
>=20
> This test also requires the dpkg-deb tool (apt/dnf install dpkg) to
> extract the kernel from the Debian package.
>=20
>   $ avocado --show=3Dapp,trace run -p arch=3Dsh4 tests/acceptance/boot_=
linux_console.py
>   JOB ID     : dc45be27f5d1edb8289a1ede139e107bbc55b045
>   JOB LOG    : /home/phil/avocado/job-results/job-2018-10-13T14.46-dc45=
be2/job.log
>    (1/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x=
86_64_pc: CANCEL: Currently specific to the x86_64 target arch (0.00 s)
>    (2/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_m=
ips_4kc_malta: CANCEL: Currently specific to the sh4 target arch (0.00 s)
>    (3/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_m=
ipsel_5kc_malta: CANCEL: Currently specific to the sh4 target arch (0.00 =
s)
>    (4/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_s=
h4_r2d: SKIP: console not working on r2d machine
>    (5/5) tests/acceptance/boot_linux_console.py:BootLinuxTracing.test_s=
h4_r2d:  /
>   trace: 22770@1539434809.450006:usb_ohci_init_time usb_bit_time=3D1000=
000 usb_frame_time=3D83
>   trace: 22770@1539434809.453017:usb_ohci_port_attach port #0
>   trace: 22770@1539434809.454827:usb_ohci_reset sysbus-ohci
>   trace: 22770@1539434809.454833:usb_ohci_stop sysbus-ohci: USB Suspend=
ed
>   trace: 22770@1539434809.454835:usb_ohci_stop sysbus-ohci: USB Suspend=
ed
>   trace: 22770@1539434809.454837:usb_ohci_port_detach port #0
>   trace: 22770@1539434809.454839:usb_ohci_port_attach port #0
>   trace: 22770@1539434811.588702:usb_ohci_reset sysbus-ohci
>   trace: 22770@1539434811.588711:usb_ohci_stop sysbus-ohci: USB Suspend=
ed
>   trace: 22770@1539434811.589062:usb_ohci_set_ctl sysbus-ohci: new stat=
e 0x80
>   trace: 22770@1539434811.589067:usb_ohci_start sysbus-ohci: USB Operat=
ional
>   trace: 22770@1539434811.589253:usb_ohci_hub_power_up powered up all p=
orts
>   PASS (2.43 s)
>   RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT =
0 | CANCEL 3
>   JOB TIME   : 2.67 s
>=20

And with similar changes, on this point of this series:

$ avocado run tests/acceptance/boot_linux_console.py
JOB ID     : 857fef1b8c0ce59a79d452f27e996ed2743404b1
JOB LOG    :
/home/cleber/avocado/job-results/job-2018-10-19T19.58-857fef1/job.log
 (1/5)
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_pc:
PASS (2.04 s)
 (2/5)
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_mips_4kc_mal=
ta:
PASS (0.57 s)
 (3/5)
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_mipsel_5kc_m=
alta:
PASS (0.59 s)
 (4/5)
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_sh4_r2d:
SKIP: console not working on r2d machine
 (5/5)
tests/acceptance/boot_linux_console.py:BootLinuxTracing.test_sh4_r2d:
PASS (1.01 s)
RESULTS    : PASS 4 | ERROR 0 | FAIL 0 | SKIP 1 | WARN 0 | INTERRUPT 0 |
CANCEL 0
JOB TIME   : 4.57 s

- Cleber.

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 64 ++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index 8f99cc0d7c..e11993bf98 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -8,11 +8,22 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
> =20
> +import os
>  import logging
>  import subprocess
> =20
>  from avocado import skip
>  from avocado_qemu import Test
> +from avocado.utils.wait import wait_for
> +
> +
> +def read_stream_for_string(stream, expected_string, logger=3DNone):
> +    msg =3D stream.readline()
> +    if len(msg) =3D=3D 0:
> +        return False
> +    if logger:
> +        logger.debug(msg.strip())
> +    return expected_string in msg
> =20
> =20
>  class BootLinuxConsole(Test):
> @@ -185,3 +196,56 @@ class BootLinuxConsole(Test):
>                  break
>              if 'Kernel panic - not syncing' in msg:
>                  self.fail("Kernel panic reached")
> +
> +class BootLinuxTracing(Test):
> +    """
> +    Boots a Linux kernel and checks that via the Tracing framework tha=
t
> +    a specific trace events occured, demostrating the kernel is operat=
ional.
> +
> +    :avocado: enable
> +    """
> +
> +    timeout =3D 60
> +
> +    def test_sh4_r2d(self):
> +        """
> +        This test requires the dpkg-deb tool (apt/dnf install dpkg) to=
 extract
> +        the kernel from the Debian package.
> +        This test also requires the QEMU binary to be compiled with:
> +
> +          $ configure ... --enable-trace-backends=3Dlog
> +
> +        The kernel can be rebuilt using this Debian kernel source [1] =
and
> +        following the instructions on [2].
> +
> +        [1] https://kernel-team.pages.debian.net/kernel-handbook/ch-co=
mmon-tasks.html#s-common-official
> +        [2] http://snapshot.debian.org/package/linux-2.6/2.6.32-30/#li=
nux-source-2.6.32_2.6.32-30
> +
> +        :avocado: tags=3Darch:sh4
> +        """
> +        if self.arch !=3D 'sh4':
> +            self.cancel('Currently specific to the %s target arch' % s=
elf.arch)
> +
> +        deb_url =3D ('http://snapshot.debian.org/archive/'
> +                   'debian-ports/20110116T065852Z/pool-sh4/main/l/'
> +                   'linux-2.6/linux-image-2.6.32-5-sh7751r_2.6.32-30_s=
h4.deb')
> +        deb_hash =3D '8025e503319dc8ad786756e3afaa8eb868e9ef59'
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        subprocess.check_call(['dpkg-deb', '--extract', deb_path, self=
.workdir])
> +        kernel_path =3D self.workdir + '/boot/vmlinuz-2.6.32-5-sh7751r=
'
> +        trace_path =3D os.path.join(self.workdir, 'trace.log')
> +        trace_logger =3D logging.getLogger('trace')
> +
> +        self.vm.set_arch(self.arch)
> +        self.vm.set_machine('r2d')
> +        kernel_command_line =3D 'noiotrap'
> +        self.vm.add_args('-trace', "enable=3Dusb_ohci_*,file=3D" + tra=
ce_path,
> +                         '-kernel', kernel_path,
> +                         '-append', kernel_command_line)
> +
> +        self.vm.launch()
> +        if not wait_for(read_stream_for_string, timeout=3D15, step=3D0=
,
> +                        args=3D(open(trace_path),
> +                              'usb_ohci_hub_power_up powered up all po=
rts',
> +                              trace_logger)):
> +            self.fail("Machine failed to boot")
>=20

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]
