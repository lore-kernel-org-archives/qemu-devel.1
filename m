Received: from eggs.gnu.org ([2001:4830:134:3::10]:49767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1eJqrA-0005wc-EG
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1eJqr5-0002gF-PZ
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:08:08 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41949
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1eJqr5-0002fI-D3
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:08:03 -0500
References: <20171005203638.19255-1-ehabkost@redhat.com>
	<20171005203638.19255-2-ehabkost@redhat.com>
	<20171128160713.0b0ea2fe@redhat.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <21d72eed-1928-4be1-5c70-c2fc4b4f85dc@cn.fujitsu.com>
Date: Wed, 29 Nov 2017 09:07:58 +0800
MIME-Version: 1.0
In-Reply-To: <20171128160713.0b0ea2fe@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 1/9] hw/acpi-build: Make assignment
 statement of next_base easy to read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

Hi, Igor,

At 11/28/2017 11:07 PM, Igor Mammedov wrote:
> On Thu,  5 Oct 2017 17:36:30 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>
>> From: Dou Liyang <douly.fnst@cn.fujitsu.com>
>>
>> It may be hard to read the assignment statement of "next_base", so
>>
>> S/next_base += (1ULL << 32) - pcms->below_4g_mem_size;
>>  /next_base = mem_base + mem_len;
>>
>> ... for readability.
>>
>> No functionality change.
>>
>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>> Message-Id: <1504231805-30957-3-git-send-email-douly.fnst@cn.fujitsu.com>
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> Pls, retest/respin once 2.12 dev window is open
>

Yes, I will.

Thanks,
	dou.

>> ---
>>  hw/i386/acpi-build.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 2af37a9129..73e3443bce 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -2381,7 +2381,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>>              }
>>              mem_base = 1ULL << 32;
>>              mem_len = next_base - pcms->below_4g_mem_size;
>> -            next_base += (1ULL << 32) - pcms->below_4g_mem_size;
>> +            next_base = mem_base + mem_len;
>>          }
>>          numamem = acpi_data_push(table_data, sizeof *numamem);
>>          build_srat_memory(numamem, mem_base, mem_len, i - 1,
>
>
>
>
