Received: from eggs.gnu.org ([2001:4830:134:3::10]:56481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjt7H-0003am-Fu
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:43:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjt7E-0000d2-88
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:43:51 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjt7E-0000cu-3W
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:43:48 -0500
Received: by mail-qk0-x241.google.com with SMTP id n141so5969499qke.3
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 11:43:47 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1488556233-31246-1-git-send-email-peter.maydell@linaro.org>
	<1488556233-31246-6-git-send-email-peter.maydell@linaro.org>
	<20170303155859.GZ9606@toto>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0e19a320-0b97-aef2-033b-b1475641eb84@amsat.org>
Date: Fri, 3 Mar 2017 16:43:43 -0300
MIME-Version: 1.0
In-Reply-To: <20170303155859.GZ9606@toto>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 5/6] disas/cris: Avoid unintended
 sign extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, patches@linaro.org, Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 03/03/2017 12:58 PM, Edgar E. Iglesias wrote:
> On Fri, Mar 03, 2017 at 03:50:32PM +0000, Peter Maydell wrote:
>> In the cris disassembler we were using 'unsigned long' to calculate
>> addresses which are supposed to be 32 bits.  This meant that we might
>> accidentally sign extend or calculate a value that was outside the 32
>> bit range of the guest CPU.  Use 'uint32_t' instead so we give the
>> right answers on 64-bit hosts.
>>
>> (Spotted by Coverity, CID 1005402, 1005403.)
>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  disas/cris.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/disas/cris.c b/disas/cris.c
>> index 8a1daf9..30217f1 100644
>> --- a/disas/cris.c
>> +++ b/disas/cris.c
>> @@ -2009,7 +2009,7 @@ print_with_operands (const struct cris_opcode *opcodep,
>>        case 'n':
>>  	{
>>  	  /* Like N but pc-relative to the start of the insn.  */
>> -	  unsigned long number
>> +	  uint32_t number
>>  	    = (buffer[2] + buffer[3] * 256 + buffer[4] * 65536
>>  	       + buffer[5] * 0x1000000 + addr);
>>
>> @@ -2201,7 +2201,7 @@ print_with_operands (const struct cris_opcode *opcodep,
>>  		      {
>>  			/* It's [pc+].  This cannot possibly be anything
>>  			   but an address.  */
>> -			unsigned long number
>> +			uint32_t number
>>  			  = prefix_buffer[2] + prefix_buffer[3] * 256
>>  			  + prefix_buffer[4] * 65536
>>  			  + prefix_buffer[5] * 0x1000000;
>> --
>> 2.7.4
>>
>
