Received: from eggs.gnu.org ([2001:4830:134:3::10]:46544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e9Bdi-0005fo-R8
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 11:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e9Bdc-0000Xv-BY
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 11:06:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e9Bdc-0000Wz-2v
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 11:06:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 98DFC49010
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 15:06:02 +0000 (UTC)
Date: Mon, 30 Oct 2017 15:05:57 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171030150556.GA8941@work-vm>
References: <20171030102830.4469-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171030102830.4469-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vga: fix region checks in wraparound case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

* Gerd Hoffmann (kraxel@redhat.com) wrote:
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Makes more sense to me;


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hw/display/vga.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index 1d19f6b..a64a094 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -1666,9 +1666,9 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
>              /* scanline wraps from end of video memory to the start */
>              assert(force_shadow);
>              update = memory_region_snapshot_get_dirty(&s->vram, snap,
> -                                                      page0, 0);
> +                                                      page0, s->vbe_size - page0);
>              update |= memory_region_snapshot_get_dirty(&s->vram, snap,
> -                                                       page1, 0);
> +                                                       0, page1);
>          } else {
>              update = memory_region_snapshot_get_dirty(&s->vram, snap,
>                                                        page0, page1 - page0);
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
