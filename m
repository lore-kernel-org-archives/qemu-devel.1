Received: from eggs.gnu.org ([209.51.188.92]:34596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggTM3-0006IS-SB
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:46:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggTM2-0001aM-4o
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:46:02 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggTM1-0001a0-Uo
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:46:02 -0500
Received: by mail-oi1-x243.google.com with SMTP id a77so60075oii.5
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 03:46:01 -0800 (PST)
MIME-Version: 1.0
References: <20181214052410.11863-1-richard.henderson@linaro.org>
	<20181214052410.11863-20-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jan 2019 11:45:50 +0000
Message-ID: <CAFEAcA-GHkNshsMRvMFLiN2rb837D0YEU6ds0Ns5JR8ABo_n6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 19/27] target/arm: Export
 aa64_va_parameters to internals.h
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
> We need to reuse this from helper-a64.c.  Provide a stub
> definition for CONFIG_USER_ONLY.  This matches the stub
> definitions that we removed for arm_regime_tbi{0,1} before.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/internals.h | 17 +++++++++++++++++
>  target/arm/helper.c    |  4 ++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 9ef9d01ee2..4fbef58126 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -951,4 +951,21 @@ typedef struct ARMVAParameters {
>      bool using64k   : 1;
>  } ARMVAParameters;
>
> +#ifdef CONFIG_USER_ONLY
> +static inline ARMVAParameters aa64_va_parameters(CPUARMState *env,
> +                                                 uint64_t va,
> +                                                 ARMMMUIdx mmu_idx, bool data)
> +{
> +    return (ARMVAParameters) {
> +        /* 48-bit address space */
> +        .tsz = 16,

I assume 48 bits is what the kernel sets up for userspace ?

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
