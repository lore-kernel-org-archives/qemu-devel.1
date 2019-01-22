Received: from eggs.gnu.org ([209.51.188.92]:52858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gltbC-00014r-MQ
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 05:48:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gltbB-0003Wn-UG
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 05:48:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gltbB-0003Vi-OU
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 05:48:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so26696332wrr.12
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 02:48:04 -0800 (PST)
References: <20190117185628.21862-1-crosa@redhat.com>
	<BN6PR2201MB1251E38EAEAFC4A8C0B13D31C69F0@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f98bc26a-e0ed-9a45-46b0-331cce9bdc49@redhat.com>
Date: Tue, 22 Jan 2019 11:48:01 +0100
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB1251E38EAEAFC4A8C0B13D31C69F0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

Hi Aleksandar,

On 1/21/19 11:15 PM, Aleksandar Markovic wrote:
>> From: Cleber Rosa <crosa@redhat.com>
> 
>>   class My(Test):
>>       def test_nx_cpu_flag(self):
>>           """
>>           :avocado: tags=arch:x86_64
>>           """
>>           test_code()
> 
>> The value of the "arch" key, in this case, "x86_64" will be used when
>> selecting the QEMU binary to use in the test.  At the same time, if
>> "x86_64-softmmu" is not a built target, the test will be filtered out
>> by "make check-acceptance"[3].
> 
> I think, the term "arch" is a little problematic in QEMU parlance. IMHO,
> "target" should be used instead. ("arch" is used in Linux kernel community)

Using target_arch/host_arch might be more explicit, but host_arch is not
very relevant regarding Avocado (except to choose the correct TCG
binary), so usually arch implies target_arch.

I mean, it is unlikely you enforce --host_arch on the command line to
run tests, this using --arch instead of --target_arch looks OK to me,
since host_arch can be guessed.

> 
> The overall structure of the "tags" should be a little different. My
> suggestion:
> 
> "target"
> "isa" (instruction set architecture, determeines how the kernel and rootfs are built)

In QEMU, "isa" is implicit with CPU, isnt' it?

I.e. I use:

$ mips64el-softmmu/qemu-system-mips64el -M Malta -cpu mips64dspr2

> "cpu"
> "machine"
> 
> This would allow clear view what a particular acceptance test tests, and will
> enforce consistency and clarity in the test organization across the board.

Maybe the problem you are pointing out is not Avocado test organization
but QEMU CPU organization... (which also bother me with boards able to
use different SoC, with different peripherals or cpus).

What is your idea on passing arch/cpu/isa to start QEMU?

> 
> That said, I am very excited about this series.

Me too :)

Regards,

Phil.
