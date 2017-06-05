Received: from eggs.gnu.org ([2001:4830:134:3::10]:34779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dHof7-0004JG-Un
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 05:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dHof3-0007wf-Sr
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 05:51:01 -0400
Received: from [59.151.112.132] (port=22822 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dHof3-0007us-Em
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 05:50:57 -0400
References: <1ee3ccf0-2d91-86ec-628c-d50ae3ffbe22@cn.fujitsu.com>
	<20170605104508.1419d7af@nial.brq.redhat.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <f035d329-aa35-953c-9eb3-29b2a03555db@cn.fujitsu.com>
Date: Mon, 5 Jun 2017 17:50:45 +0800
MIME-Version: 1.0
In-Reply-To: <20170605104508.1419d7af@nial.brq.redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Memory Hotplug : Does QEmu support cold-plugged
 memory?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Andrew Jones <drjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Michal Hocko <mhocko@kernel.org>

Hi Igor,

At 06/05/2017 04:45 PM, Igor Mammedov wrote:
> On Mon, 5 Jun 2017 15:53:02 +0800
> Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
>
>> Hi all,
>>
>> I want to boot up a system with some removable memory.
>>
>> So, i used '-object' and '-device' to cold-plug memory
>> in QEmu as following :
>>
>> ./x86_64-softmmu/qemu-system-x86_64 \
>> 	...
>> 	-object memory-backend-ram,id=mem3,size=128M \
>> 	-device pc-dimm,id=dimm3,memdev=mem3 \
>> 	...
>>
>> then i want to hot-remove this memory by 'device-del' and
>> 'object-del'.
>>
>> But, unfortunately, I can't remove the memory device.
>>
>> And, in guest OS, I found the memory's removable feature is 0,
>> But, in QEmu monitor with 'info memory-devices', I found the
>> hotplugged is false and hotpluggable is true.
> It's issue in the guest side kernel.
> In short it's not guarantied that guest kernel would be able
> to hotremove DIMM module (even if hardware is capable of) since
> kernel might use its memory as not MOVABLE, so DIMM might be
> temporally or permanently pinned by kernel allocations.
>

I see.

> There is ongoing refactoring/cleanup work upstream, that
> tries to make memhotplug behavior consistent/reasonable.
>
> If you are interested, I'd suggest to review/test changes that
> Michal works on upstream, to make sure that refactoring won't
> break your usecase.

OK, I will.

>
> You can find the latest series Michal posted at:
> http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1410289.html
>

um, I found the patchset, and I am reading the discussions and test
cases you gave in v2.

>
>>
>> Could you help me:
>>
>> 1, Can the ram based memory-backend be plugged like above?
> yes, it can be used as above
>
>> 2, Does the 'info memory-devices' command show a wrong info?
> nope,
> command shows hotpluggable status the way hw (qemu) sees it
>
>> 3, Can file memory backend(memory-backend-file) be cold-plugged?
> yes, it can.
>
> [...]
>

Thanks a lot ;)

Thanks,
	dou.

>
>
