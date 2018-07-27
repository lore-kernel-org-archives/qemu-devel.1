Received: from eggs.gnu.org ([2001:4830:134:3::10]:36794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fj23v-0003SM-SC
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fj23u-0006y6-Sq
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:41:39 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180727095421.386-1-luc.michel@greensocs.com>
	<20180727095421.386-5-luc.michel@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5f9537c1-9b8b-69a6-cbc6-4ca26125ef91@amsat.org>
Date: Fri, 27 Jul 2018 09:41:29 -0300
MIME-Version: 1.0
In-Reply-To: <20180727095421.386-5-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 04/20] vmstate.h: Provide
 VMSTATE_UINT16_SUB_ARRAY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, mark.burton@greensocs.com, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>

On 07/27/2018 06:54 AM, Luc Michel wrote:
> Provide a VMSTATE_UINT16_SUB_ARRAY macro to save a uint16_t sub-array in
> a VMState.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/migration/vmstate.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 42b946ce90..2b501d0466 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -921,10 +921,13 @@ extern const VMStateInfo vmstate_info_qtailq;
>      VMSTATE_2DARRAY(_f, _s, _n1, _n2, _v, vmstate_info_uint16, uint16_t)
>  
>  #define VMSTATE_UINT16_ARRAY(_f, _s, _n)                               \
>      VMSTATE_UINT16_ARRAY_V(_f, _s, _n, 0)
>  
> +#define VMSTATE_UINT16_SUB_ARRAY(_f, _s, _start, _num)                \
> +    VMSTATE_SUB_ARRAY(_f, _s, _start, _num, 0, vmstate_info_uint16, uint16_t)
> +
>  #define VMSTATE_UINT16_2DARRAY(_f, _s, _n1, _n2)                      \
>      VMSTATE_UINT16_2DARRAY_V(_f, _s, _n1, _n2, 0)
>  
>  #define VMSTATE_UINT8_2DARRAY_V(_f, _s, _n1, _n2, _v)                 \
>      VMSTATE_2DARRAY(_f, _s, _n1, _n2, _v, vmstate_info_uint8, uint8_t)
> 
