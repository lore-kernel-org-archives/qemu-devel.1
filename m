Received: from eggs.gnu.org ([209.51.188.92]:43624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpJrK-0005pH-Ql
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:26:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpJrJ-0005ie-Kc
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:26:54 -0500
From: Cleber Rosa <crosa@redhat.com>
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-16-crosa@redhat.com>
	<b235e7a9-57ad-5547-b8ca-693159820a8f@redhat.com>
	<e63a4ea3-e9ff-4920-cdfa-14bf04b5b08c@redhat.com>
Message-ID: <84aa43ba-df19-51f6-e14d-fb82a7f2dfcc@redhat.com>
Date: Thu, 31 Jan 2019 16:26:44 -0500
MIME-Version: 1.0
In-Reply-To: <e63a4ea3-e9ff-4920-cdfa-14bf04b5b08c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 15/18] Boot Linux Console Test: add a test
 for aarch64 + virt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Aleksandar Rikalo <arikalo@wavecomp.com>



On 1/31/19 3:21 PM, Cleber Rosa wrote:
>=20
>=20
> On 1/31/19 3:02 PM, Wainer dos Santos Moschetta wrote:
>>
>> On 01/17/2019 04:56 PM, Cleber Rosa wrote:
>>> Just like the previous tests, boots a Linux kernel on a aarch64 targe=
t
>>> using the virt machine.
>>>
>>> One special option added is the CPU type, given that the kernel
>>> selected fails to boot on the virt machine's default CPU (cortex-a15)=
.
>>>
>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>> ---
>>> =C2=A0 .travis.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>> =C2=A0 tests/acceptance/boot_linux_console.py | 20 ++++++++++++++++++=
++
>>> =C2=A0 2 files changed, 21 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index 54100eea5a..595e8c0b6c 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -187,7 +187,7 @@ matrix:
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Acceptance (Functional) tests
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - env:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CONFIG=3D"--python=3D/u=
sr/bin/python3
>>> --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,ppc64-so=
ftmmu"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CONFIG=3D"--python=3D/u=
sr/bin/python3
>>> --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,ppc64-so=
ftmmu,aarch64-softmmu"
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - TEST_CMD=3D"=
make check-acceptance"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addons:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 apt:
>>> diff --git a/tests/acceptance/boot_linux_console.py
>>> b/tests/acceptance/boot_linux_console.py
>>> index f3ccd23a7a..107700b517 100644
>>> --- a/tests/acceptance/boot_linux_console.py
>>> +++ b/tests/acceptance/boot_linux_console.py
>>> @@ -138,3 +138,23 @@ class BootLinuxConsole(Test):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.launch=
()
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 console_patter=
n =3D 'Kernel command line: %s' %
>>> kernel_command_line
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.wait_for_=
console_pattern(console_pattern)
>>> +
>>> +=C2=A0=C2=A0=C2=A0 def test_aarch64_virt(self):
>>
>> That test case fails on my system (Fedora 29 x86_64). Avocado seems
>> unable to kill the VM so it=C2=A0 reaches the timeout.
>>
>> I compiled QEMU with default configuration:
>>
>> $ configure --python=3D/usr/bin/python3 --target-list=3Dx86_64-softmmu
>> --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,ppc64-sof=
tmmu,aarch64-softmmu)
>>
>>
>> Follows a snippet of the Avocado's job.log file:
>> ----
>> 2019-01-31 14:41:34,912 test=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L0602 INFO | START
>> 07-/root/src/qemu/tests/acceptance/boot_linux_console.py:BootLinuxCons=
ole.test_aarch64_virt
>>
>> 2019-01-31 14:41:34,912 test=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L0298 DEBUG| DATA
>> (filename=3Doutput.expected) =3D> NOT FOUND (data sources: variant, te=
st, file)
>> 2019-01-31 14:41:34,913 parameters=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 L0146 DEBUG| PARAMS (key=3Darch,
>> path=3D*, default=3Daarch64) =3D> 'aarch64'
>> 2019-01-31 14:41:34,913 parameters=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 L0146 DEBUG| PARAMS
>> (key=3Dqemu_bin, path=3D*, default=3Daarch64-softmmu/qemu-system-aarch=
64) =3D>
>> 'aarch64-softmmu/qemu-system-aarch64'
>> 2019-01-31 14:41:34,915 download=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 L0070 INFO | Fetching
>> https://sjc.edge.kernel.org/fedora-buffet/fedora/linux/releases/29/Ser=
ver/aarch64/os/images/pxeboot/vmlinuz
>> -> /var/lib/avocado/data/cache/by_name/vmlinuz.3upct2pr
>> 2019-01-31 14:41:35,490 download=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 L0054 DEBUG| Retrieved URL
>> "https://sjc.edge.kernel.org/fedora-buffet/fedora/linux/releases/29/Se=
rver/aarch64/os/images/pxeboot/vmlinuz":
>> content-length 8623423, date: "Thu, 31 Jan 2019 19:41:35 GMT",
>> last-modified: "Sun, 21 Oct 2018 00:43:09 GMT"
>> 2019-01-31 14:41:41,765 qemu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L0317 DEBUG| VM launch command:
>> 'aarch64-softmmu/qemu-system-aarch64 -chardev
>> socket,id=3Dmon,path=3D/var/tmp/tmpizirkcud/qemu-32609-monitor.sock -m=
on
>> chardev=3Dmon,mode=3Dcontrol -display none -vga none -machine virt -ch=
ardev
>> socket,id=3Dconsole,path=3D/var/tmp/tmpizirkcud/qemu-32609-console.soc=
k,server,nowait
>> -serial chardev:console -cpu cortex-a53 -kernel
>> /var/lib/avocado/data/cache/by_name/vmlinuz -append console=3DttyAMA0'
>> 2019-01-31 14:41:41,779 qmp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L0167 DEBUG| >>> {'execute':
>> 'qmp_capabilities'}
>> 2019-01-31 14:41:41,931 qmp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L0175 DEBUG| <<< {'return': {}}
>> 2019-01-31 14:41:42,830 boot_linux_conso L0041 DEBUG| [=C2=A0=C2=A0=C2=
=A0 0.000000]
>> Booting Linux on physical CPU 0x0000000000 [0x410fd034]
>>
>> (...)
>>
>> 2019-01-31 14:41:42,833 boot_linux_conso L0041 DEBUG| [=C2=A0=C2=A0=C2=
=A0 0.000000]
>> Policy zone: DMA32
>> 2019-01-31 14:41:42,833 boot_linux_conso L0041 DEBUG| [=C2=A0=C2=A0=C2=
=A0 0.000000]
>> Kernel command line: console=3DttyAMA0
>> 2019-01-31 14:41:42,833 qmp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L0167 DEBUG| >>> {'execute':
>> 'quit'}
>=20
> Here, a QMP response like "<<< {'return': {}}" would be expected.
>=20
> Since I can not reproduce this on my system (or on Travis-CI jobs I've
> sent), can you tell me on top of which commit you've applied these patc=
hes?
>=20

I spoke too soon:

https://travis-ci.org/clebergnu/qemu/jobs/487121425#L3033

This looks like a recent regression, and I'm guessing it's not on the
test's side.  I'll try to bisect it and let you know.

Thanks,
- Cleber.
