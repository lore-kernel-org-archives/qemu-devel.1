Received: from eggs.gnu.org ([2001:4830:134:3::10]:41965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWkC2-0006re-Qs
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:43:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWkC1-0005PN-QG
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:43:30 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWkC1-0005Nx-JU
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:43:29 -0500
Received: by mail-oi1-x244.google.com with SMTP id w13so12332227oiw.9
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 07:43:29 -0800 (PST)
MIME-Version: 1.0
References: <20181207103631.28193-1-richard.henderson@linaro.org>
	<20181207103631.28193-16-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Dec 2018 15:43:17 +0000
Message-ID: <CAFEAcA9HJEQqe70VvC2Env+DNW5Q+siMFzcLnv_ZPxvMP6uQrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 15/26] target/arm: Introduce arm_mmu_idx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>

On Fri, 7 Dec 2018 at 10:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The pattern
>
>   ARMMMUIdx mmu_idx = core_to_arm_mmu_idx(env, cpu_mmu_index(env, false));
>
> is computing the full ARMMMUIdx, stripping off the ARM bits,
> and then putting them back.
>
> Avoid the extra two steps with the appropriate helper function.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h    |  1 +
>  target/arm/helper.c | 27 ++++++++++++++++-----------
>  2 files changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 18f2378b87..6bac5c18d0 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2740,6 +2740,7 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
>  ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate);
>
>  /* Determine the current mmu_idx to use for normal loads/stores */
> +ARMMMUIdx arm_mmu_idx(CPUARMState *env);
>  int cpu_mmu_index(CPUARMState *env, bool ifetch);

Could we give the new function its own comment rather than
making it share with the existing function, please?

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
