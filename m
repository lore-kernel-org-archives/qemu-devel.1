Received: from eggs.gnu.org ([2001:4830:134:3::10]:58589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d31Np-0005fn-6A
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d31Nm-0001Qg-0y
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:24:01 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:36359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1d31Nl-0001QI-Rj
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:23:57 -0400
Received: by mail-it0-x242.google.com with SMTP id x188so21010716itb.3
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 07:23:57 -0700 (PDT)
In-Reply-To: <CAFEAcA9-34kbchbixYaJ26KBKGYfnQhcOaEZ0EAE7q4XfjoVww@mail.gmail.com>
References: <8366F7D4-6288-406E-8C64-2FE3777FC0C3@gmail.com>
	<CAFEAcA9-34kbchbixYaJ26KBKGYfnQhcOaEZ0EAE7q4XfjoVww@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C3135A79-E3D9-4D3F-95F3-12A8870CD2F5@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Tue, 25 Apr 2017 10:23:54 -0400
Subject: Re: [Qemu-devel] [PATCH 2/9] Add risu_ppc.c file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


On Apr 25, 2017, at 4:36 AM, Peter Maydell wrote:

> On 25 April 2017 at 04:18, G 3 <programmingkidx@gmail.com> wrote:
>> Add the risu_ppc.c file. It defines several functions used by risu.
>>
>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>> ---
>>  risu_ppc.c | 41 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>  create mode 100644 risu_ppc.c
>>
>> diff --git a/risu_ppc.c b/risu_ppc.c
>> new file mode 100644
>> index 0000000..70a1cf7
>> --- /dev/null
>> +++ b/risu_ppc.c
>> @@ -0,0 +1,41 @@
>> +/*****************************************************************
>> + * File: risu_ppc.c
>> + * Date: 3-27-2017
>> + * Description: Implement advance_pc(), set_ucontext_paramreg(),
>> + *              get_reginfo_paramreg(), get_risuop()
>> + *****************************************************************/
>> +
>> +#include "risu.h"
>> +
>> +/* Advances the program counter register to the next instruction */
>> +void advance_pc(void *vuc)
>> +{
>> +    ucontext_t *uc = (ucontext_t*)vuc;
>> +    uc->uc_mcontext->ss.srr0 += 4;
>> +}
>> +
>> +/* Sets register r0 to the address of a memory block. */
>> +void set_ucontext_paramreg(void *vuc, uint64_t value)
>> +{
>> +    ucontext_t *uc = vuc;
>> +    uc->uc_mcontext->ss.r0 = value;
>> +}
>
> This doesn't look like it matches the Linux PPC uc_mcontext
> struct, which (like the ppc64 one) has a uc_mcontext.regs
> field, not uc_mcontext->ss.
>
> Risu is a Linux program, so all CPU backends must build
> on Linux. It could perhaps be ported to other host OSes,
> but we'd need to put in more infrastructure for dealing
> with host OS differences, not just have "PPC works only
> on OSX and the others work only on Linux".
>
> thanks
> -- PMM

What about having it work on both Mac OS X and Linux? A few #ifdef's  
should work.
