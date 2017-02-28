Received: from eggs.gnu.org ([2001:4830:134:3::10]:46008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cij7K-0006Mi-L3
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:51:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cij7F-00042G-Kz
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:51:06 -0500
References: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
	<1487715299-21102-2-git-send-email-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7ba0b043-f299-1d35-a699-b41740248287@redhat.com>
Date: Tue, 28 Feb 2017 15:50:55 +0100
MIME-Version: 1.0
In-Reply-To: <1487715299-21102-2-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/9] sysemu: add defines for sparc & ppc
 graphics_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 21.02.2017 23:14, Gerd Hoffmann wrote:
> Add defines for the sparc and ppc arch specific graphics defaults.
> They return the graphic_* values these variables are non-zero, and
> the default values otherwise.
> 
> After switching over ppc and sparc to use these we don't need the
> arch-specific initialization for the graphic_* variables any more.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/sysemu/sysemu.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 576c7ce..9450788 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -142,9 +142,16 @@ typedef enum {
>  extern int vga_interface_type;
>  #define xenfb_enabled (vga_interface_type == VGA_XENFB)
>  
> +#define sparc_graphic_width  (graphic_width  ? graphic_width  : 1024)
> +#define sparc_graphic_height (graphic_height ? graphic_height :  768)
> +#define sparc_graphic_depth  (graphic_depth  ? graphic_depth  :    8)
> +#define ppc_graphic_width    (graphic_width  ? graphic_width  :  800)
> +#define ppc_graphic_height   (graphic_height ? graphic_height :  600)
> +#define ppc_graphic_depth    (graphic_depth  ? graphic_depth  :   32)

I have to say that I really dislike the idea to hide this logic in such
macros. Could we please do it without such macros, i.e. by just adding
some code a la
	if (!graphic_width) {
		graphic_width = 800;
	}
to the right machine_init() functions instead?

 Thomas
