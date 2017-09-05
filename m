Received: from eggs.gnu.org ([2001:4830:134:3::10]:42233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dp2Db-0004Fj-6j
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 20:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dp2DW-0004kP-Gn
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 20:59:55 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:25152
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dp2DW-0004jW-4n
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 20:59:50 -0400
References: <1504181068-17822-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<1504181068-17822-2-git-send-email-douly.fnst@cn.fujitsu.com>
	<20170904113907.2a6e0cc7@nial.brq.redhat.com>
	<ec0c5471-5960-42aa-2723-f3dcb63d9fdc@cn.fujitsu.com>
	<20170904131118.4de9ed44@nial.brq.redhat.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <5c552a10-d329-d249-2efc-e117e8c1a2d4@cn.fujitsu.com>
Date: Tue, 5 Sep 2017 08:59:42 +0800
MIME-Version: 1.0
In-Reply-To: <20170904131118.4de9ed44@nial.brq.redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/3] hw/acpi-build: Fix SRAT memory
 building in case of node 0 without RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, mst@redhat.com, rth@twiddle.net

Hi Igor,

At 09/04/2017 07:11 PM, Igor Mammedov wrote:
[...]
>>>> +        if (mem_base <= HOLE_640K_START &&
>>>> +            next_base > HOLE_640K_START) {
>>>> +            mem_len -= next_base - HOLE_640K_START;
>>>> +            if (mem_len > 0) {
>>>> +                numamem = acpi_data_push(table_data, sizeof *numamem);
>>>> +                build_srat_memory(numamem, mem_base, mem_len, i - 1,
>>>> +                                  MEM_AFFINITY_ENABLED);
>>>> +            }
>>>> +
>>>> +            /* Check for the rare case: 640K < RAM < 1M */
>>>> +            if (next_base <= HOLE_640K_END) {
>>>> +                next_base = HOLE_640K_END;
>>> Is this assignment really necessary?
>>>
>>
>> It is necessary, because we set mem_base to next_base before setting
>> next_base;
>>
>> But, I can refine it:
>>
>>                                     MEM_AFFINITY_ENABLED);
>>               }
>>
>> +            mem_base = HOLE_640K_END;
>>               /* Check for the rare case: 640K < RAM < 1M */
>>               if (next_base <= HOLE_640K_END) {
>> -                next_base = HOLE_640K_END;
>>                   continue;
>>               }
>> -            mem_base = HOLE_640K_END;
>>               mem_len = next_base - HOLE_640K_END;
>>           }
>>
>> Is it?
> I was wrong, so just leave it as it is now.
>

OK, I see.

Thanks,
	dou.
