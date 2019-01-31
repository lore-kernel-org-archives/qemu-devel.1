Received: from eggs.gnu.org ([209.51.188.92]:53358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gp2U2-0003hO-Uj
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 21:53:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gp2U1-0001Wr-Um
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 21:53:42 -0500
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-19-crosa@redhat.com>
	<f0426dd5-fd7a-daf0-9c0d-bd48bb36d8a7@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <af8f29c0-0b2b-ef65-2242-6b2c8ea08a3f@redhat.com>
Date: Wed, 30 Jan 2019 21:53:28 -0500
MIME-Version: 1.0
In-Reply-To: <f0426dd5-fd7a-daf0-9c0d-bd48bb36d8a7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 18/18] Boot Linux Console Test: add a test
 for alpha + clipper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>



On 1/22/19 5:52 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/17/19 7:56 PM, Cleber Rosa wrote:
>> Similar to the x86_64 + pc test, it boots a Linux kernel on a Malta
>> board and verify the serial is working.  One extra command added to
>> the QEMU command line is '-vga std', because the kernel used is
>> known to crash without it.
>>
>> If alpha is a target being built, "make check-acceptance" will
>> automatically include this test by the use of the "arch:alpha" tags.
>>
>> Alternatively, this test can be run using:
>>
>>     $ avocado run -t arch:alpha tests/acceptance
>>     $ avocado run -t machine:clipper tests/acceptance
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  .travis.yml                            |  2 +-
>>  scripts/qemu.py                        |  1 -
>>  tests/acceptance/boot_linux_console.py | 22 ++++++++++++++++++++++
>>  3 files changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 0d5a4b104b..73a113af87 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -187,7 +187,7 @@ matrix:
>> =20
>>      # Acceptance (Functional) tests
>>      - env:
>> -        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_6=
4-softmmu,mips-softmmu,mips64el-softmmu,ppc64-softmmu,aarch64-softmmu,arm=
-softmmu,s390x-softmmu"
>> +        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_6=
4-softmmu,mips-softmmu,mips64el-softmmu,ppc64-softmmu,aarch64-softmmu,arm=
-softmmu,s390x-softmmu,alpha-softmmu"
>>          - TEST_CMD=3D"make check-acceptance"
>>        addons:
>>          apt:
>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>> index 1531e28fc1..a704da418a 100644
>> --- a/scripts/qemu.py
>> +++ b/scripts/qemu.py
>> @@ -34,7 +34,6 @@ def kvm_available(target_arch=3DNone):
>> =20
>>  #: Maps machine types to the preferred console device types
>>  CONSOLE_DEV_TYPES =3D {
>> -    r'^clipper$': 'isa-serial',
>=20
> Why this change?
>=20

Because we've come to conclusion (I believe :) that's better, whenever
possible, to let QEMU pick the default device type by machine.  The
discussion happened here:

https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg04582.html

- Cleber.
