Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CED9C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 23:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63D8520868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 23:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D8520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44974 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ1pA-0006D4-Nq
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 19:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45108)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hZ1oH-0005oA-IX
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hZ1oF-0008QL-GG
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:28:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48936)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hZ1oE-0008Mq-LK
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:28:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C11783081252;
 Thu,  6 Jun 2019 23:28:33 +0000 (UTC)
Received: from dhcp-17-47.bos.redhat.com (dhcp-17-47.bos.redhat.com
 [10.18.17.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE0977E687;
 Thu,  6 Jun 2019 23:28:30 +0000 (UTC)
Date: Thu, 6 Jun 2019 19:28:28 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190606232828.GA30644@dhcp-17-47.bos.redhat.com>
References: <20190606230232.9888-1-philmd@redhat.com>
 <20190606230232.9888-3-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190606230232.9888-3-philmd@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 06 Jun 2019 23:28:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 2/2] BootLinuxConsoleTest: Run
 kerneltests BusyBox on Malta
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 07, 2019 at 01:02:32AM +0200, Philippe Mathieu-Daud=E9 wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
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
>   console: / # reboot: Restarting system
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Tested-by: Cleber Rosa <crosa@redhat.com>
> ---
> v3: Use archive.extract() instead of shutil+gzip (Cleber)
> ---
>  tests/acceptance/boot_linux_console.py | 44 ++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index a7a735c90d..751e3bff86 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -49,6 +49,11 @@ class BootLinuxConsole(Test):
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
> @@ -140,6 +145,45 @@ class BootLinuxConsole(Test):
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
> +        initrd_path =3D archive.extract(initrd_path_gz,
> +                                      os.path.join(self.workdir, 'root=
fs.cpio'))
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
> 2.20.1
>=20

Reviewed-by: Cleber Rosa <crosa@redhat.com>

