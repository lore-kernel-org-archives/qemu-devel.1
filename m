Received: from eggs.gnu.org ([2001:4830:134:3::10]:49341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erkc5-0007h4-Ql
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erkc5-0006Di-0j
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:20:41 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:37336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erkc4-0006DV-SY
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:20:40 -0500
Received: by mail-oi0-x243.google.com with SMTP id f186so7003968oig.4
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 05:20:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171228180814.9749-8-lukeshu@lukeshu.com>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-8-lukeshu@lukeshu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Mar 2018 13:20:19 +0000
Message-ID: <CAFEAcA9QEMxyK9fq6DPBngPhPBdc4a2xOXx2zYsLqWqKTvZ-Eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 07/10] linux-user: init_guest_space: Clean
 up control flow a bit
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
> Instead of doing
>
>         if (check1) {
>             if (check2) {
>                success;
>             }
>         }
>
>         retry;
>
> Do a clearer
>
>         if (!check1) {
>            goto try_again;
>         }
>
>         if (!check2) {
>            goto try_again;
>         }
>
>         success;
>
>     try_again:
>         retry;
>
> Besides being clearer, this makes it easier to insert more checks that
> need to trigger a retry on check failure, or rearrange them, or anything
> like that.
>
> Because some indentation is changing, "ignore space change" may be useful
> for viewing this patch.
>
> Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
> ---
>  linux-user/elfload.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
