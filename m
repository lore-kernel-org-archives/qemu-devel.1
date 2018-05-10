Received: from eggs.gnu.org ([2001:4830:134:3::10]:56347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGq0t-0005Qc-92
	for qemu-devel@nongnu.org; Thu, 10 May 2018 14:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGq0s-0007ea-F5
	for qemu-devel@nongnu.org; Thu, 10 May 2018 14:09:59 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180503115620.10596-1-edgar.iglesias@gmail.com>
	<20180503115620.10596-3-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c7409bf9-b336-8df2-bc2a-ace45077bcce@amsat.org>
Date: Thu, 10 May 2018 15:09:46 -0300
MIME-Version: 1.0
In-Reply-To: <20180503115620.10596-3-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v1 2/2] xlnx-zynqmp: Swap
 Cortex-R5 for Cortex-R5F
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com, frasse.iglesias@gmail.com, alistair@alistair23.me, frederic.konrad@adacore.com, qemu-arm@nongnu.org

Hi Edgar,

On 05/03/2018 08:56 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> The ZynqMP has Cortex-R5Fs with the optional FPU enabled.

What about updating the xlnx-zcu102 machine description too?

  mc->desc = "Xilinx ZynqMP ZCU102 board with 4xA53s and 2xR5Fs ..."

> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

I just noticed we can not get information for the R profile cores via
the monitor:

(qemu) info cpus
* CPU #0: thread_id=19283
  CPU #1: thread_id=19284
  CPU #2: thread_id=19285
  CPU #3: thread_id=19286

same with "info registers -a"

> ---
>  hw/arm/xlnx-zynqmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 505253e0d2..efeb53c732 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -116,7 +116,7 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
>          char *name;
>  
>          object_initialize(&s->rpu_cpu[i], sizeof(s->rpu_cpu[i]),
> -                          "cortex-r5-" TYPE_ARM_CPU);
> +                          "cortex-r5f-" TYPE_ARM_CPU);
>          object_property_add_child(OBJECT(s), "rpu-cpu[*]",
>                                    OBJECT(&s->rpu_cpu[i]), &error_abort);
>  
> 
