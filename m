Received: from eggs.gnu.org ([209.51.188.92]:36347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqevi-0002cU-Hf
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqevg-0004gQ-Is
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:08:57 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqeve-0004dc-Nj
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:08:55 -0500
Received: by mail-ot1-x342.google.com with SMTP id k98so13117042otk.3
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:08:52 -0800 (PST)
MIME-Version: 1.0
References: <20190204131228.25949-1-richard.henderson@linaro.org>
	<20190204131228.25949-2-richard.henderson@linaro.org>
In-Reply-To: <20190204131228.25949-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Feb 2019 14:08:40 +0000
Message-ID: <CAFEAcA_x4zfMJaYd6=PXHk8fhj=W1at2oS5YVbDE24L_dDvQ_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 1/4] fixup! target/arm: Cache the GP bit
 for a page in MemTxAttrs
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

On Mon, 4 Feb 2019 at 13:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We talked about changing this, but missed when applying to target-arm.next.
> ---
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Yeah, I'd already caught this (also the initialization of
guarded is no longer required), I just hadn't done the
compile test to let me push it out to target-arm.next
(now done).

thanks
-- PMM
