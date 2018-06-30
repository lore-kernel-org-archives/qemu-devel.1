Received: from eggs.gnu.org ([2001:4830:134:3::10]:60346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fZJKW-0004mu-Qr
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 13:06:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fZJKT-0002EF-Lb
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 13:06:36 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:37304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fZJKT-0002D7-Gl
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 13:06:33 -0400
Received: by mail-qt0-x244.google.com with SMTP id a18-v6so10605542qtj.4
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 10:06:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180630165448.30795-1-mjt@msgid.tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <02f11058-3e97-934d-8016-e90193091609@amsat.org>
Date: Sat, 30 Jun 2018 14:06:27 -0300
MIME-Version: 1.0
In-Reply-To: <20180630165448.30795-1-mjt@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] ui: do not build-depend or link with
 libdrm, it is not needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

On 06/30/2018 01:54 PM, Michael Tokarev wrote:
> Opengl support brings up libdrm. But actually nothing uses this library
> or includes any of its headers. Just remove checking for it from configure.

libgbm is linked to libdrm, but I don't see call from QEMU to libdrm,
son we don't need to check for it (and his headers) indeed.

> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 65548df1fc..951ff022dd 100755
> --- a/configure
> +++ b/configure
> @@ -3865,7 +3865,7 @@ libs_softmmu="$libs_softmmu $fdt_libs"
>  # opengl probe (for sdl2, gtk, milkymist-tmu2)
>  
>  if test "$opengl" != "no" ; then
> -  opengl_pkgs="epoxy libdrm gbm"
> +  opengl_pkgs="epoxy gbm"
>    if $pkg_config $opengl_pkgs; then
>      opengl_cflags="$($pkg_config --cflags $opengl_pkgs)"
>      opengl_libs="$($pkg_config --libs $opengl_pkgs)"
> 
