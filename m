Received: from eggs.gnu.org ([2001:4830:134:3::10]:38507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPseN-0002mt-GI
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 12:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPseM-0004Uo-O2
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 12:48:07 -0400
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:42698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPseM-0004UQ-JF
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 12:48:06 -0400
Received: by mail-ot0-x229.google.com with SMTP id 92-v6so3596244otw.9
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 09:48:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180530180120.13355-2-richard.henderson@linaro.org>
References: <20180530180120.13355-1-richard.henderson@linaro.org>
	<20180530180120.13355-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Jun 2018 17:47:45 +0100
Message-ID: <CAFEAcA8EPLL8+2hUw2-gkV-Z8Yf1wX74BcAMKe5T77-B=kUWqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3b 01/18] target/arm: Extend
 vec_reg_offset to larger sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 30 May 2018 at 19:01, Richard Henderson <richard.henderson@linaro.org> wrote:
> Rearrange the arithmetic so that we are agnostic about the total size
> of the vector and the size of the element.  This will allow us to index
> up to the 32nd byte and with 16-byte elements.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.h | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
