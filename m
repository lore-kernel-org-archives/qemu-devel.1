Received: from eggs.gnu.org ([2001:4830:134:3::10]:60043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpuXS-00060n-Aq
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:27:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpuXR-000232-Dh
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:27:46 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:34528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cpuXR-00022u-7W
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:27:45 -0400
Received: by mail-wr0-x232.google.com with SMTP id l37so89077893wrc.1
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 03:27:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490005227-1997-1-git-send-email-kraxel@redhat.com>
References: <1490005227-1997-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 10:27:23 +0000
Message-ID: <CAFEAcA-BgcjBKigP88aWRBMo9gUuc5E7zo+x95Z7c84TPH3yKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] console: drop epoxy/gl.h include
 dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 March 2017 at 10:20, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Use "unsigned int" instead of GLenum and GLuint, so we don't depend on
> these types from opengl headers.  Drop all CONFIG_OPENGL #ifdefs from
> console.h
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

> diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
> index aaf226c..1e8d07b 100644
> --- a/include/ui/sdl2.h
> +++ b/include/ui/sdl2.h
> @@ -7,6 +7,10 @@
>  #include <SDL.h>
>  #include <SDL_syswm.h>
>
> +#ifdef CONFIG_OPENGL
> +# include <epoxy/gl.h>
> +#endif
> +
>  struct sdl2_console {
>      DisplayChangeListener dcl;
>      DisplaySurface *surface;

ui/sdl2.h is included by ui/sdl2.c, ui/sdl2-2d.c, ui/sdl2-gl.c and
ui/sdl2-input.c, but none of those are compiled with OPENGL_CFLAGS
so this won't work if epoxy/gl.h isn't on the default include path,
I think.

thanks
-- PMM
