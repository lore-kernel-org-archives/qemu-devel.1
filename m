Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7EDC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549E320684
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549E320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50416 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYdPc-00071G-Hp
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 17:25:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1hYdOZ-0006Xj-CH
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 17:24:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1hYdOX-0006AB-Vx
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 17:24:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hYdOV-000659-Tz
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 17:24:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 523BA5AFE9;
	Wed,  5 Jun 2019 21:24:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-121-163.rdu2.redhat.com
	[10.10.121.163])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EF5B91B4B4;
	Wed,  5 Jun 2019 21:24:19 +0000 (UTC)
Date: Wed, 5 Jun 2019 17:24:18 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Message-ID: <20190605212418.GB11823@localhost.localdomain>
References: <20190520231910.12184-1-f4bug@amsat.org>
	<20190520231910.12184-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190520231910.12184-4-f4bug@amsat.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Wed, 05 Jun 2019 21:24:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/4] BootLinuxConsoleTest: Run kerneltests
 BusyBox on Malta
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

On Tue, May 21, 2019 at 01:19:09AM +0200, Philippe Mathieu-Daud=E9 wrote:
> This tests boots a Linux kernel on a Malta machine up to a
> busybox shell on the serial console. Few commands are executed
> before halting the machine (via reboot).
>=20
> We use the initrd cpio image from the kerneltests project:
> https://kerneltests.org/
>=20
> If MIPS is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:mips" tags.
>=20
> Alternatively, this test can be run using:
>=20
>   $ avocado --show=3Dconsole run -t arch:mips tests/acceptance/boot_lin=
ux_console.py
>   [...]
>   console: Boot successful.
>   [...]
>   console: / # uname -a
>   console: Linux buildroot 4.5.0-2-4kc-malta #1 Debian 4.5.5-1 (2016-05=
-29) mips GNU/Linux
>   console: / # reboot

This seems like an ordinary input on the console...

>   console: / # reboot: Restarting system
>

And this seems like a perfectly normal output from the called
command. But, I also noticed this:

    console: cat /proc/cpuinfo
    console: / # cat /proc/cpuinfo
    console: system type            : MIPS Malta

Which seems to indicate an erroneous echo behavior of the console.
Any hints?

> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 49 ++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index 1c330871c0..60ea240ab6 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -11,6 +11,7 @@
>  import os
>  import logging
>  import lzma
> +import gzip
>  import shutil
> =20
>  from avocado_qemu import Test
> @@ -47,6 +48,11 @@ class BootLinuxConsole(Test):
>                  fail =3D 'Failure message found in console: %s' % fail=
ure_message
>                  self.fail(fail)
> =20
> +    def exec_command_and_wait_for_pattern(self, command, success_messa=
ge):
> +        command +=3D '\n'
> +        self.vm.console_socket.sendall(command.encode())
> +        self.wait_for_console_pattern(success_message)
> +
>      def extract_from_deb(self, deb, path):
>          """
>          Extracts a file from a deb package into the test workdir
> @@ -138,6 +144,49 @@ class BootLinuxConsole(Test):
>          console_pattern =3D 'Kernel command line: %s' % kernel_command=
_line
>          self.wait_for_console_pattern(console_pattern)
> =20
> +    def test_mips_malta_cpio(self):
> +        """
> +        :avocado: tags=3Darch:mips
> +        :avocado: tags=3Dmachine:malta
> +        :avocado: tags=3Dendian:big
> +        """
> +        deb_url =3D ('http://snapshot.debian.org/archive/debian/'
> +                   '20160601T041800Z/pool/main/l/linux/'
> +                   'linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb')
> +        deb_hash =3D 'a3c84f3e88b54e06107d65a410d1d1e8e0f340f8'
> +        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
> +        kernel_path =3D self.extract_from_deb(deb_path,
> +                                            '/boot/vmlinux-4.5.0-2-4kc=
-malta')
> +        initrd_url =3D ('https://github.com/groeck/linux-build-test/ra=
w/'
> +                      '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs=
/'
> +                      'mips/rootfs.cpio.gz')
> +        initrd_hash =3D 'bf806e17009360a866bf537f6de66590de349a99'
> +        initrd_path_gz =3D self.fetch_asset(initrd_url, asset_hash=3Di=
nitrd_hash)
> +        initrd_path =3D self.workdir + "rootfs.cpio"
> +
> +        with gzip.open(initrd_path_gz, 'rb') as f_in:
> +            with open(initrd_path, 'wb') as f_out:
> +                shutil.copyfileobj(f_in, f_out)

The last four lines can be replaced by:

        initrd_path =3D archive.extract(initrd_path_gz,
                                      os.path.join(self.workdir, "rootfs.=
cpio"))

And with that, the gzip import can also be removed.

> +
> +        self.vm.set_machine('malta')
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE
> +                               + 'console=3DttyS0 console=3Dtty '
> +                               + 'rdinit=3D/sbin/init noreboot')
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-initrd', initrd_path,
> +                         '-append', kernel_command_line,
> +                         '-no-reboot')
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Boot successful.')
> +
> +        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
> +                                               'BogoMIPS')
> +        self.exec_command_and_wait_for_pattern('uname -a',
> +                                               'Debian')
> +        self.exec_command_and_wait_for_pattern('reboot',
> +                                               'reboot: Restarting sys=
tem')
> +
>      def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_hash)=
:
>          kernel_path_xz =3D self.fetch_asset(kernel_url, asset_hash=3Dk=
ernel_hash)
>          kernel_path =3D self.workdir + "kernel"
> --=20
> 2.19.1
>=20

Tested-by: Cleber Rosa <crosa@redhat.com>

