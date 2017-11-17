Received: from eggs.gnu.org ([2001:4830:134:3::10]:57518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFXq8-0007pg-TY
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 23:01:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFXq5-0001O1-T7
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 23:01:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eFXq5-0001LB-Md
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 23:01:13 -0500
References: <20171116184835.28556-1-maxime.coquelin@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <61cc035d-9e50-e96c-bc37-5511c6a7dab7@redhat.com>
Date: Fri, 17 Nov 2017 12:01:01 +0800
MIME-Version: 1.0
In-Reply-To: <20171116184835.28556-1-maxime.coquelin@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] virtio-net: Fix TX data discard on
 backend disconnection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, mst@redhat.com, yuri.benditovich@daynix.com, yvugenfi@redhat.com, qemu-devel@nongnu.org



On 2017=E5=B9=B411=E6=9C=8817=E6=97=A5 02:48, Maxime Coquelin wrote:
> This series fixes TX data discard when backend disconnects.
>
> On backend disconnection, QEMU cannot retrieve its internal
> avail index, which makes the virtio queue internal state
> inconsistent (last_avail_idx will always be 0, whereas used_idx
> is correct).
>
> It results in discarding TX data to corrupt the vring state, by
> completing descriptors already completed by the backend.
>
> This series fixes this by restoring last_avail_idx to the vring
> used idx, as some backends used to do on reconnection.
>
> Maxime Coquelin (2):
>    virtio: Add queue interface to restore avail index from vring used
>      index
>    vhost: restore avail index from vring used index on disconnection
>
>   hw/virtio/vhost.c          |  4 ++++
>   hw/virtio/virtio.c         | 10 ++++++++++
>   include/hw/virtio/virtio.h |  1 +
>   3 files changed, 15 insertions(+)
>

Reviewed-by: Jason Wang <jasowang@redhat.com>
