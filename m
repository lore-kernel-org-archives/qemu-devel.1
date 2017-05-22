Received: from eggs.gnu.org ([2001:4830:134:3::10]:60565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dCr4L-0004RY-Rj
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:24:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dCr4L-0002AU-3g
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:24:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dCr4K-00029u-TI
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:24:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2766C8AE7E
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 17:24:31 +0000 (UTC)
Date: Mon, 22 May 2017 20:24:23 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170522202344-mutt-send-email-mst@kernel.org>
References: <20170520080658.337-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170520080658.337-1-maxime.coquelin@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vhost_net: do not expose MTU feature bit
 to kernel backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: aconole@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org

On Sat, May 20, 2017 at 10:06:58AM +0200, Maxime Coquelin wrote:
> This patch removes MTU from the list of features supported by
> the kernel backend, so that vhost kernel backend does not have
> to advertise it to be negotiated.
> 
> Cc: Aaron Conole <aconole@redhat.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

This will break cross-version migration when the kernel
does not advertise it though. I'm afraid we'll need
a compat flag.

> ---
>  hw/net/vhost_net.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index 22874a9..bdd8633 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -51,7 +51,6 @@ static const int kernel_feature_bits[] = {
>      VIRTIO_RING_F_EVENT_IDX,
>      VIRTIO_NET_F_MRG_RXBUF,
>      VIRTIO_F_VERSION_1,
> -    VIRTIO_NET_F_MTU,
>      VIRTIO_F_IOMMU_PLATFORM,
>      VHOST_INVALID_FEATURE_BIT
>  };
> -- 
> 2.9.3
