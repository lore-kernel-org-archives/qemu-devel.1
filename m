Received: from eggs.gnu.org ([209.51.188.92]:55005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gnrLC-0006p1-L9
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 15:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gnrLB-000711-Fq
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 15:47:42 -0500
Date: Sun, 27 Jan 2019 21:47:36 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.9999.1901272112240.63988@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.21.9999.1901272146170.63988@zero.eik.bme.hu>
References: <20190127090306.30826-1-mark.cave-ayland@ilande.co.uk>
	<20190127090306.30826-3-mark.cave-ayland@ilande.co.uk>
	<alpine.BSF.2.21.9999.1901271251060.35973@zero.eik.bme.hu>
	<3dc12858-4254-9da1-7eb2-309948d0d376@ilande.co.uk>
	<5ea37d08-91f6-33cc-b220-f1a96796d794@linaro.org>
	<897875e0-fc56-c280-0cd0-c7e0dac04fa1@ilande.co.uk>
	<alpine.BSF.2.21.9999.1901272112240.63988@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 2/8] target/ppc: rework
 vmrg{l, h}{b, h, w} instructions to use Vsr* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On Sun, 27 Jan 2019, BALATON Zoltan wrote:
> On Sun, 27 Jan 2019, Mark Cave-Ayland wrote:
>> On 27/01/2019 17:26, Richard Henderson wrote:
>> 
>>> On 1/27/19 7:19 AM, Mark Cave-Ayland wrote:
>>>> Could this make the loop slower? I certainly haven't noticed any obvious
>>>> performance difference during testing (OS X uses merge quite a bit for
>>>> display rendering), and I'd hope that with a good compiler and modern 
>>>> branch
>>>> prediction then any effect here would be negligible.
>>> 
>>> I would expect the i < n/2 loop to be faster, because the assignments are
>>> unconditional.  FWIW.
>> 
>> Do you have any idea as to how much faster? Is it something that would show 
>> up as
>> significant within the context of QEMU?
>
> I don't have numbers either but since these vector ops are meant to and are 
> used for speeding up repetitive calculations I'd expect it to be run many 
> times which means that even a small difference would add up. So I think it's 
> worth trying to make these optimal also when host vector ops cannot be used.
>
> I don't know about a good benchmark to measure this. Maybe you could try 
> converting some video in Mac OS X or something similar that's known to use 
> AltiVec/VMX. There are also these under MorphOS on mac99:
> http://www.amiga-news.de/en/news/AN-2012-02-00011-EN.html
> where the mplayer one is mostly VMX bound I think and lame is more dependent 
> on floating point ops but that also has a VMX version (still mainly float I 
> think). I'd copy input file to RAM: disk first to avoid overhead from IDE 
> emulation. But these are probably too short to measure this.
>
> I can't test this now but maybe someone reading this on the list who can try 
> it with and without this series could help.

I've found these (untested and quite old but may work) so you don't need 
MorphOS only OS X:

https://tmkk.undo.jp/lame/index_e.html

Regards,
BALATON Zoltan
