Received: from eggs.gnu.org ([209.51.188.92]:55655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1FT-0005Fo-4J
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1FR-0003I4-7W
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:58:11 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm1FR-0003Fq-2J
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:58:09 -0500
Received: by mail-ot1-x344.google.com with SMTP id 32so24596717ota.12
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 10:58:07 -0800 (PST)
MIME-Version: 1.0
References: <20190110124951.15473-1-richard.henderson@linaro.org>
	<20190110124951.15473-4-richard.henderson@linaro.org>
In-Reply-To: <20190110124951.15473-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 15:57:45 +0000
Message-ID: <CAFEAcA8tni8rxoON-9xZzA52jZfX-kzYZXfLhX23vw2Q--vk+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/4] target/arm: Compute TB_FLAGS for TBI
 for user-only
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

On Thu, 10 Jan 2019 at 12:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Enables, but does not turn on, TBI for CONFIG_USER_ONLY.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/internals.h | 21 ---------------------
>  target/arm/helper.c    | 13 ++++++-------
>  2 files changed, 6 insertions(+), 28 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
