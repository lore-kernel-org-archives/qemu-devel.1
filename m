Received: from eggs.gnu.org ([209.51.188.92]:56185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpIgW-0004wV-GX
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 15:11:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpIgU-00019g-Qk
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 15:11:40 -0500
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-14-crosa@redhat.com>
	<69b6fafd-bc9f-c012-7087-6a84882abc7e@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <a899de6d-5864-db8f-e892-e1d96ac670fb@redhat.com>
Date: Thu, 31 Jan 2019 15:11:06 -0500
MIME-Version: 1.0
In-Reply-To: <69b6fafd-bc9f-c012-7087-6a84882abc7e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 13/18] Boot Linux Console Test: add a test
 for mips64el + malta
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Aleksandar Rikalo <arikalo@wavecomp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>



On 1/31/19 1:14 PM, Wainer dos Santos Moschetta wrote:
>=20
> On 01/17/2019 04:56 PM, Cleber Rosa wrote:
>> Similar to the x86_64 + pc test, it boots a Linux kernel on a Malta
>> board and verify the serial is working.
>>
>> If mips64el is a target being built, "make check-acceptance" will
>> automatically include this test by the use of the "arch:mips" tags.
>=20
> s/arch:mips/arch:mips64el
>=20

Good catch!

>>
>> Alternatively, this test can be run using:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 $ avocado run -t arch:mips64el tests/acceptan=
ce
>> =C2=A0=C2=A0=C2=A0=C2=A0 $ avocado run -t machine:malta tests/acceptan=
ce
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>> =C2=A0 .travis.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0 tests/acceptance/boot_linux_console.py | 39 +++++++++++++++++++=
+++++++
>> =C2=A0 2 files changed, 40 insertions(+), 1 deletion(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 49f9016e6a..28648f7a61 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -187,7 +187,7 @@ matrix:
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Acceptance (Functional) tests
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - env:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CONFIG=3D"--python=3D/us=
r/bin/python3
>> --target-list=3Dx86_64-softmmu,mips-softmmu"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CONFIG=3D"--python=3D/us=
r/bin/python3
>> --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - TEST_CMD=3D"m=
ake check-acceptance"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addons:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 apt:
>> diff --git a/tests/acceptance/boot_linux_console.py
>> b/tests/acceptance/boot_linux_console.py
>> index 0678ec91d2..20b845fce1 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -9,8 +9,11 @@
>> =C2=A0 # later.=C2=A0 See the COPYING file in the top-level directory.
>> =C2=A0 =C2=A0 import logging
>> +import os
>> =C2=A0 =C2=A0 from avocado_qemu import Test
>> +from avocado.utils import process
>> +from avocado.utils import archive
>> =C2=A0 =C2=A0 =C2=A0 class BootLinuxConsole(Test):
>> @@ -80,3 +83,39 @@ class BootLinuxConsole(Test):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.launch(=
)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 console_pattern=
 =3D 'Kernel command line: %s' %
>> kernel_command_line
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.wait_for_c=
onsole_pattern(console_pattern)
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_mips64el_malta(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This test requires the ar =
tool to extract "data.tar.gz" from
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the Debian package.
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The kernel can be rebuilt =
using this Debian kernel source [1]
>> and
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 following the instructions=
 on [2].
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [1]
>> https://kernel-team.pages.debian.net/kernel-handbook/ch-common-tasks.h=
tml#s-common-official
>>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [2]
>> http://snapshot.debian.org/package/linux-2.6/2.6.32-48/#linux-source-2=
.6.32_2.6.32-48
>>
>=20
> There references 1 and 2 are inverted.
>=20

And yet another one good catch!  Your proofreading is awesome!

- Cleber.

> - Wainer
>=20
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Darch:mips=
64el
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Dmachine:m=
alta
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deb_url =3D
>> ('http://snapshot.debian.org/archive/debian/20130217T032700Z/'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'pool/main/l/linux-2.6/'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> 'linux-image-2.6.32-5-5kc-malta_2.6.32-48_mipsel.deb')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deb_hash =3D '1aaec92083bf=
22fda31e0d27fa8d9a388e5fc3d5'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deb_path =3D self.fetch_as=
set(deb_url, asset_hash=3Ddeb_hash)
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cwd =3D os.getcwd()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.chdir(self.workdir)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 process.run("ar x %s data.=
tar.gz" % deb_path)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 archive.extract("data.tar.=
gz", self.workdir)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.chdir(cwd)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_path =3D self.workd=
ir + '/boot/vmlinux-2.6.32-5-5kc-malta'
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.set_machine('malta=
')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.set_console()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_command_line =3D 'c=
onsole=3DttyS0 printk.time=3D0'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.add_args('-kernel'=
, kernel_path,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 '-append', kernel_command_line)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.launch()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 console_pattern =3D 'Kerne=
l command line: %s' %
>> kernel_command_line
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.wait_for_console_patt=
ern(console_pattern)
>=20

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]
