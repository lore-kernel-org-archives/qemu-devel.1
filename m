Received: from eggs.gnu.org ([2001:4830:134:3::10]:43354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dI3PV-0002k2-Hk
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 21:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dI3PS-0003RE-FZ
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 21:35:53 -0400
Received: from [59.151.112.132] (port=58529 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dI3PS-0003QX-3h
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 21:35:50 -0400
References: <cover.1496387804.git.maozy.fnst@cn.fujitsu.com>
	<28378a4dc27a2694dfacf5254813d59175cda4e6.1496387804.git.maozy.fnst@cn.fujitsu.com>
	<37b5f59f-8714-236e-a9b3-d57d96a0a143@redhat.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <7fa5ede1-d9ad-83d0-9bda-8cac2dc53551@cn.fujitsu.com>
Date: Tue, 6 Jun 2017 09:34:26 +0800
MIME-Version: 1.0
In-Reply-To: <37b5f59f-8714-236e-a9b3-d57d96a0a143@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/6] pci: Add comment for
 pci_add_capability2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, armbru@redhat.com

Hi, Marcel

On 06/05/2017 09:34 PM, Marcel Apfelbaum wrote:
> On 02/06/2017 10:54, Mao Zhongyi wrote:
>> Add a comment for pci_add_capability2() to explain the return
>> value. This may help to make a correct return value check for
>> its callers.
>>
>> Cc: mst@redhat.com
>> Cc: marcel@redhat.com
>> Cc: armbru@redhat.com
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> ---
>>   hw/pci/pci.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 53566b8..9810d5f 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -2276,6 +2276,10 @@ int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
>>       return ret;
>>   }
>>   +/*
>> + * On success, pci_add_capability2() returns a positive value.
>
> Hi,
> I would specify what is the return value: the offset of the pci capability.
>
> Thanks,
> Marcel
>

Thanks, I will.
Mao

>> + * On failure, it sets an error and returns a negative value.
>> + */
>>   int pci_add_capability2(PCIDevice *pdev, uint8_t cap_id,
>>                          uint8_t offset, uint8_t size,
>>                          Error **errp)
>>
>
>
>
>
