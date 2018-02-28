Received: from eggs.gnu.org ([2001:4830:134:3::10]:56934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1er6xi-0000Qa-Qh
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:00:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1er6xc-0004pT-HU
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:00:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51260 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1er6xc-0004p3-99
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:00:16 -0500
Date: Wed, 28 Feb 2018 19:00:03 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180228190003.GM2981@work-vm>
References: <1519810529-4034-1-git-send-email-hejianet@gmail.com>
	<1519810529-4034-2-git-send-email-hejianet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519810529-4034-2-git-send-email-hejianet@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] vhost: fix incorrect check in
 vhost_verify_ring_mappings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jia He <hejianet@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Jia He <jia.he@hxt-semitech.com>

* Jia He (hejianet@gmail.com) wrote:
> In commit 0ca1fd2d6878 ("vhost: Simplify ring verification checks"),
> it checks the virtqueue desc mapping for 3 times.
> 
> Fixed: commit 0ca1fd2d6878 ("vhost: Simplify ring verification checks")
> Signed-off-by: Jia He <jia.he@hxt-semitech.com>

Oops, well spotted; copy & paste strikes again.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hw/virtio/vhost.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 00f2512..bbf6c0c 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -359,7 +359,7 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
>  
>          j++;
>          r = vhost_verify_ring_part_mapping(
> -                vq->desc, vq->desc_phys, vq->desc_size,
> +                vq->avail, vq->avail_phys, vq->avail_size,
>                  reg_hva, reg_gpa, reg_size);
>          if (r) {
>              break;
> @@ -367,7 +367,7 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
>  
>          j++;
>          r = vhost_verify_ring_part_mapping(
> -                vq->desc, vq->desc_phys, vq->desc_size,
> +                vq->used, vq->used_phys, vq->used_size,
>                  reg_hva, reg_gpa, reg_size);
>          if (r) {
>              break;
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
