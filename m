Received: from eggs.gnu.org ([2001:4830:134:3::10]:33906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dVvGi-0002jG-Vi
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dVvGf-0001Yt-UR
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:44:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dVvGf-0001YQ-Ny
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:44:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6C1E8E92A
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:44:04 +0000 (UTC)
References: <ae882d766ec76c57a7babc2798f16a5a31d64358.1499931846.git.mprivozn@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7e36dfeb-1699-2fd8-dd6a-771c6fb3bc98@redhat.com>
Date: Fri, 14 Jul 2017 15:43:57 +0800
MIME-Version: 1.0
In-Reply-To: <ae882d766ec76c57a7babc2798f16a5a31d64358.1499931846.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtion-net: Prefer is_power_of_2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com



On 2017=E5=B9=B407=E6=9C=8813=E6=97=A5 15:44, Michal Privoznik wrote:
> We have a function that checks if given number is power of two.
> We should prefer it instead of expanding the check on our own.
>
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>   hw/net/virtio-net.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 5630a9ec44..657d099c54 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1942,7 +1942,7 @@ static void virtio_net_device_realize(DeviceState=
 *dev, Error **errp)
>        */
>       if (n->net_conf.rx_queue_size < VIRTIO_NET_RX_QUEUE_MIN_SIZE ||
>           n->net_conf.rx_queue_size > VIRTQUEUE_MAX_SIZE ||
> -        (n->net_conf.rx_queue_size & (n->net_conf.rx_queue_size - 1)))=
 {
> +        !is_power_of_2(n->net_conf.rx_queue_size)) {
>           error_setg(errp, "Invalid rx_queue_size (=3D %" PRIu16 "), "
>                      "must be a power of 2 between %d and %d.",
>                      n->net_conf.rx_queue_size, VIRTIO_NET_RX_QUEUE_MIN=
_SIZE,

Applied.

Thanks
