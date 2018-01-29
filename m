Received: from eggs.gnu.org ([2001:4830:134:3::10]:45801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egDH6-0006jJ-TH
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egDH6-0003Am-2N
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:31:20 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:40462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1egDH5-0003AA-TS
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:31:20 -0500
Received: by mail-ot0-x244.google.com with SMTP id x4so7278466otg.7
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 09:31:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180123035349.24538-3-richard.henderson@linaro.org>
References: <20180123035349.24538-1-richard.henderson@linaro.org>
	<20180123035349.24538-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jan 2018 17:30:58 +0000
Message-ID: <CAFEAcA8YzpmG1+J8Gbp63hsi0oLXujijpL=QBW68DW681dmwCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 2/5] target/arm: Add predicate registers
 for SVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 23 January 2018 at 03:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 1854fe51a8..3f4f6b6144 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -188,6 +188,13 @@ typedef struct ARMVectorReg {
>      uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);
>  } ARMVectorReg;
>
> +/* In AArch32 mode, predicate registers do not exist at all.  */
> +#ifdef TARGET_AARCH64
> +typedef struct ARMPredicateReg {
> +    uint64_t p[2 * ARM_MAX_VQ / 8] QEMU_ALIGNED(16);
> +} ARMPredicateReg;
> +#endif
> +
>
>  typedef struct CPUARMState {
>      /* Regs for current mode.  */
> @@ -515,6 +522,11 @@ typedef struct CPUARMState {
>      struct {
>          ARMVectorReg zregs[32];
>
> +#ifdef TARGET_AARCH64
> +        /* Store FFR as pregs[16] to make it easier to treat as any other.  */
> +        ARMPredicateReg pregs[17];
> +#endif

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
