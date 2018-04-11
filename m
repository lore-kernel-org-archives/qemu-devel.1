Received: from eggs.gnu.org ([2001:4830:134:3::10]:49691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f6AhD-0008MH-1k
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 04:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f6Ah7-00089V-GZ
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 04:01:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44476 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f6Ah7-00088n-CO
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 04:01:29 -0400
References: <20180411072027.5656-1-tiwei.bie@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fc66437c-ae8c-15fa-c8d3-6aa6bdb22a36@redhat.com>
Date: Wed, 11 Apr 2018 16:01:19 +0800
MIME-Version: 1.0
In-Reply-To: <20180411072027.5656-1-tiwei.bie@intel.com>
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
To: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org
Cc: dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com



On 2018=E5=B9=B404=E6=9C=8811=E6=97=A5 15:20, Tiwei Bie wrote:
> This patch introduces VHOST_USER_PROTOCOL_F_NEED_ALL_IOTLB
> feature for vhost-user. By default, vhost-user backend needs
> to query the IOTLBs from QEMU after meeting unknown IOVAs.
> With this protocol feature negotiated, QEMU will provide all
> the IOTLBs to vhost-user backend without waiting for the
> queries from backend. This is helpful when using a hardware
> accelerator which is not able to handle unknown IOVAs at the
> vhost-user backend.
>
> Signed-off-by: Tiwei Bie<tiwei.bie@intel.com>
> ---
> The idea of this patch is to let QEMU push all the IOTLBs
> to vhost-user backend without waiting for the queries from
> the backend. Because hardware accelerator at the vhost-user
> backend may not be able to handle unknown IOVAs.
>
> This is just a RFC for now. It seems that, it doesn't work
> as expected when guest is using kernel driver (To handle
> this case, it seems that some RAM regions' events also need
> to be listened). Any comments would be appreciated! Thanks!

Interesting, a quick question is why this is needed? Can we just use=20
exist IOTLB update message?

It looks to me at least kernel does not need this.

Thanks
