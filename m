Received: from eggs.gnu.org ([2001:4830:134:3::10]:52511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH46M-00043m-UU
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH46H-0007yj-Vy
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:44:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gH46H-0007wd-O0
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:44:45 -0400
Date: Mon, 29 Oct 2018 10:44:36 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181029094436.uuwiievt25fvlbu6@sirius.home.kraxel.org>
References: <20181022080053.9379-1-yuchenlin@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022080053.9379-1-yuchenlin@synology.com>
Subject: Re: [Qemu-devel] [PATCH] vga_int: remove unused function protype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuchenlin@synology.com
Cc: qemu-devel@nongnu.org

On Mon, Oct 22, 2018 at 04:00:53PM +0800, yuchenlin@synology.com wrote:
> From: yuchenlin <yuchenlin@synology.com>
> 
> Signed-off-by: yuchenlin <yuchenlin@synology.com>
> ---
>  hw/display/vga_int.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
> index 6e4fa48a79..55c418eab5 100644
> --- a/hw/display/vga_int.h
> +++ b/hw/display/vga_int.h
> @@ -166,7 +166,6 @@ MemoryRegion *vga_init_io(VGACommonState *s, Object *obj,
>                            const MemoryRegionPortio **vbe_ports);
>  void vga_common_reset(VGACommonState *s);
>  
> -void vga_sync_dirty_bitmap(VGACommonState *s);
>  void vga_dirty_log_start(VGACommonState *s);
>  void vga_dirty_log_stop(VGACommonState *s);

Added to vga queue.

thanks,
  Gerd
