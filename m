Received: from eggs.gnu.org ([2001:4830:134:3::10]:36340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e1kO2-0008Hg-01
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e1kNy-0007Xn-Oi
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:35:13 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:12503
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e1kNy-0007U9-DX
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:35:10 -0400
References: <1504231805-30957-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<1504231805-30957-3-git-send-email-douly.fnst@cn.fujitsu.com>
	<20171010022958.GD5259@localhost.localdomain>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <8d1a75b0-fe25-aa93-4e68-fb9e193e837e@cn.fujitsu.com>
Date: Tue, 10 Oct 2017 10:34:54 +0800
MIME-Version: 1.0
In-Reply-To: <20171010022958.GD5259@localhost.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 2/4] hw/acpi-build: Make assignment
 statement of next_base easy to read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, rth@twiddle.net, mst@redhat.com, Peter Maydell <peter.maydell@linaro.org>

Hi Eduardo,

At 10/10/2017 10:29 AM, Eduardo Habkost wrote:
> On Fri, Sep 01, 2017 at 10:10:03AM +0800, Dou Liyang wrote:
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
>
> This or the new test case at patch 3/4 seem to have caused build
> failures under some circumstances:
>
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg486368.html
>
> I couldn't reproduce the failure yet, but I'm removing this and
> patch 3/4 from the queue until this is investigated.

Hmm, I see, I will do it.

Thanks,
	dou.
>
>> ---
>>  hw/i386/acpi-build.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index a0cf3bf..48525a1 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -2411,7 +2411,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>>              }
>>              mem_base = 1ULL << 32;
>>              mem_len = next_base - pcms->below_4g_mem_size;
>> -            next_base += (1ULL << 32) - pcms->below_4g_mem_size;
>> +            next_base = mem_base + mem_len;
>>          }
>>          numamem = acpi_data_push(table_data, sizeof *numamem);
>>          build_srat_memory(numamem, mem_base, mem_len, i - 1,
>> --
>> 2.5.5
>>
>>
>>
>>
>
