Received: from eggs.gnu.org ([2001:4830:134:3::10]:45199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diIm7-0007Wp-Uc
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diIm3-0004e3-Tz
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:15:43 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:32995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diIm3-0004cy-Nk
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:15:39 -0400
Received: by mail-qt0-x241.google.com with SMTP id c13so1657639qtk.0
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 04:15:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-3-git-send-email-imammedo@redhat.com>
	<d675fe0d-a775-b594-cbf1-057c8c5ba94f@amsat.org>
	<8d859891-c442-c1a6-021c-acbd30841263@amsat.org>
	<20170817125306.45dc8d04@nial.brq.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3dd33437-2373-b1a7-5b60-346feb5e5c0a@amsat.org>
Date: Thu, 17 Aug 2017 08:15:34 -0300
MIME-Version: 1.0
In-Reply-To: <20170817125306.45dc8d04@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/28] mips: MIPSCPU model subclasses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Yongbok Kim <yongbok.kim@imgtec.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 08/17/2017 07:53 AM, Igor Mammedov wrote:
> On Thu, 17 Aug 2017 00:38:59 -0300
> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
> 
>> Hi Igor,
>>
>> On 07/15/2017 06:48 PM, Philippe Mathieu-Daudé wrote:
>>> On 07/14/2017 10:51 AM, Igor Mammedov wrote:
>>>> Register separate QOM types for each mips cpu model,
>>>> so it would be possible to reuse generic CPU creation
>>>> routines.
>>>>
>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>
>>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>    
>>>> ---
[...]
>>>> +static ObjectClass *mips_cpu_class_by_name(const char *cpu_model)
>>>> +{
>>>> +    ObjectClass *oc;
>>>> +    char *typename;
>>>> +
>>>> +    if (cpu_model == NULL) {
>>>> +        return NULL;
>>>> +    }
>>>> +
>>>> +    typename = mips_cpu_type_name(cpu_model);
>>>> +    oc = object_class_by_name(typename);
>>>> +    g_free(typename);
>>>> +    return oc;
>>>>    }
>>>>    static void mips_cpu_class_init(ObjectClass *c, void *data)
>>>> @@ -171,6 +196,7 @@ static void mips_cpu_class_init(ObjectClass *c,
>>>> void *data)
>>>>        mcc->parent_reset = cc->reset;
>>>>        cc->reset = mips_cpu_reset;
>>>> +    cc->class_by_name = mips_cpu_class_by_name;
>>
>> Now than I'm reading again...
>>
>>>>        cc->has_work = mips_cpu_has_work;
>>>>        cc->do_interrupt = mips_cpu_do_interrupt;
>>>>        cc->cpu_exec_interrupt = mips_cpu_exec_interrupt;
>>>> @@ -203,9 +229,34 @@ static const TypeInfo mips_cpu_type_info = {
>>
>> Shouldn't this class now be abstract?
> it should,
> 
> I see your are fixing it in your version of series,
> so I'll just drop mips from my series so that you could merge
> your version of mips part separately via your tree,
> assuming you can do it fast once merge window is open
> as I have another series on top that does more extensive
> generalization/clean up and depends on this series
> (including mips being properly QOMified)

Ok I'll squash it there.
