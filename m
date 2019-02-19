Received: from eggs.gnu.org ([209.51.188.92]:54561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw8hy-0002sF-8l
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:57:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw8hw-0003lh-Mt
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:57:26 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gw8hw-0003jR-7v
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:57:24 -0500
Received: by mail-ot1-x342.google.com with SMTP id i20so35428532otl.0
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 08:57:21 -0800 (PST)
MIME-Version: 1.0
References: <20190215192302.27855-1-richard.henderson@linaro.org>
	<20190215192302.27855-4-richard.henderson@linaro.org>
In-Reply-To: <20190215192302.27855-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Feb 2019 16:57:08 +0000
Message-ID: <CAFEAcA8x7d6LKBLjuEz61hSPt5cEuT9MfmAJ+GH+QCGCctTe8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 3/8] target/arm: Rearrange
 Floating-point data-processing (2 regs)
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

On Fri, 15 Feb 2019 at 19:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> There are lots of special cases within these insns.  Split the
> major argument decode/loading/saving into no_output (compares),
> rd_is_dp, and rm_is_dp.
>
> We still need to special case argument load for compare (rd as
> input, rm as zero) and vcvt fixed (rd as input+output), but lots
> of special cases do disappear.
>
> Now that we have a full switch at the beginning, hoist the ISA
> checks from the code generation.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
