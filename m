Received: from eggs.gnu.org ([209.51.188.92]:36912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghr7O-0007Dk-Sn
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 02:20:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghr7M-00047j-MT
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 02:20:38 -0500
References: <5c2e6965.1c69fb81.b832c.13ee@mx.google.com>
	<2c434536-6388-563f-344b-c6800769a733@vivier.eu>
	<20190111003735.GP6682@umbus.fritz.box>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3d0e3354-5a56-7576-cc36-7cfb360bf636@vivier.eu>
Date: Fri, 11 Jan 2019 08:20:18 +0100
MIME-Version: 1.0
In-Reply-To: <20190111003735.GP6682@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] Whitespace cleanup:
 target/ppc/translate_init.inc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-trivial@nongnu.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Jon Diekema <jon.diekema@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 11/01/2019 01:37, David Gibson wrote:
> On Wed, Jan 09, 2019 at 11:15:26AM +0100, Laurent Vivier wrote:
>> Hi Jon,
>>
>> please cc: qemu-devel and MAINTAINERS when you send a patch.
>>
>> You can have the list of maintainers using a script in qemu directory:
>>
>>     ./scripts/get_maintainer.pl XXXX.patch
>>
>> Thanks,
>> Laurent
> 
> Hrm.  Like the other patch, I didn't seem to receive this - I checked
> back through my archives.  I think something must be not working with
> email from Jon to me, although I can't quite imagine what.
> 
>>
>> On 03/01/2019 20:58, Jon Diekema wrote:
>>> From: Jon Diekema <jon.diekema@gmail.com>
>>> Date: Tue, 25 Dec 2018 04:03:04 -0500
>>> Subject: Whitespace cleanup: target/ppc/translate_init.inc.c
>>>
>>> Signed-off-by: Jon Diekema <jon.diekema@gmail.com>
>>> ---
>>>   target/ppc/translate_init.inc.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
>>> index c971a5faf7..b5f4c9bd55 100644
>>> --- a/target/ppc/translate_init.inc.c
>>> +++ b/target/ppc/translate_init.inc.c
>>> @@ -5237,7 +5237,7 @@ static void init_proc_601(CPUPPCState *env)
>>>                    0x00000000);
>>>       /* Memory management */
>>>       init_excp_601(env);
>>> -    /* XXX: beware that dcache line size is 64
>>> +    /* XXX: beware that dcache line size is 64
>>>        *      but dcbz uses 32 bytes "sectors"
>>>        * XXX: this breaks clcs instruction !
>>>        */
>>> @@ -10485,7 +10485,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
>>>       cc->tcg_initialize = ppc_translate_init;
>>>   #endif
>>>       cc->disas_set_info = ppc_disas_set_info;
>>> -
>>> +
>>>       dc->fw_name = "PowerPC,UNKNOWN";
>>>   }
>>>   
>>>
>>
> 

Likewise. Only sent to qemu-trivial ML.

Thanks,
Laurent
