Received: from eggs.gnu.org ([2001:4830:134:3::10]:59090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYopc-0002tR-Uv
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYopc-00061L-9G
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:32:40 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:46635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYopc-000609-4I
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:32:40 -0400
Received: by mail-ot0-x243.google.com with SMTP id v24-v6so9091576otk.13
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 01:32:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629001538.11415-5-richard.henderson@linaro.org>
References: <20180629001538.11415-1-richard.henderson@linaro.org>
	<20180629001538.11415-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 09:32:19 +0100
Message-ID: <CAFEAcA8faroCkvr=k_+OTc-MCC=F05MU=LasquewoSu5zkdsqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/6] target/arm: Prune a15 features from max
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

On 29 June 2018 at 01:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
> There is no need to re-set these 3 features already
> implied by the call to aarch64_a15_initfn.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.c | 3 ---
>  1 file changed, 3 deletions(-)
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
