Received: from eggs.gnu.org ([2001:4830:134:3::10]:58241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1esy5f-0004yW-Oa
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 16:56:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1esy5e-0008Vg-9D
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 16:56:15 -0500
Received: from chuckie.co.uk ([82.165.15.123]:40966
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1esy5e-0008U1-1A
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 16:56:14 -0500
References: <1519984765-15748-1-git-send-email-konrad@adacore.com>
	<8a0c9302-3c3a-6d2f-064c-231adc126dbd@twiddle.net>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <7c87cbfc-242a-b875-35b1-4ef1a4763808@ilande.co.uk>
Date: Mon, 5 Mar 2018 21:56:05 +0000
MIME-Version: 1.0
In-Reply-To: <8a0c9302-3c3a-6d2f-064c-231adc126dbd@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] sparc: fix leon3 casa instruction when MMU
 is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, KONRAD Frederic <konrad@adacore.com>, qemu-devel@nongnu.org
Cc: frederic.konrad@adacore.com

On 02/03/18 19:04, Richard Henderson wrote:
> On 03/02/2018 01:59 AM, KONRAD Frederic wrote:
>> From: KONRAD Frederic <frederic.konrad@adacore.com>
>>
>> Since the commit af7a06bac7d3abb2da48ef3277d2a415772d2ae8:
>> `casa [..](10), .., ..` (and probably others alternate space instructions)
>> triggers a data access exception when the MMU is disabled.
>>
>> When we enter get_asi(...) dc->mem_idx is set to MMU_PHYS_IDX when the MMU
>> is disabled. Just keep mem_idx unchanged in this case so we passthrough the
>> MMU when it is disabled.
>>
>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>> ---
>>
>> Notes:
>>      Changes RFC -> V1:
>>       * emit the instruction with MMU_PHYS_IDX instead of checking that the MMU
>>         is enabled in get_physical_address(..)
>>
>>   target/sparc/translate.c | 5 +++++
>>   1 file changed, 5 insertions(+)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks for reviewing the patch Richard. Do you want me to take this one 
via my qemu-sparc branch?


ATB,

Mark.
