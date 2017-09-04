Received: from eggs.gnu.org ([208.118.235.92]:48524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dot6M-0004Pt-CT
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dot5v-0006No-TP
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:15:50 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dot5v-0006NY-M3
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:15:23 -0400
Received: by mail-qk0-x243.google.com with SMTP id o77so407943qke.2
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 08:15:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1504533662-198084-1-git-send-email-imammedo@redhat.com>
	<1504533662-198084-3-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3ae5cf75-a8a4-2265-d07b-b1e90d3ac70c@amsat.org>
Date: Mon, 4 Sep 2017 12:15:13 -0300
MIME-Version: 1.0
In-Reply-To: <1504533662-198084-3-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/6] cpu: make cpu_generic_init() abort
 QEMU on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony Green <green@moxielogic.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Filippov <jcmvbkbc@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Jia Liu <proljc@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Alexander Graf <agraf@suse.de>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Andrew Jones <drjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Fabien Chouteau <chouteau@adacore.com>, Jan Kiszka <jan.kiszka@web.de>, Yongbok Kim <yongbok.kim@imgtec.com>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <huth@tuxfamily.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>, Aurelien Jarno <aurelien@aurel32.net>

On 09/04/2017 11:00 AM, Igor Mammedov wrote:
> Almost every user of cpu_generic_init() checks for
> returned NULL and then reports failure in a custom way
> and aborts process.
> Some users assume that call can't fail and don't check
> for failure, though they should have checked for it.
> 
> In either cases cpu_generic_init() failure is fatal,
> so instead of checking for failure and reporting
> it various ways, make cpu_generic_init() report
> errors in consistent way and terminate QEMU on failure.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> Even though it's tree wide change, it's trivial so all
> affected call sites are included within one patch.
> 
> CC: Richard Henderson <rth@twiddle.net>
> CC: Jan Kiszka <jan.kiszka@web.de>
> CC: Peter Maydell <peter.maydell@linaro.org>
> CC: Andrzej Zaborowski <balrogg@gmail.com>
> CC: Michael Walle <michael@walle.cc>
> CC: Thomas Huth <huth@tuxfamily.org>
> CC: Aurelien Jarno <aurelien@aurel32.net>
> CC: Yongbok Kim <yongbok.kim@imgtec.com>
> CC: "Hervé Poussineau" <hpoussin@reactos.org>
> CC: Anthony Green <green@moxielogic.com>
> CC: Jia Liu <proljc@gmail.com>
> CC: Stafford Horne <shorne@gmail.com>
> CC: Alexander Graf <agraf@suse.de>
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> CC: Magnus Damm <magnus.damm@gmail.com>
> CC: Fabien Chouteau <chouteau@adacore.com>
> CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> CC: Artyom Tarasenko <atar4qemu@gmail.com>
> CC: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
> CC: Max Filippov <jcmvbkbc@gmail.com>
> CC: Riku Voipio <riku.voipio@iki.fi>
> CC: Laurent Vivier <laurent@vivier.eu>
> 
> ---
>   include/qom/cpu.h              |  3 ++-
>   bsd-user/main.c                |  4 ----
>   hw/alpha/dp264.c               |  4 ----
>   hw/arm/musicpal.c              |  4 ----
>   hw/arm/omap1.c                 |  4 ----
>   hw/arm/omap2.c                 |  4 ----
>   hw/arm/pxa2xx.c                |  8 --------
>   hw/arm/strongarm.c             |  5 -----
>   hw/lm32/lm32_boards.c          |  8 --------
>   hw/lm32/milkymist.c            |  4 ----
>   hw/m68k/an5206.c               |  4 ----
>   hw/m68k/mcf5208.c              |  4 ----
>   hw/mips/cps.c                  |  4 ----
>   hw/mips/mips_fulong2e.c        |  4 ----
>   hw/mips/mips_jazz.c            |  4 ----
>   hw/mips/mips_malta.c           |  4 ----
>   hw/mips/mips_mipssim.c         |  4 ----
>   hw/mips/mips_r4k.c             |  4 ----
>   hw/moxie/moxiesim.c            |  4 ----
>   hw/openrisc/openrisc_sim.c     |  4 ----
>   hw/ppc/e500.c                  |  4 ----
>   hw/ppc/mac_newworld.c          |  4 ----
>   hw/ppc/mac_oldworld.c          |  4 ----
>   hw/ppc/ppc440_bamboo.c         |  4 ----
>   hw/ppc/ppc4xx_devs.c           |  5 -----
>   hw/ppc/prep.c                  |  9 ---------
>   hw/ppc/virtex_ml507.c          |  4 ----
>   hw/sh4/r2d.c                   |  4 ----
>   hw/sh4/shix.c                  |  4 ----
>   hw/sparc/leon3.c               |  4 ----
>   hw/sparc/sun4m.c               |  4 ----
>   hw/sparc64/sparc64.c           |  4 ----
>   hw/tricore/tricore_testboard.c |  4 ----
>   hw/unicore32/puv3.c            |  4 ----
>   hw/xtensa/sim.c                |  5 -----
>   hw/xtensa/xtfpga.c             |  5 -----
>   linux-user/main.c              |  4 ----
>   qom/cpu.c                      | 13 ++++++-------
>   38 files changed, 8 insertions(+), 169 deletions(-)
> 
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index a92a7d2..392ae75 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -649,7 +649,8 @@ CPUState *cpu_create(const char *typename);
>    *
>    * processes optional parameters and registers them as global properties
>    *
> - * Returns: type of CPU to create or %NULL if an error occurred.
> + * Returns: type of CPU to create or prints error and terminates process
> + *          if an error occurred.
>    */
>   const char *cpu_parse_features(const char *typename, const char *cpu_model);
>   
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index 8a6706a..836daac 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -902,10 +902,6 @@ int main(int argc, char **argv)
>       /* NOTE: we need to init the CPU at this stage to get
>          qemu_host_page_size */
>       cpu = cpu_init(cpu_model);
> -    if (!cpu) {
> -        fprintf(stderr, "Unable to find CPU definition\n");
> -        exit(1);
> -    }
>       env = cpu->env_ptr;
>   #if defined(TARGET_SPARC) || defined(TARGET_PPC)
>       cpu_reset(cpu);
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index 1c5a177..1b12130 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -68,10 +68,6 @@ static void clipper_init(MachineState *machine)
>       memset(cpus, 0, sizeof(cpus));
>       for (i = 0; i < smp_cpus; ++i) {
>           cpus[i] = ALPHA_CPU(cpu_generic_init(TYPE_ALPHA_CPU, cpu_model));
> -        if (!cpus[i]) {
> -            error_report("Unable to find CPU definition");
> -            exit(1);
> -        }
>       }
>   
>       cpus[0]->env.trap_arg0 = ram_size;
> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> index a8b3d46..64c8e09 100644
> --- a/hw/arm/musicpal.c
> +++ b/hw/arm/musicpal.c
> @@ -1594,10 +1594,6 @@ static void musicpal_init(MachineState *machine)
>           cpu_model = "arm926";
>       }
>       cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, cpu_model));
> -    if (!cpu) {
> -        fprintf(stderr, "Unable to find CPU definition\n");
> -        exit(1);
> -    }
>   
>       /* For now we use a fixed - the original - RAM size */
>       memory_region_allocate_system_memory(ram, NULL, "musicpal.ram",
> diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
> index 400ba30..04e65ce 100644
> --- a/hw/arm/omap1.c
> +++ b/hw/arm/omap1.c
> @@ -3864,10 +3864,6 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *system_memory,
>       /* Core */
>       s->mpu_model = omap310;
>       s->cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, core));
> -    if (s->cpu == NULL) {
> -        fprintf(stderr, "Unable to find CPU definition\n");
> -        exit(1);
> -    }
>       s->sdram_size = sdram_size;
>       s->sram_size = OMAP15XX_SRAM_SIZE;
>   
> diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
> index ece25ae..5821477 100644
> --- a/hw/arm/omap2.c
> +++ b/hw/arm/omap2.c
> @@ -2262,10 +2262,6 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
>       /* Core */
>       s->mpu_model = omap2420;
>       s->cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, core ?: "arm1136-r2"));
> -    if (s->cpu == NULL) {
> -        fprintf(stderr, "Unable to find CPU definition\n");
> -        exit(1);
> -    }
>       s->sdram_size = sdram_size;
>       s->sram_size = OMAP242X_SRAM_SIZE;
>   
> diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
> index b0ac3cf..c16657d 100644
> --- a/hw/arm/pxa2xx.c
> +++ b/hw/arm/pxa2xx.c
> @@ -2067,10 +2067,6 @@ PXA2xxState *pxa270_init(MemoryRegion *address_space,
>           revision = "pxa270";
>   
>       s->cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, revision));
> -    if (s->cpu == NULL) {
> -        fprintf(stderr, "Unable to find CPU definition\n");
> -        exit(1);
> -    }
>       s->reset = qemu_allocate_irq(pxa2xx_reset, s, 0);
>   
>       /* SDRAM & Internal Memory Storage */
> @@ -2197,10 +2193,6 @@ PXA2xxState *pxa255_init(MemoryRegion *address_space, unsigned int sdram_size)
>       s = g_new0(PXA2xxState, 1);
>   
>       s->cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, "pxa255"));
> -    if (s->cpu == NULL) {
> -        fprintf(stderr, "Unable to find CPU definition\n");
> -        exit(1);
> -    }
>       s->reset = qemu_allocate_irq(pxa2xx_reset, s, 0);
>   
>       /* SDRAM & Internal Memory Storage */
> diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
> index 884242b..c1145dd 100644
> --- a/hw/arm/strongarm.c
> +++ b/hw/arm/strongarm.c
> @@ -1599,11 +1599,6 @@ StrongARMState *sa1110_init(MemoryRegion *sysmem,
>   
>       s->cpu = ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, rev));
>   
> -    if (!s->cpu) {
> -        error_report("Unable to find CPU definition");
> -        exit(1);
> -    }
> -
>       memory_region_allocate_system_memory(&s->sdram, NULL, "strongarm.sdram",
>                                            sdram_size);
>       memory_region_add_subregion(sysmem, SA_SDCS0, &s->sdram);
> diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
> index eccf0ac..b0bb3ef 100644
> --- a/hw/lm32/lm32_boards.c
> +++ b/hw/lm32/lm32_boards.c
> @@ -105,10 +105,6 @@ static void lm32_evr_init(MachineState *machine)
>           cpu_model = "lm32-full";
>       }
>       cpu = LM32_CPU(cpu_generic_init(TYPE_LM32_CPU, cpu_model));
> -    if (cpu == NULL) {
> -        fprintf(stderr, "qemu: unable to find CPU '%s'\n", cpu_model);
> -        exit(1);
> -    }
>   
>       env = &cpu->env;
>       reset_info->cpu = cpu;
> @@ -206,10 +202,6 @@ static void lm32_uclinux_init(MachineState *machine)
>           cpu_model = "lm32-full";
>       }
>       cpu = LM32_CPU(cpu_generic_init(TYPE_LM32_CPU, cpu_model));
> -    if (cpu == NULL) {
> -        fprintf(stderr, "qemu: unable to find CPU '%s'\n", cpu_model);
> -        exit(1);
> -    }
>   
>       env = &cpu->env;
>       reset_info->cpu = cpu;
> diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
> index dffd879..4db4d2d 100644
> --- a/hw/lm32/milkymist.c
> +++ b/hw/lm32/milkymist.c
> @@ -112,10 +112,6 @@ milkymist_init(MachineState *machine)
>           cpu_model = "lm32-full";
>       }
>       cpu = LM32_CPU(cpu_generic_init(TYPE_LM32_CPU, cpu_model));
> -    if (cpu == NULL) {
> -        fprintf(stderr, "qemu: unable to find CPU '%s'\n", cpu_model);
> -        exit(1);
> -    }
>   
>       env = &cpu->env;
>       reset_info->cpu = cpu;
> diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
> index 7b9b15d..9002c46 100644
> --- a/hw/m68k/an5206.c
> +++ b/hw/m68k/an5206.c
> @@ -43,10 +43,6 @@ static void an5206_init(MachineState *machine)
>           cpu_model = "m5206";
>       }
>       cpu = M68K_CPU(cpu_generic_init(TYPE_M68K_CPU, cpu_model));
> -    if (!cpu) {
> -        error_report("Unable to find m68k CPU definition");
> -        exit(1);
> -    }
>       env = &cpu->env;
>   
>       /* Initialize CPU registers.  */
> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
> index 1a0f180..b9dde75 100644
> --- a/hw/m68k/mcf5208.c
> +++ b/hw/m68k/mcf5208.c
> @@ -233,10 +233,6 @@ static void mcf5208evb_init(MachineState *machine)
>           cpu_model = "m5208";
>       }
>       cpu = M68K_CPU(cpu_generic_init(TYPE_M68K_CPU, cpu_model));
> -    if (!cpu) {
> -        fprintf(stderr, "Unable to find m68k CPU definition\n");
> -        exit(1);
> -    }
>       env = &cpu->env;
>   
>       /* Initialize CPU registers.  */
> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> index 4ef337d..79d4c5e 100644
> --- a/hw/mips/cps.c
> +++ b/hw/mips/cps.c
> @@ -72,10 +72,6 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
>   
>       for (i = 0; i < s->num_vp; i++) {
>           cpu = cpu_mips_init(s->cpu_model);
> -        if (cpu == NULL) {
> -            error_setg(errp, "%s: CPU initialization failed",  __func__);
> -            return;
> -        }
>   
>           /* Init internal devices */
>           cpu_mips_irq_init_cpu(cpu);
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 3532399..439a3d7 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -281,10 +281,6 @@ static void mips_fulong2e_init(MachineState *machine)
>           cpu_model = "Loongson-2E";
>       }
>       cpu = cpu_mips_init(cpu_model);
> -    if (cpu == NULL) {
> -        fprintf(stderr, "Unable to find CPU definition\n");
> -        exit(1);
> -    }
>       env = &cpu->env;
>   
>       qemu_register_reset(main_cpu_reset, cpu);
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index df2262a..ae10670 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -152,10 +152,6 @@ static void mips_jazz_init(MachineState *machine,
>           cpu_model = "R4000";
>       }
>       cpu = cpu_mips_init(cpu_model);
> -    if (cpu == NULL) {
> -        fprintf(stderr, "Unable to find CPU definition\n");
> -        exit(1);
> -    }
>       env = &cpu->env;
>       qemu_register_reset(main_cpu_reset, cpu);
>   
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index af678f5..c82e0af 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -932,10 +932,6 @@ static void create_cpu_without_cps(const char *cpu_model,
>   
>       for (i = 0; i < smp_cpus; i++) {
>           cpu = cpu_mips_init(cpu_model);
> -        if (cpu == NULL) {
> -            fprintf(stderr, "Unable to find CPU definition\n");
> -            exit(1);
> -        }
>   
>           /* Init internal devices */
>           cpu_mips_irq_init_cpu(cpu);
> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> index 07fc4c2..49cd38d 100644
> --- a/hw/mips/mips_mipssim.c
> +++ b/hw/mips/mips_mipssim.c
> @@ -164,10 +164,6 @@ mips_mipssim_init(MachineState *machine)
>   #endif
>       }
>       cpu = cpu_mips_init(cpu_model);
> -    if (cpu == NULL) {
> -        fprintf(stderr, "Unable to find CPU definition\n");
> -        exit(1);
> -    }
>       env = &cpu->env;
>   
>       reset_info = g_malloc0(sizeof(ResetData));
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index 2f5ced7..60da607 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -194,10 +194,6 @@ void mips_r4k_init(MachineState *machine)
>   #endif
>       }
>       cpu = cpu_mips_init(cpu_model);
> -    if (cpu == NULL) {
> -        fprintf(stderr, "Unable to find CPU definition\n");
> -        exit(1);
> -    }
>       env = &cpu->env;
>   
>       reset_info = g_malloc0(sizeof(ResetData));
> diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
> index 4c27b45..5ea8dd3 100644
> --- a/hw/moxie/moxiesim.c
> +++ b/hw/moxie/moxiesim.c
> @@ -119,10 +119,6 @@ static void moxiesim_init(MachineState *machine)
>           cpu_model = "MoxieLite-moxie-cpu";
>       }
>       cpu = MOXIE_CPU(cpu_generic_init(TYPE_MOXIE_CPU, cpu_model));
> -    if (!cpu) {
> -        fprintf(stderr, "Unable to find CPU definition\n");
> -        exit(1);
> -    }
>       env = &cpu->env;
>   
>       qemu_register_reset(main_cpu_reset, cpu);
> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
> index 243d802..86bf284 100644
> --- a/hw/openrisc/openrisc_sim.c
> +++ b/hw/openrisc/openrisc_sim.c
> @@ -110,10 +110,6 @@ static void openrisc_sim_init(MachineState *machine)
>   
>       for (n = 0; n < smp_cpus; n++) {
>           cpu = OPENRISC_CPU(cpu_generic_init(TYPE_OPENRISC_CPU, cpu_model));
> -        if (cpu == NULL) {
> -            fprintf(stderr, "Unable to find CPU definition!\n");
> -            exit(1);
> -        }
>           qemu_register_reset(main_cpu_reset, cpu);
>           main_cpu_reset(cpu);
>       }
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index f0596f3..fc4786c 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -821,10 +821,6 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
>   
>           cpu = POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
>                                              machine->cpu_model));
> -        if (cpu == NULL) {
> -            fprintf(stderr, "Unable to initialize CPU!\n");
> -            exit(1);
> -        }
>           env = &cpu->env;
>           cs = CPU(cpu);
>   
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index d466634..33b46cb 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -189,10 +189,6 @@ static void ppc_core99_init(MachineState *machine)
>       for (i = 0; i < smp_cpus; i++) {
>           cpu = POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
>                                              machine->cpu_model));
> -        if (cpu == NULL) {
> -            fprintf(stderr, "Unable to find PowerPC CPU definition\n");
> -            exit(1);
> -        }
>           env = &cpu->env;
>   
>           /* Set time-base frequency to 100 Mhz */
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index fcac399..193b904 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -118,10 +118,6 @@ static void ppc_heathrow_init(MachineState *machine)
>       for (i = 0; i < smp_cpus; i++) {
>           cpu = POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
>                                              machine->cpu_model));
> -        if (cpu == NULL) {
> -            fprintf(stderr, "Unable to find PowerPC CPU definition\n");
> -            exit(1);
> -        }
>           env = &cpu->env;
>   
>           /* Set time-base frequency to 16.6 Mhz */
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index ca26398..f92d47f 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -187,10 +187,6 @@ static void bamboo_init(MachineState *machine)
>           machine->cpu_model = "440EP";
>       }
>       cpu = POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, machine->cpu_model));
> -    if (cpu == NULL) {
> -        fprintf(stderr, "Unable to initialize CPU!\n");
> -        exit(1);
> -    }
>       env = &cpu->env;
>   
>       if (env->mmu_model != POWERPC_MMU_BOOKE) {
> diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
> index 6b38ed7..88f3d4c 100644
> --- a/hw/ppc/ppc4xx_devs.c
> +++ b/hw/ppc/ppc4xx_devs.c
> @@ -57,11 +57,6 @@ PowerPCCPU *ppc4xx_init(const char *cpu_model,
>   
>       /* init CPUs */
>       cpu = POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, cpu_model));
> -    if (cpu == NULL) {
> -        fprintf(stderr, "Unable to find PowerPC %s CPU definition\n",
> -                cpu_model);
> -        exit(1);
> -    }
>       env = &cpu->env;
>   
>       cpu_clk->cb = NULL; /* We don't care about CPU clock frequency changes */
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 00f3321..94138a4 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -522,10 +522,6 @@ static void ppc_prep_init(MachineState *machine)
>       for (i = 0; i < smp_cpus; i++) {
>           cpu = POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
>                                              machine->cpu_model));
> -        if (cpu == NULL) {
> -            fprintf(stderr, "Unable to find PowerPC CPU definition\n");
> -            exit(1);
> -        }
>           env = &cpu->env;
>   
>           if (env->flags & POWERPC_FLAG_RTC_CLK) {
> @@ -726,11 +722,6 @@ static void ibm_40p_init(MachineState *machine)
>           machine->cpu_model = "604";
>       }
>       cpu = POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, machine->cpu_model));
> -    if (!cpu) {
> -        error_report("could not initialize CPU '%s'",
> -                     machine->cpu_model);
> -        exit(1);
> -    }
>       env = &cpu->env;
>       if (PPC_INPUT(env) != PPC_FLAGS_INPUT_6xx) {
>           error_report("only 6xx bus is supported on this machine");
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index d5fdc16..ed9b406 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -97,10 +97,6 @@ static PowerPCCPU *ppc440_init_xilinx(ram_addr_t *ram_size,
>       qemu_irq *irqs;
>   
>       cpu = POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, cpu_model));
> -    if (cpu == NULL) {
> -        fprintf(stderr, "Unable to initialize CPU!\n");
> -        exit(1);
> -    }
>       env = &cpu->env;
>   
>       ppc_booke_timers_init(cpu, sysclk, 0/* no flags */);
> diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
> index 22bc534..16b9ed2 100644
> --- a/hw/sh4/r2d.c
> +++ b/hw/sh4/r2d.c
> @@ -247,10 +247,6 @@ static void r2d_init(MachineState *machine)
>       }
>   
>       cpu = SUPERH_CPU(cpu_generic_init(TYPE_SUPERH_CPU, cpu_model));
> -    if (cpu == NULL) {
> -        fprintf(stderr, "Unable to find CPU definition\n");
> -        exit(1);
> -    }
>       env = &cpu->env;
>   
>       reset_info = g_malloc0(sizeof(ResetData));
> diff --git a/hw/sh4/shix.c b/hw/sh4/shix.c
> index 7f8a4b6..50ee36a 100644
> --- a/hw/sh4/shix.c
> +++ b/hw/sh4/shix.c
> @@ -57,10 +57,6 @@ static void shix_init(MachineState *machine)
>           cpu_model = "any";
>   
>       cpu = SUPERH_CPU(cpu_generic_init(TYPE_SUPERH_CPU, cpu_model));
> -    if (cpu == NULL) {
> -        fprintf(stderr, "Unable to find CPU definition\n");
> -        exit(1);
> -    }
>   
>       /* Allocate memory space */
>       memory_region_init_ram(rom, NULL, "shix.rom", 0x4000, &error_fatal);
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 56512ec..ec2816b 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -127,10 +127,6 @@ static void leon3_generic_hw_init(MachineState *machine)
>       }
>   
>       cpu = SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
> -    if (cpu == NULL) {
> -        fprintf(stderr, "qemu: Unable to find Sparc CPU definition\n");
> -        exit(1);
> -    }
>       env = &cpu->env;
>   
>       cpu_sparc_set_id(env, 0);
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index cf47dca..e1bdd48 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -798,10 +798,6 @@ static void cpu_devinit(const char *cpu_model, unsigned int id,
>       CPUSPARCState *env;
>   
>       cpu = SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
> -    if (cpu == NULL) {
> -        fprintf(stderr, "qemu: Unable to find Sparc CPU definition\n");
> -        exit(1);
> -    }
>       env = &cpu->env;
>   
>       cpu_sparc_set_id(env, id);
> diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
> index ecf38a4..097d529 100644
> --- a/hw/sparc64/sparc64.c
> +++ b/hw/sparc64/sparc64.c
> @@ -354,10 +354,6 @@ SPARCCPU *sparc64_cpu_devinit(const char *cpu_model,
>           cpu_model = default_cpu_model;
>       }
>       cpu = SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
> -    if (cpu == NULL) {
> -        fprintf(stderr, "Unable to find Sparc CPU definition\n");
> -        exit(1);
> -    }
>       env = &cpu->env;
>   
>       env->tick = cpu_timer_create("tick", cpu, tick_irq,
> diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
> index 3fcd8bb..0486f8a 100644
> --- a/hw/tricore/tricore_testboard.c
> +++ b/hw/tricore/tricore_testboard.c
> @@ -75,10 +75,6 @@ static void tricore_testboard_init(MachineState *machine, int board_id)
>           machine->cpu_model = "tc1796";
>       }
>       cpu = TRICORE_CPU(cpu_generic_init(TYPE_TRICORE_CPU, machine->cpu_model));
> -    if (!cpu) {
> -        error_report("Unable to find CPU definition");
> -        exit(1);
> -    }
>       env = &cpu->env;
>       memory_region_init_ram(ext_cram, NULL, "powerlink_ext_c.ram",
>                              2 * 1024 * 1024, &error_fatal);
> diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
> index eb9862f..504ea46 100644
> --- a/hw/unicore32/puv3.c
> +++ b/hw/unicore32/puv3.c
> @@ -128,10 +128,6 @@ static void puv3_init(MachineState *machine)
>       }
>   
>       cpu = UNICORE32_CPU(cpu_generic_init(TYPE_UNICORE32_CPU, cpu_model));
> -    if (!cpu) {
> -        error_report("Unable to find CPU definition");
> -        exit(1);
> -    }
>       env = &cpu->env;
>   
>       puv3_soc_init(env);
> diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
> index 1b4767f..b3580b1 100644
> --- a/hw/xtensa/sim.c
> +++ b/hw/xtensa/sim.c
> @@ -85,11 +85,6 @@ static void xtensa_sim_init(MachineState *machine)
>   
>       for (n = 0; n < smp_cpus; n++) {
>           cpu = XTENSA_CPU(cpu_generic_init(TYPE_XTENSA_CPU, cpu_model));
> -        if (cpu == NULL) {
> -            error_report("unable to find CPU definition '%s'",
> -                         cpu_model);
> -            exit(EXIT_FAILURE);
> -        }
>           env = &cpu->env;
>   
>           env->sregs[PRID] = n;
> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
> index 182ec1e..a19cceb 100644
> --- a/hw/xtensa/xtfpga.c
> +++ b/hw/xtensa/xtfpga.c
> @@ -233,11 +233,6 @@ static void lx_init(const LxBoardDesc *board, MachineState *machine)
>   
>       for (n = 0; n < smp_cpus; n++) {
>           cpu = XTENSA_CPU(cpu_generic_init(TYPE_XTENSA_CPU, cpu_model));
> -        if (cpu == NULL) {
> -            error_report("unable to find CPU definition '%s'",
> -                         cpu_model);
> -            exit(EXIT_FAILURE);
> -        }
>           env = &cpu->env;
>   
>           env->sregs[PRID] = n;
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 03666ef..829f974 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -4323,10 +4323,6 @@ int main(int argc, char **argv, char **envp)
>       /* NOTE: we need to init the CPU at this stage to get
>          qemu_host_page_size */
>       cpu = cpu_init(cpu_model);
> -    if (!cpu) {
> -        fprintf(stderr, "Unable to find CPU definition\n");
> -        exit(EXIT_FAILURE);
> -    }
>       env = cpu->env_ptr;
>       cpu_reset(cpu);
>   
> diff --git a/qom/cpu.c b/qom/cpu.c
> index d715890..307d638 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -61,7 +61,7 @@ CPUState *cpu_create(const char *typename)
>       if (err != NULL) {
>           error_report_err(err);
>           object_unref(OBJECT(cpu));
> -        return NULL;
> +        exit(EXIT_FAILURE);
>       }
>       return cpu;
>   }
> @@ -78,8 +78,9 @@ const char *cpu_parse_features(const char *typename, const char *cpu_model)
>   
>       oc = cpu_class_by_name(typename, model_pieces[0]);
>       if (oc == NULL) {
> +        error_report("unable to find CPU model '%s'", model_pieces[0]);
>           g_strfreev(model_pieces);
> -        return NULL;
> +        exit(EXIT_FAILURE);
>       }
>   
>       cpu_type = object_class_get_name(oc);
> @@ -88,7 +89,7 @@ const char *cpu_parse_features(const char *typename, const char *cpu_model)
>       g_strfreev(model_pieces);
>       if (err != NULL) {
>           error_report_err(err);
> -        return NULL;
> +        exit(EXIT_FAILURE);
>       }
>       return cpu_type;
>   }
> @@ -100,10 +101,8 @@ CPUState *cpu_generic_init(const char *typename, const char *cpu_model)
>        */
>       const char *cpu_type = cpu_parse_features(typename, cpu_model);
>   
> -    if (cpu_type) {
> -        return cpu_create(cpu_type);
> -    }
> -    return NULL;
> +    assert(cpu_type);

This assert seems now superfluous.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +    return cpu_create(cpu_type);
>   }
>   
>   bool cpu_paging_enabled(const CPUState *cpu)
> 
