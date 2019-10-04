Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F57AC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44F682133F
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 10:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F682133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGL3k-00084J-AG
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 06:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iGKEu-0001OT-WE
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:51:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iGKEt-0000ZM-2b
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:51:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51960)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iGKEs-0000Yw-QH
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:51:07 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A83A788302
 for <qemu-devel@nongnu.org>; Fri,  4 Oct 2019 09:51:05 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id i10so2453844wrb.20
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 02:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mWwkfaj7DiI7QWCdvJDTwpSZSl7xdYNq4dUdcKHAq4s=;
 b=uZTmqY0mYYqo1/aCLMmwldPI8bsnBcMZvWwScBDFssF5xIRm5MkE0mZGbsv09Frymv
 t6krL79RYQq2S61llbHyCWekNnNWUz+8agLfP7Oy5NkujmUVc8TpQqpYidYRni2itxim
 0gMueEi1EL7RlPp30VDlBegTzBBELWGBuhH0b4BV9EDhwYKtcif8cblHDKt/r77gp73w
 uTPw+DOI2e92GmDYL9kAF2BSoZmE8o+Sn9pS/aW7RyOiD1GVngcdBc13w6OIR/sH+/kx
 ydvLD8TxoLEFAAQuBwihZfTLTgg8bYSt73zHrP72q5BDDexsCMhfuB3cAIAOa0ijV1Od
 tioQ==
X-Gm-Message-State: APjAAAV/NXACONMTnlTXA2AbDUWL02t4C4ukXndjsXBoIPNKwydvlq4j
 WVltHPTKCdVo/57BpaztEOVeSusNiEEOw6dU2+FFf9UshcEh7yxea3wIXON8stGtMu6Z6ESvk0T
 c/RDroVIWFyqktO0=
X-Received: by 2002:adf:a415:: with SMTP id d21mr10190552wra.94.1570182664149; 
 Fri, 04 Oct 2019 02:51:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx39xn1MTD/GUYixKxFisjgQXqUxMtzm0Wyx/kHvkcOuYQzI8KA5zYuJEZ3+9GqsKG/Vt44fA==
X-Received: by 2002:adf:a415:: with SMTP id d21mr10190517wra.94.1570182663721; 
 Fri, 04 Oct 2019 02:51:03 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b130sm3505464wmh.12.2019.10.04.02.51.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2019 02:51:03 -0700 (PDT)
Subject: Re: [PATCH v6 05/10] hw/i386: make x86.c independent from
 PCMachineState
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191004093752.16564-1-slp@redhat.com>
 <20191004093752.16564-6-slp@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8285d054-145c-14aa-b029-2f48a7f7333c@redhat.com>
Date: Fri, 4 Oct 2019 11:51:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191004093752.16564-6-slp@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ehabkost@redhat.com, mst@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 imammedo@redhat.com, sgarzare@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/4/19 11:37 AM, Sergio Lopez wrote:
> As a last step into splitting PCMachineState and deriving
> X86MachineState from it, make the functions previously extracted from
> pc.c to x86.c independent from PCMachineState, using X86MachineState
> instead.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   include/hw/i386/x86.h | 13 ++++++++----
>   hw/i386/pc.c          | 14 ++++++++-----
>   hw/i386/pc_piix.c     |  2 +-
>   hw/i386/pc_q35.c      |  2 +-
>   hw/i386/x86.c         | 49 ++++++++++++++++++++----------------------=
-
>   5 files changed, 43 insertions(+), 37 deletions(-)
>=20
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index a930a7ad9d..f44359e9e9 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -73,10 +73,11 @@ typedef struct {
>   #define X86_MACHINE_CLASS(class) \
>       OBJECT_CLASS_CHECK(X86MachineClass, class, TYPE_X86_MACHINE)
>  =20
> -uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
> +uint32_t x86_cpu_apic_id_from_index(X86MachineState *pcms,
>                                       unsigned int cpu_index);
> -void x86_cpu_new(PCMachineState *pcms, int64_t apic_id, Error **errp);
> -void x86_cpus_init(PCMachineState *pcms);
> +
> +void x86_cpu_new(X86MachineState *pcms, int64_t apic_id, Error **errp)=
;
> +void x86_cpus_init(X86MachineState *pcms, int default_cpu_version);
>   CpuInstanceProperties x86_cpu_index_to_props(MachineState *ms,
>                                                unsigned cpu_index);
>   int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx);
> @@ -84,6 +85,10 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(Machi=
neState *ms);
>  =20
>   void x86_bios_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw);
>  =20
> -void x86_load_linux(PCMachineState *pcms, FWCfgState *fw_cfg);
> +void x86_load_linux(X86MachineState *x86ms,
> +                    FWCfgState *fw_cfg,
> +                    int acpi_data_size,
> +                    bool pvh_enabled,
> +                    bool linuxboot_dma_enabled);
>  =20
>   #endif
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 0dc1420a1f..0bf93d489c 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -982,8 +982,8 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
>  =20
>   void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)
>   {
> -    PCMachineState *pcms =3D PC_MACHINE(ms);
> -    int64_t apic_id =3D x86_cpu_apic_id_from_index(pcms, id);
> +    X86MachineState *x86ms =3D X86_MACHINE(ms);
> +    int64_t apic_id =3D x86_cpu_apic_id_from_index(x86ms, id);
>       Error *local_err =3D NULL;
>  =20
>       if (id < 0) {
> @@ -998,7 +998,8 @@ void pc_hot_add_cpu(MachineState *ms, const int64_t=
 id, Error **errp)
>           return;
>       }
>  =20
> -    x86_cpu_new(PC_MACHINE(ms), apic_id, &local_err);
> +
> +    x86_cpu_new(X86_MACHINE(ms), apic_id, &local_err);
>       if (local_err) {
>           error_propagate(errp, local_err);
>           return;
> @@ -1099,6 +1100,7 @@ void xen_load_linux(PCMachineState *pcms)
>   {
>       int i;
>       FWCfgState *fw_cfg;
> +    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>       X86MachineState *x86ms =3D X86_MACHINE(pcms);
>  =20
>       assert(MACHINE(pcms)->kernel_filename !=3D NULL);
> @@ -1107,7 +1109,8 @@ void xen_load_linux(PCMachineState *pcms)
>       fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
>       rom_set_fw(fw_cfg);
>  =20
> -    x86_load_linux(pcms, fw_cfg);
> +    x86_load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
> +                   pcmc->pvh_enabled, pcmc->linuxboot_dma_enabled);
>       for (i =3D 0; i < nb_option_roms; i++) {
>           assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
>                  !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
> @@ -1243,7 +1246,8 @@ void pc_memory_init(PCMachineState *pcms,
>       }
>  =20
>       if (linux_boot) {
> -        x86_load_linux(pcms, fw_cfg);
> +        x86_load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
> +                       pcmc->pvh_enabled, pcmc->linuxboot_dma_enabled)=
;
>       }
>  =20
>       for (i =3D 0; i < nb_option_roms; i++) {
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 0afa8fe6ea..a86317cdff 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -154,7 +154,7 @@ static void pc_init1(MachineState *machine,
>           }
>       }
>  =20
> -    x86_cpus_init(pcms);
> +    x86_cpus_init(x86ms, pcmc->default_cpu_version);
>  =20
>       if (kvm_enabled() && pcmc->kvmclock_enabled) {
>           kvmclock_create();
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 8e7beb9415..8bdca373d6 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -181,7 +181,7 @@ static void pc_q35_init(MachineState *machine)
>           xen_hvm_init(pcms, &ram_memory);
>       }
>  =20
> -    x86_cpus_init(pcms);
> +    x86_cpus_init(x86ms, pcmc->default_cpu_version);
>  =20
>       kvmclock_create();
>  =20
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 4a8e254d69..55944a9a02 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -60,11 +60,10 @@ static size_t pvh_start_addr;
>    * no concept of "CPU index", and the NUMA tables on fw_cfg need the =
APIC ID of
>    * all CPUs up to max_cpus.
>    */
> -uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
> +uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
>                                       unsigned int cpu_index)
>   {
> -    MachineState *ms =3D MACHINE(pcms);
> -    X86MachineState *x86ms =3D X86_MACHINE(pcms);
> +    MachineState *ms =3D MACHINE(x86ms);
>       X86MachineClass *x86mc =3D X86_MACHINE_GET_CLASS(x86ms);
>       uint32_t correct_id;
>       static bool warned;
> @@ -83,14 +82,14 @@ uint32_t x86_cpu_apic_id_from_index(PCMachineState =
*pcms,
>       }
>   }
>  =20
> -void x86_cpu_new(PCMachineState *pcms, int64_t apic_id, Error **errp)
> +
> +void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp=
)
>   {
>       Object *cpu =3D NULL;
>       Error *local_err =3D NULL;
>       CPUX86State *env =3D NULL;
> -    X86MachineState *x86ms =3D X86_MACHINE(pcms);
>  =20
> -    cpu =3D object_new(MACHINE(pcms)->cpu_type);
> +    cpu =3D object_new(MACHINE(x86ms)->cpu_type);
>  =20
>       env =3D &X86_CPU(cpu)->env;
>       env->nr_dies =3D x86ms->smp_dies;
> @@ -102,16 +101,14 @@ void x86_cpu_new(PCMachineState *pcms, int64_t ap=
ic_id, Error **errp)
>       error_propagate(errp, local_err);
>   }
>  =20
> -void x86_cpus_init(PCMachineState *pcms)
> +void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
>   {
>       int i;
>       const CPUArchIdList *possible_cpus;
> -    MachineState *ms =3D MACHINE(pcms);
> -    MachineClass *mc =3D MACHINE_GET_CLASS(pcms);
> -    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(mc);
> -    X86MachineState *x86ms =3D X86_MACHINE(pcms);
> +    MachineState *ms =3D MACHINE(x86ms);
> +    MachineClass *mc =3D MACHINE_GET_CLASS(x86ms);
>  =20
> -    x86_cpu_set_default_version(pcmc->default_cpu_version);
> +    x86_cpu_set_default_version(default_cpu_version);
>  =20
>       /* Calculates the limit to CPU APIC ID values
>        *
> @@ -120,11 +117,11 @@ void x86_cpus_init(PCMachineState *pcms)
>        *
>        * This is used for FW_CFG_MAX_CPUS. See comments on fw_cfg_arch_=
create().
>        */
> -    x86ms->apic_id_limit =3D x86_cpu_apic_id_from_index(pcms,
> +    x86ms->apic_id_limit =3D x86_cpu_apic_id_from_index(x86ms,
>                                                         ms->smp.max_cpu=
s - 1) + 1;
>       possible_cpus =3D mc->possible_cpu_arch_ids(ms);
>       for (i =3D 0; i < ms->smp.cpus; i++) {
> -        x86_cpu_new(pcms, possible_cpus->cpus[i].arch_id, &error_fatal=
);
> +        x86_cpu_new(x86ms, possible_cpus->cpus[i].arch_id, &error_fata=
l);
>       }
>   }
>  =20
> @@ -152,7 +149,6 @@ int64_t x86_get_default_cpu_node_id(const MachineSt=
ate *ms, int idx)
>  =20
>   const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>   {
> -    PCMachineState *pcms =3D PC_MACHINE(ms);
>       X86MachineState *x86ms =3D X86_MACHINE(ms);
>       int i;
>       unsigned int max_cpus =3D ms->smp.max_cpus;
> @@ -174,7 +170,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(Mach=
ineState *ms)
>  =20
>           ms->possible_cpus->cpus[i].type =3D ms->cpu_type;
>           ms->possible_cpus->cpus[i].vcpus_count =3D 1;
> -        ms->possible_cpus->cpus[i].arch_id =3D x86_cpu_apic_id_from_in=
dex(pcms, i);
> +        ms->possible_cpus->cpus[i].arch_id =3D x86_cpu_apic_id_from_in=
dex(x86ms, i);
>           x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
>                                    x86ms->smp_dies, ms->smp.cores,
>                                    ms->smp.threads, &topo);
> @@ -331,8 +327,11 @@ static bool load_elfboot(const char *kernel_filena=
me,
>       return true;
>   }
>  =20
> -void x86_load_linux(PCMachineState *pcms,
> -                    FWCfgState *fw_cfg)
> +void x86_load_linux(X86MachineState *x86ms,
> +                    FWCfgState *fw_cfg,
> +                    int acpi_data_size,
> +                    bool pvh_enabled,
> +                    bool linuxboot_dma_enabled)
>   {
>       uint16_t protocol;
>       int setup_size, kernel_size, cmdline_size;
> @@ -342,9 +341,7 @@ void x86_load_linux(PCMachineState *pcms,
>       hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr =3D 0;
>       FILE *f;
>       char *vmode;
> -    MachineState *machine =3D MACHINE(pcms);
> -    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> -    X86MachineState *x86ms =3D X86_MACHINE(pcms);
> +    MachineState *machine =3D MACHINE(x86ms);
>       struct setup_data *setup_data;
>       const char *kernel_filename =3D machine->kernel_filename;
>       const char *initrd_filename =3D machine->initrd_filename;
> @@ -387,7 +384,7 @@ void x86_load_linux(PCMachineState *pcms,
>            * saving the PVH entry point used by the x86/HVM direct boot=
 ABI.
>            * If load_elfboot() is successful, populate the fw_cfg info.
>            */
> -        if (pcmc->pvh_enabled &&
> +        if (pvh_enabled &&
>               load_elfboot(kernel_filename, kernel_size,
>                            header, pvh_start_addr, fw_cfg)) {
>               fclose(f);
> @@ -417,7 +414,7 @@ void x86_load_linux(PCMachineState *pcms,
>  =20
>                   initrd_data =3D g_mapped_file_get_contents(mapped_fil=
e);
>                   initrd_size =3D g_mapped_file_get_length(mapped_file)=
;
> -                initrd_max =3D x86ms->below_4g_mem_size - pcmc->acpi_d=
ata_size - 1;
> +                initrd_max =3D x86ms->below_4g_mem_size - acpi_data_si=
ze - 1;
>                   if (initrd_size >=3D initrd_max) {
>                       fprintf(stderr, "qemu: initrd is too large, canno=
t support."
>                               "(max: %"PRIu32", need %"PRId64")\n",
> @@ -495,8 +492,8 @@ void x86_load_linux(PCMachineState *pcms,
>           initrd_max =3D 0x37ffffff;
>       }
>  =20
> -    if (initrd_max >=3D x86ms->below_4g_mem_size - pcmc->acpi_data_siz=
e) {
> -        initrd_max =3D x86ms->below_4g_mem_size - pcmc->acpi_data_size=
 - 1;
> +    if (initrd_max >=3D x86ms->below_4g_mem_size - acpi_data_size) {
> +        initrd_max =3D x86ms->below_4g_mem_size - acpi_data_size - 1;
>       }
>  =20
>       fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
> @@ -645,7 +642,7 @@ void x86_load_linux(PCMachineState *pcms,
>  =20
>       option_rom[nb_option_roms].bootindex =3D 0;
>       option_rom[nb_option_roms].name =3D "linuxboot.bin";
> -    if (pcmc->linuxboot_dma_enabled && fw_cfg_dma_enabled(fw_cfg)) {
> +    if (linuxboot_dma_enabled && fw_cfg_dma_enabled(fw_cfg)) {
>           option_rom[nb_option_roms].name =3D "linuxboot_dma.bin";
>       }
>       nb_option_roms++;
>=20

