Received: from eggs.gnu.org ([208.118.235.92]:33291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gKwbO-0007JD-LV
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 21:32:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gKwbL-0000VN-5r
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 21:32:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gKwbK-0000On-S8
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 21:32:51 -0500
References: <20181016132327.121839-1-xiao.w.wang@intel.com>
	<2e010e02-f7a2-d009-ac7a-fdc266f99254@redhat.com>
	<D0158A423229094DA7ABF71CF2FA0DA34EBC9415@SHSMSX104.ccr.corp.intel.com>
	<e516b798-ecf3-030c-621b-468250bcc7d3@redhat.com>
	<D0158A423229094DA7ABF71CF2FA0DA34EBC98A4@SHSMSX104.ccr.corp.intel.com>
	<925d4df0-13e3-39ea-5d91-991144a29ffe@redhat.com>
	<D0158A423229094DA7ABF71CF2FA0DA34EBCB34F@SHSMSX104.ccr.corp.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9e22fb2f-c6fd-d71b-5ef7-21a11f657bd6@redhat.com>
Date: Fri, 9 Nov 2018 10:32:35 +0800
MIME-Version: 1.0
In-Reply-To: <D0158A423229094DA7ABF71CF2FA0DA34EBCB34F@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/2] vhost-vfio: introduce mdev based HW
 vhost backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liang, Cunming" <cunming.liang@intel.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>, "mst@redhat.com" <mst@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Cc: "Daly, Dan" <dan.daly@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Bie, Tiwei" <tiwei.bie@intel.com>, "Ye, Xiaolong" <xiaolong.ye@intel.com>


On 2018/11/9 =E4=B8=8A=E5=8D=8812:48, Liang, Cunming wrote:
>> -----Original Message-----
>> From: Jason Wang [mailto:jasowang@redhat.com]
>> Sent: Thursday, November 8, 2018 2:16 AM
>> To: Liang, Cunming<cunming.liang@intel.com>; Wang, Xiao W
>> <xiao.w.wang@intel.com>;mst@redhat.com;alex.williamson@redhat.com
>> Cc:qemu-devel@nongnu.org; Bie, Tiwei<tiwei.bie@intel.com>; Ye, Xiaolon=
g
>> <xiaolong.ye@intel.com>; Wang, Zhihong<zhihong.wang@intel.com>; Daly, =
Dan
>> <dan.daly@intel.com>
>> Subject: Re: [RFC 0/2] vhost-vfio: introduce mdev based HW vhost backe=
nd
>>
>>
>> On 2018/11/7 =E4=B8=8B=E5=8D=8811:08, Liang, Cunming wrote:
>>>>>> believe.
>>>>> [LC] Agreed, so it reuses CMD defined by vhost-kernel ioctl. But
>>>>> VFIO provides
>>>> device specific things (e.g. DMAR, INTR and etc.) which is the extra
>>>> APIs being introduced by this transport.
>>>>
>>>>
>>>> I'm not quite sure I understand here. I think having vhost-kernel
>>>> compatible ioctl does not conflict of using VFIO ioctl like DMA or I=
NTR?
>>>>
>>>> Btw, VFIO DMA ioctl is even not a must from my point of view,
>>>> vhost-mdev can forward the mem table information to device driver an=
d
>>>> let it call DMA API to map/umap pages.
>>> [LC] If not regarding vhost-mdev as a device, then forward mem table =
won't be a
>> concern.
>>> If introducing a new mdev bus driver (vhost-mdev) which allows mdev i=
nstance to
>> be a new type of provider for vhost-kernel. It becomes a pretty good a=
lternative to
>> fully leverage vhost-kernel ioctl.
>>> I'm not sure it's the same view as yours when you says reusing vhost-=
kernel ioctl.
>>>
>> Yes it is.
> [LC] It sounds a pretty good idea to me. Let us spend some time to figu=
re out the next level detail, and sync-up further plan in community call.=
:)
>

Cool, thanks.
