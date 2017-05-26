Received: from eggs.gnu.org ([2001:4830:134:3::10]:59863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dE7vK-000111-IB
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dE7vJ-00048I-P2
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:36:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dE7vJ-00047h-JQ
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:36:29 -0400
From: Jason Wang <jasowang@redhat.com>
References: <1495549241-23380-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1495549241-23380-7-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<9f0e7f5e-7da7-4d78-95d9-be544b1bd28e@redhat.com>
	<b4ad4d4a-a469-edff-ed98-06cb7d4ecc8f@cn.fujitsu.com>
	<9de12794-ee9d-4874-b6c0-c8902cbc09c7@redhat.com>
Message-ID: <88049ac0-921b-303c-321d-d5e373b8d2d3@redhat.com>
Date: Fri, 26 May 2017 13:36:23 +0800
MIME-Version: 1.0
In-Reply-To: <9de12794-ee9d-4874-b6c0-c8902cbc09c7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V5 6/9] net/colo-compare.c: Make
 colo-compare support vnet_hdr_len
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, bian naimeng <biannm@cn.fujitsu.com>, weifuqiang <weifuqiang@huawei.com>



On 2017=E5=B9=B405=E6=9C=8826=E6=97=A5 13:35, Jason Wang wrote:
>
>
> On 2017=E5=B9=B405=E6=9C=8825=E6=97=A5 21:18, Zhang Chen wrote:
>>>> @@ -472,7 +474,10 @@ static void colo_compare_connection(void=20
>>>> *opaque, void *user_data)
>>>>           }
>>>>             if (result) {
>>>> -            ret =3D compare_chr_send(&s->chr_out, pkt->data,=20
>>>> pkt->size);
>>>> +            ret =3D compare_chr_send(s,
>>>> +                                   pkt->data,
>>>> +                                   pkt->size,
>>>> +                                   pkt->vnet_hdr_len);
>>>
>>> Why not check vnet_hdr support here?  And don't we need strip=20
>>> vnet_hdr here? (Since the redirector on destination does not do this)
>>
>> If we create a normal qemu guest that use virtio-net-pci driver, the=20
>> guest's send packet have the vnet_hdr,
>> qemu virtio-net-pci driver will strip vnet_hdr then send to external=20
>> network. In COLO we just redirect
>> or mirror the packet, finally the packet will back to primary qemu=20
>> virtio-net-pci driver, So we just send
>> the packet.
>>
>> Thanks
>> Zhang Chen=20
>
> But you send vnet_hdr_len unconditionally, which mean colo-compare can=20
> not work for redirector with vnet_hdr off now?
>
> Thanks
>

Btw, you may consider to update the COLO example in docs for the case=20
that needs vnet hdr.

Thanks
