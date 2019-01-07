Received: from eggs.gnu.org ([209.51.188.92]:33690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggTKk-0005Kl-Lb
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:44:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggTKj-0007Rt-HL
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:44:42 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggTKj-0007Jd-Bh
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:44:41 -0500
Received: by mail-ot1-x341.google.com with SMTP id 32so28039ota.12
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 03:44:19 -0800 (PST)
MIME-Version: 1.0
References: <20181214052410.11863-1-richard.henderson@linaro.org>
	<20181214052410.11863-19-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jan 2019 11:44:07 +0000
Message-ID: <CAFEAcA-FUWL2Ta4zWiRUMG0o2FX=RoPafRvGmqvLFkmVsw1odA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 18/27] target/arm: Reuse
 aa64_va_parameters for setting tbflags
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

On Fri, 14 Dec 2018 at 05:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The arm_regime_tbi{0,1} functions are replacable with the new function
> by giving the lowest and highest address.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h    | 35 --------------------------
>  target/arm/helper.c | 61 ++++++++++++---------------------------------
>  2 files changed, 16 insertions(+), 80 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
