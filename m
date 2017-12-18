Received: from eggs.gnu.org ([2001:4830:134:3::10]:43163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eR22e-0001AY-AS
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eR22Z-0001Ep-Tv
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:29:40 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171218173022.18418-1-richard.henderson@linaro.org>
	<20171218173022.18418-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7c447107-e135-74bc-dd18-31789fb86a6d@amsat.org>
Date: Mon, 18 Dec 2017 17:29:25 -0300
MIME-Version: 1.0
In-Reply-To: <20171218173022.18418-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 6/9] vmstate: Add
 VMSTATE_UINT64_SUB_ARRAY
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
> At the same time, move VMSTATE_UINT32_SUB_ARRAY
> beside the other UINT32 definitions.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/migration/vmstate.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 88b55df5ae..8c3889433c 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -905,6 +905,9 @@ extern const VMStateInfo vmstate_info_qtailq;
>  #define VMSTATE_UINT32_ARRAY(_f, _s, _n)                              \
>      VMSTATE_UINT32_ARRAY_V(_f, _s, _n, 0)
>  
> +#define VMSTATE_UINT32_SUB_ARRAY(_f, _s, _start, _num)                \
> +    VMSTATE_SUB_ARRAY(_f, _s, _start, _num, 0, vmstate_info_uint32, uint32_t)
> +
>  #define VMSTATE_UINT32_2DARRAY(_f, _s, _n1, _n2)                      \
>      VMSTATE_UINT32_2DARRAY_V(_f, _s, _n1, _n2, 0)
>  
> @@ -914,6 +917,9 @@ extern const VMStateInfo vmstate_info_qtailq;
>  #define VMSTATE_UINT64_ARRAY(_f, _s, _n)                              \
>      VMSTATE_UINT64_ARRAY_V(_f, _s, _n, 0)
>  
> +#define VMSTATE_UINT64_SUB_ARRAY(_f, _s, _start, _num)                \
> +    VMSTATE_SUB_ARRAY(_f, _s, _start, _num, 0, vmstate_info_uint64, uint64_t)
> +
>  #define VMSTATE_UINT64_2DARRAY(_f, _s, _n1, _n2)                      \
>      VMSTATE_UINT64_2DARRAY_V(_f, _s, _n1, _n2, 0)
>  
> @@ -932,9 +938,6 @@ extern const VMStateInfo vmstate_info_qtailq;
>  #define VMSTATE_INT32_ARRAY(_f, _s, _n)                               \
>      VMSTATE_INT32_ARRAY_V(_f, _s, _n, 0)
>  
> -#define VMSTATE_UINT32_SUB_ARRAY(_f, _s, _start, _num)                \
> -    VMSTATE_SUB_ARRAY(_f, _s, _start, _num, 0, vmstate_info_uint32, uint32_t)
> -
>  #define VMSTATE_INT64_ARRAY_V(_f, _s, _n, _v)                         \
>      VMSTATE_ARRAY(_f, _s, _n, _v, vmstate_info_int64, int64_t)
>  
> 
