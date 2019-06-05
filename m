Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FC3C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 18:17:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D82520866
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 18:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D82520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48110 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYaT9-0000TN-BB
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 14:17:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1hYaSA-0008Pp-0E
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 14:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1hYaS8-0005oj-F6
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 14:16:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hYaS8-0005ll-74
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 14:16:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0EBEA3085065;
	Wed,  5 Jun 2019 18:15:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-121-163.rdu2.redhat.com
	[10.10.121.163])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9ACA11902B;
	Wed,  5 Jun 2019 18:15:45 +0000 (UTC)
Date: Wed, 5 Jun 2019 14:15:43 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Message-ID: <20190605181543.GC7080@localhost.localdomain>
References: <20190520231910.12184-1-f4bug@amsat.org>
	<20190520231910.12184-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190520231910.12184-3-f4bug@amsat.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 05 Jun 2019 18:15:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/4] BootLinuxConsoleTest: Test nanoMIPS
 kernels on the I7200 CPU
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Caio Carrara <ccarrara@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 21, 2019 at 01:19:08AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Similar to the x86_64/pc test, it boots a Linux kernel on a Malta
> machine and verify the serial is working.
>=20
> Use the documentation added in commit f7d257cb4a17 to test
> nanoMIPS kernels and the I7200 CPU.
>=20
> This test can be run using:
>=20
>   $ avocado --show=3Dconsole run -t arch:mipsel tests/acceptance/boot_l=
inux_console.py
>   console: [    0.000000] Linux version 4.15.18-00432-gb2eb9a8b (emubui=
ld@mipscs563) (gcc version 6.3.0 (Codescape GNU Tools 2018.04-02 for nano=
MIPS Linux)) #1 SMP Wed Jun 27 11:10:08 PDT 2018
>   console: [    0.000000] GCRs appear to have been moved (expected them=
 at 0x1fbf8000)!
>   console: [    0.000000] GCRs appear to have been moved (expected them=
 at 0x1fbf8000)!
>   console: [    0.000000] CPU0 revision is: 00010000 (MIPS GENERIC QEMU=
)
>   console: [    0.000000] MIPS: machine is mti,malta
>   console: [    0.000000] Determined physical RAM map:
>   console: [    0.000000]  memory: 08000000 @ 00000000 (usable)
>   console: [    0.000000] earlycon: ns16550a0 at I/O port 0x3f8 (option=
s '38400n8')
>   console: [    0.000000] bootconsole [ns16550a0] enabled
>   console: [    0.000000] User-defined physical RAM map:
>   console: [    0.000000]  memory: 10000000 @ 00000000 (usable)
>   console: [    0.000000] Initrd not found or empty - disabling initrd
>   console: [    0.000000] MIPS CPS SMP unable to proceed without a CM
>   console: [    0.000000] Primary instruction cache 32kB, VIPT, 4-way, =
linesize 32 bytes.
>   console: [    0.000000] Primary data cache 32kB, 4-way, VIPT, cache a=
liases, linesize 32 bytes
>   console: [    0.000000] This processor doesn't support highmem. -2621=
44k highmem ignored
>   console: [    0.000000] Zone ranges:
>   console: [    0.000000]   Normal   [mem 0x0000000000000000-0x00000000=
0fffffff]
>   console: [    0.000000]   HighMem  empty
>   console: [    0.000000] Movable zone start for each node
>   console: [    0.000000] Early memory node ranges
>   console: [    0.000000]   node   0: [mem 0x0000000000000000-0x0000000=
00fffffff]
>   console: [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-=
0x000000000fffffff]
>   console: [    0.000000] random: get_random_bytes called from start_ke=
rnel+0x60/0x2f0 with crng_init=3D0
>   console: [    0.000000] percpu: Embedded 16 pages/cpu @(ptrval) s3662=
0 r8192 d20724 u65536
>   console: [    0.000000] Built 1 zonelists, mobility grouping on.  Tot=
al pages: 64960
>   console: [    0.000000] Kernel command line: printk.time=3D0 mem=3D25=
6m@@0x0 console=3DttyS0 earlycon
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 58 ++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index 6aa084e049..1c330871c0 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -10,6 +10,8 @@
> =20
>  import os
>  import logging
> +import lzma
> +import shutil
> =20
>  from avocado_qemu import Test
>  from avocado.utils import process
> @@ -136,6 +138,62 @@ class BootLinuxConsole(Test):
>          console_pattern =3D 'Kernel command line: %s' % kernel_command=
_line
>          self.wait_for_console_pattern(console_pattern)
> =20
> +    def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_hash)=
:

Nitpick: It's clear that having helper methods that tests build on is
a common pattern (even when we improve the parameter situation, so
that individual tests can be fed their own set of parameters).  What
bothers me a bit is the "_test_" component in their names, because it
makes it a bit harder on my eyes to distinguish between tests and
other methods.

Given that we are just starting to build our conventions, so I guess
I'd make sense to at try follow some prior art.  Looking at
virtio_version.py, I see that Eduardo used "check_" as a prefix for
methods of similar purpose.  Let me know if you think this seems worth
doing.

> +        kernel_path_xz =3D self.fetch_asset(kernel_url, asset_hash=3Dk=
ernel_hash)
> +        kernel_path =3D self.workdir + "kernel"
> +        with lzma.open(kernel_path_xz, 'rb') as f_in:
> +            with open(kernel_path, 'wb') as f_out:
> +                shutil.copyfileobj(f_in, f_out)
> +

avocado.utils.archive *almost* suits this lzma case (but not quite), so
ack on this.

> +        self.vm.set_machine('malta')
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE
> +                               + 'mem=3D256m@@0x0 '
> +                               + 'console=3DttyS0')

Another nitpick: these last two lines can be a single one (and avoid
one extra string concatenation).

> +        self.vm.add_args('-no-reboot',
> +                         '-cpu', 'I7200',
> +                         '-kernel', kernel_path,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        console_pattern =3D 'Kernel command line: %s' % kernel_command=
_line
> +        self.wait_for_console_pattern(console_pattern)
> +
> +    def test_mips_malta32el_nanomips_4k(self):
> +        """
> +        :avocado: tags=3Darch:mipsel
> +        :avocado: tags=3Dmachine:malta
> +        :avocado: tags=3Dendian:little
> +        """
> +        kernel_url =3D ('https://mipsdistros.mips.com/LinuxDistro/nano=
mips/'
> +                      'kernels/v4.15.18-432-gb2eb9a8b07a1-201806271021=
42/'
> +                      'generic_nano32r6el_page4k.xz')
> +        kernel_hash =3D '477456aafd2a0f1ddc9482727f20fe9575565dd6'
> +        self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
> +
> +    def test_mips_malta32el_nanomips_16k_up(self):
> +        """
> +        :avocado: tags=3Darch:mipsel
> +        :avocado: tags=3Dmachine:malta
> +        :avocado: tags=3Dendian:little
> +        """
> +        kernel_url =3D ('https://mipsdistros.mips.com/LinuxDistro/nano=
mips/'
> +                      'kernels/v4.15.18-432-gb2eb9a8b07a1-201806271021=
42/'
> +                      'generic_nano32r6el_page16k_up.xz')
> +        kernel_hash =3D 'e882868f944c71c816e832e2303b7874d044a7bc'
> +        self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
> +
> +    def test_mips_malta32el_nanomips_64k_dbg(self):
> +        """
> +        :avocado: tags=3Darch:mipsel
> +        :avocado: tags=3Dmachine:malta
> +        :avocado: tags=3Dendian:little
> +        """
> +        kernel_url =3D ('https://mipsdistros.mips.com/LinuxDistro/nano=
mips/'
> +                      'kernels/v4.15.18-432-gb2eb9a8b07a1-201806271021=
42/'
> +                      'generic_nano32r6el_page64k_dbg.xz')
> +        kernel_hash =3D '18d1c68f2e23429e266ca39ba5349ccd0aeb7180'
> +        self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
> +
>      def test_aarch64_virt(self):
>          """
>          :avocado: tags=3Darch:aarch64
> --=20
> 2.19.1
>=20

I'd suggest you to add the mipsel target to the configure list on
.travis.yaml, ir accordance with the previous patches that added tests
for new arches.

Other than that, it looks good to me.

Tested-by: Cleber Rosa <crosa@redhat.com>

