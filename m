Received: from eggs.gnu.org ([2001:4830:134:3::10]:51248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dW1Ye-0005oJ-Ua
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dW1YZ-0007UA-Tf
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:27:04 -0400
Date: Fri, 14 Jul 2017 17:26:44 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170714172631-mutt-send-email-mst@kernel.org>
References: <1500035226-6530-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500035226-6530-1-git-send-email-jasowang@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-net: fix offload ctrl endian
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Dmitry Fleytman <dfleytma@redhat.com>

On Fri, Jul 14, 2017 at 08:27:06PM +0800, Jason Wang wrote:
> Spec said offloads should be le64, so use virtio_ldq_p() to guarantee
> valid endian.
> 
> Fixes: 644c98587d4c ("virtio-net: dynamic network offloads configuration")
> Cc: qemu-stable@nongnu.org
> Cc: Dmitry Fleytman <dfleytma@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/net/virtio-net.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 657d099..eb8f5b6 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -757,6 +757,7 @@ static int virtio_net_handle_offloads(VirtIONet *n, uint8_t cmd,
>  
>      if (cmd == VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET) {
>          uint64_t supported_offloads;

An empty line wouldn't hurt here.

> +        offloads = virtio_ldq_p(vdev, &offloads);
>  
>          if (!n->has_vnet_hdr) {
>              return VIRTIO_NET_ERR;
> -- 
> 2.7.4
