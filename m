Received: from eggs.gnu.org ([209.51.188.92]:44124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBGIW-0003f0-95
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hBGGO-00080R-SS
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:03:29 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46410 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Mateja.Marjanovic@rt-rk.com>)
	id 1hBGGO-0007z6-Fn
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:03:28 -0400
References: <1553845000-6537-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<CY4PR2201MB125406EDB6C28B4F84C6A5F7C6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Message-ID: <6848c456-2369-3f18-7fd8-cfd4a9a76b8d@rt-rk.com>
Date: Tue, 2 Apr 2019 12:03:25 +0200
MIME-Version: 1.0
In-Reply-To: <CY4PR2201MB125406EDB6C28B4F84C6A5F7C6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 0/5] Add support for MSA instructions on
 a big endian host
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


On 1.4.19. 19:53, Aleksandar Markovic wrote:
>> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>> Subject: [PATCH v3 0/5] Add support for MSA instructions on a big endian host
> "Add" -> "Fix"
>
> Big endian host support should have worked from the moment MSA
> support is added to QEMU.
I will change it in v4.
>
>> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>>
>> Add support for MSA instructions while executing QEMU on a
>> machine that uses big endian MIPS CPU. Also change the
>> implementation of helpers for MSA instructions
>> ST.<B|H|W|D>, LD.<B|H|W|D>, INSERT.<B|H|W> (and D on MIPS64),
>> COPY_S.<B|H|W> (and D on MIPS64) and COPY_U.<B|H> (and W
>> on MIPS64). Instead of using a switch in a helper, which is
>> called many times, put a switch in translate.c file, which
>> is called only a few times.
>>
> This paragraph suggests that there are essentially two independent
> changes in this series (one for big endian host, another for refactoring
> helpers), while in reality they are closely related. You should have
> started the second sentence with "This is achieved by changing the
> implementation of helpers for...".
I will make it more clear in v4.
>
>> v3:
>>   - Unroll loops in ST.<B|H|W|D> and LD.<B|H|W|D>
>>     instructions.
>>   - Eliminate macro that generates the helpers for
>>     the ST.<B|H|W|D> and LD.<B|H|W|D> instructions,
>>     and add four helpers for each (for byte,
>>     halfword, word and doubleword).
>>   - Eliminate the helpers for INSERT.<B|H|W|D>,
>>     COPY_S.<B|H|W|D> and COPY_U.<B|H|W> and add
>>     four (three in case of COPY_U) helpers for
>>     each one.
>>
> The cover letter should contain the complete series history.
I thought only the last version was necessary, but from now
on I will write the complete series history.
>
> Thanks,
> Aleksandar
>
>> Mateja Marjanovic (5):
>>    target/mips: MSA instructions ld, big endian host fix
>>    target/mips: MSA instructions st, big endian host fix
>>    target/mips: Different approach toward COPY_S MSA instr. and big
>>      endian fix
>>    target/mips: Different approach toward COPY_U MSA instr. and big
>>      endian fix
>>    target/mips: Different approach toward INSERT MSA instr. and big
>>      endian fix
Thanks,
Mateja
