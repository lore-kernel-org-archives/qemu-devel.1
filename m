Received: from eggs.gnu.org ([2001:4830:134:3::10]:53422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz7Kb-0004QU-Fg
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz7KX-0005Zs-C9
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:28:49 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:38118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz7KX-0005ZY-8q
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:28:45 -0400
Received: by mail-qk0-x243.google.com with SMTP id q8so4635925qkl.5
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 13:28:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-8-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ddd580d5-46bc-bbde-fa41-cb8fe15e6dd0@amsat.org>
Date: Mon, 2 Oct 2017 17:28:41 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-8-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/38] lm32: milkymist: use generic
 cpu_model parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: michael@walle.cc
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 06:07 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: michael@walle.cc
> ---
>   hw/lm32/milkymist.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
> index 4db4d2d..d4e765f 100644
> --- a/hw/lm32/milkymist.c
> +++ b/hw/lm32/milkymist.c
> @@ -80,7 +80,6 @@ static void main_cpu_reset(void *opaque)
>   static void
>   milkymist_init(MachineState *machine)
>   {
> -    const char *cpu_model = machine->cpu_model;
>       const char *kernel_filename = machine->kernel_filename;
>       const char *kernel_cmdline = machine->kernel_cmdline;
>       const char *initrd_filename = machine->initrd_filename;
> @@ -108,10 +107,7 @@ milkymist_init(MachineState *machine)
>   
>       reset_info = g_malloc0(sizeof(ResetInfo));
>   
> -    if (cpu_model == NULL) {
> -        cpu_model = "lm32-full";
> -    }
> -    cpu = LM32_CPU(cpu_generic_init(TYPE_LM32_CPU, cpu_model));
> +    cpu = LM32_CPU(cpu_create(machine->cpu_type));
>   
>       env = &cpu->env;
>       reset_info->cpu = cpu;
> @@ -216,6 +212,7 @@ static void milkymist_machine_init(MachineClass *mc)
>       mc->desc = "Milkymist One";
>       mc->init = milkymist_init;
>       mc->is_default = 0;
> +    mc->default_cpu_type = LM32_CPU_TYPE_NAME("lm32-full");
>   }
>   
>   DEFINE_MACHINE("milkymist", milkymist_machine_init)
> 
