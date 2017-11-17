Received: from eggs.gnu.org ([2001:4830:134:3::10]:50490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFgdD-000319-40
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:24:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eFgd9-0003cJ-2C
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:24:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eFgd8-0003bK-Sj
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:24:26 -0500
Date: Fri, 17 Nov 2017 15:24:21 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171117152342-mutt-send-email-mst@kernel.org>
References: <1510899865-40323-1-git-send-email-chao.gao@intel.com>
	<1510899865-40323-2-git-send-email-chao.gao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510899865-40323-2-git-send-email-chao.gao@intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] i386/msi: Correct mask of
 destination ID in MSI address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chao Gao <chao.gao@intel.com>
Cc: qemu-devel@nongnu.org, Anthony Perard <anthony.perard@citrix.com>, Peter Xu <peterx@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>

On Fri, Nov 17, 2017 at 02:24:23PM +0800, Chao Gao wrote:
> According to SDM 10.11.1, only [19:12] bits of MSI address are
> Destination ID, change the mask to avoid ambiguity for VT-d spec
> has used the bit 4 to indicate a remappable interrupt request.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Do you want me to merge this?

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
