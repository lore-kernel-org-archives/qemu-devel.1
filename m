Received: from eggs.gnu.org ([2001:4830:134:3::10]:54724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gPfyg-0001fe-Nn
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 22:48:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gPfyd-0000WS-BD
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 22:48:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gPfyd-0000UK-44
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 22:48:27 -0500
Date: Thu, 22 Nov 2018 11:46:56 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20181122034656.GB27426@wei-ubt>
References: <1539266915-15216-1-git-send-email-wexu@redhat.com>
	<1539266915-15216-13-git-send-email-wexu@redhat.com>
	<1e29f314-f227-55ad-23f0-353dab8e7f98@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e29f314-f227-55ad-23f0-353dab8e7f98@redhat.com>
Subject: Re: [Qemu-devel] [[RFC v3 12/12] virtio: feature vhost-net support
 for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com

On Wed, Nov 21, 2018 at 02:03:59PM +0100, Maxime Coquelin wrote:
> Hi Wei,
> 
> On 10/11/18 4:08 PM, wexu@redhat.com wrote:
> >From: Wei Xu <wexu@redhat.com>
> >
> >(cherry picked from commit 305a2c4640c15c5717245067ab937fd10f478ee6)
> >Signed-off-by: Wei Xu <wexu@redhat.com>
> >(cherry picked from commit 46476dae6f44c6fef8802a4a0ac7d0d79fe399e3)
> >Signed-off-by: Wei Xu <wexu@redhat.com>
> >---
> >  hw/virtio/vhost.c          | 3 +++
> >  hw/virtio/virtio.c         | 4 ++++
> >  include/hw/virtio/virtio.h | 1 +
> >  3 files changed, 8 insertions(+)
> >
> >diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >index 9df2da3..de06d55 100644
> >--- a/hw/virtio/vhost.c
> >+++ b/hw/virtio/vhost.c
> >@@ -974,6 +974,9 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
> >      }
> >      state.num = virtio_queue_get_last_avail_idx(vdev, idx);
> >+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> >+        state.num |= ((int)virtio_queue_packed_get_wc(vdev, idx)) << 31;
> 
> For next version, please note that we agreed to move the wrap counter
> value at bit 15. DPDK vhost lib implemented it that way.

Yes, I have revised it in my next version, thanks for remindering.

> 
