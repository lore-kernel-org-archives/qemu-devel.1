Received: from eggs.gnu.org ([2001:4830:134:3::10]:57270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz250-0002xe-Va
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz24x-0003Fn-Sp
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:52:23 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz24x-0003FZ-O4
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:52:19 -0400
Received: by mail-qk0-x241.google.com with SMTP id z14so4011302qkg.3
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 07:52:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-6-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d9f6c8c3-8300-bc33-ae7c-0f4acf113d1d@amsat.org>
Date: Mon, 2 Oct 2017 11:52:16 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-6-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/38] cris: use generic cpu_model parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, edgar.iglesias@gmail.com
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 06:07 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: edgar.iglesias@gmail.com
> ---
>   hw/cris/axis_dev88.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
> index 5eb552b..9ccc435 100644
> --- a/hw/cris/axis_dev88.c
> +++ b/hw/cris/axis_dev88.c
> @@ -251,7 +251,6 @@ static
>   void axisdev88_init(MachineState *machine)
>   {
>       ram_addr_t ram_size = machine->ram_size;
> -    const char *cpu_model = machine->cpu_model;
>       const char *kernel_filename = machine->kernel_filename;
>       const char *kernel_cmdline = machine->kernel_cmdline;
>       CRISCPU *cpu;
> @@ -268,10 +267,7 @@ void axisdev88_init(MachineState *machine)
>       MemoryRegion *phys_intmem = g_new(MemoryRegion, 1);
>   
>       /* init CPUs */
> -    if (cpu_model == NULL) {
> -        cpu_model = "crisv32";
> -    }
> -    cpu = CRIS_CPU(cpu_generic_init(TYPE_CRIS_CPU, cpu_model));
> +    cpu = CRIS_CPU(cpu_create(machine->cpu_type));
>       env = &cpu->env;
>   
>       /* allocate RAM */
> @@ -359,6 +355,7 @@ static void axisdev88_machine_init(MachineClass *mc)
>       mc->desc = "AXIS devboard 88";
>       mc->init = axisdev88_init;
>       mc->is_default = 1;
> +    mc->default_cpu_type = CRIS_CPU_TYPE_NAME("crisv32");
>   }
>   
>   DEFINE_MACHINE("axis-dev88", axisdev88_machine_init)
> 
