Received: from eggs.gnu.org ([2001:4830:134:3::10]:33164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gBxho-0006Cd-IS
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gBxhi-0006B0-Su
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:54:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gBxhi-0006A6-Gd
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:54:18 -0400
References: <1539266915-15216-1-git-send-email-wexu@redhat.com>
	<1539266915-15216-4-git-send-email-wexu@redhat.com>
	<fef2ece0-03ca-3eef-3c21-31ee0a6440b7@redhat.com>
	<20181015070954.GB27871@wei-ubt>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <45cdc553-3ad6-e093-007b-4891c598fbab@redhat.com>
Date: Mon, 15 Oct 2018 15:54:08 +0800
MIME-Version: 1.0
In-Reply-To: <20181015070954.GB27871@wei-ubt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [[RFC v3 03/12] virtio: init memory cache for
 packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Xu <wexu@redhat.com>
Cc: maxime.coquelin@redhat.com, jfreimann@redhat.com, qemu-devel@nongnu.org, tiwei.bie@intel.com



On 2018=E5=B9=B410=E6=9C=8815=E6=97=A5 15:09, Wei Xu wrote:
>>> -hwaddr virtio_queue_get_avail_size(VirtIODevice *vdev, int n)
>>> +hwaddr virtio_queue_get_driver_size(VirtIODevice *vdev, int n)
>>>   {
>>> -    return offsetof(VRingAvail, ring) +
>>> -        sizeof(uint16_t) * vdev->vq[n].vring.num;
>>> +    int s;
>>> +
>>> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
>>> +        return sizeof(struct VRingPackedDescEvent);
>>> +    } else {
>>> +        s =3D virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)=
 ? 2 : 0;
>>> +        return offsetof(VRingAvail, ring) +
>>> +            sizeof(uint16_t) * vdev->vq[n].vring.num + s;
>> I tend to move this to an independent patch.
> You mean this two functions?
>
> Wei
>

I mean moving the adding of event to get_avail()/get_used().

Thanks
