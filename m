Received: from eggs.gnu.org ([2001:4830:134:3::10]:47739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fL74x-0005jX-3M
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fL74t-0002Dr-Sr
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:11:51 -0400
Received: from 17.mo6.mail-out.ovh.net ([46.105.36.150]:40107)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fL74t-00029C-Jd
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:11:47 -0400
Received: from player791.ha.ovh.net (unknown [10.109.122.44])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 9CD0615D5B4
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 15:11:37 +0200 (CEST)
Date: Tue, 22 May 2018 15:11:15 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180522151115.7aa526cd@bahia.lan>
In-Reply-To: <20180522104000.9044-5-peter.maydell@linaro.org>
References: <20180522104000.9044-1-peter.maydell@linaro.org>
	<20180522104000.9044-5-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 4/5] ppc: Rename 2.13 machines
 to 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, patches@linaro.org, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Tue, 22 May 2018 11:39:59 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> Rename the 2.13 machines to match the number we're going to
> use for the next release.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/ppc/cpu.h                |  2 +-
>  hw/ppc/spapr.c                  | 14 +++++++-------
>  target/ppc/machine.c            |  8 ++++----
>  target/ppc/translate_init.inc.c |  2 +-
>  4 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 7ccd2f460e..0247c1f04c 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1215,7 +1215,7 @@ struct PowerPCCPU {
>      uint64_t mig_insns_flags2;
>      uint32_t mig_nb_BATs;
>      bool pre_2_10_migration;
> -    bool pre_2_13_migration;
> +    bool pre_3_0_migration;
>      int32_t mig_slb_nr;
>  };
>  
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ebf30dd60b..213f6f9599 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4071,18 +4071,18 @@ static const TypeInfo spapr_machine_info = {
>      type_init(spapr_machine_register_##suffix)
>  
>  /*
> - * pseries-2.13
> + * pseries-3.0
>   */
> -static void spapr_machine_2_13_instance_options(MachineState *machine)
> +static void spapr_machine_3_0_instance_options(MachineState *machine)
>  {
>  }
>  
> -static void spapr_machine_2_13_class_options(MachineClass *mc)
> +static void spapr_machine_3_0_class_options(MachineClass *mc)
>  {
>      /* Defaults for the latest behaviour inherited from the base class */
>  }
>  
> -DEFINE_SPAPR_MACHINE(2_13, "2.13", true);
> +DEFINE_SPAPR_MACHINE(3_0, "3.0", true);
>  
>  /*
>   * pseries-2.12
> @@ -4091,18 +4091,18 @@ DEFINE_SPAPR_MACHINE(2_13, "2.13", true);
>      HW_COMPAT_2_12                                                     \
>      {                                                                  \
>          .driver = TYPE_POWERPC_CPU,                                    \
> -        .property = "pre-2.13-migration",                              \
> +        .property = "pre-3.0-migration",                              \
>          .value    = "on",                                              \
>      },
>  
>  static void spapr_machine_2_12_instance_options(MachineState *machine)
>  {
> -    spapr_machine_2_13_instance_options(machine);
> +    spapr_machine_3_0_instance_options(machine);
>  }
>  
>  static void spapr_machine_2_12_class_options(MachineClass *mc)
>  {
> -    spapr_machine_2_13_class_options(mc);
> +    spapr_machine_3_0_class_options(mc);
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_12);
>  }
>  
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index ba1b9e531f..b2745ec4e5 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -150,11 +150,11 @@ static bool cpu_pre_2_8_migration(void *opaque, int version_id)
>  }
>  
>  #if defined(TARGET_PPC64)
> -static bool cpu_pre_2_13_migration(void *opaque, int version_id)
> +static bool cpu_pre_3_0_migration(void *opaque, int version_id)
>  {
>      PowerPCCPU *cpu = opaque;
>  
> -    return cpu->pre_2_13_migration;
> +    return cpu->pre_3_0_migration;
>  }
>  #endif
>  
> @@ -220,7 +220,7 @@ static int cpu_pre_save(void *opaque)
>          cpu->mig_insns_flags2 = env->insns_flags2 & insns_compat_mask2;
>          cpu->mig_nb_BATs = env->nb_BATs;
>      }
> -    if (cpu->pre_2_13_migration) {
> +    if (cpu->pre_3_0_migration) {
>          if (cpu->hash64_opts) {
>              cpu->mig_slb_nr = cpu->hash64_opts->slb_size;
>          }
> @@ -517,7 +517,7 @@ static const VMStateDescription vmstate_slb = {
>      .needed = slb_needed,
>      .post_load = slb_post_load,
>      .fields = (VMStateField[]) {
> -        VMSTATE_INT32_TEST(mig_slb_nr, PowerPCCPU, cpu_pre_2_13_migration),
> +        VMSTATE_INT32_TEST(mig_slb_nr, PowerPCCPU, cpu_pre_3_0_migration),
>          VMSTATE_SLB_ARRAY(env.slb, PowerPCCPU, MAX_SLB_ENTRIES),
>          VMSTATE_END_OF_LIST()
>      }
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
> index a0b3f184b2..ab782cb32a 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -10427,7 +10427,7 @@ static Property ppc_cpu_properties[] = {
>      DEFINE_PROP_BOOL("pre-2.8-migration", PowerPCCPU, pre_2_8_migration, false),
>      DEFINE_PROP_BOOL("pre-2.10-migration", PowerPCCPU, pre_2_10_migration,
>                       false),
> -    DEFINE_PROP_BOOL("pre-2.13-migration", PowerPCCPU, pre_2_13_migration,
> +    DEFINE_PROP_BOOL("pre-3.0-migration", PowerPCCPU, pre_3_0_migration,
>                       false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
