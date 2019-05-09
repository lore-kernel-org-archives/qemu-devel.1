Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BDCC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:43:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F6921019
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIl4iuLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F6921019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57773 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOm8U-0007th-6L
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 12:43:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOm5R-0004y8-Fi
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOm5Q-0000lR-68
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:40:01 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:35441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOm5P-0000ky-Um
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:40:00 -0400
Received: by mail-lf1-x141.google.com with SMTP id j20so2056811lfh.2
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 09:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=kkPalT7MC8oYOuUkIIY93vYktuttFfqWpbP4uOxNx0s=;
	b=PIl4iuLRn5cSAHhnm4X756uMeKZFX0N9Gl24B/dRxXPTRrEZySqWtfUxlMzzjZ3oF+
	3Nzau07blAB+Jz6T3lNFVzi1eu+kRlDRLo+09tjZCLzzB/6nIO8CCAC6toAsEHVW0FkA
	bmj8LigvXLIbM6ED/BsWMYs7/XXOYg3mc0nWJ//ou+/jkOyC2sZ/jtzCTemc6wQTuA44
	2bQk616gBJH/u6da+UXaHO2Wi8QHMm/mmwDzw2UUQSR64XXGAjeVf8JVacwUmFN/csC0
	wMAQuTKeQfwBZsqUHbUOn98XkKan4zzD8m5teKXw1lXR0WoG5EjFiIVLv9HBZVf9N1YX
	QpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=kkPalT7MC8oYOuUkIIY93vYktuttFfqWpbP4uOxNx0s=;
	b=FSKZ4EsC23pXLlM+Obx392e9bG+8xseRvUfBkG4HQ8SkEUuAP/yjyWv0nUrMmriEpM
	5ydgywDeNasVzZM2dGNpzRsXBQ4hDw+/JoqaM9PMIdYz8lJryEBRu5OqlqnRl1vW5mDH
	N+1hkT/XFtOpmL+dTdgdQGVa4XekQ0a6/NC4T35zP8X70PS2idKtSUwR/9djmqceMDBz
	AdvWv7ROWSUh+2gBpLtr2SfJf9G5MuP00L2jpfGJdcc8tKzKBUS2cxrHhp2uy9iK4EkW
	i5CYpaMsqSHJISCdNcO5RFWK+SS0WIXQbqccsIC2jQjE55XaoYNInhUQAx0KrFxNiXxX
	rttA==
X-Gm-Message-State: APjAAAUkMcwEJiUsNwBmd/Ut029j5svKzaO3sB0ieFQIPADSEH5NULcK
	CU2PAbcLv75zk6EQs9VbFM2SKoM0iyipXApNM7+J8g5j
X-Google-Smtp-Source: APXvYqwYOVSCIe8xvNAoIzNjlaX3F/FZTsyJUygOPQOUsAP0OD1lQOuCw5ceQCtyOae3B02yQFH4/f4fi/a0+OyqdNw=
X-Received: by 2002:a19:4a04:: with SMTP id x4mr2998776lfa.124.1557419998534; 
	Thu, 09 May 2019 09:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <1557131596-25403-1-git-send-email-like.xu@linux.intel.com>
	<1557131596-25403-5-git-send-email-like.xu@linux.intel.com>
In-Reply-To: <1557131596-25403-5-git-send-email-like.xu@linux.intel.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 09:37:47 -0700
Message-ID: <CAKmqyKOA0DBpgGCV1z7zZbTd3foyUB_nE7O_tLG5NVE2pKmhdQ@mail.gmail.com>
To: Like Xu <like.xu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::141
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
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	Richard Henderson <rth@twiddle.net>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 6, 2019 at 1:34 AM Like Xu <like.xu@linux.intel.com> wrote:
>
> Following the replace rules, the global smp variables in hppa/mips/openrisc
> /sparc*/xtensa are replaced with smp machine properties. No semantic changes.
>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
> --
> 1.8.3.1
>

