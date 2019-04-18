Received: from eggs.gnu.org ([209.51.188.92]:42216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hH27r-0003mM-Dd
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hH27p-00087v-Ti
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:10:31 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46369 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Mateja.Marjanovic@rt-rk.com>)
	id 1hH27p-00086p-Dg
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:10:29 -0400
References: <1555491867-5922-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<BN6PR2201MB1251516C13CAE873ADDA73DBC6250@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<BN6PR2201MB1251599D75CE44B174BD5116C6250@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Message-ID: <83a1c5ee-2974-7a1c-9df3-d6049894c287@rt-rk.com>
Date: Thu, 18 Apr 2019 10:10:27 +0200
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB1251599D75CE44B174BD5116C6250@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] target/mips: Amend tests for MSA binary
 integer operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>


On 17.4.19. 22:22, Aleksandar Markovic wrote:
>> From: Aleksandar Markovic
>> Subject: Re: [PATCH] target/mips: Amend tests for MSA binary integer operations
>>
>>> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>>> Subject: [PATCH] target/mips: Amend tests for MSA binary integer operations
>>>
>>> Amend tests for certain MSA binary integer instructions
>>> (for example DIV_S.B) by appending two missing test cases
>>> to complete standard battery of 80 test cases for each
>>> such instruction. Expected values were pulled from the
>>> results of the MIPS64r6 machine that executed those
>>> instruction, and QEMU emulation should produce the same
>>> results.
>>>
>>> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>>> ---
>> I'm afraid your patch doesn't apply to the tip of the source tree:
> Unfortunately, Mateja, even after resolving patch application conflicts,
> the code doesn't build.
>
> For example, wrappers for many MSA instructions are missing, and
> there are other problems too.
>
> The patch needs a major amending and refactoring, which I will do
> tomorrow, or in next few days, so that you can focus on your other
> remaining tasks (for example, explaining "active_fpu" role from
> another series, and big endian host MSA test failures).

Alright, I will focus on those tasks.

Thanks,
Mateja

>
> The good thing is that we will eventually expand test coverage.
>
> Thanks,
> Aleksandar
