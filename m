Received: from eggs.gnu.org ([2001:4830:134:3::10]:52938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVs8c-0007Ni-7h
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:23:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVs8b-0002WP-82
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:23:34 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
	<20170713163219.9024-13-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <498283b2-0a64-dc41-5a05-583971022b72@amsat.org>
Date: Fri, 14 Jul 2017 01:23:25 -0300
MIME-Version: 1.0
In-Reply-To: <20170713163219.9024-13-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 12/29] ui: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, Gerd Hoffmann <kraxel@redhat.com>

On 07/13/2017 01:32 PM, Marc-André Lureau wrote:
> I used the clang-tidy qemu-round check to generate the fix:
> https://github.com/elmarco/clang-tools-extra
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   ui/cursor.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ui/cursor.c b/ui/cursor.c
> index 5155b392e8..2e2fe13fa6 100644
> --- a/ui/cursor.c
> +++ b/ui/cursor.c
> @@ -118,7 +118,7 @@ void cursor_put(QEMUCursor *c)
>   
>   int cursor_get_mono_bpl(QEMUCursor *c)
>   {
> -    return (c->width + 7) / 8;
> +    return DIV_ROUND_UP(c->width, 8);
>   }
>   
>   void cursor_set_mono(QEMUCursor *c,
> 
