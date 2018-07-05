Received: from eggs.gnu.org ([2001:4830:134:3::10]:53279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7170a5bb2=anthony.perard@citrix.com>)
	id 1fb18P-0005sC-6Y
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7170a5bb2=anthony.perard@citrix.com>)
	id 1fb18M-00040c-31
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:05:09 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:30902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=7170a5bb2=anthony.perard@citrix.com>)
	id 1fb18L-0003tl-R1
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:05:06 -0400
Date: Thu, 5 Jul 2018 11:05:01 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180705100501.GB2195@perard.uk.xensource.com>
References: <20180704153919.12432-1-f4bug@amsat.org>
	<20180704153919.12432-5-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180704153919.12432-5-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 4/8] xen: Remove useless casts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Laurent Vivier <laurent@vivier.eu>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, "open list:X86" <xen-devel@lists.xenproject.org>

On Wed, Jul 04, 2018 at 12:39:15PM -0300, Philippe Mathieu-Daudé wrote:
> Patch created mechanically by rerunning:
> 
>   $  spatch --sp-file scripts/coccinelle/typecast.cocci \
>             --macro-file scripts/cocci-macro-file.h \
>             --dir . --in-place
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

> ---
>  hw/xen/xen_pt_config_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
> index aee31c62bb..55a83333f2 100644
> --- a/hw/xen/xen_pt_config_init.c
> +++ b/hw/xen/xen_pt_config_init.c
> @@ -543,7 +543,7 @@ static int xen_pt_exp_rom_bar_reg_write(XenPCIPassthroughState *s,
>  {
>      XenPTRegInfo *reg = cfg_entry->reg;
>      XenPTRegion *base = NULL;
> -    PCIDevice *d = (PCIDevice *)&s->dev;
> +    PCIDevice *d = &s->dev;
>      uint32_t writable_mask = 0;
>      uint32_t throughable_mask = get_throughable_mask(s, reg, valid_mask);
>      pcibus_t r_size = 0;

-- 
Anthony PERARD
