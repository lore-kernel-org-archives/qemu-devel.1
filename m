Received: from eggs.gnu.org ([2001:4830:134:3::10]:48173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dL3H4-0001ww-3z
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dL3Gz-0004TU-Io
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:03:34 -0400
Received: from [59.151.112.132] (port=21258 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dL3Gy-0004RV-Um
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:03:29 -0400
References: <1496829322-17099-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1496829322-17099-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<4d998686-136d-1b6d-a641-9332930dcc93@redhat.com>
	<28122598-b6b3-9eb6-b726-bd7c22735780@cn.fujitsu.com>
	<93409ed0-7dcb-a167-9438-f5f2b1f3bef5@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <5eff3578-61ac-f41a-1cab-9cc6ef40d7db@cn.fujitsu.com>
Date: Wed, 14 Jun 2017 16:04:31 +0800
MIME-Version: 1.0
In-Reply-To: <93409ed0-7dcb-a167-9438-f5f2b1f3bef5@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH V6 02/10] net/filter-mirror.c: Make filter
 mirror support vnet support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, weifuqiang <weifuqiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>



On 06/13/2017 05:14 PM, Jason Wang wrote:
>
>
> On 2017年06月12日 17:27, Zhang Chen wrote:
>>>
>>>> +        if (nf->direction == NET_FILTER_DIRECTION_RX ||
>>>> +            nf->direction == NET_FILTER_DIRECTION_ALL) {
>>>> +            vnet_hdr_len = nf->netdev->vnet_hdr_len;
>>>
>>> This can only work if e.g virtio-net set its own vnet_hdr_len. But 
>>> looks like it use guest_hdr_len instead.
>>
>> I see in hw/net/virtio-net.c use the "qemu_set_vnet_hdr_len(nc->peer, 
>> n->guest_hdr_len);" to
>> set the nf->netdev->vnet_hdr_len, any case not include here? 
>
> You mean:
>
>         if (peer_has_vnet_hdr(n) &&
>             qemu_has_vnet_hdr_len(nc->peer, n->guest_hdr_len)) {
>             qemu_set_vnet_hdr_len(nc->peer, n->guest_hdr_len);
>             n->host_hdr_len = n->guest_hdr_len;
>         }
>
> ?
>
> From the code, it only set peer's vnet header when peer supports 
> vnet_hdr up to n->guest_hdr_len. If peer can't, virtio-net will strip 
> the header.

So, We should get the n->guest_hdr_len in another way? like set a new 
parameter in NetClientState?
Any suggestion about it?

Thanks
Zhang Chen

>
> Thanks
>
>
>

-- 
Thanks
Zhang Chen
