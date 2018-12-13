Received: from eggs.gnu.org ([2001:4830:134:3::10]:56648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gXMPx-0004bH-VK
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 03:32:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gXMPp-0003ta-ND
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 03:32:24 -0500
References: <20181203100415.53027-1-r.bolshakov@yadro.com>
	<20181203100415.53027-2-r.bolshakov@yadro.com>
	<20181212211646.vem27l5pe6pzujd4@SPB-NB-133.local>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8ad0725d-50e5-4503-e380-acc5720b8fd3@vivier.eu>
Date: Thu, 13 Dec 2018 09:32:04 +0100
MIME-Version: 1.0
In-Reply-To: <20181212211646.vem27l5pe6pzujd4@SPB-NB-133.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for-3.1 2/2] i386: hvf: drop
 debug printf in decode_sldtgroup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On 12/12/2018 22:16, Roman Bolshakov wrote:
> On Mon, Dec 03, 2018 at 01:04:15PM +0300, Roman Bolshakov wrote:
>> It's going to clutter QEMU logs if 0x0f00 is trapped.
>>
>> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
>> ---
>>  target/i386/hvf/x86_decode.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
>> index d125a6ef83..5f513c5563 100644
>> --- a/target/i386/hvf/x86_decode.c
>> +++ b/target/i386/hvf/x86_decode.c
>> @@ -525,8 +525,6 @@ static void decode_sldtgroup(CPUX86State *env, struct x86_decode *decode)
>>          X86_DECODE_CMD_INVL
>>      };
>>      decode->cmd = group[decode->modrm.reg];
>> -    printf("%llx: decode_sldtgroup: %d\n", env->hvf_emul->fetch_rip,
>> -            decode->modrm.reg);
>>  }
>>  
>>  static void decode_lidtgroup(CPUX86State *env, struct x86_decode *decode)
>> -- 
>> 2.17.2 (Apple Git-113)
>>
> 
> Could you please apply to trivial queue
Applied to my trivial-patches branch.

Thanks,
Laurent
