Received: from eggs.gnu.org ([2001:4830:134:3::10]:52992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diUUx-0008DC-J5
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diUUw-0006Pi-N3
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:46:47 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170817230114.3655-1-richard.henderson@linaro.org>
	<20170817230114.3655-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9ceed03c-896b-a947-0736-3ee108bec7a3@amsat.org>
Date: Thu, 17 Aug 2017 20:46:36 -0300
MIME-Version: 1.0
In-Reply-To: <20170817230114.3655-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/8] tcg: Add types for host vectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org

On 08/17/2017 08:01 PM, Richard Henderson wrote:
> Nothing uses or enables them yet.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   tcg/tcg.h | 5 +++++
>   tcg/tcg.c | 2 +-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index dd97095af5..1277caed3d 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -256,6 +256,11 @@ typedef struct TCGPool {
>   typedef enum TCGType {
>       TCG_TYPE_I32,
>       TCG_TYPE_I64,
> +
> +    TCG_TYPE_V64,
> +    TCG_TYPE_V128,
> +    TCG_TYPE_V256,
> +
>       TCG_TYPE_COUNT, /* number of different types */
>   
>       /* An alias for the size of the host register.  */
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 787c8ba0f7..ea78d47fad 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -118,7 +118,7 @@ static TCGReg tcg_reg_alloc_new(TCGContext *s, TCGType t)
>   static bool tcg_out_ldst_finalize(TCGContext *s);
>   #endif
>   
> -static TCGRegSet tcg_target_available_regs[2];
> +static TCGRegSet tcg_target_available_regs[TCG_TYPE_COUNT];
>   static TCGRegSet tcg_target_call_clobber_regs;
>   
>   #if TCG_TARGET_INSN_UNIT_SIZE == 1
> 
