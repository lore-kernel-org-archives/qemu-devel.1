Received: from eggs.gnu.org ([209.51.188.92]:36901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gvztO-0000jR-8W
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:32:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gvztM-0000Ry-7d
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:32:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gvztH-0000PE-V1
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:32:33 -0500
References: <1550118402-4057-1-git-send-email-wexu@redhat.com>
	<1550118402-4057-12-git-send-email-wexu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ba86ca50-73e8-1c06-8ab0-0e8b74aeac58@redhat.com>
Date: Tue, 19 Feb 2019 15:32:19 +0800
MIME-Version: 1.0
In-Reply-To: <1550118402-4057-12-git-send-email-wexu@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 11/11] virtio: CLI and provide packed
 ring feature bit by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, qemu-devel@nongnu.org
Cc: tiwei.bie@intel.com, mst@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com


On 2019/2/14 =E4=B8=8B=E5=8D=8812:26, wexu@redhat.com wrote:
> From: Wei Xu <wexu@redhat.com>
>
> Add userspace and vhost kernel/user support.
>
> Add CLI "ring_packed=3Dtrue/false" to enable/disable packed ring provis=
ion.
> Usage:
>      -device virtio-net-pci,netdev=3Dxx,mac=3Dxx:xx:xx:xx:xx:xx,ring_pa=
cked=3Dfalse
>
> By default it is provided.


Please compat this for old machine types.

Thanks


>
> Signed-off-by: Wei Xu <wexu@redhat.com>
> ---
>   hw/net/vhost_net.c         | 2 ++
>   include/hw/virtio/virtio.h | 4 +++-
>   2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index e037db6..f593086 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -53,6 +53,7 @@ static const int kernel_feature_bits[] =3D {
>       VIRTIO_F_VERSION_1,
>       VIRTIO_NET_F_MTU,
>       VIRTIO_F_IOMMU_PLATFORM,
> +    VIRTIO_F_RING_PACKED,
>       VHOST_INVALID_FEATURE_BIT
>   };
>  =20
> @@ -78,6 +79,7 @@ static const int user_feature_bits[] =3D {
>       VIRTIO_NET_F_MRG_RXBUF,
>       VIRTIO_NET_F_MTU,
>       VIRTIO_F_IOMMU_PLATFORM,
> +    VIRTIO_F_RING_PACKED,
>  =20
>       /* This bit implies RARP isn't sent by QEMU out of band */
>       VIRTIO_NET_F_GUEST_ANNOUNCE,
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 9c1fa07..2eb27d2 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -264,7 +264,9 @@ typedef struct VirtIORNGConf VirtIORNGConf;
>       DEFINE_PROP_BIT64("any_layout", _state, _field, \
>                         VIRTIO_F_ANY_LAYOUT, true), \
>       DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
> -                      VIRTIO_F_IOMMU_PLATFORM, false)
> +                      VIRTIO_F_IOMMU_PLATFORM, false), \
> +    DEFINE_PROP_BIT64("ring_packed", _state, _field, \
> +                      VIRTIO_F_RING_PACKED, true)
>  =20
>   hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
>   hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n);
