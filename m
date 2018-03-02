Received: from eggs.gnu.org ([2001:4830:134:3::10]:49224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erkbn-0007RY-Ms
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:20:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erkbm-00064B-Hw
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:20:23 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erkbm-000641-AO
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:20:22 -0500
Received: by mail-oi0-x243.google.com with SMTP id u73so7012819oie.3
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 05:20:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171228180814.9749-7-lukeshu@lukeshu.com>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-7-lukeshu@lukeshu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Mar 2018 13:20:01 +0000
Message-ID: <CAFEAcA9LG5MX1t10U8xwatG104FRNUwsZ1pX8vj30H=QAw-Ayg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 06/10] linux-user: init_guest_commpage: Add
 a comment about size check
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
>  linux-user/elfload.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 22f2632dfa..b560f5d6fe 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -374,6 +374,11 @@ static int init_guest_commpage(unsigned long guest_base,
>
>      /* If the commpage lies within the already allocated guest space,
>       * then there is no way we can allocate it.
> +     *
> +     * You may be thinking that that this check is redundant because
> +     * we already validated the guest size against MAX_RESERVED_VA;
> +     * but if qemu_host_page_mask is unusually large, then
> +     * test_page_addr may be lower.
>       */
>      if (test_page_addr >= guest_base
>          && test_page_addr < (guest_base + guest_size)) {
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
