Received: from eggs.gnu.org ([2001:4830:134:3::10]:58904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dq0zn-0006rm-EB
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dq0zi-0008F6-Sg
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:53:43 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:37660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dq0zi-0008Ek-Ow
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:53:38 -0400
Received: by mail-qt0-x241.google.com with SMTP id h21so248097qth.4
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 10:53:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170907084700.952-1-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1e452e84-63ad-b057-4891-750d6d58512a@amsat.org>
Date: Thu, 7 Sep 2017 14:53:35 -0300
MIME-Version: 1.0
In-Reply-To: <20170907084700.952-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] buildsys: Move brlapi libs to per object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 09/07/2017 05:47 AM, Fam Zheng wrote:
> baum.o already receives the sdl cflags in its per object variable, do
> the same for brlapi libs to avoid cluttering libs_softmmu.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   chardev/Makefile.objs | 1 +
>   configure             | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
> index 52a8127606..d68e1347f9 100644
> --- a/chardev/Makefile.objs
> +++ b/chardev/Makefile.objs
> @@ -20,5 +20,6 @@ chardev-obj-$(CONFIG_WIN32) += char-win-stdio.o
>   common-obj-y += msmouse.o wctablet.o testdev.o
>   common-obj-$(CONFIG_BRLAPI) += baum.o
>   baum.o-cflags := $(SDL_CFLAGS)
> +baum.o-libs := $(BRLAPI_LIBS)
>   
>   common-obj-$(CONFIG_SPICE) += spice.o
> diff --git a/configure b/configure
> index fb7e34a901..d718718cfa 100755
> --- a/configure
> +++ b/configure
> @@ -3106,7 +3106,6 @@ int main( void ) { return brlapi__openConnection (NULL, NULL, NULL); }
>   EOF
>     if compile_prog "" "$brlapi_libs" ; then
>       brlapi=yes
> -    libs_softmmu="$brlapi_libs $libs_softmmu"
>     else
>       if test "$brlapi" = "yes" ; then
>         feature_not_found "brlapi" "Install brlapi devel"
> @@ -5693,6 +5692,7 @@ if test "$curl" = "yes" ; then
>   fi
>   if test "$brlapi" = "yes" ; then
>     echo "CONFIG_BRLAPI=y" >> $config_host_mak
> +  echo "BRLAPI_LIBS=$brlapi_libs" >> $config_host_mak
>   fi
>   if test "$bluez" = "yes" ; then
>     echo "CONFIG_BLUEZ=y" >> $config_host_mak
> 
