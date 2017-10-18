Received: from eggs.gnu.org ([2001:4830:134:3::10]:39940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4flC-0008Q0-Ox
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4fl9-0004th-E0
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:15:14 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44799)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e4fl9-0004tJ-A9
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:15:11 -0400
Date: Wed, 18 Oct 2017 00:15:10 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171018041510.GC13959@flamenco>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-24-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016172609.23422-24-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 23/50] hack dump tb->flags and tb->cflags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Mon, Oct 16, 2017 at 10:25:42 -0700, Richard Henderson wrote:
> ---
>  accel/tcg/cpu-exec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 39ec9508d1..99f1d519c5 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -146,9 +146,9 @@ static inline tcg_target_ulong cpu_tb_exec(CPUState *cpu, TranslationBlock *itb)
>      uint8_t *tb_ptr = itb->tc.ptr;
>  
>      qemu_log_mask_and_addr(CPU_LOG_EXEC, itb->pc,
> -                           "Trace %p [%d: " TARGET_FMT_lx "] %s\n",
> +                           "Trace %p [%d: " TARGET_FMT_lx ", %x, %x] %s\n",
>                             itb->tc.ptr, cpu->cpu_index, itb->pc,
> -                           lookup_symbol(itb->pc));
> +                           itb->flags, itb->cflags, lookup_symbol(itb->pc));

Given the title, did you indent to submit this patch in the series,
or it was just a private patch for debugging?

		E.
