Received: from eggs.gnu.org ([2001:4830:134:3::10]:40973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqh7e-0001Fn-6S
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqh7a-0001Lv-8B
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:24:54 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:45973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqh7a-0001LH-2g
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:24:50 -0500
Received: by mail-ot0-x22a.google.com with SMTP id f11so4078774otj.12
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 07:24:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-61-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-61-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 15:24:28 +0000
Message-ID: <CAFEAcA9Vbir97mF67SE9wPpQ7x2qFfKP8nub88-Eph4xJjJYkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 60/67] target/arm: Implement SVE FP Fast
 Reduction Group
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

On 17 February 2018 at 18:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    | 35 ++++++++++++++++++++++++++
>  target/arm/sve_helper.c    | 61 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 55 +++++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  8 ++++++
>  4 files changed, 159 insertions(+)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
