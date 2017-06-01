Received: from eggs.gnu.org ([2001:4830:134:3::10]:49719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dGKN7-0005w0-DX
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 03:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dGKN4-0000HJ-0z
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 03:18:17 -0400
Received: from [59.151.112.132] (port=17341 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dGKN3-0000Di-Lx
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 03:18:13 -0400
References: <1495549241-23380-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1495549241-23380-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<118320f3-67cf-bb46-8ae7-6de552cc15bf@redhat.com>
	<20c9a93a-de80-68d7-9838-38f5a5444250@cn.fujitsu.com>
	<c3a29be5-1000-7dc8-f50a-fe75068d057c@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <8ecf119d-bbac-c568-9dca-9e9c1ea135bb@cn.fujitsu.com>
Date: Thu, 1 Jun 2017 15:18:41 +0800
MIME-Version: 1.0
In-Reply-To: <c3a29be5-1000-7dc8-f50a-fe75068d057c@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V5 3/9] net/filter-mirror.c: Add new option
 to enable vnet support for filter-redirector
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



On 05/26/2017 01:30 PM, Jason Wang wrote:
>
>
> On 2017年05月25日 20:58, Zhang Chen wrote:
>>>>     static void filter_redirector_init(Object *obj)
>>>>   {
>>>> +    MirrorState *s = FILTER_REDIRECTOR(obj);
>>>> +
>>>>       object_property_add_str(obj, "indev", 
>>>> filter_redirector_get_indev,
>>>>                               filter_redirector_set_indev, NULL);
>>>>       object_property_add_str(obj, "outdev", 
>>>> filter_redirector_get_outdev,
>>>>                               filter_redirector_set_outdev, NULL);
>>>> +
>>>> +    /*
>>>> +     * The vnet_hdr is disabled by default, if you want to enable
>>>> +     * this option, you must enable all the option on related modules
>>>> +     * (like other filter or colo-compare).
>>>> +     */
>>>> +    s->vnet_hdr = false;
>>>> +    object_property_add_str(obj, "vnet_hdr", 
>>>> filter_redirector_get_vnet_hdr,
>>>> +                            filter_redirector_set_vnet_hdr, NULL);
>>>
>>> Why not using object_property_add_bool()?
>>
>> Because use object_property_add_bool() we should change the option from
>> "vnet_hdr=on/off" to "vnet_hdr", it seems hard to read for user.
>>
>> Thanks
>> Zhang Chen 
>
> Looks like there's no exist use case for using str as boolean. And you 
> can probably change the name to "vnet-hdr-support" to make it more 
> readable.

OK, I will change it as you said in next version.

Thanks
ZhangChen

>
> Thanks
>
>
> .
>

-- 
Thanks
Zhang Chen
