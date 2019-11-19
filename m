Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA67C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 089A9222B5
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VH1e5A96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089A9222B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX3wM-0002g3-5M
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 08:53:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iX3vh-0002G4-2h
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:52:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iX3vd-000798-Er
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:52:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58828
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iX3vd-00078s-Aj
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574171544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8B8IiyMxlvgmlX6FgwFd8BPbD+2sHkXcCnQRXHMdxSY=;
 b=VH1e5A96kVDSvk+Ss/z+ZsbTi39dGypMsbGQHXzWFahja3uq/7C9vlJpP4wWXqGmqkmxI9
 Q7ZD60rHWcM2XbApsc8alZwZj2aN5tX29vgo4ai9w97gPYwp76brYcWliOjnBp8Yl/wSiA
 K0idPfqXhloQ+0xD2g8xQYR+k2+AZzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-SeZiU6aWOFadpg2pe9skag-1; Tue, 19 Nov 2019 08:52:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BB70800EBE;
 Tue, 19 Nov 2019 13:52:21 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-83.gru2.redhat.com
 [10.97.116.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 827A05E247;
 Tue, 19 Nov 2019 13:52:15 +0000 (UTC)
Subject: Re: [PATCH 06/26] tests/acceptance: Rename avocado_qemu.Test as
 MachineTest
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191028073441.6448-1-philmd@redhat.com>
 <20191028073441.6448-7-philmd@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <91987b1a-c20f-c5ae-1240-1743c16a8d71@redhat.com>
Date: Tue, 19 Nov 2019 11:52:14 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191028073441.6448-7-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: SeZiU6aWOFadpg2pe9skag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>, Kamil Rytarowski <kamil@netbsd.org>,
 Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On 10/28/19 4:34 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> This class is used to test QEMU machines, rename it as MachineTest.
> This will allow us to add a UserTest class for qemu-user tests.


My concern with this rename is that usually "Machine" refers to machine=20
type implementation. What if we follow QEMU's terminology of User vs=20
System? So it would be renamed to something like SystemTest (vs=20
LinuxUserTest as you propose on Patch 08).

Thanks,

Wainer

>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   docs/devel/testing.rst                    | 8 ++++----
>   tests/acceptance/avocado_qemu/__init__.py | 7 ++++++-
>   tests/acceptance/boot_linux_console.py    | 4 ++--
>   tests/acceptance/cpu_queries.py           | 4 ++--
>   tests/acceptance/empty_cpu_model.py       | 4 ++--
>   tests/acceptance/linux_initrd.py          | 4 ++--
>   tests/acceptance/linux_ssh_mips_malta.py  | 4 ++--
>   tests/acceptance/migration.py             | 4 ++--
>   tests/acceptance/version.py               | 4 ++--
>   tests/acceptance/virtio_version.py        | 4 ++--
>   tests/acceptance/vnc.py                   | 4 ++--
>   11 files changed, 28 insertions(+), 23 deletions(-)
>
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 8e981e062d..d9fab83458 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -601,7 +601,7 @@ class.  Here's a simple usage example:
>     from avocado_qemu import Test
>  =20
>  =20
> -  class Version(Test):
> +  class Version(MachineTest):
>         """
>         :avocado: tags=3Dquick
>         """
> @@ -625,7 +625,7 @@ in the current directory, tagged as "quick", run:
>  =20
>     avocado run -t quick .
>  =20
> -The ``avocado_qemu.Test`` base test class
> +The ``avocado_qemu.MachineTest`` base test class
>   -----------------------------------------
>  =20
>   The ``avocado_qemu.Test`` class has a number of characteristics that
> @@ -646,10 +646,10 @@ and hypothetical example follows:
>  =20
>   .. code::
>  =20
> -  from avocado_qemu import Test
> +  from avocado_qemu import MachineTest
>  =20
>  =20
> -  class MultipleMachines(Test):
> +  class MultipleMachines(MachineTest):
>         """
>         :avocado: enable
>         """
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
> index bdece76723..a2cc3d689b 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -100,7 +100,6 @@ def exec_command_and_wait_for_pattern(test, command,
>  =20
>   class Test(avocado.Test):
>       def setUp(self):
> -        self._vms =3D {}
>           arches =3D self.tags.get('arch', [])
>           if len(arches) =3D=3D 1:
>               arch =3D arches.pop()
> @@ -113,6 +112,12 @@ class Test(avocado.Test):
>           if self.qemu_bin is None:
>               self.cancel("No QEMU binary defined or found in the source =
tree")
>  =20
> +
> +class MachineTest(Test):
> +    def setUp(self):
> +        self._vms =3D {}
> +        super().setUp()
> +
>       def _new_vm(self, *args):
>           vm =3D QEMUMachine(self.qemu_bin)
>           if args:
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 4b419b0559..f94dc4bbca 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -13,14 +13,14 @@ import lzma
>   import gzip
>   import shutil
>  =20
> -from avocado_qemu import Test
> +from avocado_qemu import MachineTest
>   from avocado_qemu import exec_command_and_wait_for_pattern
>   from avocado_qemu import wait_for_console_pattern
>   from avocado.utils import process
>   from avocado.utils import archive
>  =20
>  =20
> -class BootLinuxConsole(Test):
> +class BootLinuxConsole(MachineTest):
>       """
>       Boots a Linux kernel and checks that the console is operational and=
 the
>       kernel command line is properly passed from QEMU to the kernel
> diff --git a/tests/acceptance/cpu_queries.py b/tests/acceptance/cpu_queri=
es.py
> index af47d2795a..40df8264cf 100644
> --- a/tests/acceptance/cpu_queries.py
> +++ b/tests/acceptance/cpu_queries.py
> @@ -10,9 +10,9 @@
>  =20
>   import logging
>  =20
> -from avocado_qemu import Test
> +from avocado_qemu import MachineTest
>  =20
> -class QueryCPUModelExpansion(Test):
> +class QueryCPUModelExpansion(MachineTest):
>       """
>       Run query-cpu-model-expansion for each CPU model, and validate resu=
lts
>       """
> diff --git a/tests/acceptance/empty_cpu_model.py b/tests/acceptance/empty=
_cpu_model.py
> index 3f4f663582..a4e9cc62f8 100644
> --- a/tests/acceptance/empty_cpu_model.py
> +++ b/tests/acceptance/empty_cpu_model.py
> @@ -8,9 +8,9 @@
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later.  See the COPYING file in the top-level directory.
>   import subprocess
> -from avocado_qemu import Test
> +from avocado_qemu import MachineTest
>  =20
> -class EmptyCPUModel(Test):
> +class EmptyCPUModel(MachineTest):
>       def test(self):
>           cmd =3D [self.qemu_bin, '-S', '-display', 'none', '-machine', '=
none', '-cpu', '']
>           r =3D subprocess.run(cmd, stderr=3Dsubprocess.PIPE, stdout=3Dsu=
bprocess.PIPE)
> diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_in=
itrd.py
> index c61d9826a4..e8afb007d0 100644
> --- a/tests/acceptance/linux_initrd.py
> +++ b/tests/acceptance/linux_initrd.py
> @@ -12,10 +12,10 @@ import logging
>   import tempfile
>   from avocado.utils.process import run
>  =20
> -from avocado_qemu import Test
> +from avocado_qemu import MachineTest
>  =20
>  =20
> -class LinuxInitrd(Test):
> +class LinuxInitrd(MachineTest):
>       """
>       Checks QEMU evaluates correctly the initrd file passed as -initrd o=
ption.
>  =20
> diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/=
linux_ssh_mips_malta.py
> index fc13f9e4d4..5db64affda 100644
> --- a/tests/acceptance/linux_ssh_mips_malta.py
> +++ b/tests/acceptance/linux_ssh_mips_malta.py
> @@ -12,14 +12,14 @@ import logging
>   import time
>  =20
>   from avocado import skipUnless
> -from avocado_qemu import Test
> +from avocado_qemu import MachineTest
>   from avocado_qemu import wait_for_console_pattern
>   from avocado.utils import process
>   from avocado.utils import archive
>   from avocado.utils import ssh
>  =20
>  =20
> -class LinuxSSH(Test):
> +class LinuxSSH(MachineTest):
>  =20
>       timeout =3D 150 # Not for 'configure --enable-debug --enable-debug-=
tcg'
>  =20
> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.p=
y
> index a44c1ae58f..3a823c9cc7 100644
> --- a/tests/acceptance/migration.py
> +++ b/tests/acceptance/migration.py
> @@ -10,13 +10,13 @@
>   # later.  See the COPYING file in the top-level directory.
>  =20
>  =20
> -from avocado_qemu import Test
> +from avocado_qemu import MachineTest
>  =20
>   from avocado.utils import network
>   from avocado.utils import wait
>  =20
>  =20
> -class Migration(Test):
> +class Migration(MachineTest):
>  =20
>       timeout =3D 10
>  =20
> diff --git a/tests/acceptance/version.py b/tests/acceptance/version.py
> index 67c2192c93..e11661f780 100644
> --- a/tests/acceptance/version.py
> +++ b/tests/acceptance/version.py
> @@ -9,10 +9,10 @@
>   # later.  See the COPYING file in the top-level directory.
>  =20
>  =20
> -from avocado_qemu import Test
> +from avocado_qemu import MachineTest
>  =20
>  =20
> -class Version(Test):
> +class Version(MachineTest):
>       """
>       :avocado: tags=3Dquick
>       """
> diff --git a/tests/acceptance/virtio_version.py b/tests/acceptance/virtio=
_version.py
> index 33593c29dd..ea33363b0f 100644
> --- a/tests/acceptance/virtio_version.py
> +++ b/tests/acceptance/virtio_version.py
> @@ -13,7 +13,7 @@ import os
>  =20
>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'py=
thon'))
>   from qemu.machine import QEMUMachine
> -from avocado_qemu import Test
> +from avocado_qemu import MachineTest
>  =20
>   # Virtio Device IDs:
>   VIRTIO_NET =3D 1
> @@ -55,7 +55,7 @@ def get_pci_interfaces(vm, devtype):
>       interfaces =3D ('pci-express-device', 'conventional-pci-device')
>       return [i for i in interfaces if devtype_implements(vm, devtype, i)=
]
>  =20
> -class VirtioVersionCheck(Test):
> +class VirtioVersionCheck(MachineTest):
>       """
>       Check if virtio-version-specific device types result in the
>       same device tree created by `disable-modern` and
> diff --git a/tests/acceptance/vnc.py b/tests/acceptance/vnc.py
> index 3f40bc2be1..c2a364d23e 100644
> --- a/tests/acceptance/vnc.py
> +++ b/tests/acceptance/vnc.py
> @@ -8,10 +8,10 @@
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later.  See the COPYING file in the top-level directory.
>  =20
> -from avocado_qemu import Test
> +from avocado_qemu import MachineTest
>  =20
>  =20
> -class Vnc(Test):
> +class Vnc(MachineTest):
>       """
>       :avocado: tags=3Dvnc,quick
>       """


