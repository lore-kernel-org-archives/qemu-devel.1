Received: from eggs.gnu.org ([2001:4830:134:3::10]:49527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erkce-0008CP-10
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:21:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erkcd-0006Sx-4C
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:21:15 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:42765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erkcc-0006SY-V8
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:21:15 -0500
Received: by mail-oi0-x241.google.com with SMTP id c18so6989258oiy.9
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 05:21:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171228180814.9749-10-lukeshu@lukeshu.com>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-10-lukeshu@lukeshu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Mar 2018 13:20:53 +0000
Message-ID: <CAFEAcA8Cc=pfrRUk8rytfdc3ybfBdR3FigDJz9rhSYLUV3keOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 09/10] linux-user: init_guest_space: Add a
 comment about search strategy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luke Shumaker <lukeshu@lukeshu.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Luke Shumaker <lukeshu@parabola.nu>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 28 December 2017 at 18:08, Luke Shumaker <lukeshu@lukeshu.com> wrote:
> From: Luke Shumaker <lukeshu@parabola.nu>
>
> Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
> ---
>  linux-user/elfload.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 1b7583d659..7736ea2c3a 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1936,6 +1936,10 @@ unsigned long init_guest_space(unsigned long host_start,
>           * happen often.  Probably means we got unlucky and host
>           * address space randomization put a shared library somewhere
>           * inconvenient.
> +         *
> +         * This is probably a good strategy if host_start, but is
> +         * probably a bad strategy if not, which means we got here
> +         * because of trouble with ARM commpage setup.
>           */
>          munmap((void *)real_start, real_size);
>          current_start += qemu_host_page_size;
> --
> 2.15.1

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
