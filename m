Received: from eggs.gnu.org ([2001:4830:134:3::10]:50629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCPnU-0000Ky-7c
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:49:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCPnT-0001ea-DW
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:49:36 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171002124052.13829-1-anthoine.bourgeois@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4f219f7b-d680-7a46-8832-5a1aaf509783@amsat.org>
Date: Wed, 8 Nov 2017 09:49:26 -0300
MIME-Version: 1.0
In-Reply-To: <20171002124052.13829-1-anthoine.bourgeois@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] gtk: fix wrong id between texture and
 framebuffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>

Hi Anthoine,

Cc'ing Gerd Hoffmann who is the maintainer of this file.

See
https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maintainer:

$ ./scripts/get_maintainer.pl -f ui/gtk-gl-area.c
Gerd Hoffmann <kraxel@redhat.com> (odd fixer:Graphics)

On 10/02/2017 09:40 AM, Anthoine Bourgeois wrote:
> From: Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>
> 
> The gd_gl_area_scanout_texture must destroy framebuffer if there is
> no texture id instead of no framebuffer id.
> The effect was a black screen with "-vga virtio -display gtk,gl=on"
> options.
> The bug was introduce by a4f113fd "gtk: use framebuffer helper functions."
> 
> Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>
> ---
>  ui/gtk-gl-area.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index 18b298f..026b7d7 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -178,8 +178,7 @@ void gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
>  
>      gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
>  
> -    if (vc->gfx.guest_fb.framebuffer  == 0 ||
> -        vc->gfx.w == 0 || vc->gfx.h == 0) {
> +    if (backing_id == 0 || vc->gfx.w == 0 || vc->gfx.h == 0) {
>          gtk_gl_area_set_scanout_mode(vc, false);
>          return;
>      }
> 
