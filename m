Received: from eggs.gnu.org ([209.51.188.92]:49121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkSxy-0004MN-Gt
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:09:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkSxv-0003so-GZ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:09:41 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkSxu-0003gT-Px
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:09:39 -0500
Received: by mail-oi1-x242.google.com with SMTP id r62so8822010oie.1
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 04:09:33 -0800 (PST)
MIME-Version: 1.0
References: <20190108223129.5570-1-richard.henderson@linaro.org>
	<20190108223129.5570-28-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-28-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 12:09:20 +0000
Message-ID: <CAFEAcA9iaRGs4T2DdjzZxM49zK+Jzu_G7SPPPb1tx9fO6ab_ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 27/31] target/arm: Implement
 pauth_computepac
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

On Tue, 8 Jan 2019 at 22:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is the main crypto routine, an implementation of QARMA.
> This matches, as much as possible, ARM pseudocode.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/pauth_helper.c | 241 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 240 insertions(+), 1 deletion(-)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
