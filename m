Received: from eggs.gnu.org ([2001:4830:134:3::10]:51480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzVLo-0005az-Mp
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzVLl-000637-9c
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:07:40 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzVLl-00062f-4M
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:07:37 -0400
Received: by mail-qk0-x242.google.com with SMTP id z14so6825265qkg.3
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 15:07:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1507059418.git.alistair.francis@xilinx.com>
	<ea095f0e516828d978bf2e7344100c20d89788f7.1507059418.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <011f8d04-3a5f-f3f9-ec78-85bc07bc7e2d@amsat.org>
Date: Tue, 3 Oct 2017 19:07:31 -0300
MIME-Version: 1.0
In-Reply-To: <ea095f0e516828d978bf2e7344100c20d89788f7.1507059418.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 4/5] xilinx_zynq: : Specify the valid
 CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, marcel@redhat.com, alistair23@gmail.com

On 10/03/2017 05:05 PM, Alistair Francis wrote:
> List all possible valid CPU options.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> 
>  hw/arm/xilinx_zynq.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index 1836a4ed45..de1e0bbce1 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -313,6 +313,10 @@ static void zynq_init(MachineState *machine)
>      arm_load_kernel(ARM_CPU(first_cpu), &zynq_binfo);
>  }
>  
> +const char *xlnx_zynq_7000_valid_cpus[] = { ARM_CPU_TYPE_NAME("cortex-a9"),
> +                                            NULL
> +                                          };
> +
>  static void zynq_machine_init(MachineClass *mc)
>  {
>      mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
> @@ -321,6 +325,7 @@ static void zynq_machine_init(MachineClass *mc)
>      mc->no_sdcard = 1;
>      mc->ignore_memory_transaction_failures = true;
>      mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
> +    mc->valid_cpu_types = xlnx_zynq_7000_valid_cpus;
>  }
>  
>  DEFINE_MACHINE("xilinx-zynq-a9", zynq_machine_init)
> 
