Received: from eggs.gnu.org ([2001:4830:134:3::10]:55048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDUTE-0005cd-Aq
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDUT9-00040k-Bt
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:05:38 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDUT2-0003hv-7L
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:05:29 -0400
Received: by mail-oi1-x243.google.com with SMTP id u74-v6so26721117oia.11
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 06:05:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181011205206.3552-18-richard.henderson@linaro.org>
References: <20181011205206.3552-1-richard.henderson@linaro.org>
	<20181011205206.3552-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 14:05:01 +0100
Message-ID: <CAFEAcA_oPQuQvnLFSGo_Q-7TBWJgqCBYt8mdbH8ZHc1RVcBzhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 17/20] target/arm: Use gvec for NEON VLD
 all lanes
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

On 11 October 2018 at 21:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 81 ++++++++++++++----------------------------
>  1 file changed, 26 insertions(+), 55 deletions(-)

> -                /* VLD2/3/4 to all lanes: bit 5 indicates register stride */
> -                stride = (insn & (1 << 5)) ? 2 : 1;


> +            stride = insn & (1 << 5) ? 2 : 1;

You dropped the clarifying parens in the ?: expression here; I've added
them back...

thanks
-- PMM
