Received: from eggs.gnu.org ([2001:4830:134:3::10]:40652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHtUa-0004fB-8j
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:28:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHtUZ-00027q-AG
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:28:12 -0500
Received: from mail-vk0-x231.google.com ([2607:f8b0:400c:c05::231]:36563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHtUY-00027R-T8
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:28:11 -0500
Received: by mail-vk0-x231.google.com with SMTP id p9so89362426vkd.3
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 06:28:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1480003738-8754-6-git-send-email-Lena.Djokic@rt-rk.com>
References: <1480003738-8754-1-git-send-email-Lena.Djokic@rt-rk.com>
	<1480003738-8754-6-git-send-email-Lena.Djokic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Dec 2016 14:27:49 +0000
Message-ID: <CAFEAcA--BjbiuUqrTUco-YeudGbnU742yBK_GE4iTG4DzzCCkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 5/7] linux-user: Fix readahead
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lena Djokic <Lena.Djokic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 24 November 2016 at 16:08, Lena Djokic <Lena.Djokic@rt-rk.com> wrote:
> Calculation of 64-bit offset was not correct for all cases.
>
> Signed-off-by: Lena Djokic <Lena.Djokic@rt-rk.com>
> ---
>  linux-user/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 1b59a71..61c4126 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11296,7 +11296,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>              arg3 = arg4;
>              arg4 = arg5;
>          }
> -        ret = get_errno(readahead(arg1, ((off64_t)arg3 << 32) | arg2, arg4));
> +        ret = get_errno(readahead(arg1, target_offset64(arg2, arg3) , arg4));
>  #else
>          ret = get_errno(readahead(arg1, arg2, arg3));
>  #endif

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
