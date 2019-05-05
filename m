Received: from eggs.gnu.org ([209.51.188.92]:49350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNJNs-0008LV-LX
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNJNr-0002U6-Pu
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:49:00 -0400
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-2-mark.cave-ayland@ilande.co.uk>
	<fc4d6169-12d4-3fd8-f85a-262135a62b93@linaro.org>
	<98ba8d01-dbab-ecde-ffbd-bb46efb29215@ilande.co.uk>
	<9059f977-6ffa-e701-6c1b-2f8d8cca2c64@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <a818778c-6e37-a9ce-3e1c-0b3eb151682f@ilande.co.uk>
Date: Sun, 5 May 2019 16:46:31 +0100
MIME-Version: 1.0
In-Reply-To: <9059f977-6ffa-e701-6c1b-2f8d8cca2c64@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/14] target/ppc: remove getVSR()/putVSR()
 from fpu_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

On 05/05/2019 15:31, Richard Henderson wrote:

> On 5/5/19 2:27 AM, Mark Cave-Ayland wrote:
>> I've spent a bit of time today going through the functions and it seems that all
>> functions which have an xt parameter, minus a couple of the TEST macros, require the
>> result to be calculated in a local variable first.
>>
>> I think the best solution is still to remove getVSR()/putVSR() but replace them with
>> macros for copying and zeroing like this:
>>
>>     #define VSRCPY(d, s) (memcpy(d, s, sizeof(ppc_vsr_t)))
>>     #define VSRZERO(d)   (memset(d, 0, sizeof(ppc_vsr_t)))
> 
> Local variable, yes.  But I see no reason for macros.
> 
>   ppc_vsr_t res = { };
>   ...
>   *xt = res;

Ah thanks for the hint - I wasn't aware that this could be done in a consistent way
for structs across all compilers. I'll implement this in the next version of the series.


ATB,

Mark.
