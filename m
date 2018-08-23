Received: from eggs.gnu.org ([2001:4830:134:3::10]:55416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fssOX-0002nU-Eg
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fssOW-0002x3-L9
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:23:37 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:38332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fssOW-0002vu-8p
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:23:36 -0400
Received: by mail-oi0-x242.google.com with SMTP id z185-v6so9837231oia.5
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 09:23:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180809042206.15726-21-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
	<20180809042206.15726-21-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 17:23:15 +0100
Message-ID: <CAFEAcA8vyDqCR1sUxfnY=v=jjjE5UD1rDmMs8gQEeH4YUievqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 20/20] target/arm: Pass TCGMemOpIdx to sve
 memory helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Desnogues <laurent.desnogues@gmail.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 9 August 2018 at 05:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> There is quite a lot of code required to compute cpu_mem_index,
> or even put together the full TCGMemOpIdx.  This can easily be
> done at translation time.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/internals.h     |   5 ++
>  target/arm/sve_helper.c    | 138 +++++++++++++++++++------------------
>  target/arm/translate-sve.c |  67 +++++++++++-------
>  3 files changed, 121 insertions(+), 89 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
