Received: from eggs.gnu.org ([2001:4830:134:3::10]:52053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=347e3a6fc=anthony.perard@citrix.com>)
	id 1dQwIp-0002QZ-IO
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:49:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=347e3a6fc=anthony.perard@citrix.com>)
	id 1dQwIm-0001Ig-DD
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:49:43 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:31064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=347e3a6fc=anthony.perard@citrix.com>)
	id 1dQwIm-0001IE-6l
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:49:40 -0400
Date: Fri, 30 Jun 2017 14:49:35 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170630134935.GE1598@perard.uk.xensource.com>
References: <1498715394-16402-1-git-send-email-tianyu.lan@intel.com>
	<1498715394-16402-2-git-send-email-tianyu.lan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1498715394-16402-2-git-send-email-tianyu.lan@intel.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] i386/msi: Correct mask of destination
 ID in MSI address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xensource.com, Chao Gao <chao.gao@intel.com>, mst@redhat.com, marcel@redhat.com, sstabellini@kernel.org, kevin.tian@intel.com

On Thu, Jun 29, 2017 at 01:49:52AM -0400, Lan Tianyu wrote:
> From: Chao Gao <chao.gao@intel.com>
> 
> According to SDM 10.11.1, only [19:12] bits of MSI address are
> Destination ID, change the mask to avoid ambiguity for VT-d spec
> has used the bit 4 to indicate a remappable interrupt request.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

> ---
>  include/hw/i386/apic-msidef.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/i386/apic-msidef.h b/include/hw/i386/apic-msidef.h
> index 8b4d4cc..420b411 100644
> --- a/include/hw/i386/apic-msidef.h
> +++ b/include/hw/i386/apic-msidef.h
> @@ -26,6 +26,6 @@
>  
>  #define MSI_ADDR_DEST_ID_SHIFT          12
>  #define MSI_ADDR_DEST_IDX_SHIFT         4
> -#define  MSI_ADDR_DEST_ID_MASK          0x00ffff0
> +#define  MSI_ADDR_DEST_ID_MASK          0x000ff000
>  
>  #endif /* HW_APIC_MSIDEF_H */

-- 
Anthony PERARD
