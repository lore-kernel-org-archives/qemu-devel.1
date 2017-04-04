Received: from eggs.gnu.org ([2001:4830:134:3::10]:38331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvQB2-0005fk-CP
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvQAz-0003us-5A
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:15:24 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvQAz-0003ug-27
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:15:21 -0400
Received: by mail-qk0-x244.google.com with SMTP id k139so12722955qke.2
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 08:15:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170316092121.25672-1-marcandre.lureau@redhat.com>
	<20170316092121.25672-4-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <20bc59c7-9270-7f26-1448-3cf9f392205f@amsat.org>
Date: Tue, 4 Apr 2017 12:15:16 -0300
MIME-Version: 1.0
In-Reply-To: <20170316092121.25672-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 03/21] xen: use a better chardev type
 check
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

On 03/16/2017 06:21 AM, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  xen-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/xen-common.c b/xen-common.c
> index fd2c92847e..d46685ef4e 100644
> --- a/xen-common.c
> +++ b/xen-common.c
> @@ -34,7 +34,7 @@ static int store_dev_info(int domid, Chardev *cs, const char *string)
>      int ret = -1;
>
>      /* Only continue if we're talking to a pty. */
> -    if (strncmp(cs->filename, "pty:", 4)) {
> +    if (!CHARDEV_IS_PTY(cs)) {
>          return 0;
>      }
>      pts = cs->filename + 4;
>
