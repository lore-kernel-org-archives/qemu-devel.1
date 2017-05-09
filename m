Received: from eggs.gnu.org ([2001:4830:134:3::10]:36105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7tQf-0007IY-2Z
	for qemu-devel@nongnu.org; Mon, 08 May 2017 20:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7tQe-0000BR-9j
	for qemu-devel@nongnu.org; Mon, 08 May 2017 20:55:05 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170508233918.9043-1-f4bug@amsat.org>
	<20170508233918.9043-10-f4bug@amsat.org>
	<b0c4d068-3bc1-3611-df36-0f76b7717856@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4eea3d1f-c7f9-1465-4287-196bdcc90e40@amsat.org>
Date: Mon, 8 May 2017 21:54:56 -0300
MIME-Version: 1.0
In-Reply-To: <b0c4d068-3bc1-3611-df36-0f76b7717856@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/11] target/sparc: fix DEBUG_MMU
 DPRINTF() arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

On 05/08/2017 09:00 PM, Eric Blake wrote:
> On 05/08/2017 06:39 PM, Philippe Mathieu-Daudé wrote:
>> invalid since 96df2bc99f9
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  target/sparc/ldst_helper.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
>> index 57968d9143..aa83a49a88 100644
>> --- a/target/sparc/ldst_helper.c
>> +++ b/target/sparc/ldst_helper.c
>> @@ -1631,7 +1631,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
>>
>>              if (oldreg != env->immu.mmuregs[reg]) {
>>                  DPRINTF_MMU("immu change reg[%d]: 0x%016" PRIx64 " -> 0x%016"
>> -                            PRIx64 "\n", reg, oldreg, env->immuregs[reg]);
>> +                            PRIx64 "\n", reg, oldreg, env->immu.mmuregs[reg]);
>
> Please take this opportunity to fix the broken definitions of
> DPRINTF_MMU() and friends so that they don't bit-rot when not defined.
> There are plenty of other examples of re-writing broken #defines to
> instead favor an if (0) { printf(...) } to benefit from -Wformat
> checking even when the debugging is disabled.

Sure, will do it.
