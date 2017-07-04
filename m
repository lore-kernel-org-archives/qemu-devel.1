Received: from eggs.gnu.org ([2001:4830:134:3::10]:58382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dSDcu-0006zA-21
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 22:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dSDcq-0003mY-Uh
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 22:31:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dSDcq-0003kH-PN
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 22:31:40 -0400
Date: Tue, 4 Jul 2017 10:31:34 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170704023134.GE32003@pxdev.xzpeter.org>
References: <1498715394-16402-1-git-send-email-tianyu.lan@intel.com>
	<1498715394-16402-2-git-send-email-tianyu.lan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org, xen-devel@lists.xensource.com, kevin.tian@intel.com, sstabellini@kernel.org, mst@redhat.com, anthony.perard@citrix.com, marcel@redhat.com, Chao Gao <chao.gao@intel.com>

On Thu, Jun 29, 2017 at 01:49:52AM -0400, Lan Tianyu wrote:
> From: Chao Gao <chao.gao@intel.com>
> 
> According to SDM 10.11.1, only [19:12] bits of MSI address are
> Destination ID, change the mask to avoid ambiguity for VT-d spec
> has used the bit 4 to indicate a remappable interrupt request.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

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
> -- 
> 1.8.3.1
> 
> 

-- 
Peter Xu
