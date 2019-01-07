Received: from eggs.gnu.org ([209.51.188.92]:58454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggVom-0000E4-Kl
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:23:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggVol-0007Ys-Rj
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:23:52 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggVol-0007Vr-N9
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:23:51 -0500
Received: by mail-ot1-x344.google.com with SMTP id w25so399489otm.13
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 06:23:51 -0800 (PST)
MIME-Version: 1.0
References: <20181214052410.11863-1-richard.henderson@linaro.org>
	<20181214052410.11863-27-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jan 2019 14:23:39 +0000
Message-ID: <CAFEAcA92i4-dqe0DV9pFXmCLwaaFv-uKBDJNu4k1bdNWhSH7gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 26/27] target/arm: Enable PAuth for
 user-only, part 2
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
> FIXME: We should have an attribute that controls the EL1 enable bits.
> We may not always want to turn on pointer authentication with -cpu max.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I suspect the commit message isn't a very useful place to put
a FIXME remark, though...

thanks
-- PMM
