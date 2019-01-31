Received: from eggs.gnu.org ([209.51.188.92]:44770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpDqm-0005qx-JY
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gpDqk-0000sA-LS
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:01:56 -0500
References: <20190117185628.21862-1-crosa@redhat.com>
	<BN6PR2201MB1251E38EAEAFC4A8C0B13D31C69F0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<f98bc26a-e0ed-9a45-46b0-331cce9bdc49@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <352f7b14-0c91-67c6-0cea-5d2d15fb3060@redhat.com>
Date: Thu, 31 Jan 2019 10:01:39 -0500
MIME-Version: 1.0
In-Reply-To: <f98bc26a-e0ed-9a45-46b0-331cce9bdc49@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/18] Acceptance Tests: target
 architecture support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>



On 1/22/19 5:48 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Aleksandar,
>=20
> On 1/21/19 11:15 PM, Aleksandar Markovic wrote:
>>> From: Cleber Rosa <crosa@redhat.com>
>>
>>>   class My(Test):
>>>       def test_nx_cpu_flag(self):
>>>           """
>>>           :avocado: tags=3Darch:x86_64
>>>           """
>>>           test_code()
>>
>>> The value of the "arch" key, in this case, "x86_64" will be used when
>>> selecting the QEMU binary to use in the test.  At the same time, if
>>> "x86_64-softmmu" is not a built target, the test will be filtered out
>>> by "make check-acceptance"[3].
>>
>> I think, the term "arch" is a little problematic in QEMU parlance. IMH=
O,
>> "target" should be used instead. ("arch" is used in Linux kernel commu=
nity)
>=20
> Using target_arch/host_arch might be more explicit, but host_arch is no=
t
> very relevant regarding Avocado (except to choose the correct TCG
> binary), so usually arch implies target_arch.
>=20
> I mean, it is unlikely you enforce --host_arch on the command line to
> run tests, this using --arch instead of --target_arch looks OK to me,
> since host_arch can be guessed.
>=20

Naming things is hard, so this is a valid discussion.  But, I have to
say that I also find "arch" in this context to be descriptive enough.

>>
>> The overall structure of the "tags" should be a little different. My
>> suggestion:
>>
>> "target"
>> "isa" (instruction set architecture, determeines how the kernel and ro=
otfs are built)
>=20
> In QEMU, "isa" is implicit with CPU, isnt' it?
>=20
> I.e. I use:
>=20
> $ mips64el-softmmu/qemu-system-mips64el -M Malta -cpu mips64dspr2
>=20
>> "cpu"
>> "machine"
>>
>> This would allow clear view what a particular acceptance test tests, a=
nd will
>> enforce consistency and clarity in the test organization across the bo=
ard.
>=20
> Maybe the problem you are pointing out is not Avocado test organization
> but QEMU CPU organization... (which also bother me with boards able to
> use different SoC, with different peripherals or cpus).
>=20
> What is your idea on passing arch/cpu/isa to start QEMU?
>=20
>>
>> That said, I am very excited about this series.
>=20
> Me too :)
>=20
> Regards,
>=20
> Phil.
>=20

Thanks! For the encouragement, help and input!

- Cleber.
