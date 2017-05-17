Received: from eggs.gnu.org ([2001:4830:134:3::10]:42922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dB2fT-0003MD-0i
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dB2fP-0000mD-2g
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:23:23 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dB2fO-0000m5-Uh
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:23:19 -0400
Received: by mail-qt0-x242.google.com with SMTP id r58so2433652qtb.2
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 10:23:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20170517122744.3541-1-kraxel@redhat.com>
Message-ID: <85059712-daf8-551a-24e1-16461fdb99ea@amsat.org>
Date: Wed, 17 May 2017 14:23:09 -0300
MIME-Version: 1.0
In-Reply-To: <20170517122744.3541-1-kraxel@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] ui: egl-headless requires dmabuf support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 05/17/2017 09:27 AM, Gerd Hoffmann wrote:
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  vl.c             | 4 ++--
>  ui/Makefile.objs | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index 5c9b40eb1c..2d7aeec186 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2129,7 +2129,7 @@ static DisplayType select_display(const char *p)
>              exit(1);
>          }
>      } else if (strstart(p, "egl-headless", &opts)) {
> -#ifdef CONFIG_OPENGL
> +#ifdef CONFIG_OPENGL_DMABUF
>          request_opengl = 1;
>          display_opengl = 1;
>          display = DT_EGL;
> @@ -4668,7 +4668,7 @@ int main(int argc, char **argv, char **envp)
>          qemu_spice_display_init();
>      }
>
> -#ifdef CONFIG_OPENGL
> +#ifdef CONFIG_OPENGL_DMABUF
>      if (display_type == DT_EGL) {
>          egl_headless_init();
>      }
> diff --git a/ui/Makefile.objs b/ui/Makefile.objs
> index aac6ae8bef..3369451285 100644
> --- a/ui/Makefile.objs
> +++ b/ui/Makefile.objs
> @@ -33,7 +33,7 @@ common-obj-y += shader.o
>  common-obj-y += console-gl.o
>  common-obj-y += egl-helpers.o
>  common-obj-y += egl-context.o
> -common-obj-y += egl-headless.o
> +common-obj-$(CONFIG_OPENGL_DMABUF) += egl-headless.o
>  ifeq ($(CONFIG_GTK_GL),y)
>  common-obj-$(CONFIG_GTK) += gtk-gl-area.o
>  else
>
