Received: from eggs.gnu.org ([2001:4830:134:3::10]:58938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f6T9V-0000xT-HD
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 23:44:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f6T9P-0001kU-81
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 23:44:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54954 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f6T9P-0001kB-3x
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 23:43:55 -0400
References: <20180411072027.5656-1-tiwei.bie@intel.com>
	<20180411161926-mutt-send-email-mst@kernel.org>
	<20180412011059.yywn73znjdip2cyv@debian>
	<20180412042724-mutt-send-email-mst@kernel.org>
	<20180412013942.egucc4isxkokta7z@debian>
	<20180412044404-mutt-send-email-mst@kernel.org>
	<20180412023505.xftmhguzu7j55nif@debian>
	<20180412061108-mutt-send-email-mst@kernel.org>
	<20180412062216-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9314ebd5-8e92-41b1-efd1-4371177075a0@redhat.com>
Date: Thu, 12 Apr 2018 11:43:41 +0800
MIME-Version: 1.0
In-Reply-To: <20180412062216-mutt-send-email-mst@kernel.org>
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
Cc: cunming.liang@intel.com, qemu-devel@nongnu.org, peterx@redhat.com, zhihong.wang@intel.com, dan.daly@intel.com



On 2018=E5=B9=B404=E6=9C=8812=E6=97=A5 11:35, Michael S. Tsirkin wrote:
>> There are more advantages to using request with PASID:
>>
>> You can use hardware support for nesting, having guest supply 1st leve=
l
>> translation and host second level translation.
>>
>> I actually had an idea to do something like this for AMD
>> and ARM which support nesting even for requests with PASID,
>> having intel benefit too would be nice.
> Something else to consider is implementing PRS capability.
>
>
> In theory this could then go like this:
>
> - get page request from device
> - fetch request from VTD page tables
> - use response to issue a page response message
>
>
> This would match the current vhost-user model.

This requires IOMMU driver can forward this to VFIO and then VFIO can=20
forward it to userspace. Looks like a lot of changes and it would be=20
even slower than what is proposed in this patch.

Thanks
