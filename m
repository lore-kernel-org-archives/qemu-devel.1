Received: from eggs.gnu.org ([2001:4830:134:3::10]:55624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drWxf-000341-0U
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 18:13:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drWxb-0000s7-Qq
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 18:13:46 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drWxb-0000rr-LO
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 18:13:43 -0400
Received: by mail-qt0-x243.google.com with SMTP id q8so6386650qtb.1
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 15:13:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170911213328.9701-1-f4bug@amsat.org>
	<20170911213328.9701-6-f4bug@amsat.org>
	<aa266e28-853b-4703-8495-8fa862aea106@gmx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9bdda758-c62c-cb04-15cd-1e93bd1664f7@amsat.org>
Date: Mon, 11 Sep 2017 19:13:39 -0300
MIME-Version: 1.0
In-Reply-To: <aa266e28-853b-4703-8495-8fa862aea106@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 5/5] tcg: restrict i386 regs definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 09/11/2017 06:44 PM, Kamil Rytarowski wrote:
> On 11.09.2017 23:33, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> cleaning while here :)
>>
>>   accel/tcg/user-exec.c | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
>> index 2a975eaf69..484a3f5f8f 100644
>> --- a/accel/tcg/user-exec.c
>> +++ b/accel/tcg/user-exec.c
>> @@ -25,15 +25,6 @@
>>   #include "exec/cpu_ldst.h"
>>   #include "translate-all.h"
>>   
>> -#undef EAX
>> -#undef ECX
>> -#undef EDX
>> -#undef EBX
>> -#undef ESP
>> -#undef EBP
>> -#undef ESI
>> -#undef EDI
>> -#undef EIP
>>   #ifdef __linux__
>>   #include <sys/ucontext.h>
>>   #endif
>> @@ -131,6 +122,15 @@ static inline int handle_cpu_signal(uintptr_t pc, unsigned long address,
>>   }
>>   
>>   #if defined(__i386__)
>> +#undef EAX
>> +#undef ECX
>> +#undef EDX
>> +#undef EBX
>> +#undef ESP
>> +#undef EBP
>> +#undef ESI
>> +#undef EDI
>> +#undef EIP
>>   
>>   #if defined(__NetBSD__)
>>   #include <ucontext.h>
>>
> 
> Why to move under i386?

I tracked the origin of these #defines in op-i386.c (7bfdb6d18c7b) and 
thought the Exx naming was for i386 while the x86_64 uses the Rxx naming 
(RAX .. RIP) so you'd only have them on i386 arch.
However it seems I didn't realize you can access x86_64 registers in 
32-bit mode via the EAX .. EIP naming, as you see I'm not confident with 
this CISC arch :S

So I guess it's best to ignore this patch?

> 
> SmartOS pollutes namespace with these symbols on x86_64.
> 

you should provide some VM :P

I plan to test this project soon:
https://www.packer.io/docs/builders/qemu.html

Regards,

Phil.
