Received: from eggs.gnu.org ([2001:4830:134:3::10]:48256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=3542bc4e9=anthony.perard@citrix.com>)
	id 1dTVaM-0007UN-HL
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=3542bc4e9=anthony.perard@citrix.com>)
	id 1dTVaH-0005UR-S1
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:54:26 -0400
Received: from smtp.citrix.com ([66.165.176.89]:20487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=3542bc4e9=anthony.perard@citrix.com>)
	id 1dTVaH-0005TI-ML
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:54:21 -0400
Date: Fri, 7 Jul 2017 16:54:19 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170707155419.GC1609@perard.uk.xensource.com>
References: <1499262995-11621-1-git-send-email-anoob.soman@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1499262995-11621-1-git-send-email-anoob.soman@citrix.com>
Subject: Re: [Qemu-devel] [PATCH] xen/pt: Fixup addr validation in
 xen_pt_pci_config_access_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anoob Soman <anoob.soman@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, sstabellini@kernel.org

On Wed, Jul 05, 2017 at 02:56:35PM +0100, Anoob Soman wrote:
> xen_pt_pci_config_access_check checks if addr >= 0xFF. 0xFF is a valid
> address and should not be ignored.
> 
> Signed-off-by: Anoob Soman <anoob.soman@citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

> ---
>  hw/xen/xen_pt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
> index b6d71bb..375efa6 100644
> --- a/hw/xen/xen_pt.c
> +++ b/hw/xen/xen_pt.c
> @@ -85,7 +85,7 @@ void xen_pt_log(const PCIDevice *d, const char *f, ...)
>  static int xen_pt_pci_config_access_check(PCIDevice *d, uint32_t addr, int len)
>  {
>      /* check offset range */
> -    if (addr >= 0xFF) {
> +    if (addr > 0xFF) {
>          XEN_PT_ERR(d, "Failed to access register with offset exceeding 0xFF. "
>                     "(addr: 0x%02x, len: %d)\n", addr, len);
>          return -1;

-- 
Anthony PERARD
