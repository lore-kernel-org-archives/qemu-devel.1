Received: from eggs.gnu.org ([2001:4830:134:3::10]:39524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ceEVf-0004cT-5w
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 00:21:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ceEVc-0004TJ-1D
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 00:21:39 -0500
Received: from [59.151.112.132] (port=64316 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ceEVb-0004Sx-Kv
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 00:21:35 -0500
References: <1486531462-13882-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1486531462-13882-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<9358a09d-d65f-2b44-9bce-7027b133f1f8@redhat.com>
	<alpine.DEB.2.10.1702131228110.6418@sstabellini-ThinkPad-X260>
	<b1cc9438-3f49-dbf9-8334-1dbdb4aa9704@cn.fujitsu.com>
	<3c0c0156-b984-859f-c51f-d76599a976bb@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <2b48fc1a-86c8-886c-a99d-05d5c343accc@cn.fujitsu.com>
Date: Thu, 16 Feb 2017 13:21:37 +0800
MIME-Version: 1.0
In-Reply-To: <3c0c0156-b984-859f-c51f-d76599a976bb@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V7 2/2] Add a new qmp command to do
 checkpoint, query xen replication status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu devel <qemu-devel@nongnu.org>, Wen Congyang <wencongyang@gmail.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Amit Shah <amit.shah@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 02/16/2017 01:08 PM, Jason Wang wrote:
>
>
> On 2017年02月16日 11:25, Zhang Chen wrote:
>> Ping...
>>
>> No new for a long time.
>>
>> Who can pick up this patch?
>>
>
> I believe you'd better cc migration maintainers (cced), have you tried 
> scripts/get_maintainer ?

Thanks Jason.
Add cc Markus Armbruster <armbru@redhat.com>,
        Amit Shah <amit.shah@redhat.com>,
        zhanghailiang <zhang.zhanghailiang@huawei.com>


>
> Thanks
>
>>
>> Thanks
>>
>> Zhang Chen
>>
>>
>> On 02/14/2017 04:28 AM, Stefano Stabellini wrote:
>>> On Wed, 8 Feb 2017, Eric Blake wrote:
>>>> On 02/07/2017 11:24 PM, Zhang Chen wrote:
>>>>> We can call this qmp command to do checkpoint outside of qemu.
>>>>> Xen colo will need this function.
>>>>>
>>>>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>>>>> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
>>>>> ---
>>>>>   migration/colo.c | 17 ++++++++++++++++
>>>>>   qapi-schema.json | 60 
>>>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>   2 files changed, 77 insertions(+)
>>>>>
>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>> Given that the series is all acked, are you going to take care of the
>>> pull request?
>>>
>>>
>>> .
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
