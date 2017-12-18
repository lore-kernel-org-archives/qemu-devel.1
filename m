Received: from eggs.gnu.org ([2001:4830:134:3::10]:41255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eR214-0008Ng-03
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:28:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eR212-0008L5-Ta
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:28:01 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171218173022.18418-1-richard.henderson@linaro.org>
	<20171218173022.18418-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0f5b89dc-2d8d-7490-c6a7-39aea14e23e7@amsat.org>
Date: Mon, 18 Dec 2017 17:27:49 -0300
MIME-Version: 1.0
In-Reply-To: <20171218173022.18418-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/9] target/arm: Mark
 disas_set_insn_syndrome inline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

On 12/18/2017 02:30 PM, Richard Henderson wrote:
> If it isn't used when translate.h is included,
> we'll get a compiler Werror.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/translate.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/translate.h b/target/arm/translate.h
> index cd7313ace7..3f4df91e5e 100644
> --- a/target/arm/translate.h
> +++ b/target/arm/translate.h
> @@ -108,7 +108,7 @@ static inline int default_exception_el(DisasContext *s)
>              ? 3 : MAX(1, s->current_el);
>  }
>  
> -static void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
> +static inline void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
>  {
>      /* We don't need to save all of the syndrome so we mask and shift
>       * out unneeded bits to help the sleb128 encoder do a better job.
> 
