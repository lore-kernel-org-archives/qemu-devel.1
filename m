Received: from eggs.gnu.org ([2001:4830:134:3::10]:50039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fssCO-0006EJ-C7
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fssCN-0004Jl-Eg
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:11:04 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:36272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fssCN-0004Hx-2z
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:11:03 -0400
Received: by mail-oi0-x244.google.com with SMTP id r69-v6so9619140oie.3
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 09:11:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180809042206.15726-20-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
	<20180809042206.15726-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 17:10:41 +0100
Message-ID: <CAFEAcA94wiw9k09G+xtCAhej1kNs6njTOrcMw4Dabb16-6Q9FQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 19/20] target/arm: Rewrite vector gather
 first-fault loads
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
> This implements the feature for softmmu, and moves the
> main loop out of a macro and into a function.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  84 ++++++++---
>  target/arm/sve_helper.c    | 290 +++++++++++++++++++++++++++----------
>  target/arm/translate-sve.c |  84 +++++------
>  3 files changed, 321 insertions(+), 137 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
