Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876E9C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 19:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64487205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 19:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64487205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBOSR-0002cm-Ks
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 15:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iBOOv-0008Bk-QA
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 15:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iBOOt-0003sy-TD
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 15:17:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51790)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iBOOt-0003sY-HJ
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 15:17:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E2F8983F45;
 Fri, 20 Sep 2019 19:17:01 +0000 (UTC)
Received: from localhost (ovpn-116-45.gru2.redhat.com [10.97.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 172A319D70;
 Fri, 20 Sep 2019 19:16:55 +0000 (UTC)
Date: Fri, 20 Sep 2019 16:16:54 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Cleber Rosa <crosa@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] Acceptance tests: use avocado.utils.ssh for SSH
 interaction
Message-ID: <20190920191654.GF5035@habkost.net>
References: <20190919225905.10829-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919225905.10829-1-crosa@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 20 Sep 2019 19:17:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 19, 2019 at 06:59:05PM -0400, Cleber Rosa wrote:
> This replaces paramiko with avocado.utils.ssh module, which is based
> on a (open)ssh binary, supposedly more ubiquitous.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

I just noticed that I have some patches on python-next that never
went to a pull request (sorry for the oversight!).

I assume I should remove
https://lore.kernel.org/qemu-devel/20190830184033.7630-1-philmd@redhat.com/
from the queue?

> ---
>  tests/acceptance/linux_ssh_mips_malta.py | 74 ++++++++----------------
>  tests/requirements.txt                   |  3 +-
>  2 files changed, 25 insertions(+), 52 deletions(-)
> 
> diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/linux_ssh_mips_malta.py
> index 134f10cac3..30c65568ce 100644
> --- a/tests/acceptance/linux_ssh_mips_malta.py
> +++ b/tests/acceptance/linux_ssh_mips_malta.py
> @@ -9,13 +9,14 @@ import os
>  import re
>  import base64
>  import logging
> -import paramiko
>  import time
>  
>  from avocado import skipIf
> +from avocado import skipUnless
>  from avocado_qemu import Test
>  from avocado.utils import process
>  from avocado.utils import archive
> +from avocado.utils import ssh
>  
>  
>  class LinuxSSH(Test):
> @@ -26,35 +27,18 @@ class LinuxSSH(Test):
>      VM_IP = '127.0.0.1'
>  
>      IMAGE_INFO = {
> -        'be': {
> -            'image_url': 'https://people.debian.org/~aurel32/qemu/mips/'
> -                         'debian_wheezy_mips_standard.qcow2',
> -            'image_hash': '8987a63270df67345b2135a6b7a4885a35e392d5',
> -            'rsa_hostkey': b'AAAAB3NzaC1yc2EAAAADAQABAAABAQCca1VitiyLAdQOld'
> -                           b'zT43IOEVJZ0wHD78GJi8wDAjMiYWUzNSSn0rXGQsINHuH5'
> -                           b'IlF+kBZsHinb/FtKCAyS9a8uCHhQI4SuB4QhAb0+39MlUw'
> -                           b'Mm0CLkctgM2eUUZ6MQMQvDlqnue6CCkxN62EZYbaxmby7j'
> -                           b'CQa1125o1HRKBvdGm2zrJWxXAfA+f1v6jHLyE8Jnu83eQ+'
> -                           b'BFY25G+Vzx1PVc3zQBwJ8r0NGTRqy2//oWQP0h+bMsgeFe'
> -                           b'KH/J3RJM22vg6+I4JAdBFcxnK+l781h1FuRxOn4O/Xslbg'
> -                           b'go6WtB4V4TOsw2E/KfxI5IZ/icxF+swVcnvF46Hf3uQc/0'
> -                           b'BBqb',
> -        },
> -        'le': {
> -            'image_url': 'https://people.debian.org/~aurel32/qemu/mipsel/'
> -                         'debian_wheezy_mipsel_standard.qcow2',
> -            'image_hash': '7866764d9de3ef536ffca24c9fb9f04ffdb45802',
> -            'rsa_hostkey': b'AAAAB3NzaC1yc2EAAAADAQABAAABAQClXJlBT71HL5yKvv'
> -                           b'gfC7jmxSWx5zSBCzET6CLZczwAafSIs7YKfNOy/dQTxhuk'
> -                           b'yIGFUugZFoF3E9PzdhunuyvyTd56MPoNIqFbb5rGokwU5I'
> -                           b'TOx3dBHZR0mClypL6MVrwe0bsiIb8GhF1zioNwcsaAZnAi'
> -                           b'KfXStVDtXvn/kLLq+xLABYt48CC5KYWoFaCoICskLAY+qo'
> -                           b'L+LWyAnQisj4jAH8VSaSKIImFpfkHWEXPhHcC4ZBlDKtnH'
> -                           b'po9vhfCHgnfW3Pzrqmk8BI4HysqPFVmJWkJGlGUL+sGeg3'
> -                           b'ZZolAYuDXGuBrw8ooPJq2v2dOH+z6dyD2q/ypmAbyPqj5C'
> -                           b'rc8H',
> -        },
> -    }
> +        'be': {'image_url': ('https://people.debian.org/~aurel32/qemu/mips/'
> +                             'debian_wheezy_mips_standard.qcow2'),
> +               'image_hash': '8987a63270df67345b2135a6b7a4885a35e392d5'},
> +        'le': {'image_url': ('https://people.debian.org/~aurel32/qemu/mipsel/'
> +                             'debian_wheezy_mipsel_standard.qcow2'),
> +               'image_hash': '7866764d9de3ef536ffca24c9fb9f04ffdb45802'}
> +        }
> +
> +
> +    @skipUnless(ssh.SSH_CLIENT_BINARY, 'No SSH client available')
> +    def setUp(self):
> +        super(LinuxSSH, self).setUp()
>  
>      def wait_for_console_pattern(self, success_message,
>                                   failure_message='Oops'):
> @@ -78,23 +62,14 @@ class LinuxSSH(Test):
>          self.log.debug("sshd listening on port:" + port)
>          return port
>  
> -    def ssh_connect(self, username, password, rsa_hostkey_b64=None):
> +    def ssh_connect(self, username, password):
>          self.ssh_logger = logging.getLogger('ssh')
> -        self.ssh_username = username
> -        self.ssh_ps1 = '# ' if username is 'root' else '$ '
> -        self.ssh_client = paramiko.SSHClient()
>          port = self.get_portfwd()
> -        if rsa_hostkey_b64:
> -            rsa_hostkey_bin = base64.b64decode(rsa_hostkey_b64)
> -            rsa_hostkey = paramiko.RSAKey(data = rsa_hostkey_bin)
> -            ipport = '[%s]:%s' % (self.VM_IP, port)
> -            self.ssh_logger.debug('ipport ' + ipport)
> -            self.ssh_client.get_host_keys().add(ipport, 'ssh-rsa', rsa_hostkey)
> +        self.ssh_session = ssh.Session(self.VM_IP, port=int(port),
> +                                       user=username, password=password)
>          for i in range(10):
>              try:
> -                self.ssh_client.connect(self.VM_IP, int(port),
> -                                        username, password, banner_timeout=90)
> -                self.ssh_logger.info("Entering interactive session.")
> +                self.ssh_session.connect()
>                  return
>              except:
>                  time.sleep(4)
> @@ -102,15 +77,15 @@ class LinuxSSH(Test):
>          self.fail("sshd timeout")
>  
>      def ssh_disconnect_vm(self):
> -        self.ssh_client.close()
> +        self.ssh_session.quit()
>  
>      def ssh_command(self, command, is_root=True):
> -        self.ssh_logger.info(self.ssh_ps1 + command)
> -        stdin, stdout, stderr = self.ssh_client.exec_command(command)
> -        stdout_lines = [line.strip('\n') for line in stdout]
> +        self.ssh_logger.info(command)
> +        result = self.ssh_session.cmd(command)
> +        stdout_lines = [line.rstrip() for line in result.stdout_text.splitlines()]
>          for line in stdout_lines:
>              self.ssh_logger.info(line)
> -        stderr_lines = [line.strip('\n') for line in stderr]
> +        stderr_lines = [line.rstrip() for line in result.stderr_text.splitlines()]
>          for line in stderr_lines:
>              self.ssh_logger.warning(line)
>          return stdout_lines, stderr_lines
> @@ -119,7 +94,6 @@ class LinuxSSH(Test):
>          image_url = self.IMAGE_INFO[endianess]['image_url']
>          image_hash = self.IMAGE_INFO[endianess]['image_hash']
>          image_path = self.fetch_asset(image_url, asset_hash=image_hash)
> -        rsa_hostkey_b64 = self.IMAGE_INFO[endianess]['rsa_hostkey']
>  
>          self.vm.set_machine('malta')
>          self.vm.set_console()
> @@ -138,7 +112,7 @@ class LinuxSSH(Test):
>          self.wait_for_console_pattern(console_pattern)
>          self.log.info('sshd ready')
>  
> -        self.ssh_connect('root', 'root', rsa_hostkey_b64=rsa_hostkey_b64)
> +        self.ssh_connect('root', 'root')
>  
>      def shutdown_via_ssh(self):
>          self.ssh_command('poweroff')
> diff --git a/tests/requirements.txt b/tests/requirements.txt
> index bd1f7590ed..a2a587223a 100644
> --- a/tests/requirements.txt
> +++ b/tests/requirements.txt
> @@ -1,5 +1,4 @@
>  # Add Python module requirements, one per line, to be installed
>  # in the tests/venv Python virtual environment. For more info,
>  # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
> -avocado-framework==68.0
> -paramiko==2.4.2
> +avocado-framework==72.0
> -- 
> 2.21.0
> 
> 

-- 
Eduardo

