Received: from eggs.gnu.org ([2001:4830:134:3::10]:56927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dD8T3-0003fV-RR
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dD8Sz-0001b2-C1
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:59:13 -0400
Received: from [59.151.112.132] (port=19570 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dD8Sz-0001Y0-0S
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:59:09 -0400
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1494553288-30764-8-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<8779a4c4-17eb-c643-6a44-6f20f55cb6f7@redhat.com>
	<ee114082-00f8-d5cf-7370-8d17b178dd63@cn.fujitsu.com>
	<459b7363-e514-7dcc-624d-f302a6e4756c@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <e2d38dc6-f686-202a-be46-e2ef8fb1cee8@cn.fujitsu.com>
Date: Tue, 23 May 2017 19:59:24 +0800
MIME-Version: 1.0
In-Reply-To: <459b7363-e514-7dcc-624d-f302a6e4756c@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V4 07/12] net/colo.c: Make vnet_hdr_len as
 packet property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, weifuqiang <weifuqiang@huawei.com>, "eddie
	. dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>



On 05/15/2017 04:18 PM, Jason Wang wrote:
>
>
> On 2017年05月15日 16:03, Zhang Chen wrote:
>>
>>
>> On 05/15/2017 12:05 PM, Jason Wang wrote:
>>>
>>>
>>> On 2017年05月12日 09:41, Zhang Chen wrote:
>>>> We can use this property flush and send packet with vnet_hdr_len.
>>>>
>>>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>>>
>>> Then I think it's not necessary to store vnet_hdr_len in 
>>> SocketReadState?
>>
>> Do you means we keep the patch 05/12 in original?
>>
>> Thanks
>> Zhang Chen
>>
>
> I mean we could fetch vnet_hdr_len from the buf directly. Or is there 
> any advantage to store it in SocketReadState?

No, The rs->buf did't have the vnet_hdr_len field.
In the net_fill_rstate(), when case = 2, we override the rs->buf by real 
net packet data,
So, the vnet_hdr_len field and packet_len field didn't be include in the 
last rs->buf.

Thanks
Zhang Chen

>
> Thanks
>
>
>
>

-- 
Thanks
Zhang Chen
