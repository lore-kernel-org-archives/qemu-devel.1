Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2887C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:18:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C11820818
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C11820818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45035 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRZ0K-0004IC-Cc
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 05:18:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRYzU-0003rf-85
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRYzS-0000xV-7D
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:17:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hRYzR-0000x9-VK
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:17:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 77A98308FBB1;
	Fri, 17 May 2019 09:17:14 +0000 (UTC)
Received: from Igors-MacBook-Pro (unknown [10.40.205.69])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2F3931001E93;
	Fri, 17 May 2019 09:17:11 +0000 (UTC)
Date: Fri, 17 May 2019 11:17:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Like Xu <like.xu@linux.intel.com>
Message-ID: <20190517111705.61932da0@Igors-MacBook-Pro>
In-Reply-To: <1557131596-25403-5-git-send-email-like.xu@linux.intel.com>
References: <1557131596-25403-1-git-send-email-like.xu@linux.intel.com>
	<1557131596-25403-5-git-send-email-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 17 May 2019 09:17:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 04/10] cpu/topology: add uncommon arch
 support for smp machine properties
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Philippe =?UTF-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair23@gmail.com>,
	Alex =?UTF-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  6 May 2019 16:33:10 +0800
Like Xu <like.xu@linux.intel.com> wrote:

subject doesn't match what this patch is doing

> Following the replace rules, the global smp variables in hppa/mips/openrisc
if I didn't recall what rules might be, I wouldn't understand what it is about.

> /sparc*/xtensa are replaced with smp machine properties. No semantic changes.

It would be better to rephrase commit message and make it more verbose,
note that commit message exists not only for reviewers but also
for whomever comes later (without knowing about implied context).
So commit message should explain insufficient details what patch is doing.


> 
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>  hw/alpha/dp264.c           | 1 +
>  hw/hppa/machine.c          | 2 ++
>  hw/mips/boston.c           | 2 +-
>  hw/mips/mips_malta.c       | 2 ++
>  hw/openrisc/openrisc_sim.c | 1 +
>  hw/sparc/sun4m.c           | 2 ++
>  hw/sparc64/sun4u.c         | 4 ++--
>  hw/xtensa/sim.c            | 2 +-
>  hw/xtensa/xtfpga.c         | 1 +
>  9 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index 0347eb8..9dfb835 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -63,6 +63,7 @@ static void clipper_init(MachineState *machine)
>      char *palcode_filename;
>      uint64_t palcode_entry, palcode_low, palcode_high;
>      uint64_t kernel_entry, kernel_low, kernel_high;
> +    unsigned int smp_cpus = machine->smp.cpus;
>  
>      /* Create up to 4 cpus.  */
>      memset(cpus, 0, sizeof(cpus));
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 416e67b..662838d 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -72,6 +72,7 @@ static void machine_hppa_init(MachineState *machine)
>      MemoryRegion *ram_region;
>      MemoryRegion *cpu_region;
>      long i;
> +    unsigned int smp_cpus = machine->smp.cpus;
>  
>      ram_size = machine->ram_size;
>  
> @@ -242,6 +243,7 @@ static void machine_hppa_init(MachineState *machine)
>  
>  static void hppa_machine_reset(MachineState *ms)
>  {
> +    unsigned int smp_cpus = ms->smp.cpus;
>      int i;
>  
>      qemu_devices_reset();
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index a8b29f6..ccbfac5 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -460,7 +460,7 @@ static void boston_mach_init(MachineState *machine)
>  
>      object_property_set_str(OBJECT(s->cps), machine->cpu_type, "cpu-type",
>                              &err);
> -    object_property_set_int(OBJECT(s->cps), smp_cpus, "num-vp", &err);
> +    object_property_set_int(OBJECT(s->cps), machine->smp.cpus, "num-vp", &err);
>      object_property_set_bool(OBJECT(s->cps), true, "realized", &err);
>  
>      if (err != NULL) {
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 534e705..70ff98b 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1095,6 +1095,8 @@ static int64_t load_kernel (void)
>  
>  static void malta_mips_config(MIPSCPU *cpu)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    unsigned int smp_cpus = ms->smp.cpus;
>      CPUMIPSState *env = &cpu->env;
>      CPUState *cs = CPU(cpu);
>  
> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
> index 7d3b734..c84b9af 100644
> --- a/hw/openrisc/openrisc_sim.c
> +++ b/hw/openrisc/openrisc_sim.c
> @@ -131,6 +131,7 @@ static void openrisc_sim_init(MachineState *machine)
>      qemu_irq *cpu_irqs[2];
>      qemu_irq serial_irq;
>      int n;
> +    unsigned int smp_cpus = machine->smp.cpus;
>  
>      for (n = 0; n < smp_cpus; n++) {
>          cpu = OPENRISC_CPU(cpu_create(machine->cpu_type));
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index ca1e382..43e3434 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -853,6 +853,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>      unsigned int num_vsimms;
>      DeviceState *dev;
>      SysBusDevice *s;
> +    unsigned int smp_cpus = machine->smp.cpus;
> +    unsigned int max_cpus = machine->smp.max_cpus;
>  
>      /* init CPUs */
>      for(i = 0; i < smp_cpus; i++) {
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 399f2d7..0807f27 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -678,8 +678,8 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>                                  &FW_CFG_IO(dev)->comb_iomem);
>  
>      fw_cfg = FW_CFG(dev);
> -    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)smp_cpus);
> -    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)max_cpus);
> +    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)machine->smp.cpus);
> +    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)machine->smp.max_cpus);
>      fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
>      fw_cfg_add_i16(fw_cfg, FW_CFG_MACHINE_ID, hwdef->machine_id);
>      fw_cfg_add_i64(fw_cfg, FW_CFG_KERNEL_ADDR, kernel_entry);
> diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
> index 12c7437..a4eef76 100644
> --- a/hw/xtensa/sim.c
> +++ b/hw/xtensa/sim.c
> @@ -60,7 +60,7 @@ static void xtensa_sim_init(MachineState *machine)
>      const char *kernel_filename = machine->kernel_filename;
>      int n;
>  
> -    for (n = 0; n < smp_cpus; n++) {
> +    for (n = 0; n < machine->smp.cpus; n++) {
>          cpu = XTENSA_CPU(cpu_create(machine->cpu_type));
>          env = &cpu->env;
>  
> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
> index e05ef75..f7f3e11 100644
> --- a/hw/xtensa/xtfpga.c
> +++ b/hw/xtensa/xtfpga.c
> @@ -238,6 +238,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
>      const unsigned system_io_size = 224 * MiB;
>      uint32_t freq = 10000000;
>      int n;
> +    unsigned int smp_cpus = machine->smp.cpus;
>  
>      if (smp_cpus > 1) {
>          mx_pic = xtensa_mx_pic_init(31);


