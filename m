Received: from eggs.gnu.org ([2001:4830:134:3::10]:58456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dE7ph-0006P2-3B
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dE7pc-0001Nw-To
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:30:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dE7pc-0001N2-N1
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:30:36 -0400
References: <1495549241-23380-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1495549241-23380-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<118320f3-67cf-bb46-8ae7-6de552cc15bf@redhat.com>
	<20c9a93a-de80-68d7-9838-38f5a5444250@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c3a29be5-1000-7dc8-f50a-fe75068d057c@redhat.com>
Date: Fri, 26 May 2017 13:30:29 +0800
MIME-Version: 1.0
In-Reply-To: <20c9a93a-de80-68d7-9838-38f5a5444250@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, weifuqiang <weifuqiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>



On 2017=E5=B9=B405=E6=9C=8825=E6=97=A5 20:58, Zhang Chen wrote:
>>>     static void filter_redirector_init(Object *obj)
>>>   {
>>> +    MirrorState *s =3D FILTER_REDIRECTOR(obj);
>>> +
>>>       object_property_add_str(obj, "indev",=20
>>> filter_redirector_get_indev,
>>>                               filter_redirector_set_indev, NULL);
>>>       object_property_add_str(obj, "outdev",=20
>>> filter_redirector_get_outdev,
>>>                               filter_redirector_set_outdev, NULL);
>>> +
>>> +    /*
>>> +     * The vnet_hdr is disabled by default, if you want to enable
>>> +     * this option, you must enable all the option on related module=
s
>>> +     * (like other filter or colo-compare).
>>> +     */
>>> +    s->vnet_hdr =3D false;
>>> +    object_property_add_str(obj, "vnet_hdr",=20
>>> filter_redirector_get_vnet_hdr,
>>> +                            filter_redirector_set_vnet_hdr, NULL);
>>
>> Why not using object_property_add_bool()?
>
> Because use object_property_add_bool() we should change the option from
> "vnet_hdr=3Don/off" to "vnet_hdr", it seems hard to read for user.
>
> Thanks
> Zhang Chen=20

Looks like there's no exist use case for using str as boolean. And you=20
can probably change the name to "vnet-hdr-support" to make it more readab=
le.

Thanks
