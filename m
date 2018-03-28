Received: from eggs.gnu.org ([2001:4830:134:3::10]:36799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f0ztB-0005E9-5r
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 21:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f0zt7-00054W-7K
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 21:28:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42934 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f0zt7-00054A-3J
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 21:28:29 -0400
Date: Wed, 28 Mar 2018 04:28:19 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180328042815-mutt-send-email-mst@kernel.org>
References: <20180328011953.19496-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328011953.19496-1-tiwei.bie@intel.com>
Subject: Re: [Qemu-devel] [PATCH] vfio: remove DPRINTF() definition from
 vfio-common.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: alex.williamson@redhat.com, qemu-devel@nongnu.org

On Wed, Mar 28, 2018 at 09:19:53AM +0800, Tiwei Bie wrote:
> This macro isn't used by any VFIO code. And its name is
> too generic. The vfio-common.h (in include/hw/vfio) can
> be included by other modules in QEMU. It can introduce
> conflicts.
> 
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/hw/vfio/vfio-common.h | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index d9360148e6..cecbd4e386 100644
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
