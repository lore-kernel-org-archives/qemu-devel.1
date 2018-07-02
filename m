Received: from eggs.gnu.org ([2001:4830:134:3::10]:51688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZzcu-0007Bu-Og
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZzct-0000sX-UO
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:16:24 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fZzct-0000rB-GX
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:16:23 -0400
Received: by mail-oi0-x243.google.com with SMTP id r16-v6so16153153oie.3
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 07:16:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180630000242.29594-3-richard.henderson@linaro.org>
References: <20180630000242.29594-1-richard.henderson@linaro.org>
	<20180630000242.29594-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Jul 2018 15:16:02 +0100
Message-ID: <CAFEAcA_SCb7s+mqK01LmWDt2hmoNNJcdpsMwuA4KKxuByQddkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] cpu: Assert asidx_from_attrs return
 value in range
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

On 30 June 2018 at 01:02, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/qom/cpu.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index cce2fd6acc..bd796579ee 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -620,11 +620,13 @@ static inline hwaddr cpu_get_phys_page_debug(CPUState *cpu, vaddr addr)
>  static inline int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs)
>  {
>      CPUClass *cc = CPU_GET_CLASS(cpu);
> +    int ret = 0;
>
>      if (cc->asidx_from_attrs) {
> -        return cc->asidx_from_attrs(cpu, attrs);
> +        ret = cc->asidx_from_attrs(cpu, attrs);
> +        assert(ret < cpu->num_ases && ret >= 0);
>      }
> -    return 0;
> +    return ret;
>  }
>  #endif
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
