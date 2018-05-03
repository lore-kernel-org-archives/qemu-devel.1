Received: from eggs.gnu.org ([2001:4830:134:3::10]:59153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEE0U-0004Pr-Ez
	for qemu-devel@nongnu.org; Thu, 03 May 2018 09:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEE0T-0000wu-My
	for qemu-devel@nongnu.org; Thu, 03 May 2018 09:10:46 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:40380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEE0T-0000wl-He
	for qemu-devel@nongnu.org; Thu, 03 May 2018 09:10:45 -0400
Received: by mail-ot0-x242.google.com with SMTP id n1-v6so20539548otf.7
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 06:10:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180427002651.28356-2-richard.henderson@linaro.org>
References: <20180427002651.28356-1-richard.henderson@linaro.org>
	<20180427002651.28356-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 May 2018 14:10:24 +0100
Message-ID: <CAFEAcA8H9pXsCfOwQx+tkbQbOfdmqrv4maNo7-_voyQjighxPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/9] tcg: Introduce helpers for
 integer min/max
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

On 27 April 2018 at 01:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
> These operations are re-invented by several targets so far.
> Several supported hosts have insns for these, so place the
> expanders out-of-line for a future introduction of tcg opcodes.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg-op.h | 16 ++++++++++++++++
>  tcg/tcg-op.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)

I think these new operations ought to be documented somewhere,
but they fall into the awkward gap between what we document
(the TCG opcodes) and what the frontends actually use (the
tcg_gen_* functions)...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
