Received: from eggs.gnu.org ([2001:4830:134:3::10]:59223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnh1L-0005kd-P1
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:37:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnh1I-0003HL-Ma
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:37:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cnh1I-0003H6-GH
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 03:37:24 -0400
References: <1488278902-11223-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<ca75b31f-1337-6fef-c799-6902f79798a5@cn.fujitsu.com>
	<8959bc26-bf4d-1ecb-a606-b602f6699a9f@redhat.com>
	<64b0e728-d4f0-8b9c-3921-23cf297fb264@cn.fujitsu.com>
	<29889b8f-2957-c1be-f71f-5f229f47ee4c@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6ae5c2a1-b04c-750b-577f-6f9b0fdd774d@redhat.com>
Date: Tue, 14 Mar 2017 15:37:15 +0800
MIME-Version: 1.0
In-Reply-To: <29889b8f-2957-c1be-f71f-5f229f47ee4c@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>



On 2017=E5=B9=B403=E6=9C=8813=E6=97=A5 15:21, Zhang Chen wrote:
>
>
> On 03/13/2017 03:10 PM, Zhang Chen wrote:
>>
>>
>> On 03/13/2017 02:28 PM, Jason Wang wrote:
>>>
>>>
>>> On 2017=E5=B9=B403=E6=9C=8813=E6=97=A5 14:18, Zhang Chen wrote:
>>>> Hi~~~ All~
>>>>
>>>> No news for a long time, anyone can give me some comments?
>>>
>>> Hi,
>>>
>>> A question is why use two kinds of colo-frames? This seems not good=20
>>> as lots of the code were duplicated.
>>
>> Because Xen colo-frame based on Xen Remus.
>> Remus do some job like the migration job in qemu/kvm, and in Xen HVM=20
>> we can not do migration in qemu,
>> So colo-frame code must running in Xen side.
>> In addition, Xen HVM use qemu to simulation device that Colo-proxy=20
>> and Replication can use same one codes in qemu.
>
> Detail:
> https://wiki.xenproject.org/wiki/COLO_-_Coarse_Grain_Lock_Stepping
>
> Thanks
> Zhang Chen=20

Ok, the idea looks ok but let's don't make the code specific to any=20
hypersior (e.g Xen). Instead, let's define a more generic API like:

1) rename the series to something like "support remote checkpoint", and=20
mention Xen is the first user
2) do not use something like "COLO_USERSPACE_PROXY_INIT", you can just=20
use a more generic name like "USERSPACE_PROXY_INIT"
3) instead of using raw strings, you can use soemthing like TLV (or=20
refer the vhost-user protocol).

Btw, is colo-compare the only user that need to be co-operated with Xen?=20
If not, better generalize the API.

Thanks
