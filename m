Received: from eggs.gnu.org ([2001:4830:134:3::10]:42795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cnhfj-0003VV-Nw
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:19:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cnhfe-00060n-Na
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:19:09 -0400
Received: from [59.151.112.132] (port=31110 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cnhfe-0005zp-Ap
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:19:06 -0400
References: <1488278902-11223-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<ca75b31f-1337-6fef-c799-6902f79798a5@cn.fujitsu.com>
	<8959bc26-bf4d-1ecb-a606-b602f6699a9f@redhat.com>
	<64b0e728-d4f0-8b9c-3921-23cf297fb264@cn.fujitsu.com>
	<29889b8f-2957-c1be-f71f-5f229f47ee4c@cn.fujitsu.com>
	<6ae5c2a1-b04c-750b-577f-6f9b0fdd774d@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <2d0c19e5-f223-9477-6c20-4257af0fb098@cn.fujitsu.com>
Date: Tue, 14 Mar 2017 16:18:23 +0800
MIME-Version: 1.0
In-Reply-To: <6ae5c2a1-b04c-750b-577f-6f9b0fdd774d@redhat.com>
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
Cc: zhangchen.fnst@cn.fujitsu.com, Stefano Stabellini <sstabellini@kernel.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>



On 03/14/2017 03:37 PM, Jason Wang wrote:
>
>
> On 2017年03月13日 15:21, Zhang Chen wrote:
>>
>>
>> On 03/13/2017 03:10 PM, Zhang Chen wrote:
>>>
>>>
>>> On 03/13/2017 02:28 PM, Jason Wang wrote:
>>>>
>>>>
>>>> On 2017年03月13日 14:18, Zhang Chen wrote:
>>>>> Hi~~~ All~
>>>>>
>>>>> No news for a long time, anyone can give me some comments?
>>>>
>>>> Hi,
>>>>
>>>> A question is why use two kinds of colo-frames? This seems not good 
>>>> as lots of the code were duplicated.
>>>
>>> Because Xen colo-frame based on Xen Remus.
>>> Remus do some job like the migration job in qemu/kvm, and in Xen HVM 
>>> we can not do migration in qemu,
>>> So colo-frame code must running in Xen side.
>>> In addition, Xen HVM use qemu to simulation device that Colo-proxy 
>>> and Replication can use same one codes in qemu.
>>
>> Detail:
>> https://wiki.xenproject.org/wiki/COLO_-_Coarse_Grain_Lock_Stepping
>>
>> Thanks
>> Zhang Chen 
>
> Ok, the idea looks ok but let's don't make the code specific to any 
> hypersior (e.g Xen). Instead, let's define a more generic API like:
>
> 1) rename the series to something like "support remote checkpoint", 
> and mention Xen is the first user
> 2) do not use something like "COLO_USERSPACE_PROXY_INIT", you can just 
> use a more generic name like "USERSPACE_PROXY_INIT"
> 3) instead of using raw strings, you can use soemthing like TLV (or 
> refer the vhost-user protocol).
>
> Btw, is colo-compare the only user that need to be co-operated with 
> Xen? If not, better generalize the API.

Yes, only colo-compare.
I got your point, will fix this series in next version.

Thanks
Zhang Chen

>
> Thanks
>
>
>
> .
>

-- 
Thanks
Zhang Chen
