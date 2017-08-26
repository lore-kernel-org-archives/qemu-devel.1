Received: from eggs.gnu.org ([2001:4830:134:3::10]:37937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dlQDu-00010y-0n
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 21:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dlQDt-0006LV-5j
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 21:49:18 -0400
References: <1503066227-18251-1-git-send-email-gengdongjiu@huawei.com>
	<1503066227-18251-2-git-send-email-gengdongjiu@huawei.com>
	<599EC7AB.3080604@huawei.com>
	<69090a96-ce90-4b2b-a419-c8d847d56093@huawei.com>
	<59A0C813.2060201@huawei.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <03f2f404-2718-75c7-d0eb-7bdeba146a2e@huawei.com>
Date: Sat, 26 Aug 2017 09:45:02 +0800
MIME-Version: 1.0
In-Reply-To: <59A0C813.2060201@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 1/6] ACPI: add APEI/HEST/CPER
 structures and macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>, lersek@redhat.com, mst@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, edk2-devel@lists.01.org, christoffer.dall@linaro.org, marc.zyngier@arm.com, will.deacon@arm.com, james.morse@arm.com, tbaicar@codeaurora.org, ard.biesheuvel@linaro.org, mingo@kernel.org, bp@suse.de, shiju.jose@huawei.com, zjzhang@codeaurora.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, john.garry@huawei.com, jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com, huangdaode@hisilicon.com, wangzhou1@hisilicon.com
Cc: huangshaoyu@huawei.com, wuquanming@huawei.com, linuxarm@huawei.com, zhengqiang10@huawei.com



On 2017/8/26 9:00, Shannon Zhao wrote:
> 
> 
> On 2017/8/25 18:37, gengdongjiu wrote:
>>>> +
>>>>>> +/* From the ACPI 6.1 spec, "18.3.2.9 Hardware Error Notification" */
>>>>>> +
>>>> It's better to refer to the first spec version of this structure and
>>>> same with others you define.
>>  do you mean which spec version? the definition is aligned with the linux kernel.
> What I mean here is that it's better to refer to the ACPI spec version
> which introduces Hardware Error Notification first time.
Ok, I basically understand your meaning. I will clear that. thanks.

> 
>>>>
>>>>>> +enum AcpiHestNotifyType {
>>>>>> +    ACPI_HEST_NOTIFY_POLLED = 0,
>>>>>> +    ACPI_HEST_NOTIFY_EXTERNAL = 1,
>>>>>> +    ACPI_HEST_NOTIFY_LOCAL = 2,
>>>>>> +    ACPI_HEST_NOTIFY_SCI = 3,
>>>>>> +    ACPI_HEST_NOTIFY_NMI = 4,
>>>>>> +    ACPI_HEST_NOTIFY_CMCI = 5,  /* ACPI 5.0 */
>>>>>> +    ACPI_HEST_NOTIFY_MCE = 6,   /* ACPI 5.0 */
>>>>>> +    ACPI_HEST_NOTIFY_GPIO = 7,  /* ACPI 6.0 */
>>>>>> +    ACPI_HEST_NOTIFY_SEA = 8,   /* ACPI 6.1 */
>>>>>> +    ACPI_HEST_NOTIFY_SEI = 9,   /* ACPI 6.1 */
>>>>>> +    ACPI_HEST_NOTIFY_GSIV = 10, /* ACPI 6.1 */
>>>>>> +    ACPI_HEST_NOTIFY_RESERVED = 11  /* 11 and greater are reserved */
>>>> In ACPI 6.2, 11 is for Software Delegated Exception, is this useful for
>>>> your patchset?
>>   it is usefull, for all the error source, I reserved the space for them.
>> Because the space is allocated one time, is not dynamically allocated.
>> so I use the ACPI_HEST_NOTIFY_RESERVED to specify that there is 11 error source.
>>
> I mean whether the new type Software Delegated Exception is useful for
> RAS. If so, we could add this new type here.
Just now I check the ACPI 6.2 spec, it indeed introduced the new type SDEI.

currently we do not use the type Software Delegated Exception which introduced by ACPI 6.2,
so may not need to add a new type.

> 
> Thanks,
> 
