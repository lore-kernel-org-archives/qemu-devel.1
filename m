Received: from eggs.gnu.org ([2001:4830:134:3::10]:43995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1TY-0006qC-Dm
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1TQ-0003WK-Os
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:40 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1TQ-0003WE-Kn
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:32 -0400
Received: by mail-qk0-x242.google.com with SMTP id z14so3931368qkg.3
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 07:13:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-15-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a5bd47c5-c17f-c1ed-7787-d55886ee6026@amsat.org>
Date: Mon, 2 Oct 2017 11:13:29 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-15-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 14/38] moxie: use generic cpu_model parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: green@moxielogic.com
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 06:07 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: green@moxielogic.com
> ---
>   hw/moxie/moxiesim.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
> index 01b9f34..3ba5848 100644
> --- a/hw/moxie/moxiesim.c
> +++ b/hw/moxie/moxiesim.c
> @@ -103,7 +103,6 @@ static void moxiesim_init(MachineState *machine)
>   {
>       MoxieCPU *cpu = NULL;
>       ram_addr_t ram_size = machine->ram_size;
> -    const char *cpu_model = machine->cpu_model;
>       const char *kernel_filename = machine->kernel_filename;
>       const char *kernel_cmdline = machine->kernel_cmdline;
>       const char *initrd_filename = machine->initrd_filename;
> @@ -115,10 +114,7 @@ static void moxiesim_init(MachineState *machine)
>       LoaderParams loader_params;
>   
>       /* Init CPUs. */
> -    if (cpu_model == NULL) {
> -        cpu_model = "MoxieLite";
> -    }
> -    cpu = MOXIE_CPU(cpu_generic_init(TYPE_MOXIE_CPU, cpu_model));
> +    cpu = MOXIE_CPU(cpu_create(machine->cpu_type));
>       env = &cpu->env;
>   
>       qemu_register_reset(main_cpu_reset, cpu);
> @@ -150,6 +146,7 @@ static void moxiesim_machine_init(MachineClass *mc)
>       mc->desc = "Moxie simulator platform";
>       mc->init = moxiesim_init;
>       mc->is_default = 1;
> +    mc->default_cpu_type = MOXIE_CPU_TYPE_NAME("MoxieLite");
>   }
>   
>   DEFINE_MACHINE("moxiesim", moxiesim_machine_init)
> 
