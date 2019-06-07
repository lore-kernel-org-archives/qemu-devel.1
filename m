Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CE5C04AB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 00:17:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78CD5208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 00:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsWeisih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78CD5208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45168 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ2ZC-00064b-6a
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 20:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53137)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hZ2Xt-0005eD-Uz
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 20:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hZ2Xs-0000hR-03
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 20:15:49 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37525)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hZ2Xq-0000aN-0t
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 20:15:47 -0400
Received: by mail-ot1-x344.google.com with SMTP id r10so294647otd.4
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 17:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Rbpd0sg4hJ+ppFHk3NhFULa6FQqlFxYGP17Pvq6/sBE=;
 b=HsWeisihG9KjEUFnROS0/AtSR/2gQgaNhWy4rw5Ud11nSCQFq+09DwPb2CjJggve1B
 c3yZte8dy+mBJq1wKSuRCJRbvtePodDo5WxuVU3FZre+gpgGLOVvWgPQGzYUYOqA4qVN
 7PSac68hoIofujefOSaEsidve5nNSwanNRk6xl869gbHY5VvmFlAzjWXWaQXa4wRd+/k
 JB/WZnkhm1vvDQbEySYndLrs6SKbIkN/y6rkxsvFoSmogx9p5btoXNhZT42UiVPpn18L
 s9yBv0Mhos3evf3m+lBSwWyb35JxmTjU2eDSwwpDuR65E56oIriD+OPl1Uh9+BHLJjZS
 kFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Rbpd0sg4hJ+ppFHk3NhFULa6FQqlFxYGP17Pvq6/sBE=;
 b=lLqzBIg74tv7usClofbu4laxTGMCNh75C4mcOCdJnwQLx+TjVkaFBgFKXbJulKnrPF
 rQGeHueP75jiwcW/XPZ/zjWe4mhTe0wPIbOGumNNGceDrezmLlYKG/Liv1YcQrujXPV+
 GhZBEXAVWNrqdfzqH8z3QeUS3Hc+di6glEYWbDJTSsS4MBWfniZRdn4BfA/jHvyahXbX
 0UdXFT27NTiRY5VoEwjIkX2bKsPIq9k40Y90momZOOC2IylvJ18ygW+nCMirNEqJbT9o
 9AkVMhjnrKVfOomGj13ChdWFHvcOci5rHcyJkE0pxviWU4vckp7OgvcAxtJuAZrUSzZQ
 iLTw==
X-Gm-Message-State: APjAAAXoH76RgPa8CbczYoqvfDyUnWg99fP5XfbEjSBC8r8X29Fx0FIF
 nW96sL6r8r0tvSKVidw8uwo05hWEfSPzHoYB2wU=
X-Google-Smtp-Source: APXvYqylpl/J9UH/fKCKQX9CQLhctxndAU9HYoO9LboLOFw4mAWj6yEU4WpcObXWO8j83Mq7k0s+s5geLD87725i6lM=
X-Received: by 2002:a9d:63c1:: with SMTP id e1mr2651927otl.341.1559866541728; 
 Thu, 06 Jun 2019 17:15:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP;
 Thu, 6 Jun 2019 17:15:41 -0700 (PDT)
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP;
 Thu, 6 Jun 2019 17:15:41 -0700 (PDT)
In-Reply-To: <20190606230232.9888-3-philmd@redhat.com>
References: <20190606230232.9888-1-philmd@redhat.com>
 <20190606230232.9888-3-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 7 Jun 2019 02:15:41 +0200
Message-ID: <CAL1e-=hs7XpwbxYZt+VnmcJpA=bPxekhdYz0w8yTRc81eiMAGQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Cleber Rosa <crosa@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 7, 2019 1:06 AM, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> w=
rote:
>
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> This tests boots a Linux kernel on a Malta machine up to a
> busybox shell on the serial console. Few commands are executed
> before halting the machine (via reboot).
>
> We use the initrd cpio image from the kerneltests project:
> https://kerneltests.org/
>
> If MIPS is a target being built, "make check-acceptance" will
> automatically include this test by the use of the "arch:mips" tags.
>
> Alternatively, this test can be run using:
>
>   $ avocado --show=3Dconsole run -t arch:mips
tests/acceptance/boot_linux_console.py
>   [...]
>   console: Boot successful.
>   [...]
>   console: / # uname -a
>   console: Linux buildroot 4.5.0-2-4kc-malta #1 Debian 4.5.5-1
(2016-05-29) mips GNU/Linux
>   console: / # reboot
>   console: / # reboot: Restarting system
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Tested-by: Cleber Rosa <crosa@redhat.com>
> ---

Excellent test, and commit message content too. May I suggest the test
group inclusion of the text of this commit message (or similar text) to the
documentation on QEMU Testing web page, as an example of the acceptance
test usage?

Yours, Aleksandar

> v3: Use archive.extract() instead of shutil+gzip (Cleber)
> ---
>  tests/acceptance/boot_linux_console.py | 44 ++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/tests/acceptance/boot_linux_console.py
b/tests/acceptance/boot_linux_console.py
> index a7a735c90d..751e3bff86 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -49,6 +49,11 @@ class BootLinuxConsole(Test):
>                  fail =3D 'Failure message found in console: %s' %
failure_message
>                  self.fail(fail)
>
> +    def exec_command_and_wait_for_pattern(self, command,
success_message):
> +        command +=3D '\n'
> +        self.vm.console_socket.sendall(command.encode())
> +        self.wait_for_console_pattern(success_message)
> +
>      def extract_from_deb(self, deb, path):
>          """
>          Extracts a file from a deb package into the test workdir
> @@ -140,6 +145,45 @@ class BootLinuxConsole(Test):
>          console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
>          self.wait_for_console_pattern(console_pattern)
>
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
> +
'/boot/vmlinux-4.5.0-2-4kc-malta')
> +        initrd_url =3D ('https://github.com/groeck/linux-build-test/raw/=
'
> +                      '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
> +                      'mips/rootfs.cpio.gz')
> +        initrd_hash =3D 'bf806e17009360a866bf537f6de66590de349a99'
> +        initrd_path_gz =3D self.fetch_asset(initrd_url,
asset_hash=3Dinitrd_hash)
> +        initrd_path =3D archive.extract(initrd_path_gz,
> +                                      os.path.join(self.workdir,
'rootfs.cpio'))
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
> +                                               'reboot: Restarting
system')
> +
>      def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_hash):
>          kernel_path_xz =3D self.fetch_asset(kernel_url,
asset_hash=3Dkernel_hash)
>          kernel_path =3D self.workdir + "kernel"
> --
> 2.20.1
>
>
