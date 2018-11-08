Received: from eggs.gnu.org ([2001:4830:134:3::10]:34977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gKZrP-0003wK-ND
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 21:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gKZrK-0008GX-Pn
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 21:15:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gKZrK-0008El-IU
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 21:15:50 -0500
References: <20181016132327.121839-1-xiao.w.wang@intel.com>
	<2e010e02-f7a2-d009-ac7a-fdc266f99254@redhat.com>
	<D0158A423229094DA7ABF71CF2FA0DA34EBC9415@SHSMSX104.ccr.corp.intel.com>
	<e516b798-ecf3-030c-621b-468250bcc7d3@redhat.com>
	<D0158A423229094DA7ABF71CF2FA0DA34EBC98A4@SHSMSX104.ccr.corp.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <925d4df0-13e3-39ea-5d91-991144a29ffe@redhat.com>
Date: Thu, 8 Nov 2018 10:15:36 +0800
MIME-Version: 1.0
In-Reply-To: <D0158A423229094DA7ABF71CF2FA0DA34EBC98A4@SHSMSX104.ccr.corp.intel.com>
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Bie, Tiwei" <tiwei.bie@intel.com>, "Ye,
	Xiaolong" <xiaolong.ye@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "Daly, Dan" <dan.daly@intel.com>


On 2018/11/7 =E4=B8=8B=E5=8D=8811:08, Liang, Cunming wrote:
>>>> believe.
>>> [LC] Agreed, so it reuses CMD defined by vhost-kernel ioctl. But VFIO=
 provides
>> device specific things (e.g. DMAR, INTR and etc.) which is the extra A=
PIs being
>> introduced by this transport.
>>
>>
>> I'm not quite sure I understand here. I think having vhost-kernel
>> compatible ioctl does not conflict of using VFIO ioctl like DMA or INT=
R?
>>
>> Btw, VFIO DMA ioctl is even not a must from my point of view, vhost-md=
ev
>> can forward the mem table information to device driver and let it call
>> DMA API to map/umap pages.
> [LC] If not regarding vhost-mdev as a device, then forward mem table wo=
n't be a concern.
> If introducing a new mdev bus driver (vhost-mdev) which allows mdev ins=
tance to be a new type of provider for vhost-kernel. It becomes a pretty =
good alternative to fully leverage vhost-kernel ioctl.
> I'm not sure it's the same view as yours when you says reusing vhost-ke=
rnel ioctl.
>

Yes it is.

Thanks
