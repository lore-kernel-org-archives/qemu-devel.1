Received: from eggs.gnu.org ([209.51.188.92]:39080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h217E-0005mI-Li
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:03:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h2175-0004Xx-NT
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:03:43 -0500
Date: Thu, 7 Mar 2019 15:03:32 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190307150332.72bde784@w520.home>
In-Reply-To: <20190307050518.64968-3-aik@ozlabs.ru>
References: <20190307050518.64968-1-aik@ozlabs.ru>
	<20190307050518.64968-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v4 2/3] vfio: Make
 vfio_get_region_info_cap public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Gavin Shan <gwshan@linux.vnet.ibm.com>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Leonardo Augusto =?UTF-8?B?R3VpbWFyw6Nlcw==?= Garcia <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>

On Thu,  7 Mar 2019 16:05:17 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> This makes vfio_get_region_info_cap() to be used in quirks.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  include/hw/vfio/vfio-common.h | 2 ++
>  hw/vfio/common.c              | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)


Acked-by: Alex Williamson <alex.williamson@redhat.com>


> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 7624c9f511c4..fbf0966af484 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -189,6 +189,8 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
>  int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
>                               uint32_t subtype, struct vfio_region_info **info);
>  bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
> +struct vfio_info_cap_header *
> +vfio_get_region_info_cap(struct vfio_region_info *info, uint16_t id);
>  #endif
>  extern const MemoryListener vfio_prereg_listener;
>  
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index df2b4721bffb..4374cc6176a2 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -729,7 +729,7 @@ static void vfio_listener_release(VFIOContainer *container)
>      }
>  }
>  
> -static struct vfio_info_cap_header *
> +struct vfio_info_cap_header *
>  vfio_get_region_info_cap(struct vfio_region_info *info, uint16_t id)
>  {
>      struct vfio_info_cap_header *hdr;
