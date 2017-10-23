Received: from eggs.gnu.org ([2001:4830:134:3::10]:50674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e6QyG-0005jL-4V
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 20:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e6QyD-0005v5-2G
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 20:52:00 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:37516
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e6QyC-0005rq-MK
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 20:51:56 -0400
References: <1508298538-28753-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<66ec5354-d66c-a4e0-aea3-bc1ca428d2a8@cn.fujitsu.com>
	<20171020191523.GQ2942@localhost.localdomain>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <0db84774-3526-467a-d638-6cb821e34d52@cn.fujitsu.com>
Date: Mon, 23 Oct 2017 08:51:45 +0800
MIME-Version: 1.0
In-Reply-To: <20171020191523.GQ2942@localhost.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ACPI/unit-test: Add a testcase for RAM
 allocation in numa node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

Hi Eduardo,

Thanks for your reply.

At 10/21/2017 03:15 AM, Eduardo Habkost wrote:
> On Wed, Oct 18, 2017 at 11:50:32AM +0800, Dou Liyang wrote:
>>
>> At 10/18/2017 11:48 AM, Dou Liyang wrote:
>>> As QEMU supports the memory-less node, it is possible that there is
>>> no RAM in the first numa node(also be called as node0). eg:
>>>   ... \
>>>   -m 128,slots=3,maxmem=1G \
>>>   -numa node -numa node,mem=128M \
>>>
>>> But, this makes it hard for QEMU to build a known-to-work ACPI SRAT
>>> table. Only fixing it is not enough.
>>>
>>> Add a testcase for this situation to make sure the ACPI table is
>>> correct for guest.
>>>
>>> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
>>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>>> ---
>>> Changelog:
>>>
>>> This patch can pass the 'make check' in Peter's machine,
>>
>> Oops,  s/can/can not  :-).
>>
>> Thanks,
>> 	dou.
>>
>>> But, in my own and Eduardo's machine, we can pass it.
>>>
>>> So I rebase and spilt it independently.
>
> Thanks!
>
>>>
>>> Peter:
>>>
>>> could you help me test it in your machine.
>>> then, give me the output files, such as /tmp/asl-6QYK7Y.dsl and /tmp/asl-1H1I7Y.dsl file.
>
> As the failures reported by Peter were about the *.memhp test
> case files, I think this patch is unlikely to be the cause of
> those failures.  I believe the problem is at:
>
>   From: Dou Liyang <douly.fnst@cn.fujitsu.com>
>   Date: Fri, 1 Sep 2017 10:10:03 +0800
>   Message-ID: <1504231805-30957-3-git-send-email-douly.fnst@cn.fujitsu.com>
>   Subject: [PATCH v6 2/4] hw/acpi-build: Make assignment statement
>            of next_base easy to read
>

This patch is just used for readability. so I discard it. and, we
need a test case for the commit

   4926403c250f ("hw/acpi-build: Fix SRAT memory building in case of 
node 0 without RAM")

So, I re-post this patch. ;-)


> However, I would still like to get test results from Peter before
> applying this patch again.

I see.

Thanks,
	dou
