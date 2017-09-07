Received: from eggs.gnu.org ([2001:4830:134:3::10]:35036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dq17z-0003U0-40
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dq17r-0004ia-Nw
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:02:11 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:35511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dq17r-0004hw-Ft
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:02:03 -0400
Received: by mail-wm0-x231.google.com with SMTP id f199so3467274wme.0
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 11:02:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170907175430.2720-1-richard.henderson@linaro.org>
References: <20170907175430.2720-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Sep 2017 19:01:41 +0100
Message-ID: <CAFEAcA_moESxhiTQrV_YS7h7pRB0cGMJ7GGW1xJjBinkQ5SdAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg/tci: Add TCG_TARGET_DEFAULT_MO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 September 2017 at 18:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Missed being added as part of 71650df7b0ee.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tci/tcg-target.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
> index 06963288dc..8df628a319 100644
> --- a/tcg/tci/tcg-target.h
> +++ b/tcg/tci/tcg-target.h
> @@ -192,4 +192,9 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
>  {
>  }
>
> +/* We could notice __i386__ or __s390x__ and reduce the barriers depending
> +   on the host.  But if you want performance, you use the normal backend.
> +   We prefer consistency across hosts on this.  */
> +#define TCG_TARGET_DEFAULT_MO  (0)
> +
>  #endif /* TCG_TARGET_H */

Applied to master as a travis build fix, thanks.

-- PMM
