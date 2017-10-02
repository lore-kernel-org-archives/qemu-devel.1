Received: from eggs.gnu.org ([2001:4830:134:3::10]:43092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1RW-0004bO-0H
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1RT-0002UF-9K
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:11:33 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:38347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1RT-0002Ts-54
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:11:31 -0400
Received: by mail-qk0-x244.google.com with SMTP id q8so3930406qkl.5
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 07:11:31 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-36-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bc59afaa-24b8-f53c-433e-ca7a1fa0aa46@amsat.org>
Date: Mon, 2 Oct 2017 11:11:26 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-36-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 35/38] mips: fulong2e: replace cpu_model
 with cpu_type
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, yongbok.kim@imgtec.com, aurelien@aurel32.net
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 06:08 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: yongbok.kim@imgtec.com
> CC: aurelien@aurel32.net
> ---
>   hw/mips/mips_fulong2e.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 7531868..146cf0f 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -258,7 +258,6 @@ static void network_init (PCIBus *pci_bus)
>   static void mips_fulong2e_init(MachineState *machine)
>   {
>       ram_addr_t ram_size = machine->ram_size;
> -    const char *cpu_model = machine->cpu_model;
>       const char *kernel_filename = machine->kernel_filename;
>       const char *kernel_cmdline = machine->kernel_cmdline;
>       const char *initrd_filename = machine->initrd_filename;
> @@ -277,10 +276,7 @@ static void mips_fulong2e_init(MachineState *machine)
>       CPUMIPSState *env;
>   
>       /* init CPUs */
> -    if (cpu_model == NULL) {
> -        cpu_model = "Loongson-2E";
> -    }
> -    cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
> +    cpu = MIPS_CPU(cpu_create(machine->cpu_type));
>       env = &cpu->env;
>   
>       qemu_register_reset(main_cpu_reset, cpu);
> @@ -385,6 +381,7 @@ static void mips_fulong2e_machine_init(MachineClass *mc)
>       mc->desc = "Fulong 2e mini pc";
>       mc->init = mips_fulong2e_init;
>       mc->block_default_type = IF_IDE;
> +    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("Loongson-2E");
>   }
>   
>   DEFINE_MACHINE("fulong2e", mips_fulong2e_machine_init)
> 
