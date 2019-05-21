Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5348FC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 08:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09EB82173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 08:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOgcgxc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09EB82173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48962 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT0Kq-0002ee-9K
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 04:41:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hT0Hi-0000sT-2r
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hT0Hg-00065a-7b
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:38:10 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hT0Hc-00061G-ME
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:38:06 -0400
Received: by mail-ot1-x343.google.com with SMTP id s19so15590516otq.5
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 01:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=xhcfNshtNEfr78uoWimczpM5uxVWrF+2ErJdoseZbFE=;
	b=lOgcgxc8L6O44rOn1au7SH3JMSBWcD0lp83GInm2TljSJSQmoMIv6yBpXHzviYv/xx
	4zeX0n52ReHsgzXKNIte/GC8IKQ9O9i7WOW2DWpZXA+sbOtMLnAr70VpoG7rXxxt/2Ox
	TEqMLP/f6ME7EF2+k1u9JgqeH7MI1lLFP+of7y8fN+YuvHcj03m+auEQBksqMggCA0Be
	EYN0dZM3j0pARJotKYpdJ52pnLbLJ7dcidsP4NZLA2HsF7itqXIzTL/dywYL/LPuaTVl
	sCQdB/9KYN6q3Ec9xyd8LUNG60TRufBpPb7Q2NU8MCV916S11LTuHuZrey31Icdk12sU
	QtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=xhcfNshtNEfr78uoWimczpM5uxVWrF+2ErJdoseZbFE=;
	b=DtyKdNnhqp1NJjNTXKlNlv2kcXdLp0kcGUi7asO2BIXyr4Lav0JDdGy8OyupDBFlxu
	RSTHl3Q8N4x1+Nu3+uoygtn7l6yRequ3/ITqJs8ZR3Hx33vqKZ/IEgZaczBPaXgLvzG+
	d9MnBapF1Oc/JQTnYlWXpc+q8ZfsHYPYmsWIbaJkl/COwXgGpJ/NLh/RXODJoRU5o4Ea
	oojTw9ucej8qE9J+VfqsBBTf7q96JU9Wh4jigrplgBncgFB+Tj/qs72Fuq9o/Vguntpc
	ZmTfpjWrqHemu6UajUke6lbtQ+JaBsIrXLyEWvUz1s00AANW39HOQt4w7Hz1Yiv3TzOz
	UmMw==
X-Gm-Message-State: APjAAAUL4XCnKwq899DPVY7mKo9JdokvRweWzdxP8O1iEqKTObbtp2rs
	3mvfhQZGMVMdjs4CksbliNw/EadaudFROLyCMWY=
X-Google-Smtp-Source: APXvYqxdUd5Na4VtObEdgusMEjFwwdtDUIFNjdAcl31bQurmkgIxc/8EZ19dGpcVTumVs/2vsvPHfpm0+l87abODCKk=
X-Received: by 2002:a9d:61d5:: with SMTP id h21mr16017915otk.306.1558427882659;
	Tue, 21 May 2019 01:38:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Tue, 21 May 2019 01:38:02
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Tue, 21 May 2019 01:38:02
	-0700 (PDT)
In-Reply-To: <20190520231910.12184-4-f4bug@amsat.org>
References: <20190520231910.12184-1-f4bug@amsat.org>
	<20190520231910.12184-4-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 21 May 2019 10:38:02 +0200
Message-ID: <CAL1e-=iN35mJgRMD5-rp4QRKPdjHpjkSsAQ+BjVfzG4cKaGG6w@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
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
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Caio Carrara <ccarrara@redhat.com>, qemu-devel@nongnu.org,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Cleber Rosa <crosa@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 21, 2019 1:19 AM, "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> wr=
ote:
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
> ---

Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  tests/acceptance/boot_linux_console.py | 49 ++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/tests/acceptance/boot_linux_console.py
b/tests/acceptance/boot_linux_console.py
> index 1c330871c0..60ea240ab6 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -11,6 +11,7 @@
>  import os
>  import logging
>  import lzma
> +import gzip
>  import shutil
>
>  from avocado_qemu import Test
> @@ -47,6 +48,11 @@ class BootLinuxConsole(Test):
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
> @@ -138,6 +144,49 @@ class BootLinuxConsole(Test):
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
> +        initrd_path =3D self.workdir + "rootfs.cpio"
> +
> +        with gzip.open(initrd_path_gz, 'rb') as f_in:
> +            with open(initrd_path, 'wb') as f_out:
> +                shutil.copyfileobj(f_in, f_out)
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
> +                                               'reboot: Restarting
system')
> +
>      def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_hash):
>          kernel_path_xz =3D self.fetch_asset(kernel_url,
asset_hash=3Dkernel_hash)
>          kernel_path =3D self.workdir + "kernel"
> --
> 2.19.1
>
