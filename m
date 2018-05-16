Received: from eggs.gnu.org ([2001:4830:134:3::10]:56400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fJ6Bi-0003tS-5j
	for qemu-devel@nongnu.org; Wed, 16 May 2018 19:50:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fJ6Bh-0002Ax-0c
	for qemu-devel@nongnu.org; Wed, 16 May 2018 19:50:29 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:37961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fJ6Bg-00029x-C6
	for qemu-devel@nongnu.org; Wed, 16 May 2018 19:50:28 -0400
Received: by mail-lf0-x244.google.com with SMTP id z142-v6so5998242lff.5
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 16:50:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180516185146.30708-38-edgar.iglesias@gmail.com>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
	<20180516185146.30708-38-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 16 May 2018 16:49:56 -0700
Message-ID: <CAKmqyKPq12t0pJYOGMHBa+VZ8hL-BJt8DWdfYkubBrGM9g9JHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 37/38] target-microblaze: cpu_mmu_index:
 Fixup indentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Richard Henderson <richard.henderson@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>

On Wed, May 16, 2018 at 11:51 AM, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Fixup the indentation of cpu_mmu_index in preparation for
> future edits.
> No functional changes.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/microblaze/cpu.h | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index e38580cd7f..c77ca2d8f9 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -360,13 +360,15 @@ int cpu_mb_signal_handler(int host_signum, void *pinfo,
>
>  static inline int cpu_mmu_index (CPUMBState *env, bool ifetch)
>  {
> -        /* Are we in nommu mode?.  */
> -        if (!(env->sregs[SR_MSR] & MSR_VM))
> -            return MMU_NOMMU_IDX;
> -
> -       if (env->sregs[SR_MSR] & MSR_UM)
> -            return MMU_USER_IDX;
> -        return MMU_KERNEL_IDX;
> +    /* Are we in nommu mode?.  */
> +    if (!(env->sregs[SR_MSR] & MSR_VM)) {
> +        return MMU_NOMMU_IDX;
> +    }
> +
> +    if (env->sregs[SR_MSR] & MSR_UM) {
> +        return MMU_USER_IDX;
> +    }
> +    return MMU_KERNEL_IDX;
>  }
>
>  int mb_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
> --
> 2.14.1
>
>
