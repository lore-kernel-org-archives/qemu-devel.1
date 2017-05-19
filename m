Received: from eggs.gnu.org ([2001:4830:134:3::10]:51085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dBccf-0004hR-Qn
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dBccb-0008SH-Vt
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:46:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dBccb-0008Rd-OV
	for qemu-devel@nongnu.org; Fri, 19 May 2017 03:46:49 -0400
References: <20170511123246.31308-1-maxime.coquelin@redhat.com>
	<20170511123246.31308-7-maxime.coquelin@redhat.com>
	<20170517194401-mutt-send-email-mst@kernel.org>
	<63eaa3cf-1114-0ab2-da05-9f2731464c83@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <aea73610-1b28-3ac9-4787-36b0f70c07f1@redhat.com>
Date: Fri, 19 May 2017 15:46:36 +0800
MIME-Version: 1.0
In-Reply-To: <63eaa3cf-1114-0ab2-da05-9f2731464c83@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] spec/vhost-user spec: Add IOMMU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, peterx@redhat.com, marcandre.lureau@gmail.com, wexu@redhat.com, vkaplans@redhat.com, jfreiman@redhat.com



On 2017=E5=B9=B405=E6=9C=8818=E6=97=A5 16:43, Maxime Coquelin wrote:
>>>
>>> +When the VHOST_USER_PROTOCOL_F_SLAVE_REQ is supported by the slave,=20
>>> and the
>>> +master initiated the slave to master communication channel using the
>>> +VHOST_USER_SET_SLAVE_REQ_FD request, the slave can send IOTLB miss=20
>>> and access
>>> +failure events by sending VHOST_USER_SLAVE_IOTLB_MSG requests to=20
>>> the master
>>> +with a struct vhost_iotlb_msg payload. For miss events, the iotlb=20
>>> payload has
>>> +to be filled with the miss message type (1), the I/O virtual=20
>>> address and the
>>> +permissions flags. For access failure event, the iotlb payload has=20
>>> to be
>>> +filled with the access failure message type (4), the I/O virtual=20
>>> address and
>>> +the permissions flags.
>>
>> I don't think slave should cache invalid entries. If it does not,
>> how can it detect access failure as opposed to a miss?
>
> Of course, invalid cache entries should not be cached.
> The VHOST_IOTLB_ACCESS_FAIL has been specified for the Kernel backend,
> even if the latter does not implement it yet.=20

Yes, I leave this for future use e.g reporting copy_to_user() failure to=20
userspace.

Thanks
