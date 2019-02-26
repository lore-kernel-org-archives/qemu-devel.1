Received: from eggs.gnu.org ([209.51.188.92]:34408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gyhaU-00070T-F8
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:36:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gyhaT-0000s5-K6
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:36:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gyhaT-0000oV-Ai
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:36:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id o10so2746646wmc.1
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 10:36:16 -0800 (PST)
References: <155119086741.1037569.12734854713022304642.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6e2fa68d-2d4b-d0ee-bc03-c1cd1c7a8cc6@redhat.com>
Date: Tue, 26 Feb 2019 19:36:13 +0100
MIME-Version: 1.0
In-Reply-To: <155119086741.1037569.12734854713022304642.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] bswap: Fix accessors syntax in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>

On 2/26/19 3:21 PM, Greg Kurz wrote:
> All accessors that have an endian infix DO have an underscore between
> {size} and {endian}.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/qemu/bswap.h |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index a684c1a7a298..5a70f78c0ba4 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -255,9 +255,9 @@ typedef union {
>  /*
>   * the generic syntax is:
>   *
> - * load: ld{type}{sign}{size}{endian}_p(ptr)
> + * load: ld{type}{sign}{size}_{endian}_p(ptr)
>   *
> - * store: st{type}{size}{endian}_p(ptr, val)
> + * store: st{type}{size}_{endian}_p(ptr, val)
>   *
>   * Note there are small differences with the softmmu access API!
>   *
> @@ -293,10 +293,10 @@ typedef union {
>   *
>   * For cases where the size to be used is not fixed at compile time,
>   * there are
> - *  stn{endian}_p(ptr, sz, val)
> + *  stn_{endian}_p(ptr, sz, val)
>   * which stores @val to @ptr as an @endian-order number @sz bytes in size
>   * and
> - *  ldn{endian}_p(ptr, sz)
> + *  ldn_{endian}_p(ptr, sz)
>   * which loads @sz bytes from @ptr as an unsigned @endian-order number
>   * and returns it in a uint64_t.
>   */
> 
> 
