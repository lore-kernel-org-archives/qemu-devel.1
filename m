Received: from eggs.gnu.org ([209.51.188.92]:42966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gujy6-0004jl-Kp
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 15:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gujy5-0006Zv-Th
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 15:20:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gujy3-0006UI-SS
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 15:20:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so11671735wrw.0
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 12:20:13 -0800 (PST)
References: <20190215115239.3159-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <220ded6c-93ee-bed0-8c26-9fc08374d520@redhat.com>
Date: Fri, 15 Feb 2019 21:20:10 +0100
MIME-Version: 1.0
In-Reply-To: <20190215115239.3159-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] build-sys: remove baum SDL CFLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 2/15/19 12:52 PM, Marc-André Lureau wrote:
> SDL dependency was removed in commit
> f29b3431f6294168e5f8fc63edb91c15c6a08e41.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  chardev/Makefile.objs | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
> index d68e1347f9..7749bc0ec2 100644
> --- a/chardev/Makefile.objs
> +++ b/chardev/Makefile.objs
> @@ -19,7 +19,6 @@ chardev-obj-$(CONFIG_WIN32) += char-win-stdio.o
>  
>  common-obj-y += msmouse.o wctablet.o testdev.o
>  common-obj-$(CONFIG_BRLAPI) += baum.o
> -baum.o-cflags := $(SDL_CFLAGS)
>  baum.o-libs := $(BRLAPI_LIBS)
>  
>  common-obj-$(CONFIG_SPICE) += spice.o
> 
