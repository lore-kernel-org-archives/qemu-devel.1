Received: from eggs.gnu.org ([2001:4830:134:3::10]:40287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1fcpxl-0005rW-Gw
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 06:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1fcpxi-0001EJ-F7
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 06:33:41 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:64292
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1fcpxi-0001Dl-27
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 06:33:38 -0400
References: <20180704132239.6506-1-douly.fnst@cn.fujitsu.com>
	<20180710094253.0c122846@redhat.com>
	<2052cdff-3dea-1267-3442-39557637b2d4@cn.fujitsu.com>
	<20180710102703.GF7451@localhost.localdomain>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <5d2b4b3d-fbe5-7c74-8580-0b669ac3bb14@cn.fujitsu.com>
Date: Tue, 10 Jul 2018 18:33:33 +0800
MIME-Version: 1.0
In-Reply-To: <20180710102703.GF7451@localhost.localdomain>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/machine: Remove the Zero check of
 nb_numa_nodes for numa_complete_configuration()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

Hi Eduardo,

At 07/10/2018 06:27 PM, Eduardo Habkost wrote:
> On Tue, Jul 10, 2018 at 04:15:30PM +0800, Dou Liyang wrote:
> [...]
>>>> +    if (nb_numa_nodes)
>>>>            machine_numa_finish_cpu_init(machine);
>>>> -    }
>>> missing curly brackets, should look like:
>>>          if (nb_numa_nodes) {
>>>              machine_numa_finish_cpu_init(machine);
>>>          }
>>>
>>> with that fixed
>>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>>>
>>
>> Thank you, Igor.
>>
>> Due to Eduardo has sent the pull request of this patch,
>> Can I fix this and send v2 patch now?
> 
> You can fix this on a follow-up patch and CC qemu-trivial.
> 

Ok, I see. ;-)

Thanks,
	dou
