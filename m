Received: from eggs.gnu.org ([209.51.188.92]:45556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1T7A-0002o3-Gb
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:45:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1T79-0004pK-PM
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:45:28 -0500
References: <155119086741.1037569.12734854713022304642.stgit@bahia.lan>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c341d677-7749-5158-df45-b529b58ba45f@vivier.eu>
Date: Wed, 6 Mar 2019 10:45:18 +0100
MIME-Version: 1.0
In-Reply-To: <155119086741.1037569.12734854713022304642.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] bswap: Fix accessors syntax
 in comment
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

On 26/02/2019 15:21, Greg Kurz wrote:
> All accessors that have an endian infix DO have an underscore between
> {size} and {endian}.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
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

Applied to my trivial-patches branch.

Thanks,
Laurent
