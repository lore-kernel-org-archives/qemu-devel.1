Received: from eggs.gnu.org ([209.51.188.92]:38429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go5UO-00026a-9h
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go5UN-0002yM-LQ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:54:08 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1go5UN-0002wg-4J
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:54:07 -0500
Received: by mail-ot1-x344.google.com with SMTP id n8so14357246otl.6
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 03:54:06 -0800 (PST)
MIME-Version: 1.0
References: <20190125184913.5970-1-richard.henderson@linaro.org>
In-Reply-To: <20190125184913.5970-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 11:53:54 +0000
Message-ID: <CAFEAcA8-zs8uq576zpHDQ=-iC_6KBs3PaF=APGV4eRPPn7RTzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Fix validation of 32-bit
 address spaces for aa32
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

On Fri, 25 Jan 2019 at 18:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> When tsz == 0, aarch32 selects the address space via exclusion,
> and there are no "top_bits" remaining that require validation.
>
> Fixes: ba97be9f4a4
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)



Applied to target-arm.next, thanks.

-- PMM
