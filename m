Received: from eggs.gnu.org ([209.51.188.92]:36406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDS30-0006xr-O9
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDS2z-0005ZT-M5
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:02:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDS2z-0005YS-D9
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:02:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so219627wrn.11
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 04:02:41 -0700 (PDT)
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-15-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <606bbd80-1981-55d3-d42e-6a0c8f8a32e8@redhat.com>
Date: Mon, 8 Apr 2019 13:02:38 +0200
MIME-Version: 1.0
In-Reply-To: <20190408083627.7479-15-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 14/15] char: Make -chardev help print to
 stdout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 4/8/19 10:36 AM, Markus Armbruster wrote:
> Command line help explicitly requested by the user should be printed
> to stdout, not stderr.  We do elsewhere.  Adjust -chardev to match:
> use qemu_printf() instead of error_printf().  Plain printf() would be
> wrong because we need to print to the current monitor for chardev-add
> help".
> 
> Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  chardev/char.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/chardev/char.c b/chardev/char.c
> index 514cd6b0c3..54724a56b1 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -28,6 +28,7 @@
>  #include "sysemu/sysemu.h"
>  #include "qemu/config-file.h"
>  #include "qemu/error-report.h"
> +#include "qemu/qemu-print.h"
>  #include "chardev/char.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-char.h"
> @@ -651,7 +652,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
>  
>          chardev_name_foreach(help_string_append, str);
>  
> -        error_printf("Available chardev backend types: %s\n", str->str);
> +        qemu_printf("Available chardev backend types: %s\n", str->str);
>          g_string_free(str, true);
>          return NULL;
>      }
> 
