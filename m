Received: from eggs.gnu.org ([2001:4830:134:3::10]:47512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gWT1i-0003lf-MN
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 16:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gWT1f-0003mh-0X
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 16:23:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gWT1d-0003lM-Ix
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 16:23:38 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5E6DC4902D
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 21:23:35 +0000 (UTC)
Date: Mon, 10 Dec 2018 14:23:32 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20181210142332.44e79f28@x1.home>
In-Reply-To: <20181210182816.2014-3-pbonzini@redhat.com>
References: <20181210182816.2014-1-pbonzini@redhat.com>
	<20181210182816.2014-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/8] vfio: make vfio_address_spaces static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

On Mon, 10 Dec 2018 19:28:10 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> It is not used outside hw/vfio/common.c, so it does not need to
> be extern.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/vfio/common.c              | 2 +-
>  include/hw/vfio/vfio-common.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)

Acked-by: Alex Williamson <alex.williamson@redhat.com>

> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 7c185e5a2e..7aa804ea0b 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -39,7 +39,7 @@
>  
>  struct vfio_group_head vfio_group_list =
>      QLIST_HEAD_INITIALIZER(vfio_group_list);
> -struct vfio_as_head vfio_address_spaces =
> +static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
>      QLIST_HEAD_INITIALIZER(vfio_address_spaces);
>  
>  #ifdef CONFIG_KVM
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 1b434d02f6..127ca47815 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -181,7 +181,6 @@ int vfio_get_device(VFIOGroup *group, const char *name,
>  
>  extern const MemoryRegionOps vfio_region_ops;
>  extern QLIST_HEAD(vfio_group_head, VFIOGroup) vfio_group_list;
> -extern QLIST_HEAD(vfio_as_head, VFIOAddressSpace) vfio_address_spaces;
>  
>  #ifdef CONFIG_LINUX
>  int vfio_get_region_info(VFIODevice *vbasedev, int index,
