Received: from eggs.gnu.org ([2001:4830:134:3::10]:46669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dlB0Q-0001Lf-NC
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dlB0P-0001SM-T2
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:34:22 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:37670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dlB0P-0001Rk-Lb
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:34:21 -0400
Received: by mail-wm0-x233.google.com with SMTP id b189so8146051wmd.0
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 02:34:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503414539-28762-6-git-send-email-peter.maydell@linaro.org>
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-6-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Aug 2017 10:34:00 +0100
Message-ID: <CAFEAcA_+oy3ys_56j+QjDDrCabU_f5SamOCiPaMJ-z+3ZkdKVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 05/20] target/arm: Add MMU
 indexes for secure v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>

On 22 August 2017 at 16:08, Peter Maydell <peter.maydell@linaro.org> wrote:
> Now that MPU lookups can return different results for v8M
> when the CPU is in secure vs non-secure state, we need to
> have separate MMU indexes; add the secure counterparts
> to the existing three M profile MMU indexes.

> @@ -2206,7 +2217,11 @@ static inline int cpu_mmu_index(CPUARMState *env, bool ifetch)
>           */
>          if ((env->v7m.exception > 0 && env->v7m.exception <= 3)
>              || env->v7m.faultmask) {
> -            return arm_to_core_mmu_idx(ARMMMUIdx_MNegPri);
> +            mmu_idx = ARMMMUIdx_MNegPri;
> +        }

Incidentally this is not exactly the right check to make when
the security extension is present, but at this point in the
series it's the best we can do (the right check requires us
to have exception banking support in the NVIC so we can
check secure HF and nonsecure HF separately); the patch to
do it right will come after the NVIC patches.

thanks
-- PMM
