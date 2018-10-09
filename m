Received: from eggs.gnu.org ([2001:4830:134:3::10]:57925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9lCw-0004Ef-V6
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:09:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9lCs-0004x9-2Y
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:09:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g9lCr-0004wo-SY
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:09:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id z25-v6so10202027wmf.1
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 23:09:21 -0700 (PDT)
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-7-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <41903cf2-1a35-6978-a2ea-0370a2c29c0b@redhat.com>
Date: Tue, 9 Oct 2018 08:09:19 +0200
MIME-Version: 1.0
In-Reply-To: <20181008173125.19678-7-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/31] char: Use error_printf() to print
 help and such
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 08/10/2018 19:31, Markus Armbruster wrote:
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  Convert a few that are actually help and such to
> error_printf().
> 
> Improves output of -chardev help from
> 
>     qemu-system-x86_64: -chardev help: Available chardev backend types:
>     serial
>     ...
> 
> to
> 
>     Available chardev backend types:
>     serial
>     ...
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  chardev/char-pty.c | 2 +-
>  chardev/char.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index e8d9a53476..f681d637c1 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -259,7 +259,7 @@ static void char_pty_open(Chardev *chr,
>      qemu_set_nonblock(master_fd);
>  
>      chr->filename = g_strdup_printf("pty:%s", pty_name);
> -    error_report("char device redirected to %s (label %s)",
> +    error_printf("char device redirected to %s (label %s)\n",
>                   pty_name, chr->label);
>  
>      s = PTY_CHARDEV(chr);
> diff --git a/chardev/char.c b/chardev/char.c
> index e115166995..7f07a1bfbd 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -634,7 +634,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, Error **errp)
>  
>          chardev_name_foreach(help_string_append, str);
>  
> -        error_report("Available chardev backend types: %s", str->str);
> +        error_printf("Available chardev backend types: %s\n", str->str);
>          g_string_free(str, true);
>          return NULL;
>      }
> 
