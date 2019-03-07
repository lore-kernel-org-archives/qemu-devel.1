Received: from eggs.gnu.org ([209.51.188.92]:60359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1h1hVf-0000D1-4D
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 20:07:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1h1hVe-0007PQ-7C
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 20:07:43 -0500
References: <1551823429-1440-1-git-send-email-guoheyi@huawei.com>
	<20190306113354.5a98654b@redhat.com>
	<b904272b-9eca-36e7-d24b-4c84b6c4f4af@huawei.com>
	<20190306172045.14a58996@Igors-MacBook-Pro.local>
From: Heyi Guo <guoheyi@huawei.com>
Message-ID: <28709fc5-5a34-0f26-ad81-db2baa6a0b53@huawei.com>
Date: Thu, 7 Mar 2019 09:07:26 +0800
MIME-Version: 1.0
In-Reply-To: <20190306172045.14a58996@Igors-MacBook-Pro.local>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] hw/arm/acpi: simplify AML bit
 and/or statement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, wanghaibin.wang@huawei.com

Got it; thanks.

Heyi

On 2019/3/7 0:20, Igor Mammedov wrote:
> On Wed, 6 Mar 2019 21:09:11 +0800
> Heyi Guo <guoheyi@huawei.com> wrote:
>
>> Sorry, I didn't know the indention policy of qemu code. So we need to indent the 2nd line just after the parentheses it belongs to?
> See "[PATCH v6 0/2] CODING_STYLE: trivial update" for clarification
>
>> Will change that and send next version.
>>
>> Thanks,
>>
>> Heyi
>>
>>
>> On 2019/3/6 18:33, Igor Mammedov wrote:
>>> On Wed, 6 Mar 2019 06:03:48 +0800
>>> Heyi Guo <guoheyi@huawei.com> wrote:
>>>
>>>> The last argument of AML bit and/or statement is the target variable,
>>>> so we don't need to use a NULL target and then an additional store
>>>> operation; a single bit and/or statement is enough.
>>>>
>>>> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
>>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>> Cc: Igor Mammedov <imammedo@redhat.com>
>>>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>>>> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
>>>> ---
>>>>    hw/arm/virt-acpi-build.c | 8 ++++----
>>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>>>> index 04b62c7..1c84e87 100644
>>>> --- a/hw/arm/virt-acpi-build.c
>>>> +++ b/hw/arm/virt-acpi-build.c
>>>> @@ -265,16 +265,16 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>>>>            aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
>>>>        aml_append(ifctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
>>>>        aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
>>>> -    aml_append(ifctx, aml_store(aml_and(aml_name("CTRL"), aml_int(0x1D), NULL),
>>>> +    aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1D),
>>>>                                    aml_name("CTRL")));
>>> pls fix indent in all such cases. I'd align it like this:
>>>      aml_append(ifctx,
>>>                 aml_and(aml_name("CTRL"), aml_int(0x1D), aml_name("CTRL")));
>>>
>>> or
>>>      aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1D),
>>>                                aml_name("CTRL")));
>>>
>>>
>>> PS:
>>> When making multi-patch series use --cover-letter git option
>>>
>>>>    
>>>>        ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
>>>> -    aml_append(ifctx1, aml_store(aml_or(aml_name("CDW1"), aml_int(0x08), NULL),
>>>> +    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
>>>>                                     aml_name("CDW1")));
>>>>        aml_append(ifctx, ifctx1);
>>>>    
>>>>        ifctx1 = aml_if(aml_lnot(aml_equal(aml_name("CDW3"), aml_name("CTRL"))));
>>>> -    aml_append(ifctx1, aml_store(aml_or(aml_name("CDW1"), aml_int(0x10), NULL),
>>>> +    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x10),
>>>>                                     aml_name("CDW1")));
>>>>        aml_append(ifctx, ifctx1);
>>>>    
>>>> @@ -283,7 +283,7 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>>>>        aml_append(method, ifctx);
>>>>    
>>>>        elsectx = aml_else();
>>>> -    aml_append(elsectx, aml_store(aml_or(aml_name("CDW1"), aml_int(4), NULL),
>>>> +    aml_append(elsectx, aml_or(aml_name("CDW1"), aml_int(4),
>>>>                                      aml_name("CDW1")));
>>>>        aml_append(elsectx, aml_return(aml_arg(3)));
>>>>        aml_append(method, elsectx);
>>> .
>>>
>>
>>
>
> .
>
