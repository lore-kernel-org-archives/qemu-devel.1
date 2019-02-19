Received: from eggs.gnu.org ([209.51.188.92]:37639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gw1n0-00040d-CN
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 04:34:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gw1mz-0000GV-JO
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 04:34:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gw1mz-0000G9-C6
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 04:34:09 -0500
References: <1550118402-4057-1-git-send-email-wexu@redhat.com>
	<1550118402-4057-8-git-send-email-wexu@redhat.com>
	<7d71fb88-2651-41eb-023e-63a11a83cd38@redhat.com>
	<20190218144640.GA28793@wei-ubt>
	<71fd17b4-9509-3f13-556d-fc4c3e617e84@redhat.com>
	<20190219082101.GA15343@wei-ubt>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d265bbf7-0bb7-9fa6-a8db-e123e5b30795@redhat.com>
Date: Tue, 19 Feb 2019 17:33:57 +0800
MIME-Version: 1.0
In-Reply-To: <20190219082101.GA15343@wei-ubt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 07/11] virtio: fill/flush/pop for packed
 ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Xu <wexu@redhat.com>
Cc: tiwei.bie@intel.com, maxime.coquelin@redhat.com, qemu-devel@nongnu.org, jfreiman@redhat.com, mst@redhat.com


On 2019/2/19 =E4=B8=8B=E5=8D=884:21, Wei Xu wrote:
> On Tue, Feb 19, 2019 at 02:49:42PM +0800, Jason Wang wrote:
>> On 2019/2/18 =E4=B8=8B=E5=8D=8810:46, Wei Xu wrote:
>>>> Do we allow chain more descriptors than vq size in the case of indir=
ect?
>>>> According to the spec:
>>>>
>>>> "
>>>>
>>>> The device limits the number of descriptors in a list through a
>>>> transport-specific and/or device-specific value. If not limited,
>>>> the maximum number of descriptors in a list is the virt queue
>>>> size.
>>>> "
>>>>
>>>> This looks possible, so the above is probably wrong if the max numbe=
r of
>>>> chained descriptors is negotiated through a device specific way.
>>>>
>>> OK, I will remove this check, while it is necessary to have a limitat=
ion
>>> for indirect descriptor anyway, otherwise it is possible to hit an ov=
erflow
>>> since presumably u16 is used for most number/size in the spec.
>>>
>> Please try to test block and scsi device for you changes as well.
> Any idea about what kind of test should be covered? AFAICT, currently
> packed ring is targeted for virtio-net as discussed during voting spec.
>
> Wei


Well it's not only for net for sure, it should support all kinds of=20
device. For testing, you should test basic function plus migration.

Thanks


>
>> Thanks
>>
>>
