Received: from eggs.gnu.org ([2001:4830:134:3::10]:52819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diUU4-0007TR-BJ
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:45:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diUU3-0005rw-Ll
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:45:52 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170817230114.3655-1-richard.henderson@linaro.org>
	<20170817230114.3655-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f7d3643e-6dc3-5bda-70f2-75c57fec4146@amsat.org>
Date: Thu, 17 Aug 2017 20:45:38 -0300
MIME-Version: 1.0
In-Reply-To: <20170817230114.3655-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 6/8] tcg: Add INDEX_op_invalid
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
> Add with value 0 so that structure zero initialization can
> indicate that the field is not present.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   tcg/tcg-opc.h | 2 ++
>   tcg/tcg.c     | 3 +++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
> index 9162125fac..b1445a4c24 100644
> --- a/tcg/tcg-opc.h
> +++ b/tcg/tcg-opc.h
> @@ -26,6 +26,8 @@
>    * DEF(name, oargs, iargs, cargs, flags)
>    */
>   
> +DEF(invalid, 0, 0, 0, TCG_OPF_NOT_PRESENT)
> +
>   /* predefined ops */
>   DEF(discard, 1, 0, 0, TCG_OPF_NOT_PRESENT)
>   DEF(set_label, 0, 0, 1, TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 3c3cdda938..879b29e81f 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -756,6 +756,9 @@ int tcg_check_temp_count(void)
>   bool tcg_op_supported(TCGOpcode op)
>   {
>       switch (op) {
> +    case INDEX_op_invalid:
> +        return false;
> +
>       case INDEX_op_discard:
>       case INDEX_op_set_label:
>       case INDEX_op_call:
> 
