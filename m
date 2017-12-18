Received: from eggs.gnu.org ([2001:4830:134:3::10]:43260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR0b3-0007QR-J7
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 13:57:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR0az-0005tV-Op
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 13:57:05 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:47005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eR0az-0005t2-IJ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 13:57:01 -0500
Received: by mail-pl0-x243.google.com with SMTP id i6so5368741plt.13
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 10:57:01 -0800 (PST)
References: <20171217055023.29225-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b2c59baf-e530-30e7-2f8a-3d33daeb875f@linaro.org>
Date: Mon, 18 Dec 2017 10:56:56 -0800
MIME-Version: 1.0
In-Reply-To: <20171217055023.29225-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg: add cs_base and flags to -d exec
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 12/16/2017 09:50 PM, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  accel/tcg/cpu-exec.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 4318441e4c..18c1a2aedb 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -146,8 +146,10 @@ static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
>      uint8_t *tb_ptr = itb->tc.ptr;
>  
>      qemu_log_mask_and_addr(CPU_LOG_EXEC, itb->pc,
> -                           "Trace %p [%d: " TARGET_FMT_lx "] %s\n",
> -                           itb->tc.ptr, cpu->cpu_index, itb->pc,
> +                           "Trace %d: %p ["
> +                           TARGET_FMT_lx "/" TARGET_FMT_lx "/%d] %s\n",
> +                           cpu->cpu_index, itb->tc.ptr,
> +                           itb->cs_base, itb->pc, itb->flags,
>                             lookup_symbol(itb->pc));


Thanks, applied to tcg-next.


r~
