Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC05FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B1220854
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B1220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5Lo-0004lo-9y
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 08:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL5LB-0004Mp-C6
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL5L9-0005jB-Lj
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:57:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38002)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL5L9-0005iK-DR
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:57:15 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 63ED02D0FB7
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 12:57:13 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id r21so1014084wme.5
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 05:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ih/gQtZvaH6oY+/qHdkguuZ+1ocYjIOII9gfQ3Q9D6w=;
 b=E7z0/krfRMOaZyOTseSaNLB8TcABDVHysyqGxSBWhQ9tFINRhEHsTdDznV962YmXb2
 Sc+lioGXqGNSSc/dM/y9du9NTi5cRH3Z0+aGuCar+cgzMqCKBQ3hUzFqXZhKCqYJ8nWh
 LlQ/IAXRlTmrdm5cWyoUpeivrIIf/pvlsWnhVIcVbpb08gnHvro51jqu/VdmoBl4k6oL
 wHAjWYKs6FEb7HiuYYmzIbZyl7SUBQV9rjPTVj1zrY0/H/lcrC/dA47qp4RjJnqmMSlg
 Rou8OykGeSRW/4FqYrIy5GyxbZSbpYiPpQsClCGJWFVWdN4FsG7OS2/QPz8VnP9ZAg5P
 G2yA==
X-Gm-Message-State: APjAAAVhE04yQm9ZoRyrVI/e3c8TGI0UZzWf8ESAMGPfLNTiR5ugJB6U
 GxYSoa/NC2/FLr6qQfwD55kAM9S1d9igm/5pVbfAUi1DhCqhmWwKlwZtPV6kBF+cVK2uDAPJRjH
 ODCrCZJvi7jMB2BQ=
X-Received: by 2002:a1c:7f4e:: with SMTP id a75mr2724395wmd.68.1571317031914; 
 Thu, 17 Oct 2019 05:57:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyahsbhfRW7LzkEcf0uUjGW14//99SdRyu+gUcYpoNvH0PZeL5y1/d2iRXawkGZSVGWBPu0Hw==
X-Received: by 2002:a1c:7f4e:: with SMTP id a75mr2724376wmd.68.1571317031550; 
 Thu, 17 Oct 2019 05:57:11 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id p12sm2341862wrm.62.2019.10.17.05.57.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 05:57:10 -0700 (PDT)
Subject: Re: [PATCH] Acceptance tests: refactor wait_for_console_pattern
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <252b6e94-fe8f-f9a7-0d4b-4743b1809a06@redhat.com>
 <20190916164011.7653-1-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <96f3e12c-93d0-60d4-d1c7-ffbc77d1224e@redhat.com>
Date: Thu, 17 Oct 2019 14:57:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190916164011.7653-1-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Willian Rampazzo <wrampazz@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 6:40 PM, Cleber Rosa wrote:
> The same utility method is already present in two different test
> files, so let's consolidate it into a single utility function.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/acceptance/avocado_qemu/__init__.py | 26 +++++++++++++
>   tests/acceptance/boot_linux_console.py    | 47 +++++++---------------=
-
>   tests/acceptance/linux_ssh_mips_malta.py  | 18 ++-------
>   3 files changed, 42 insertions(+), 49 deletions(-)
>=20
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptan=
ce/avocado_qemu/__init__.py
> index bd41e0443c..a0fe16e47f 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -8,6 +8,7 @@
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later.  See the COPYING file in the top-level directory.
>  =20
> +import logging
>   import os
>   import sys
>   import uuid
> @@ -53,6 +54,31 @@ def pick_default_qemu_bin(arch=3DNone):
>           return qemu_bin_from_src_dir_path
>  =20
>  =20
> +def wait_for_console_pattern(test, success_message,
> +                             failure_message=3D'Kernel panic - not syn=
cing'):
> +    """
> +    Waits for messages to appear on the console, while logging the con=
tent
> +
> +    :param test: an Avocado test containing a VM that will have its co=
nsole
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
> +            fail =3D 'Failure message found in console: %s' % failure_=
message
> +            test.fail(fail)
> +
> +
>   class Test(avocado.Test):
>       def setUp(self):
>           self._vms =3D {}
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index 8a9a314ab4..9ff2213874 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -9,12 +9,12 @@
>   # later.  See the COPYING file in the top-level directory.
>  =20
>   import os
> -import logging
>   import lzma
>   import gzip
>   import shutil
>  =20
>   from avocado_qemu import Test
> +from avocado_qemu import wait_for_console_pattern
>   from avocado.utils import process
>   from avocado.utils import archive
>  =20
> @@ -29,31 +29,10 @@ class BootLinuxConsole(Test):
>  =20
>       KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
>  =20
> -    def wait_for_console_pattern(self, success_message,
> -                                 failure_message=3D'Kernel panic - not=
 syncing'):
> -        """
> -        Waits for messages to appear on the console, while logging the=
 content
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
> -                fail =3D 'Failure message found in console: %s' % fail=
ure_message
> -                self.fail(fail)
> -
>       def exec_command_and_wait_for_pattern(self, command, success_mess=
age):
>           command +=3D '\n'
>           self.vm.console_socket.sendall(command.encode())
> -        self.wait_for_console_pattern(success_message)
> +        wait_for_console_pattern(self, success_message)
>  =20
>       def extract_from_deb(self, deb, path):
>           """
> @@ -89,7 +68,7 @@ class BootLinuxConsole(Test):
>                            '-append', kernel_command_line)
>           self.vm.launch()
>           console_pattern =3D 'Kernel command line: %s' % kernel_comman=
d_line
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
>  =20
>       def test_mips_malta(self):
>           """
> @@ -112,7 +91,7 @@ class BootLinuxConsole(Test):
>                            '-append', kernel_command_line)
>           self.vm.launch()
>           console_pattern =3D 'Kernel command line: %s' % kernel_comman=
d_line
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
>  =20
>       def test_mips64el_malta(self):
>           """
> @@ -145,7 +124,7 @@ class BootLinuxConsole(Test):
>                            '-append', kernel_command_line)
>           self.vm.launch()
>           console_pattern =3D 'Kernel command line: %s' % kernel_comman=
d_line
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
>  =20
>       def test_mips_malta_cpio(self):
>           """
> @@ -181,7 +160,7 @@ class BootLinuxConsole(Test):
>                            '-append', kernel_command_line,
>                            '-no-reboot')
>           self.vm.launch()
> -        self.wait_for_console_pattern('Boot successful.')
> +        wait_for_console_pattern(self, 'Boot successful.')
>  =20
>           self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
>                                                  'BogoMIPS')
> @@ -208,7 +187,7 @@ class BootLinuxConsole(Test):
>                            '-append', kernel_command_line)
>           self.vm.launch()
>           console_pattern =3D 'Kernel command line: %s' % kernel_comman=
d_line
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
>  =20
>       def test_mips_malta32el_nanomips_4k(self):
>           """
> @@ -266,7 +245,7 @@ class BootLinuxConsole(Test):
>                            '-append', kernel_command_line)
>           self.vm.launch()
>           console_pattern =3D 'Kernel command line: %s' % kernel_comman=
d_line
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
>  =20
>       def test_arm_virt(self):
>           """
> @@ -287,7 +266,7 @@ class BootLinuxConsole(Test):
>                            '-append', kernel_command_line)
>           self.vm.launch()
>           console_pattern =3D 'Kernel command line: %s' % kernel_comman=
d_line
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
>  =20
>       def test_arm_emcraft_sf2(self):
>           """
> @@ -314,7 +293,7 @@ class BootLinuxConsole(Test):
>                            '-drive', 'file=3D' + spi_path + ',if=3Dmtd,=
format=3Draw',
>                            '-no-reboot')
>           self.vm.launch()
> -        self.wait_for_console_pattern('init started: BusyBox')
> +        wait_for_console_pattern(self, 'init started: BusyBox')
>  =20
>       def test_s390x_s390_ccw_virtio(self):
>           """
> @@ -335,7 +314,7 @@ class BootLinuxConsole(Test):
>                            '-append', kernel_command_line)
>           self.vm.launch()
>           console_pattern =3D 'Kernel command line: %s' % kernel_comman=
d_line
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
>  =20
>       def test_alpha_clipper(self):
>           """
> @@ -357,7 +336,7 @@ class BootLinuxConsole(Test):
>                            '-append', kernel_command_line)
>           self.vm.launch()
>           console_pattern =3D 'Kernel command line: %s' % kernel_comman=
d_line
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
>  =20
>       def test_ppc64_pseries(self):
>           """
> @@ -377,4 +356,4 @@ class BootLinuxConsole(Test):
>                            '-append', kernel_command_line)
>           self.vm.launch()
>           console_pattern =3D 'Kernel command line: %s' % kernel_comman=
d_line
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
> diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptanc=
e/linux_ssh_mips_malta.py
> index 134f10cac3..da7a386117 100644
> --- a/tests/acceptance/linux_ssh_mips_malta.py
> +++ b/tests/acceptance/linux_ssh_mips_malta.py
> @@ -14,6 +14,7 @@ import time
>  =20
>   from avocado import skipIf
>   from avocado_qemu import Test
> +from avocado_qemu import wait_for_console_pattern
>   from avocado.utils import process
>   from avocado.utils import archive
>  =20
> @@ -56,19 +57,6 @@ class LinuxSSH(Test):
>           },
>       }
>  =20
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
> -                fail =3D 'Failure message found in console: %s' % fail=
ure_message
> -                self.fail(fail)
> -
>       def get_portfwd(self):
>           res =3D self.vm.command('human-monitor-command',
>                                 command_line=3D'info usernet')
> @@ -135,7 +123,7 @@ class LinuxSSH(Test):
>  =20
>           self.log.info('VM launched, waiting for sshd')
>           console_pattern =3D 'Starting OpenBSD Secure Shell server: ss=
hd'
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern, 'Oops')
>           self.log.info('sshd ready')
>  =20
>           self.ssh_connect('root', 'root', rsa_hostkey_b64=3Drsa_hostke=
y_b64)
> @@ -143,7 +131,7 @@ class LinuxSSH(Test):
>       def shutdown_via_ssh(self):
>           self.ssh_command('poweroff')
>           self.ssh_disconnect_vm()
> -        self.wait_for_console_pattern('Power down')
> +        wait_for_console_pattern(self, 'Power down', 'Oops')
>  =20
>       def run_common_commands(self):
>           stdout, stderr =3D self.ssh_command('lspci -d 11ab:4620')
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

