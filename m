Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3CEC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1DEF217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DEF217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58738 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUFAM-0005ge-VR
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 14:43:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUF9K-00055Y-J1
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUF9I-0003kV-Hm
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:42:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hUF9G-0003hT-JU
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:42:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D17F35944C;
	Fri, 24 May 2019 18:42:28 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B57325C1B4;
	Fri, 24 May 2019 18:42:27 +0000 (UTC)
Date: Fri, 24 May 2019 15:42:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Message-ID: <20190524184225.GI10764@habkost.net>
References: <20190523161832.22490-1-f4bug@amsat.org>
	<20190523161832.22490-5-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190523161832.22490-5-f4bug@amsat.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Fri, 24 May 2019 18:42:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 4/4] BootLinuxSshTest: Test some
 userspace commands on Malta
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Cleber Rosa <crosa@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 23, 2019 at 06:18:32PM +0200, Philippe Mathieu-Daud=E9 wrote:
> This tests boot a full VM and check the serial console until
> the SSH daemon is running, then start a SSH session and run
> some commands.
>=20
> This test can be run using:
>=20
>   $ avocado --show=3Dssh run -t arch:mips tests/acceptance/linux_ssh_mi=
ps_malta.py
>   ssh: Entering interactive session.
>   ssh: # uname -a
>   ssh: Linux debian-mips 3.2.0-4-4kc-malta #1 Debian 3.2.51-1 mips GNU/=
Linux
>   ssh: # lspci -d 11ab:4620
>   ssh: 00:00.0 Host bridge: Marvell Technology Group Ltd. GT-64120/6412=
0A/64121A System Controller (rev 10)
>   ssh: # cat /sys/bus/i2c/devices/i2c-0/name
>   ssh: SMBus PIIX4 adapter at 1100
>   ssh: # cat /proc/mtd
>   ssh: dev:    size   erasesize  name
>   ssh: mtd0: 00100000 00010000 "YAMON"
>   ssh: mtd1: 002e0000 00010000 "User FS"
>   ssh: mtd2: 00020000 00010000 "Board Config"
>   ssh: # md5sum /dev/mtd2ro
>   ssh: 0dfbe8aa4c20b52e1b8bf3cb6cbdf193  /dev/mtd2ro
>   ssh: # poweroff
>=20
> Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> v2: Add skipIf(getenv(CONTINUOUS_INTEGRATION))

This will make the behavior of "make check-acceptance" different
inside and outside Travis, in a way that is not documented
anywhere.  I thought we would be using Avocado tags to indicate
which tests we want to skip.

But if it solves our immediate problems we're having, I won't
NACK this.  Can we at least add TODO comments indicating we
should eventually get rid of the hack?

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

> ---
>  MAINTAINERS                              |   1 +
>  tests/acceptance/linux_ssh_mips_malta.py | 230 +++++++++++++++++++++++
>  tests/requirements.txt                   |   1 +
>  3 files changed, 232 insertions(+)
>  create mode 100644 tests/acceptance/linux_ssh_mips_malta.py
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3cacd751bf..8c34d5c34b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -934,6 +934,7 @@ M: Aurelien Jarno <aurelien@aurel32.net>
>  R: Aleksandar Rikalo <arikalo@wavecomp.com>
>  S: Maintained
>  F: hw/mips/mips_malta.c
> +F: tests/acceptance/linux_ssh_mips_malta.py
> =20
>  Mipssim
>  M: Aleksandar Markovic <amarkovic@wavecomp.com>
> diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptanc=
e/linux_ssh_mips_malta.py
> new file mode 100644
> index 0000000000..aafb0c39f6
> --- /dev/null
> +++ b/tests/acceptance/linux_ssh_mips_malta.py
> @@ -0,0 +1,230 @@
> +# Functional test that boots a VM and run commands via a SSH session
> +#
> +# Copyright (c) Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import os
> +import re
> +import base64
> +import logging
> +import paramiko
> +import time
> +
> +from avocado import skipIf
> +from avocado_qemu import Test
> +from avocado.utils import process
> +from avocado.utils import archive
> +
> +
> +class LinuxSSH(Test):
> +
> +    timeout =3D 150 # Not for 'configure --enable-debug --enable-debug=
-tcg'
> +
> +    KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
> +    VM_IP =3D '127.0.0.1'
> +
> +    IMAGE_INFO =3D {
> +        'be': {
> +            'image_url': 'https://people.debian.org/~aurel32/qemu/mips=
/'
> +                         'debian_wheezy_mips_standard.qcow2',
> +            'image_hash': '8987a63270df67345b2135a6b7a4885a35e392d5',
> +            'rsa_hostkey': b'AAAAB3NzaC1yc2EAAAADAQABAAABAQCca1VitiyLA=
dQOld'
> +                           b'zT43IOEVJZ0wHD78GJi8wDAjMiYWUzNSSn0rXGQsI=
NHuH5'
> +                           b'IlF+kBZsHinb/FtKCAyS9a8uCHhQI4SuB4QhAb0+3=
9MlUw'
> +                           b'Mm0CLkctgM2eUUZ6MQMQvDlqnue6CCkxN62EZYbax=
mby7j'
> +                           b'CQa1125o1HRKBvdGm2zrJWxXAfA+f1v6jHLyE8Jnu=
83eQ+'
> +                           b'BFY25G+Vzx1PVc3zQBwJ8r0NGTRqy2//oWQP0h+bM=
sgeFe'
> +                           b'KH/J3RJM22vg6+I4JAdBFcxnK+l781h1FuRxOn4O/=
Xslbg'
> +                           b'go6WtB4V4TOsw2E/KfxI5IZ/icxF+swVcnvF46Hf3=
uQc/0'
> +                           b'BBqb',
> +        },
> +        'le': {
> +            'image_url': 'https://people.debian.org/~aurel32/qemu/mips=
el/'
> +                         'debian_wheezy_mipsel_standard.qcow2',
> +            'image_hash': '7866764d9de3ef536ffca24c9fb9f04ffdb45802',
> +            'rsa_hostkey': b'AAAAB3NzaC1yc2EAAAADAQABAAABAQClXJlBT71HL=
5yKvv'
> +                           b'gfC7jmxSWx5zSBCzET6CLZczwAafSIs7YKfNOy/dQ=
Txhuk'
> +                           b'yIGFUugZFoF3E9PzdhunuyvyTd56MPoNIqFbb5rGo=
kwU5I'
> +                           b'TOx3dBHZR0mClypL6MVrwe0bsiIb8GhF1zioNwcsa=
AZnAi'
> +                           b'KfXStVDtXvn/kLLq+xLABYt48CC5KYWoFaCoICskL=
AY+qo'
> +                           b'L+LWyAnQisj4jAH8VSaSKIImFpfkHWEXPhHcC4ZBl=
DKtnH'
> +                           b'po9vhfCHgnfW3Pzrqmk8BI4HysqPFVmJWkJGlGUL+=
sGeg3'
> +                           b'ZZolAYuDXGuBrw8ooPJq2v2dOH+z6dyD2q/ypmAby=
Pqj5C'
> +                           b'rc8H',
> +        },
> +    }
> +
> +    def wait_for_console_pattern(self, success_message,
> +                                 failure_message=3D'Oops'):
> +        console =3D self.vm.console_socket.makefile()
> +        console_logger =3D logging.getLogger('console')
> +        while True:
> +            msg =3D console.readline()
> +            console_logger.debug(msg.strip())
> +            if success_message in msg:
> +                break
> +            if failure_message in msg:
> +                fail =3D 'Failure message found in console: %s' % fail=
ure_message
> +                self.fail(fail)
> +
> +    def get_portfwd(self):
> +        res =3D self.vm.command('human-monitor-command',
> +                              command_line=3D'info usernet')
> +        line =3D res.split('\r\n')[2]
> +        port =3D re.split(r'.*TCP.HOST_FORWARD.*127\.0\.0\.1 (\d+)\s+1=
0\..*',
> +                        line)[1]
> +        self.log.debug("sshd listening on port:" + port)
> +        return port
> +
> +    def ssh_connect(self, username, password, rsa_hostkey_b64=3DNone):
> +        self.ssh_logger =3D logging.getLogger('ssh')
> +        self.ssh_username =3D username
> +        self.ssh_ps1 =3D '# ' if username is 'root' else '$ '
> +        self.ssh_client =3D paramiko.SSHClient()
> +        port =3D self.get_portfwd()
> +        if rsa_hostkey_b64:
> +            rsa_hostkey_bin =3D base64.b64decode(rsa_hostkey_b64)
> +            rsa_hostkey =3D paramiko.RSAKey(data =3D rsa_hostkey_bin)
> +            ipport =3D '[%s]:%s' % (self.VM_IP, port)
> +            self.ssh_logger.debug('ipport ' + ipport)
> +            self.ssh_client.get_host_keys().add(ipport, 'ssh-rsa', rsa=
_hostkey)
> +        for i in range(10):
> +            try:
> +                self.ssh_client.connect(self.VM_IP, int(port),
> +                                        username, password, banner_tim=
eout=3D90)
> +                self.ssh_logger.info("Entering interactive session.")
> +                return
> +            except:
> +                time.sleep(4)
> +                pass
> +        self.fail("sshd timeout")
> +
> +    def ssh_disconnect_vm(self):
> +        self.ssh_client.close()
> +
> +    def ssh_command(self, command, is_root=3DTrue):
> +        self.ssh_logger.info(self.ssh_ps1 + command)
> +        stdin, stdout, stderr =3D self.ssh_client.exec_command(command=
)
> +        stdout_lines =3D [line.strip('\n') for line in stdout]
> +        for line in stdout_lines:
> +            self.ssh_logger.info(line)
> +        stderr_lines =3D [line.strip('\n') for line in stderr]
> +        for line in stderr_lines:
> +            self.ssh_logger.warning(line)
> +        return stdout_lines, stderr_lines
> +
> +    def boot_debian_wheezy_image_and_ssh_login(self, endianess, kernel=
_path):
> +        image_url =3D self.IMAGE_INFO[endianess]['image_url']
> +        image_hash =3D self.IMAGE_INFO[endianess]['image_hash']
> +        image_path =3D self.fetch_asset(image_url, asset_hash=3Dimage_=
hash)
> +        rsa_hostkey_b64 =3D self.IMAGE_INFO[endianess]['rsa_hostkey']
> +
> +        self.vm.set_machine('malta')
> +        self.vm.set_console()
> +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE
> +                               + 'console=3DttyS0 root=3D/dev/sda1')
> +        self.vm.add_args('-no-reboot',
> +                         '-kernel', kernel_path,
> +                         '-append', kernel_command_line,
> +                         '-hda', image_path,
> +                         '-netdev', 'user,id=3Dvnet,hostfwd=3D:127.0.0=
.1:0-:22',
> +                         '-device', 'pcnet,netdev=3Dvnet')
> +        self.vm.launch()
> +
> +        self.log.info('VM launched, waiting for sshd')
> +        console_pattern =3D 'Starting OpenBSD Secure Shell server: ssh=
d'
> +        self.wait_for_console_pattern(console_pattern)
> +        self.log.info('sshd ready')
> +
> +        self.ssh_connect('root', 'root', rsa_hostkey_b64=3Drsa_hostkey=
_b64)
> +
> +    def shutdown_via_ssh(self):
> +        self.ssh_command('poweroff')
> +        self.ssh_disconnect_vm()
> +        self.wait_for_console_pattern('Power down')
> +
> +    def run_common_commands(self):
> +        stdout, stderr =3D self.ssh_command('lspci -d 11ab:4620')
> +        self.assertIn(True, ["GT-64120" in line for line in stdout])
> +
> +        stdout, stderr =3D self.ssh_command('cat /sys/bus/i2c/devices/=
i2c-0/name')
> +        self.assertIn(True, ["SMBus PIIX4 adapter" in line
> +                             for line in stdout])
> +
> +        stdout, stderr =3D self.ssh_command('cat /proc/mtd')
> +        self.assertIn(True, ["YAMON" in line
> +                             for line in stdout])
> +
> +        # Empty 'Board Config'
> +        stdout, stderr =3D self.ssh_command('md5sum /dev/mtd2ro')
> +        self.assertIn(True, ["0dfbe8aa4c20b52e1b8bf3cb6cbdf193" in lin=
e
> +                             for line in stdout])
> +
> +    def do_test_mips_malta(self, endianess, kernel_path, uname_m):
> +        self.boot_debian_wheezy_image_and_ssh_login(endianess, kernel_=
path)
> +
> +        stdout, stderr =3D self.ssh_command('uname -a')
> +        self.assertIn(True, [uname_m + " GNU/Linux" in line for line i=
n stdout])
> +
> +        self.run_common_commands()
> +        self.shutdown_via_ssh()
> +
> +    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI=
')
> +    def test_mips_malta32eb_kernel3_2_0(self):
> +        """
> +        :avocado: tags=3Darch:mips
> +        :avocado: tags=3Dmachine:malta
> +        :avocado: tags=3Dendian:big
> +        :avocado: tags=3Ddevice:pcnet32
> +        """
> +        kernel_url =3D ('https://people.debian.org/~aurel32/qemu/mips/=
'
> +                      'vmlinux-3.2.0-4-4kc-malta')
> +        kernel_hash =3D '592e384a4edc16dade52a6cd5c785c637bcbc9ad'
> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkern=
el_hash)
> +
> +        self.do_test_mips_malta('be', kernel_path, 'mips')
> +
> +    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI=
')
> +    def test_mips_malta32el_kernel3_2_0(self):
> +        """
> +        :avocado: tags=3Darch:mipsel
> +        :avocado: tags=3Dmachine:malta
> +        :avocado: tags=3Dendian:little
> +        :avocado: tags=3Ddevice:pcnet32
> +        """
> +        kernel_url =3D ('https://people.debian.org/~aurel32/qemu/mipse=
l/'
> +                      'vmlinux-3.2.0-4-4kc-malta')
> +        kernel_hash =3D 'a66bea5a8adaa2cb3d36a1d4e0ccdb01be8f6c2a'
> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkern=
el_hash)
> +
> +        self.do_test_mips_malta('le', kernel_path, 'mips')
> +
> +    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI=
')
> +    def test_mips_malta64eb_kernel3_2_0(self):
> +        """
> +        :avocado: tags=3Darch:mips64
> +        :avocado: tags=3Dmachine:malta
> +        :avocado: tags=3Dendian:big
> +        :avocado: tags=3Ddevice:pcnet32
> +        """
> +        kernel_url =3D ('https://people.debian.org/~aurel32/qemu/mips/=
'
> +                      'vmlinux-3.2.0-4-5kc-malta')
> +        kernel_hash =3D 'db6eea7de35d36c77d8c165b6bcb222e16eb91db'
> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkern=
el_hash)
> +        self.do_test_mips_malta('be', kernel_path, 'mips64')
> +
> +    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI=
')
> +    def test_mips_malta64el_kernel3_2_0(self):
> +        """
> +        :avocado: tags=3Darch:mips64el
> +        :avocado: tags=3Dmachine:malta
> +        :avocado: tags=3Dendian:little
> +        :avocado: tags=3Ddevice:pcnet32
> +        """
> +        kernel_url =3D ('https://people.debian.org/~aurel32/qemu/mipse=
l/'
> +                      'vmlinux-3.2.0-4-5kc-malta')
> +        kernel_hash =3D '6a7f77245acf231415a0e8b725d91ed2f3487794'
> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkern=
el_hash)
> +        self.do_test_mips_malta('le', kernel_path, 'mips64')
> diff --git a/tests/requirements.txt b/tests/requirements.txt
> index 002ded6a22..3ae0e29ad7 100644
> --- a/tests/requirements.txt
> +++ b/tests/requirements.txt
> @@ -2,3 +2,4 @@
>  # in the tests/venv Python virtual environment. For more info,
>  # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
>  avocado-framework=3D=3D68.0
> +paramiko
> --=20
> 2.19.1
>=20

--=20
Eduardo

