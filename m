Received: from eggs.gnu.org ([2001:4830:134:3::10]:38773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gWUY8-0005ct-2K
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 18:01:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gWUY2-0000WQ-Sf
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 18:01:15 -0500
Date: Tue, 11 Dec 2018 00:01:06 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <763b8fce-daee-97ff-f1da-4f6dba6c5036@linaro.org>
Message-ID: <alpine.BSF.2.21.9999.1812102350070.74563@zero.eik.bme.hu>
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
	<alpine.BSF.2.21.9999.1812100112050.45639@zero.eik.bme.hu>
	<20181210025943.GE4261@umbus.fritz.box>
	<alpine.BSF.2.21.9999.1812102035360.24343@zero.eik.bme.hu>
	<763b8fce-daee-97ff-f1da-4f6dba6c5036@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH 0/6] target/ppc: convert VMX
 instructions to use TCG vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Mon, 10 Dec 2018, Richard Henderson wrote:
> On 12/10/18 2:54 PM, BALATON Zoltan wrote:
>> Tried it on i5 650 which has: sse sse2 ssse3 sse4_1 sse4_2. I assume x86_64
>> should be supported but not sure what are the CPU requirements.
>
> Not quite.  I only support avx1 and later.
>
> I thought about supporting sse4 and later (that's the minimum with all of the
> instructions that do what we need), but there is only one cpu generation with
> sse4 and without avx1, and avx1 is already 8 years old.

OK that explains why I haven't seen any improvements. My CPU just predates 
AVX and happens to be in the generation you mention. But I agree this 
probably does not worth the effort. Maybe I should test on something newer 
instead.

Thank you,
BALATON Zoltan
