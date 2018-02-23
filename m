Received: from eggs.gnu.org ([2001:4830:134:3::10]:39628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epIF2-0005Vh-Ba
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epIF1-0004dm-FY
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:38:44 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:35629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epIF1-0004aU-4z
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:38:43 -0500
Received: by mail-pl0-x242.google.com with SMTP id bb3so5369140plb.2
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 10:38:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171228180814.9749-4-lukeshu@lukeshu.com>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-4-lukeshu@lukeshu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 18:38:21 +0000
Message-ID: <CAFEAcA8k4sDCv0uRcnQPBHE+inz1PWFe37naJZ-8kqusz5HccQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 03/10] linux-user: init_guest_space: Clean
 up if we can't initialize the commpage
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
> We'll just exit with an error anyway, so it doesn't really matter, but it
> is cleaned up in all of the other places were we error out.
>
> Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
> ---
>  linux-user/elfload.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 453394239c..1a6b660b25 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1886,6 +1886,7 @@ unsigned long init_guest_space(unsigned long host_start,
>              if (valid == 1) {
>                  break;
>              } else if (valid == -1) {
> +                munmap((void *)real_start, host_size);
>                  return (unsigned long)-1;
>              }
>              /* valid == 0, so try again. */
> --
> 2.15.1

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
