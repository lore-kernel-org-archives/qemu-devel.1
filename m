Received: from eggs.gnu.org ([208.118.235.92]:54603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gc6un-0002tO-Mc
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 05:59:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gc6sR-00075G-Po
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 05:57:29 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:44435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gc6sR-00073m-Ke
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 05:57:27 -0500
Received: by mail-oi1-x22a.google.com with SMTP id m6so12687426oig.11
	for <qemu-devel@nongnu.org>; Wed, 26 Dec 2018 02:57:25 -0800 (PST)
MIME-Version: 1.0
References: <20181226034254.17842-1-richard.henderson@linaro.org>
In-Reply-To: <20181226034254.17842-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Dec 2018 10:57:12 +0000
Message-ID: <CAFEAcA_wv1U-ZZFkqiS+9Hh2CkGerFv2vfJMevChBN6NOLALUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] slirp: Use lduw_be_p in slirp_input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>

On Wed, 26 Dec 2018 at 03:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The pointer may be unaligned, so we must use our routines for that.
> At the same time, we might as well use the big-endian version
> instead of ntohs.
>
> This fixes sparc64 host SIGBUS during pxe boot.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  slirp/slirp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
