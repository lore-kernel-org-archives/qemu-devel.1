Received: from eggs.gnu.org ([2001:4830:134:3::10]:52980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cqCfD-0007eu-A3
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 01:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cqCf9-0006y5-Dq
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 01:48:59 -0400
Received: from [59.151.112.132] (port=16947 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cqCf9-0006v2-1i
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 01:48:55 -0400
References: <1489657928-14919-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<22303218-697c-7166-406b-050888efdfd5@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <cc051a40-9142-9364-8bc8-de8ec453ebe2@cn.fujitsu.com>
Date: Tue, 21 Mar 2017 13:47:56 +0800
MIME-Version: 1.0
In-Reply-To: <22303218-697c-7166-406b-050888efdfd5@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/3] Add COLO-proxy virtio-net support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>, bian naimeng <biannm@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 03/21/2017 11:39 AM, Jason Wang wrote:
>
>
> On 2017年03月16日 17:52, Zhang Chen wrote:
>> If user use -device virtio-net-pci, virtio-net driver will add a header
>> to raw net packet that colo-proxy can't handle it. COLO-proxy just
>> focus on the packet payload, so we skip the virtio-net header to compare
>> the sent packet that primary guest's to secondary guest's.
>>
>>
>> Zhang Chen (3):
>>    COLO-proxy: Add virtio-net packet parse function
>>    COLO-proxy: Add a tag to mark virtio-net packet
>>    COLO-compare: Add virtio-net packet compare support
>>
>>   net/colo-compare.c    | 42 +++++++++++++++++++++++++++++++++---------
>>   net/colo.c            | 14 ++++++++++----
>>   net/colo.h            |  7 ++++++-
>>   net/filter-rewriter.c | 15 ++++++++++-----
>>   4 files changed, 59 insertions(+), 19 deletions(-)
>>
>
> Hi:
>
> Git grep told us virtio-net is not the only user for vnet header. 
> E1000e and vmxnet3 uses it too.
>
> So we need solve them all instead of being virtio-net specific.
>

Yes, In this series I just try to parse vnet header, if failed I will 
try to parse normal net packet.
So, I just focus on vnet header rather than virtio-net driver.
But the patch comments really make people confused , Should I fix all 
the comments send the V2 ?

Thanks
Zhang Chen

> Thanks
>
>
>

-- 
Thanks
Zhang Chen
