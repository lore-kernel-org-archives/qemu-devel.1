Received: from eggs.gnu.org ([209.51.188.92]:57378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gvzE5-0008BE-V4
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:49:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gvzE4-0007PH-Ki
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:49:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gvzE1-0006yz-Rp
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:49:54 -0500
References: <1550118402-4057-1-git-send-email-wexu@redhat.com>
	<1550118402-4057-8-git-send-email-wexu@redhat.com>
	<7d71fb88-2651-41eb-023e-63a11a83cd38@redhat.com>
	<20190218144640.GA28793@wei-ubt>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <71fd17b4-9509-3f13-556d-fc4c3e617e84@redhat.com>
Date: Tue, 19 Feb 2019 14:49:42 +0800
MIME-Version: 1.0
In-Reply-To: <20190218144640.GA28793@wei-ubt>
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
Cc: qemu-devel@nongnu.org, mst@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com


On 2019/2/18 =E4=B8=8B=E5=8D=8810:46, Wei Xu wrote:
>> Do we allow chain more descriptors than vq size in the case of indirec=
t?
>> According to the spec:
>>
>> "
>>
>> The device limits the number of descriptors in a list through a
>> transport-specific and/or device-specific value. If not limited,
>> the maximum number of descriptors in a list is the virt queue
>> size.
>> "
>>
>> This looks possible, so the above is probably wrong if the max number =
of
>> chained descriptors is negotiated through a device specific way.
>>
> OK, I will remove this check, while it is necessary to have a limitatio=
n
> for indirect descriptor anyway, otherwise it is possible to hit an over=
flow
> since presumably u16 is used for most number/size in the spec.
>

Please try to test block and scsi device for you changes as well.

Thanks
