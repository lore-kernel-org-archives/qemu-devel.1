Received: from eggs.gnu.org ([2001:4830:134:3::10]:45652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cR8k8-0004wH-Ad
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:34:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cR8k5-00068K-83
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:34:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cR8k5-00067W-1n
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:34:25 -0500
References: <1483092559-24488-1-git-send-email-jasowang@redhat.com>
	<1483092559-24488-11-git-send-email-jasowang@redhat.com>
	<20170110065459-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3f506d7a-d8f2-795e-43c8-06e9c16c2c6a@redhat.com>
Date: Wed, 11 Jan 2017 10:34:16 +0800
MIME-Version: 1.0
In-Reply-To: <20170110065459-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V4 10/10] vhost_net: device IOTLB support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, vkaplans@redhat.com, wexu@redhat.com, cornelia.huck@de.ibm.com, pbonzini@redhat.com



On 2017=E5=B9=B401=E6=9C=8810=E6=97=A5 12:55, Michael S. Tsirkin wrote:
> On Fri, Dec 30, 2016 at 06:09:19PM +0800, Jason Wang wrote:
>> This patches implements Device IOTLB support for vhost kernel. This is
>> done through:
>>
>> 1) switch to use dma helpers when map/unmap vrings from vhost codes
>> 2) introduce a set of VhostOps to:
>>     - setting up device IOTLB request callback
>>     - processing device IOTLB request
>>     - processing device IOTLB invalidation
>> 2) kernel support for Device IOTLB API:
>>
>> - allow vhost-net to query the IOMMU IOTLB entry through eventfd
>> - enable the ability for qemu to update a specified mapping of vhost
>> - through ioctl.
>> - enable the ability to invalidate a specified range of iova for the
>>    device IOTLB of vhost through ioctl. In x86/intel_iommu case this i=
s
>>    triggered through iommu memory region notifier from device IOTLB
>>    invalidation descriptor processing routine.
>>
>> With all the above, kernel vhost_net can co-operate with userspace
>> IOMMU. For vhost-user, the support could be easily done on top by
>> implementing the VhostOps.
>>
>> Cc: Michael S. Tsirkin<mst@redhat.com>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
> Specifically this patch is the one causing issues.
>
>

Yes, this is because it tries to enable device IOTLB for vhost-user.=20
Will post a new version for this patch.

Thanks
