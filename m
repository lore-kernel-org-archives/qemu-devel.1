Received: from eggs.gnu.org ([2001:4830:134:3::10]:56925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZhsI-0006Ra-A6
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZhsH-0007qi-H2
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:46:50 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:44011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZhsH-0007qL-DI
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:46:49 -0500
Received: by mail-ot0-x243.google.com with SMTP id t28so2947417oti.10
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 10:46:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218173022.18418-5-richard.henderson@linaro.org>
References: <20171218173022.18418-1-richard.henderson@linaro.org>
	<20171218173022.18418-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 18:46:28 +0000
Message-ID: <CAFEAcA-qMT4Yf0eUsOOgGpNOtAnSdWU6+vMt9SxTPpyQxhUMuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/9] target/arm: Use pointers in neon tbl
 helper
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
> Rather than passing a regno to the helper, pass pointers to the
> vector register directly.  This eliminates the need to pass in
> the environment pointer and reduces the number of places that
> directly access env->vfp.regs[].
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h    |  2 +-
>  target/arm/op_helper.c | 17 +++++++----------
>  target/arm/translate.c |  8 ++++----
>  3 files changed, 12 insertions(+), 15 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
