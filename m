Received: from eggs.gnu.org ([2001:4830:134:3::10]:57205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f6G1N-000447-DK
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f6G1K-0000aI-8O
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:42:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37380 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f6G1K-0000a0-3t
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:42:42 -0400
References: <20180411072027.5656-1-tiwei.bie@intel.com>
	<20180411161926-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b8e19751-9cb8-331d-a464-35babdfb9ca2@redhat.com>
Date: Wed, 11 Apr 2018 21:42:36 +0800
MIME-Version: 1.0
In-Reply-To: <20180411161926-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] vhost-user: introduce F_NEED_ALL_IOTLB
 protocol feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>
Cc: peterx@redhat.com, qemu-devel@nongnu.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com



On 2018=E5=B9=B404=E6=9C=8811=E6=97=A5 21:22, Michael S. Tsirkin wrote:
> On Wed, Apr 11, 2018 at 03:20:27PM +0800, Tiwei Bie wrote:
>> This patch introduces VHOST_USER_PROTOCOL_F_NEED_ALL_IOTLB
>> feature for vhost-user. By default, vhost-user backend needs
>> to query the IOTLBs from QEMU after meeting unknown IOVAs.
>> With this protocol feature negotiated, QEMU will provide all
>> the IOTLBs to vhost-user backend without waiting for the
>> queries from backend. This is helpful when using a hardware
>> accelerator which is not able to handle unknown IOVAs at the
>> vhost-user backend.
>>
>> Signed-off-by: Tiwei Bie<tiwei.bie@intel.com>
> This is potentially a large amount of data to be sent
> on a socket.
>
> I had an impression that a hardware accelerator was using
> VFIO anyway. Given this, can't we have QEMU program
> the shadow IOMMU tables into VFIO directly?
>
>

So if we want to do this, my understanding is we need to implement the=20
driver inside qemu (or link it to qemu).

Thanks
