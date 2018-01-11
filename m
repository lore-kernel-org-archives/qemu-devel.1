Received: from eggs.gnu.org ([2001:4830:134:3::10]:56725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZhrm-0005yi-Oc
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:46:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZhrm-0007Yp-4d
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:46:18 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:38175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZhrm-0007YO-0P
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:46:18 -0500
Received: by mail-oi0-x241.google.com with SMTP id m65so2297112oig.5
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 10:46:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218173022.18418-3-richard.henderson@linaro.org>
References: <20171218173022.18418-1-richard.henderson@linaro.org>
	<20171218173022.18418-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 18:45:56 +0000
Message-ID: <CAFEAcA8j3bOeVz7ptUKaxS=jVaeqaBrQRwhpHAzPARvUd7SPgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/9] target/arm: Use pointers in crypto
 helpers
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

On 18 December 2017 at 17:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Rather than passing regnos to the helpers, pass pointers to the
> vector registers directly.  This eliminates the need to pass in
> the environment pointer and reduces the number of places that
> directly access env->vfp.regs[].
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h        |  18 ++---
>  target/arm/crypto_helper.c | 184 +++++++++++++++++----------------------------
>  target/arm/translate-a64.c |  68 +++++++++--------
>  target/arm/translate.c     |  68 +++++++++--------
>  4 files changed, 154 insertions(+), 184 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
