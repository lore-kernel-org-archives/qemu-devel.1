Received: from eggs.gnu.org ([2001:4830:134:3::10]:46107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eevAp-0006MO-5x
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 22:59:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eevAm-0006U9-4k
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 22:59:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eevAm-0006Te-0S
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 22:59:28 -0500
References: <20180125040328.22867-1-tiwei.bie@intel.com>
	<20180125040328.22867-7-tiwei.bie@intel.com>
	<20180126015553-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <28ab37d5-6cf6-866d-9167-e14e7441415f@redhat.com>
Date: Fri, 26 Jan 2018 11:41:27 +0800
MIME-Version: 1.0
In-Reply-To: <20180126015553-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v1 6/6] vhost-user: add
 VFIO based accelerators support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, alex.williamson@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com



On 2018=E5=B9=B401=E6=9C=8826=E6=97=A5 07:59, Michael S. Tsirkin wrote:
>> The virtual IOMMU isn't supported by the accelerators for now.
>> Because vhost-user currently lacks of an efficient way to share
>> the IOMMU table in VM to vhost backend. That's why the software
>> implementation of virtual IOMMU support in vhost-user backend
>> can't support dynamic mapping well.
> What exactly is meant by that? vIOMMU seems to work for people,
> it's not that fast if you change mappings all the time,
> but e.g. dpdk within guest doesn't.

Yes, software implementation support dynamic mapping for sure. I think=20
the point is, current vhost-user backend can not program hardware IOMMU.=20
So it can not let hardware accelerator to cowork with software vIOMMU. I=20
think that's another call to implement the offloaded path inside qemu=20
which has complete support for vIOMMU co-operated VFIO.

Thanks

>
>> Once this problem is solved
>> in vhost-user, virtual IOMMU can be supported by accelerators
>> too, and the IOMMU feature bit checking in this patch can be
>> removed.
> Given it works with software backends right now, I suspect
> this will be up to you guys to address.
>
