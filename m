Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AB5C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE8852173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8852173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55034 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT61N-0004mC-6q
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 10:45:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hT60S-0004IA-RE
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hT60Q-0000iU-Ku
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:44:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hT60Q-0000Y8-Bx
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:44:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so5980766wrv.2
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 07:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=fPshr+OEm74CgnV7UYCBI9NfAL1JodQwPqNivmbNI3Q=;
	b=DQdKMDNZ5GmtvyUi8FzLQa2DWZCw6gHs/izwnkjB16LdgSe8tSzqAbk44gG5QbJ7Ex
	Qj1yK9HtZpGGKNGSVG23+m0XhuX5OUw6PL4TIJqXKw7m3GZ4QhDNf4vpXUt6G6/7VFAx
	z3fOYEKYguDN0IKzMSpKwMgO5v8l071wqVkk3ScwQXErJ0XTekMSXSDVzEbj+kRlMshF
	uA9dw+PKPnn1sqOoKc9w0N7zNX5HUhgjOnzLIq1J8VsDpCMfp6MrwPlf+/ZBeJOESc/b
	3gNmsFxbY/bFverxn5cW7S4i+fjtm6D44EOsMPzwXrYj2XpV/gWBCGmGLQs/VNToPnj9
	H65w==
X-Gm-Message-State: APjAAAW5ny5neNA6ZNZeEkeBch/ILjdkd0qCdechB651s4oJe4+T5EJe
	Y4ZmFEL4FrF74dw4domjpVtKKg==
X-Google-Smtp-Source: APXvYqxoH0zrxXS6o6RvCK0+k+45IZfnSm/Os94VOT5l+HgjrsKNtiQerzUv7VdY3J5t8uXBOEX9xg==
X-Received: by 2002:a5d:68c7:: with SMTP id p7mr27741406wrw.23.1558449870397; 
	Tue, 21 May 2019 07:44:30 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	x5sm24281172wrt.72.2019.05.21.07.44.29
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 07:44:29 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20190520231910.12184-1-f4bug@amsat.org>
	<20190520231910.12184-5-f4bug@amsat.org>
	<CAL1e-=jfYuh4jLAacFeZcOes5A3PERNLqsE4_hiEci+x0XBTrw@mail.gmail.com>
	<CAL1e-=heGtJj-30YsAVyGKSMULZ5ggVd42+c9caGqN3PBRddag@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <92d1d73c-c091-9768-a850-69b736c28edc@redhat.com>
Date: Tue, 21 May 2019 16:44:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=heGtJj-30YsAVyGKSMULZ5ggVd42+c9caGqN3PBRddag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 4/4] BootLinuxSshTest: Test some userspace
 commands on Malta
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

Hi Aleksandar,

On 5/21/19 11:26 AM, Aleksandar Markovic wrote:
> On May 21, 2019 10:18 AM, "Aleksandar Markovic" <aleksandar.m.mail@gmail.com>
> wrote:
>>
>>
>> On May 21, 2019 1:19 AM, "Philippe Mathieu-Daudé" <f4bug@amsat.org> wrote:
>>>
>>> This tests boot a full VM and check the serial console until
>>> the SSH daemon is running, then start a SSH session and run
>>> some commands.
>>>
> 
> If there is no objection from Cleber or others, I would like to apply this
> patch to my next MIPS pull request. We in Wave just started regular
> regression tests of various nature for QEMU 4.1 for MIPS, and would really
> like to have this test integrated as soon as possible, that is why I am
> rushing a bit. I am talking here about this patch only, since it is a sort
> of an independant unit - I will not do anything with other remaining
> patches from this series.

Thanks for the quick review :)

> 
> Please let me know if you have any concerns.

I threw this as it because it is working enough for me, but I'm secretly
hoping Cleber would take it and improve it, because I don't feel
confident with Python, and he better know Avocado ;)
This is why I also split this out of the other BootLinuxConsole test.

Anyway if it doesn't break anything and is already useful, it can get
improved later.

> Sincerely, Aleksandar
> 
>>> This test can be run using:
>>>
>>>   $ avocado --show=ssh run -t arch:mips
> tests/acceptance/linux_ssh_mips_malta.py
>>>   ssh: Entering interactive session.
>>>   ssh: # uname -a
>>>   ssh: Linux debian-mips 3.2.0-4-4kc-malta #1 Debian 3.2.51-1 mips
> GNU/Linux
>>>   ssh: # lspci -d 11ab:4620
>>>   ssh: 00:00.0 Host bridge: Marvell Technology Group Ltd.
> GT-64120/64120A/64121A System Controller (rev 10)
>>>   ssh: # cat /sys/bus/i2c/devices/i2c-0/name
>>>   ssh: SMBus PIIX4 adapter at 1100
>>>   ssh: # cat /proc/mtd
>>>   ssh: dev:    size   erasesize  name
>>>   ssh: mtd0: 00100000 00010000 "YAMON"
>>>   ssh: mtd1: 002e0000 00010000 "User FS"
>>>   ssh: mtd2: 00020000 00010000 "Board Config"
>>>   ssh: # md5sum /dev/mtd2ro
>>>   ssh: 0dfbe8aa4c20b52e1b8bf3cb6cbdf193  /dev/mtd2ro
>>>   ssh: # poweroff

Aleksandar, do you think of other commands we should run? What commands
do you usually try?

I plan to later install more packages in the VM (in particular test
packages, FPU extensive, device tests and so on).

My rule about device testing is "if the device can be tested in a KVM
guest, don't test it on TCG guest" for obvious reason of speed.

>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>
>> Excelent! Frankly, this was something that we in MIPS needed and missed
> very much for a long time.
>>
>> I liked the idea that this test does not run as a default, giving us
> opportunity to extend and adjust it in future as we deem appropriate for
> our MIPS needs, but without affecting people running default test

Note, the tests have the "slow" avocado tag, but it is not used because
I'm not sure how to modify the 'check-acceptance' rule of
tests/Makefile.include but Cleber will probably fix this ;)

> execution. In other words, this patch achieves “best of both worlds”.
>>
>> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>>
>>> TODO: do not run this tests by default, use the 'slow' tag
>>> ---
>>>  MAINTAINERS                              |   1 +
>>>  tests/acceptance/linux_ssh_mips_malta.py | 229 +++++++++++++++++++++++
>>>  tests/requirements.txt                   |   1 +
>>>  3 files changed, 231 insertions(+)
>>>  create mode 100644 tests/acceptance/linux_ssh_mips_malta.py
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 9424a490d6..69fa4b3abc 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -934,6 +934,7 @@ M: Aurelien Jarno <aurelien@aurel32.net>
>>>  R: Aleksandar Rikalo <arikalo@wavecomp.com>
>>>  S: Maintained
>>>  F: hw/mips/mips_malta.c
>>> +F: tests/acceptance/linux_ssh_mips_malta.py
>>>
>>>  Mipssim
>>>  M: Aleksandar Markovic <amarkovic@wavecomp.com>
>>> diff --git a/tests/acceptance/linux_ssh_mips_malta.py
> b/tests/acceptance/linux_ssh_mips_malta.py
>>> new file mode 100644
>>> index 0000000000..ceb530ff88
>>> --- /dev/null
>>> +++ b/tests/acceptance/linux_ssh_mips_malta.py
>>> @@ -0,0 +1,229 @@
>>> +# Functional test that boots a VM and run commands via a SSH session
>>> +#
>>> +# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> +#
>>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>>> +# later.  See the COPYING file in the top-level directory.
>>> +
>>> +import os
>>> +import re
>>> +import base64
>>> +import logging
>>> +import paramiko
>>> +import time
>>> +
>>> +from avocado_qemu import Test
>>> +from avocado.utils import process
>>> +from avocado.utils import archive
>>> +
>>> +
>>> +class LinuxSSH(Test):
>>> +
>>> +    timeout = 150 # Not for 'configure --enable-debug
> --enable-debug-tcg'
>>> +
>>> +    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
>>> +    VM_IP = '127.0.0.1'
>>> +
>>> +    IMAGE_INFO = {
>>> +        'be': {
>>> +            'image_url': 'https://people.debian.org/~aurel32/qemu/mips/
> '
>>> +                         'debian_wheezy_mips_standard.qcow2',
>>> +            'image_hash': '8987a63270df67345b2135a6b7a4885a35e392d5',
>>> +            'rsa_hostkey':
> b'AAAAB3NzaC1yc2EAAAADAQABAAABAQCca1VitiyLAdQOld'
>>> +
>  b'zT43IOEVJZ0wHD78GJi8wDAjMiYWUzNSSn0rXGQsINHuH5'
>>> +
>  b'IlF+kBZsHinb/FtKCAyS9a8uCHhQI4SuB4QhAb0+39MlUw'
>>> +
>  b'Mm0CLkctgM2eUUZ6MQMQvDlqnue6CCkxN62EZYbaxmby7j'
>>> +
>  b'CQa1125o1HRKBvdGm2zrJWxXAfA+f1v6jHLyE8Jnu83eQ+'
>>> +
>  b'BFY25G+Vzx1PVc3zQBwJ8r0NGTRqy2//oWQP0h+bMsgeFe'
>>> +
>  b'KH/J3RJM22vg6+I4JAdBFcxnK+l781h1FuRxOn4O/Xslbg'
>>> +
>  b'go6WtB4V4TOsw2E/KfxI5IZ/icxF+swVcnvF46Hf3uQc/0'
>>> +                           b'BBqb',
>>> +        },
>>> +        'le': {
>>> +            'image_url': '
> https://people.debian.org/~aurel32/qemu/mipsel/'
>>> +                         'debian_wheezy_mipsel_standard.qcow2',
>>> +            'image_hash': '7866764d9de3ef536ffca24c9fb9f04ffdb45802',
>>> +            'rsa_hostkey':
> b'AAAAB3NzaC1yc2EAAAADAQABAAABAQClXJlBT71HL5yKvv'
>>> +
>  b'gfC7jmxSWx5zSBCzET6CLZczwAafSIs7YKfNOy/dQTxhuk'
>>> +
>  b'yIGFUugZFoF3E9PzdhunuyvyTd56MPoNIqFbb5rGokwU5I'
>>> +
>  b'TOx3dBHZR0mClypL6MVrwe0bsiIb8GhF1zioNwcsaAZnAi'
>>> +
>  b'KfXStVDtXvn/kLLq+xLABYt48CC5KYWoFaCoICskLAY+qo'
>>> +
>  b'L+LWyAnQisj4jAH8VSaSKIImFpfkHWEXPhHcC4ZBlDKtnH'
>>> +
>  b'po9vhfCHgnfW3Pzrqmk8BI4HysqPFVmJWkJGlGUL+sGeg3'
>>> +
>  b'ZZolAYuDXGuBrw8ooPJq2v2dOH+z6dyD2q/ypmAbyPqj5C'
>>> +                           b'rc8H',
>>> +        },
>>> +    }
>>> +
>>> +    def wait_for_console_pattern(self, success_message,
>>> +                                 failure_message='Oops'):

Reviewing myself:

This method might go in a generic class to handle buffered IO with QEMU
chardev.

>>> +        console = self.vm.console_socket.makefile()
>>> +        console_logger = logging.getLogger('console')
>>> +        while True:
>>> +            msg = console.readline()
>>> +            console_logger.debug(msg.strip())
>>> +            if success_message in msg:
>>> +                break
>>> +            if failure_message in msg:
>>> +                fail = 'Failure message found in console: %s' %
> failure_message
>>> +                self.fail(fail)
>>> +
>>> +    def get_portfwd(self):
>>> +        res = self.vm.command('human-monitor-command',
>>> +                              command_line='info usernet')
>>> +        line = res.split('\r\n')[2]
>>> +        port = re.split(r'.*TCP.HOST_FORWARD.*127\.0\.0\.1
> (\d+)\s+10\..*',
>>> +                        line)[1]
>>> +        self.log.debug("sshd listening on port:" + port)
>>> +        return port
>>> +
>>> +    def ssh_connect(self, username, password, rsa_hostkey_b64=None):
>>> +        self.ssh_logger = logging.getLogger('ssh')
>>> +        self.ssh_username = username
>>> +        self.ssh_ps1 = '# ' if username is 'root' else '$ '
>>> +        self.ssh_client = paramiko.SSHClient()
>>> +        port = self.get_portfwd()
>>> +        if rsa_hostkey_b64:
>>> +            rsa_hostkey_bin = base64.b64decode(rsa_hostkey_b64)
>>> +            rsa_hostkey = paramiko.RSAKey(data = rsa_hostkey_bin)
>>> +            ipport = '[%s]:%s' % (self.VM_IP, port)
>>> +            self.ssh_logger.debug('ipport ' + ipport)
>>> +            self.ssh_client.get_host_keys().add(ipport, 'ssh-rsa',
> rsa_hostkey)
>>> +        for i in range(10):
>>> +            try:
>>> +                self.ssh_client.connect(self.VM_IP, int(port),
>>> +                                        username, password,
> banner_timeout=90)
>>> +                self.ssh_logger.info("Entering interactive session.")
>>> +                return
>>> +            except:
>>> +                time.sleep(4)
>>> +                pass
>>> +        self.fail("sshd timeout")
>>> +
>>> +    def ssh_disconnect_vm(self):
>>> +        self.ssh_client.close()
>>> +
>>> +    def ssh_command(self, command, is_root=True):
>>> +        self.ssh_logger.info(self.ssh_ps1 + command)
>>> +        stdin, stdout, stderr = self.ssh_client.exec_command(command)
>>> +        stdout_lines = [line.strip('\n') for line in stdout]
>>> +        for line in stdout_lines:
>>> +            self.ssh_logger.info(line)
>>> +        stderr_lines = [line.strip('\n') for line in stderr]
>>> +        for line in stderr_lines:
>>> +            self.ssh_logger.warning(line)
>>> +        return stdout_lines, stderr_lines
>>> +
>>> +    def boot_debian_wheezy_image_and_ssh_login(self, endianess,
> kernel_path):
>>> +        image_url = self.IMAGE_INFO[endianess]['image_url']
>>> +        image_hash = self.IMAGE_INFO[endianess]['image_hash']
>>> +        image_path = self.fetch_asset(image_url, asset_hash=image_hash)
>>> +        rsa_hostkey_b64 = self.IMAGE_INFO[endianess]['rsa_hostkey']
>>> +
>>> +        self.vm.set_machine('malta')
>>> +        self.vm.set_console()
>>> +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
>>> +                               + 'console=ttyS0 root=/dev/sda1')
>>> +        self.vm.add_args('-no-reboot',
>>> +                         '-kernel', kernel_path,
>>> +                         '-append', kernel_command_line,
>>> +                         '-hda', image_path,

We should probably use 'snapshot=on' here.

>>> +                         '-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0
> -:22',
>>> +                         '-device', 'pcnet,netdev=vnet')
>>> +        self.vm.launch()
>>> +
>>> +        self.log.info('VM launched, waiting for sshd')
>>> +        console_pattern = 'Starting OpenBSD Secure Shell server: sshd'
>>> +        self.wait_for_console_pattern(console_pattern)
>>> +        self.log.info('sshd ready')
>>> +
>>> +        self.ssh_connect('root', 'root',
> rsa_hostkey_b64=rsa_hostkey_b64)
>>> +
>>> +    def shutdown_via_ssh(self):
>>> +        self.ssh_command('poweroff')
>>> +        self.ssh_disconnect_vm()
>>> +        self.wait_for_console_pattern('Power down')
>>> +
>>> +    def run_common_commands(self):
>>> +        stdout, stderr = self.ssh_command('lspci -d 11ab:4620')
>>> +        self.assertIn(True, ["GT-64120" in line for line in stdout])
>>> +
>>> +        stdout, stderr = self.ssh_command('cat
> /sys/bus/i2c/devices/i2c-0/name')
>>> +        self.assertIn(True, ["SMBus PIIX4 adapter" in line
>>> +                             for line in stdout])
>>> +
>>> +        stdout, stderr = self.ssh_command('cat /proc/mtd')
>>> +        self.assertIn(True, ["YAMON" in line
>>> +                             for line in stdout])
>>> +
>>> +        # Empty 'Board Config'
>>> +        stdout, stderr = self.ssh_command('md5sum /dev/mtd2ro')
>>> +        self.assertIn(True, ["0dfbe8aa4c20b52e1b8bf3cb6cbdf193" in line
>>> +                             for line in stdout])
>>> +
>>> +    def do_test_mips_malta(self, endianess, kernel_path, uname_m):
>>> +        self.boot_debian_wheezy_image_and_ssh_login(endianess,
> kernel_path)
>>> +
>>> +        stdout, stderr = self.ssh_command('uname -a')
>>> +        self.assertIn(True, [uname_m + " GNU/Linux" in line for line
> in stdout])
>>> +
>>> +        self.run_common_commands()
>>> +        self.shutdown_via_ssh()
>>> +
>>> +    def test_mips_malta32eb_kernel3_2_0(self):
>>> +        """
>>> +        :avocado: tags=slow
>>> +        :avocado: tags=arch:mips
>>> +        :avocado: tags=machine:malta
>>> +        :avocado: tags=endian:big
>>> +        :avocado: tags=device:pcnet32
>>> +        """
>>> +        kernel_url = ('https://people.debian.org/~aurel32/qemu/mips/'
>>> +                      'vmlinux-3.2.0-4-4kc-malta')
>>> +        kernel_hash = '592e384a4edc16dade52a6cd5c785c637bcbc9ad'
>>> +        kernel_path = self.fetch_asset(kernel_url,
> asset_hash=kernel_hash)
>>> +
>>> +        self.do_test_mips_malta('be', kernel_path, 'mips')
>>> +
>>> +    def test_mips_malta32el_kernel3_2_0(self):
>>> +        """
>>> +        :avocado: tags=slow
>>> +        :avocado: tags=arch:mipsel
>>> +        :avocado: tags=machine:malta
>>> +        :avocado: tags=endian:little
>>> +        :avocado: tags=device:pcnet32
>>> +        """
>>> +        kernel_url = ('https://people.debian.org/~aurel32/qemu/mipsel/'
>>> +                      'vmlinux-3.2.0-4-4kc-malta')
>>> +        kernel_hash = 'a66bea5a8adaa2cb3d36a1d4e0ccdb01be8f6c2a'
>>> +        kernel_path = self.fetch_asset(kernel_url,
> asset_hash=kernel_hash)
>>> +
>>> +        self.do_test_mips_malta('le', kernel_path, 'mips')
>>> +
>>> +    def test_mips_malta64eb_kernel3_2_0(self):
>>> +        """
>>> +        :avocado: tags=slow
>>> +        :avocado: tags=arch:mips64
>>> +        :avocado: tags=machine:malta
>>> +        :avocado: tags=endian:big
>>> +        :avocado: tags=device:pcnet32
>>> +        """
>>> +        kernel_url = ('https://people.debian.org/~aurel32/qemu/mips/'
>>> +                      'vmlinux-3.2.0-4-5kc-malta')
>>> +        kernel_hash = 'db6eea7de35d36c77d8c165b6bcb222e16eb91db'
>>> +        kernel_path = self.fetch_asset(kernel_url,
> asset_hash=kernel_hash)
>>> +        self.do_test_mips_malta('be', kernel_path, 'mips64')
>>> +
>>> +    def test_mips_malta64el_kernel3_2_0(self):
>>> +        """
>>> +        :avocado: tags=slow
>>> +        :avocado: tags=arch:mips64el
>>> +        :avocado: tags=machine:malta
>>> +        :avocado: tags=endian:little
>>> +        :avocado: tags=device:pcnet32
>>> +        """
>>> +        kernel_url = ('https://people.debian.org/~aurel32/qemu/mipsel/'
>>> +                      'vmlinux-3.2.0-4-5kc-malta')
>>> +        kernel_hash = '6a7f77245acf231415a0e8b725d91ed2f3487794'
>>> +        kernel_path = self.fetch_asset(kernel_url,
> asset_hash=kernel_hash)
>>> +        self.do_test_mips_malta('le', kernel_path, 'mips64')
>>> diff --git a/tests/requirements.txt b/tests/requirements.txt
>>> index 002ded6a22..3ae0e29ad7 100644
>>> --- a/tests/requirements.txt
>>> +++ b/tests/requirements.txt
>>> @@ -2,3 +2,4 @@
>>>  # in the tests/venv Python virtual environment. For more info,
>>>  # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
>>>  avocado-framework==68.0
>>> +paramiko
>>> --
>>> 2.19.1
>>>

