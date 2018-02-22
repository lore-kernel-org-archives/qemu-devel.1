Received: from eggs.gnu.org ([2001:4830:134:3::10]:60044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoufc-0005Pn-BN
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 12:28:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoufb-0006vD-B7
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 12:28:36 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:40328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eoufb-0006u5-0p
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 12:28:35 -0500
Received: by mail-ot0-x241.google.com with SMTP id s4so5306567oth.7
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 09:28:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-2-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 17:28:13 +0000
Message-ID: <CAFEAcA-00jCXJzwSgGmC0gg=vWpmVFs0qUbrzEQ_THSzw74O9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 01/67] target/arm: Enable SVE
 for aarch64-linux-user
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
> Enable ARM_FEATURE_SVE for the generic "any" cpu.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.c   | 7 +++++++
>  target/arm/cpu64.c | 1 +
>  2 files changed, 8 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

though this should probably go at the end of the patchseries rather
than the beginning?

thanks
-- PMM
