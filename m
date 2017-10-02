Received: from eggs.gnu.org ([2001:4830:134:3::10]:55070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1zs-0007Zk-Uv
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1zp-0008JU-JH
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:47:04 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1zp-0008JE-Ew
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:47:01 -0400
Received: by mail-qk0-x242.google.com with SMTP id z14so4000276qkg.3
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 07:47:01 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-4-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <389c37ac-6023-4c7a-75ec-9cf82706890f@amsat.org>
Date: Mon, 2 Oct 2017 11:46:58 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-4-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/38] alpha: use generic cpu_model parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, rth@twiddle.net
Cc: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 06:07 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: rth@twiddle.net
> ---
>   hw/alpha/dp264.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index 1b12130..babd6ea 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -51,7 +51,6 @@ static int clipper_pci_map_irq(PCIDevice *d, int irq_num)
>   static void clipper_init(MachineState *machine)
>   {
>       ram_addr_t ram_size = machine->ram_size;
> -    const char *cpu_model = machine->cpu_model ? machine->cpu_model : "ev67";
>       const char *kernel_filename = machine->kernel_filename;
>       const char *kernel_cmdline = machine->kernel_cmdline;
>       const char *initrd_filename = machine->initrd_filename;
> @@ -67,7 +66,7 @@ static void clipper_init(MachineState *machine)
>       /* Create up to 4 cpus.  */
>       memset(cpus, 0, sizeof(cpus));
>       for (i = 0; i < smp_cpus; ++i) {
> -        cpus[i] = ALPHA_CPU(cpu_generic_init(TYPE_ALPHA_CPU, cpu_model));
> +        cpus[i] = ALPHA_CPU(cpu_create(machine->cpu_type));
>       }
>   
>       cpus[0]->env.trap_arg0 = ram_size;
> @@ -179,6 +178,7 @@ static void clipper_machine_init(MachineClass *mc)
>       mc->block_default_type = IF_IDE;
>       mc->max_cpus = 4;
>       mc->is_default = 1;
> +    mc->default_cpu_type = ALPHA_CPU_TYPE_NAME("ev67");
>   }
>   
>   DEFINE_MACHINE("clipper", clipper_machine_init)
> 
