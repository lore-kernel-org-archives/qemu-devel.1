Received: from eggs.gnu.org ([2001:4830:134:3::10]:36450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNLH-0004fg-15
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNLD-0007H7-Ry
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:34:35 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:50587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNLD-0007G8-NT
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:34:31 -0400
Received: by mail-qt0-x243.google.com with SMTP id f15so12964714qtf.7
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 06:34:31 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-24-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <316ae405-8e88-d3d2-fac8-e7b3969a68ba@amsat.org>
Date: Tue, 3 Oct 2017 10:34:27 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-24-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 23/38] xtensa: sim: use generic cpu_model
 parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: jcmvbkbc@gmail.com

On 10/02/2017 06:08 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: jcmvbkbc@gmail.com
> ---
>  hw/xtensa/sim.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
> index b3580b1..2bb883b 100644
> --- a/hw/xtensa/sim.c
> +++ b/hw/xtensa/sim.c
> @@ -75,16 +75,11 @@ static void xtensa_sim_init(MachineState *machine)
>      XtensaCPU *cpu = NULL;
>      CPUXtensaState *env = NULL;
>      ram_addr_t ram_size = machine->ram_size;
> -    const char *cpu_model = machine->cpu_model;
>      const char *kernel_filename = machine->kernel_filename;
>      int n;
>  
> -    if (!cpu_model) {
> -        cpu_model = XTENSA_DEFAULT_CPU_MODEL;
> -    }
> -
>      for (n = 0; n < smp_cpus; n++) {
> -        cpu = XTENSA_CPU(cpu_generic_init(TYPE_XTENSA_CPU, cpu_model));
> +        cpu = XTENSA_CPU(cpu_create(machine->cpu_type));
>          env = &cpu->env;
>  
>          env->sregs[PRID] = n;
> @@ -133,6 +128,7 @@ static void xtensa_sim_machine_init(MachineClass *mc)
>      mc->init = xtensa_sim_init;
>      mc->max_cpus = 4;
>      mc->no_serial = 1;
> +    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
>  }
>  
>  DEFINE_MACHINE("sim", xtensa_sim_machine_init)
> 
