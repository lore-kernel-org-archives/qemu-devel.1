Received: from eggs.gnu.org ([2001:4830:134:3::10]:42581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eovB0-0006LH-6f
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:01:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eovAv-0000WV-P8
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:01:02 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eovAv-0000W5-Ij
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:00:57 -0500
Received: by mail-oi0-x242.google.com with SMTP id 24so4334025oij.3
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 10:00:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-4-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 18:00:35 +0000
Message-ID: <CAFEAcA8oBn4xKJfuiznvz0rXdFo=2yR5eZnLR2HE01t4mKXHfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 03/67] target/arm: Add SVE
 decode skeleton
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

On 17 February 2018 at 18:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Including only 4, as-yet unimplemented, instruction patterns
> so that the whole thing compiles.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 11 +++++++-
>  target/arm/translate-sve.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++
>  .gitignore                 |  1 +
>  target/arm/Makefile.objs   | 10 ++++++++
>  target/arm/sve.decode      | 45 +++++++++++++++++++++++++++++++++
>  5 files changed, 129 insertions(+), 1 deletion(-)
>  create mode 100644 target/arm/translate-sve.c
>  create mode 100644 target/arm/sve.decode

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
