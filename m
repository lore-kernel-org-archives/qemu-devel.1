Received: from eggs.gnu.org ([2001:4830:134:3::10]:45031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1civwD-00062z-Oy
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:32:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1civwA-0005EK-Kw
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:32:29 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1civwA-0005EC-HI
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:32:26 -0500
Received: by mail-qk0-x243.google.com with SMTP id s186so8022566qkb.1
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 20:32:26 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170227134202.2991-1-marcandre.lureau@redhat.com>
	<20170227134202.2991-11-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fedcd439-6523-79a7-9c3f-8a49653d1749@amsat.org>
Date: Wed, 1 Mar 2017 01:32:22 -0300
MIME-Version: 1.0
In-Reply-To: <20170227134202.2991-11-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 10/21] char: useless NULL check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

On 02/27/2017 10:41 AM, Marc-André Lureau wrote:
> g_strdup(NULL) returns NULL already.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  chardev/char.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index 558fd8b31c..bb20d73fcf 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -764,7 +764,7 @@ void qemu_chr_parse_common(QemuOpts *opts, ChardevCommon *backend)
>      const char *logfile = qemu_opt_get(opts, "logfile");
>
>      backend->has_logfile = logfile != NULL;
> -    backend->logfile = logfile ? g_strdup(logfile) : NULL;
> +    backend->logfile = g_strdup(logfile);
>
>      backend->has_logappend = true;
>      backend->logappend = qemu_opt_get_bool(opts, "logappend", false);
>
