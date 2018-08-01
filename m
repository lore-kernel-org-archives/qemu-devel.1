Received: from eggs.gnu.org ([2001:4830:134:3::10]:57456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1fl0ru-00008u-Tq
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 19:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1fl0rt-0002AJ-VO
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 19:49:26 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:33599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lepton@google.com>) id 1fl0rt-00029Z-Pb
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 19:49:25 -0400
Received: by mail-vk0-x242.google.com with SMTP id y70-v6so193949vkc.0
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 16:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180726225900.180698-1-lepton@google.com>
In-Reply-To: <20180726225900.180698-1-lepton@google.com>
From: =?UTF-8?B?VGFvIFd1KOWQtOa2m0BFbmcp?= <lepton@google.com>
Date: Thu, 2 Aug 2018 07:49:12 +0800
Message-ID: <CAOvqHj5=MUV6MEBqZ-eX0A9_+kHXyrjH9qz3gTASD8NFjx5WKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] sdl2: redraw correctly when scanout_mode
 enabled.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>, kraxel@redhat.com

On Fri, Jul 27, 2018 at 6:59 AM Tao Wu <lepton@google.com> wrote:
>
> When scanout_mode enabled, surface is out of sync with actual screen.
> In such case, we just call sdl2_gl_scanout_flush to do redraw. This
> fixes bug reported in
> https://lists.freedesktop.org/archives/virglrenderer-devel/2018-July/001330.html
>
> Signed-off-by: Tao Wu <lepton@google.com>
> ---
>  ui/sdl2-gl.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
> index 83b71853d1..1bf4542d8d 100644
> --- a/ui/sdl2-gl.c
> +++ b/ui/sdl2-gl.c
> @@ -124,6 +124,11 @@ void sdl2_gl_redraw(struct sdl2_console *scon)
>  {
>      assert(scon->opengl);
>
> +    if (scon->scanout_mode) {
> +        /* sdl2_gl_scanout_flush actually only care about
> +         * the first argument. */
> +        return sdl2_gl_scanout_flush(&scon->dcl, 0, 0, 0, 0);
> +    }
>      if (scon->surface) {
>          sdl2_gl_render_surface(scon);
>      }
> --
> 2.18.0.345.g5c9ce644c3-goog
>
Ping, thanks!
