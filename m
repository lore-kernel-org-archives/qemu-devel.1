Received: from eggs.gnu.org ([2001:4830:134:3::10]:34535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cnK8g-0006LM-Lh
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 03:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cnK8d-0002nG-Gn
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 03:11:30 -0400
Received: from [59.151.112.132] (port=42139 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cnK8d-0002m1-4X
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 03:11:27 -0400
References: <1488278902-11223-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<ca75b31f-1337-6fef-c799-6902f79798a5@cn.fujitsu.com>
	<8959bc26-bf4d-1ecb-a606-b602f6699a9f@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <64b0e728-d4f0-8b9c-3921-23cf297fb264@cn.fujitsu.com>
Date: Mon, 13 Mar 2017 15:10:37 +0800
MIME-Version: 1.0
In-Reply-To: <8959bc26-bf4d-1ecb-a606-b602f6699a9f@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/3] COLO-compare: Make COLO-compare
 support Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Stefano Stabellini <sstabellini@kernel.org>



On 03/13/2017 02:28 PM, Jason Wang wrote:
>
>
> On 2017年03月13日 14:18, Zhang Chen wrote:
>> Hi~~~ All~
>>
>> No news for a long time, anyone can give me some comments?
>
> Hi,
>
> A question is why use two kinds of colo-frames? This seems not good as 
> lots of the code were duplicated.

Because Xen colo-frame based on Xen Remus.
Remus do some job like the migration job in qemu/kvm, and in Xen HVM we 
can not do migration in qemu,
So colo-frame code must running in Xen side.
In addition, Xen HVM use qemu to simulation device that Colo-proxy and 
Replication can use same one codes in qemu.

Thanks
Zhang Chen

>
> Thanks
>
>>
>>
>> Thanks
>>
>> Zhang Chen
>>
>>
>> On 02/28/2017 06:48 PM, Zhang Chen wrote:
>>> This series focus on COLO Xen support.
>>> We add a new chardev socket in colo-compare as the way
>>> of communicate with Xen COLO-frame.
>>> Xen part:
>>> https://lists.xenproject.org/archives/html/xen-devel/2017-02/msg02067.html 
>>>
>>>
>>> This series is a frame, have some TODO job depend on this patch:
>>> https://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg05055.html
>>>
>>>
>>> Zhang Chen (3):
>>>    COLO-compare: Add new parameter for communicate with Xen colo-frame
>>>    COLO-compare: Add Xen notify chardev socket handler frame
>>>    COLO-compare: Add colo-compare Xen notify
>>>
>>>   net/colo-compare.c | 77 
>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   qemu-options.hx    | 38 ++++++++++++++++++++++++---
>>>   2 files changed, 111 insertions(+), 4 deletions(-)
>>>
>>
>
>
>
> .
>

-- 
Thanks
Zhang Chen
