Received: from eggs.gnu.org ([2001:4830:134:3::10]:33830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drqLi-0001NA-8l
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drqLh-00024Z-GR
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:55:54 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:43825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1drqLh-00024D-9B
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:55:53 -0400
Received: by mail-wm0-x22f.google.com with SMTP id a137so2007795wma.0
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 11:55:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170912162513.21694-8-richard.henderson@linaro.org>
References: <20170912162513.21694-1-richard.henderson@linaro.org>
	<20170912162513.21694-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 19:55:31 +0100
Message-ID: <CAFEAcA_wFNHcHtQYpv1GyQDUF9LU95kw2RrboYB0J0LCiMZi4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 07/16] target/arm: Align vector registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 12 September 2017 at 17:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 98b9b26fd3..419f008277 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -486,7 +486,7 @@ typedef struct CPUARMState {
>           * the two execution states, and means we do not need to explicitly
>           * map these registers when changing states.
>           */
> -        float64 regs[64];
> +        float64 regs[64] __attribute__((aligned(16)));
>
>          uint32_t xregs[16];
>          /* We store these fpcsr fields separately for convenience.  */
> --
> 2.13.5

I notice we have a QEMU_ALIGNED() macro to wrap the __attribute__,
though we use it less often than not at the moment...

thanks
-- PMM
