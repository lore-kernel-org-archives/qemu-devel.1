Received: from eggs.gnu.org ([2001:4830:134:3::10]:51705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eretf-0007ih-CZ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 02:14:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eretb-0006gX-DH
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 02:14:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42278 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eretb-0006fn-8x
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 02:14:23 -0500
References: <cover.1519961667.git.jbaron@akamai.com>
	<c9d3cf2fbc3c64bb28e0438185d85d95b2088127.1519961667.git.jbaron@akamai.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7fc612d0-9610-9b07-d054-bb1438898f47@redhat.com>
Date: Fri, 2 Mar 2018 15:14:01 +0800
MIME-Version: 1.0
In-Reply-To: <c9d3cf2fbc3c64bb28e0438185d85d95b2088127.1519961667.git.jbaron@akamai.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] virtio-net: add linkspeed and duplex
 settings to virtio-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Baron <jbaron@akamai.com>, mst@redhat.com
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org



On 2018=E5=B9=B403=E6=9C=8802=E6=97=A5 11:46, Jason Baron wrote:
> Although linkspeed and duplex can be set in a linux guest via 'ethtool =
-s',
> this requires custom ethtool commands for virtio-net by default.
>
> Introduce a new feature flag, VIRTIO_NET_F_SPEED_DUPLEX, which allows
> the hypervisor to export a linkspeed and duplex setting. The user can
> subsequently overwrite it later if desired via: 'ethtool -s'.
>
> Linkspeed and duplex settings can be set as:
> '-device virtio-net,speed=3D10000,duplex=3Dfull'

I was thinking whether or not it's better to decide the duplex by the=20
type of backends.

E.g userspace and vhost-kernel implement a in fact half duplex. But dpdk=20
implement a full duplex.

Thanks

>
> where speed is [0...INT_MAX], and duplex is ["half"|"full"].
>
> Signed-off-by: Jason Baron<jbaron@akamai.com>
> Cc: "Michael S. Tsirkin"<mst@redhat.com>
> Cc: Jason Wang<jasowang@redhat.com>
> Cc:virtio-dev@lists.oasis-open.org
> ---
