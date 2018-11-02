Received: from eggs.gnu.org ([2001:4830:134:3::10]:46304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIaNO-0008J2-Lw
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:24:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIaNN-0008ID-Rr
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:24:42 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIaNN-0008Gh-Dj
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:24:41 -0400
Received: by mail-oi1-x243.google.com with SMTP id v198-v6so1732502oif.2
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 07:24:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181024113709.16599-2-richard.henderson@linaro.org>
References: <20181024113709.16599-1-richard.henderson@linaro.org>
	<20181024113709.16599-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Nov 2018 14:24:18 +0000
Message-ID: <CAFEAcA_7axj1ETq4bA8FJQ9xZQ9Fjyy9sZEuttzrjUXjEqAEag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/5] target/arm: Install ARMISARegisters
 from kvm host
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

On 24 October 2018 at 12:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The ID registers are replacing (some of) the feature bits.
> We need (some of) these values to determine the set of data
> to be handled during migration.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/kvm_arm.h | 1 +
>  target/arm/kvm.c     | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 21c0129da2..6393455b1d 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -183,6 +183,7 @@ void kvm_arm_destroy_scratch_host_vcpu(int *fdarray);
>   * by asking the host kernel)
>   */
>  typedef struct ARMHostCPUFeatures {
> +    ARMISARegisters isar;
>      uint64_t features;
>      uint32_t target;
>      const char *dtb_compatible;
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 09a86e2820..44dd0ce6ce 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -158,6 +158,7 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
>
>      cpu->kvm_target = arm_host_cpu_features.target;
>      cpu->dtb_compatible = arm_host_cpu_features.dtb_compatible;
> +    cpu->isar = arm_host_cpu_features.isar;
>      env->features = arm_host_cpu_features.features;
>  }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
