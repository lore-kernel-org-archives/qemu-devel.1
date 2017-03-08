Received: from eggs.gnu.org ([2001:4830:134:3::10]:35958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1clSnM-0003H8-2K
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 23:01:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1clSnJ-00036G-0i
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 23:01:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1clSnI-00035s-RO
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 23:01:44 -0500
Date: Wed, 8 Mar 2017 06:01:40 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170308060131-mutt-send-email-mst@kernel.org>
References: <1488519630-89058-1-git-send-email-wei.w.wang@intel.com>
	<1488519630-89058-3-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488519630-89058-3-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v7 kernel 2/5] virtio-balloon:
 VIRTIO_BALLOON_F_CHUNK_TRANSFER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Liang Li <liang.z.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Amit Shah <amit.shah@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, Liang Li <liliang324@gmail.com>

On Fri, Mar 03, 2017 at 01:40:27PM +0800, Wei Wang wrote:
> From: Liang Li <liang.z.li@intel.com>
> 
> Add a new feature bit, VIRTIO_BALLOON_F_CHUNK_TRANSFER. Please check
> the implementation patch commit for details about this feature.


better squash into next patch.

> Signed-off-by: Liang Li <liang.z.li@intel.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Amit Shah <amit.shah@redhat.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Liang Li <liliang324@gmail.com>
> Cc: Wei Wang <wei.w.wang@intel.com>
> ---
>  include/uapi/linux/virtio_balloon.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index 343d7dd..ed627b2 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -34,10 +34,14 @@
>  #define VIRTIO_BALLOON_F_MUST_TELL_HOST	0 /* Tell before reclaiming pages */
>  #define VIRTIO_BALLOON_F_STATS_VQ	1 /* Memory Stats virtqueue */
>  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
> +#define VIRTIO_BALLOON_F_CHUNK_TRANSFER	3 /* Transfer pages in chunks */
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
>  
> +/* Shift to get a chunk size */
> +#define VIRTIO_BALLOON_CHUNK_SIZE_SHIFT 12
> +
>  struct virtio_balloon_config {
>  	/* Number of pages host wants Guest to give up. */
>  	__u32 num_pages;
> @@ -82,4 +86,12 @@ struct virtio_balloon_stat {
>  	__virtio64 val;
>  } __attribute__((packed));
>  
> +/* Response header structure */
> +struct virtio_balloon_resp_hdr {
> +	u8 cmd;
> +	u8 flag;
> +	__le16 id; /* cmd id */
> +	__le32 data_len; /* Payload len in bytes */
> +};
> +
>  #endif /* _LINUX_VIRTIO_BALLOON_H */
> -- 
> 2.7.4
