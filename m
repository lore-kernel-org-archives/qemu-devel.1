Received: from eggs.gnu.org ([2001:4830:134:3::10]:53977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ez1wG-000352-LR
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 11:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ez1wB-0002bq-QY
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 11:15:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34278 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ez1wB-0002bG-ME
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 11:15:31 -0400
Date: Thu, 22 Mar 2018 17:15:30 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180322171450-mutt-send-email-mst@kernel.org>
References: <20180319071537.28649-1-tiwei.bie@intel.com>
	<20180319071537.28649-6-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319071537.28649-6-tiwei.bie@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/6] vfio: remove DPRINTF() definition
 from vfio-common.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com

On Mon, Mar 19, 2018 at 03:15:36PM +0800, Tiwei Bie wrote:
> This macro isn't used by any VFIO code. And its name is
> too generic. The vfio-common.h (in include/hw/vfio) can
> be included by other modules in QEMU. It can introduce
> conflicts.
> 
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>

This one can go ahead immediately.
Try posting as a separate patch.

> ---
>  include/hw/vfio/vfio-common.h | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b820f7984c..f6aa4ae959 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -34,15 +34,6 @@
>  #define ERR_PREFIX "vfio error: %s: "
>  #define WARN_PREFIX "vfio warning: %s: "
>  
> -/*#define DEBUG_VFIO*/
> -#ifdef DEBUG_VFIO
> -#define DPRINTF(fmt, ...) \
> -    do { fprintf(stderr, "vfio: " fmt, ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) \
> -    do { } while (0)
> -#endif
> -
>  enum {
>      VFIO_DEVICE_TYPE_PCI = 0,
>      VFIO_DEVICE_TYPE_PLATFORM = 1,
> -- 
> 2.11.0
