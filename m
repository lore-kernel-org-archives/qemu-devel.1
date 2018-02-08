Received: from eggs.gnu.org ([2001:4830:134:3::10]:41173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ejdoV-00011Y-Km
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 23:28:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ejdoR-00084n-KZ
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 23:27:59 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:56106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ejdoR-00084M-Dh
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 23:27:55 -0500
Received: by mail-it0-x241.google.com with SMTP id b66so5037306itd.5
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 20:27:54 -0800 (PST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20171026014139.46221-1-aik@ozlabs.ru>
	<82b6cfcf-70ae-2817-8eb8-fe630d3bec95@ozlabs.ru>
	<70dce2ac-5278-d7c1-744d-83de8e111faf@ozlabs.ru>
	<bebff732-86de-d7e2-93d5-a33fa44f5763@ozlabs.ru>
Message-ID: <bef12936-8383-d455-8753-5f04bb58827d@ozlabs.ru>
Date: Thu, 8 Feb 2018 15:27:48 +1100
MIME-Version: 1.0
In-Reply-To: <bebff732-86de-d7e2-93d5-a33fa44f5763@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v2] machine: Polish -machine xxx,help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>

On 02/02/18 13:45, Alexey Kardashevskiy wrote:
> On 29/01/18 16:03, Alexey Kardashevskiy wrote:
>> On 15/12/17 15:47, Alexey Kardashevskiy wrote:
>>> On 26/10/17 12:41, Alexey Kardashevskiy wrote:
>>>> The "-machine xxx,help" prints kernel-irqchip possible values as
>>>> "OnOffSplit", this adds separators to the printed line.
>>>>
>>>> Also, since only lower case letters are specified in qapi/common.json,
>>>> this changes the letter cases too.
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>
>>> ping?
>>
>>
>> anyone?
> 
> Let's try trivial list now :)


And ping again :)


> 
> 
>>
>>>
>>>
>>>> ---
>>>>
>>>> aik@fstn1-p1:~$ ./qemu-system-ppc64 -machine pseries,help 2>&1 | grep kernel-irqchip
>>>>
>>>> Was:
>>>> pseries-2.11.kernel-irqchip=OnOffSplit (Configure KVM in-kernel irqchip)
>>>>
>>>> Now:
>>>> pseries-2.11.kernel-irqchip=on|off|split (Configure KVM in-kernel irqchip)
>>>> ---
>>>>  hw/core/machine.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>>> index 36c2fb069c..bd3db14e12 100644
>>>> --- a/hw/core/machine.c
>>>> +++ b/hw/core/machine.c
>>>> @@ -506,7 +506,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
>>>>      object_class_property_set_description(oc, "accel",
>>>>          "Accelerator list", &error_abort);
>>>>  
>>>> -    object_class_property_add(oc, "kernel-irqchip", "OnOffSplit",
>>>> +    object_class_property_add(oc, "kernel-irqchip", "on|off|split",
>>>>          NULL, machine_set_kernel_irqchip,
>>>>          NULL, NULL, &error_abort);
>>>>      object_class_property_set_description(oc, "kernel-irqchip",
>>>>
>>>
>>>
>>
>>
> 
> 


-- 
Alexey
