Received: from eggs.gnu.org ([2001:4830:134:3::10]:52858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVs8K-0007Ag-OI
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVs8J-0002TV-QG
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:23:16 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
	<20170713163219.9024-17-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2dcce37a-b757-7a2d-63f3-8e7984b2692a@amsat.org>
Date: Fri, 14 Jul 2017 01:23:06 -0300
MIME-Version: 1.0
In-Reply-To: <20170713163219.9024-17-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2 16/29] console: use
 DIV_ROUND_UP
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
>   include/ui/console.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 7262bef6d3..8024878bae 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -328,7 +328,7 @@ static inline int surface_bits_per_pixel(DisplaySurface *s)
>   static inline int surface_bytes_per_pixel(DisplaySurface *s)
>   {
>       int bits = PIXMAN_FORMAT_BPP(s->format);
> -    return (bits + 7) / 8;
> +    return DIV_ROUND_UP(bits, 8);
>   }
>   
>   static inline pixman_format_code_t surface_format(DisplaySurface *s)
> 
