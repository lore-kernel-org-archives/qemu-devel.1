Received: from eggs.gnu.org ([2001:4830:134:3::10]:39804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIVYq-0004zL-94
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIVYm-00081d-9b
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:43:56 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIVYm-00081K-4H
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:43:52 -0400
Received: by mail-qk0-x242.google.com with SMTP id l132-v6so12284215qke.3
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 01:43:52 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180515082319.30723-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <89e20d15-308b-215e-b739-9a40689facfe@amsat.org>
Date: Tue, 15 May 2018 05:43:48 -0300
MIME-Version: 1.0
In-Reply-To: <20180515082319.30723-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] sdl2: move opts assignment into loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 05/15/2018 05:23 AM, Gerd Hoffmann wrote:
> So the opts pointer is set for all sdl2_consoles.
> 
> Fixes: 844fd50dbbcfc9e401895274bf4fb8da8e8d3f64
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  ui/sdl2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index da037248c2..a0f9b16bc1 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -804,7 +804,6 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
>          return;
>      }
>      sdl2_console = g_new0(struct sdl2_console, sdl2_num_outputs);
> -    sdl2_console->opts = o;
>      for (i = 0; i < sdl2_num_outputs; i++) {
>          QemuConsole *con = qemu_console_lookup_by_index(i);
>          assert(con != NULL);
> @@ -812,6 +811,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
>              sdl2_console[i].hidden = true;
>          }
>          sdl2_console[i].idx = i;
> +        sdl2_console[i].opts = o;
>  #ifdef CONFIG_OPENGL
>          sdl2_console[i].opengl = display_opengl;
>          sdl2_console[i].dcl.ops = display_opengl ? &dcl_gl_ops : &dcl_2d_ops;
> 
