Received: from eggs.gnu.org ([2001:4830:134:3::10]:49982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz7CS-0001X7-AV
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz7CP-0002jz-IM
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:20:24 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz7CP-0002iY-6K
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:20:21 -0400
Received: by mail-qk0-x244.google.com with SMTP id w63so3045438qkd.2
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 13:20:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-17-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9b556666-4108-7b4c-89be-49549fdb1e97@amsat.org>
Date: Mon, 2 Oct 2017 17:20:17 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-17-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 16/38] openrisc: use generic cpu_model
 parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: shorne@gmail.com
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 06:07 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: shorne@gmail.com
> ---
>   hw/openrisc/openrisc_sim.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
> index 86bf284..f61b63d 100644
> --- a/hw/openrisc/openrisc_sim.c
> +++ b/hw/openrisc/openrisc_sim.c
> @@ -98,18 +98,13 @@ static void cpu_openrisc_load_kernel(ram_addr_t ram_size,
>   static void openrisc_sim_init(MachineState *machine)
>   {
>       ram_addr_t ram_size = machine->ram_size;
> -    const char *cpu_model = machine->cpu_model;
>       const char *kernel_filename = machine->kernel_filename;
>       OpenRISCCPU *cpu = NULL;
>       MemoryRegion *ram;
>       int n;
>   
> -    if (!cpu_model) {
> -        cpu_model = "or1200";
> -    }
> -
>       for (n = 0; n < smp_cpus; n++) {
> -        cpu = OPENRISC_CPU(cpu_generic_init(TYPE_OPENRISC_CPU, cpu_model));
> +        cpu = OPENRISC_CPU(cpu_create(machine->cpu_type));
>           qemu_register_reset(main_cpu_reset, cpu);
>           main_cpu_reset(cpu);
>       }
> @@ -138,6 +133,7 @@ static void openrisc_sim_machine_init(MachineClass *mc)
>       mc->init = openrisc_sim_init;
>       mc->max_cpus = 1;
>       mc->is_default = 1;
> +    mc->default_cpu_type = OPENRISC_CPU_TYPE_NAME("or1200");
>   }
>   
>   DEFINE_MACHINE("or1k-sim", openrisc_sim_machine_init)
> 
