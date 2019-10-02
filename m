Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE50C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 15:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DC5121848
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 15:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC5121848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFgN4-0008MJ-Q3
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 11:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFgL1-0007bV-HQ
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFgL0-0006be-0r
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:14:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46602)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFgKz-0006ac-Op
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:14:45 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F21AB81DE7
 for <qemu-devel@nongnu.org>; Wed,  2 Oct 2019 15:14:41 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id z205so3148879wmb.7
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 08:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wMZyKrViudErGw6QLEFrHTfE6cLZFgHYrAVdwUSRBNI=;
 b=mnJMgTviBsev7ANEF39aDSk+5vqQkUrNALLIQoCDEi5n1D1BabkT/HGELMcy2U8CFd
 sYAlnWOzfo3+0P/ZaPg76CnutStKEpooejPRyILP1Kd67XLu+Of7csXdFA/NGVIjSYmU
 lVj57WDdT19xdT3Y5nR8lS7QrZpTWSL3ZRVFe/xqYKhtSSuBvCMg4wbu/gLJI6FE7s2N
 VPAZ8JMnE4fB5TxHu3CzunMAnOoDWE3w33WYYWtaurGjOvR5J05Q6nBVuepoduHD/y9Q
 FkPSsjPMsvXYyfvQwzTk9IPkeso40i/dU7dnp3JUi2AlmvWI8RapBDc8z9SCpQ/nfAt3
 V5yQ==
X-Gm-Message-State: APjAAAX1c0Cxkzi+s3I0bmGj9lKC6ikzab02pRbI+xIw43qRzxyVSGkG
 5GMS0iYkyf5fRPlkgw1rKtYKyXNEohQAMD/9/nW5ZIEwGNF8UWmmw66NzdIy26pFOahqq9HUVVt
 ZrzIj9NXyqU5k/h8=
X-Received: by 2002:a1c:29c4:: with SMTP id p187mr3553288wmp.28.1570029280614; 
 Wed, 02 Oct 2019 08:14:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwNK2o5AS2lYnYVzLEJdPyCU/0T3uHncr6Hz9HK4yH7KHesDGCVrXMq5Zh5tEqmf1YthtoUcg==
X-Received: by 2002:a1c:29c4:: with SMTP id p187mr3553260wmp.28.1570029280274; 
 Wed, 02 Oct 2019 08:14:40 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id o10sm2656835wrm.23.2019.10.02.08.14.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2019 08:14:39 -0700 (PDT)
Subject: Re: [PATCH v5 02/10] hw/i386/pc: rename functions shared with non-PC
 machines
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191002113103.45023-1-slp@redhat.com>
 <20191002113103.45023-3-slp@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5d305923-d640-25ae-c539-cc0206ac9f2a@redhat.com>
Date: Wed, 2 Oct 2019 17:14:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191002113103.45023-3-slp@redhat.com>
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

Hi Sergio,

Depending of the IDE developers use, the patch subject is not always=20
prepended to the patch description.

You can add: "The following functions are named *pc* but are not=20
PC-machine specific but generic to the X86 architecture, rename them:"

On 10/2/19 1:30 PM, Sergio Lopez wrote:
> load_linux                 -> x86_load_linux
> pc_new_cpu                 -> x86_new_cpu

Maybe we can rename this one 'x86_cpu_new'?

> pc_cpus_init               -> x86_cpus_init
> pc_cpu_index_to_props      -> x86_cpu_index_to_props
> pc_get_default_cpu_node_id -> x86_get_default_cpu_node_id
> pc_possible_cpu_arch_ids   -> x86_possible_cpu_arch_ids
> old_pc_system_rom_init     -> x86_system_rom_init

This one as 'x86_bios_rom_init'?

Nit: Adding 2 spaces before each line would ease readability.

>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>   hw/i386/pc.c         | 28 ++++++++++++++--------------
>   hw/i386/pc_piix.c    |  2 +-
>   hw/i386/pc_q35.c     |  2 +-
>   hw/i386/pc_sysfw.c   |  6 +++---
>   include/hw/i386/pc.h |  2 +-
>   5 files changed, 20 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index bcda50efcc..029bc23e7c 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1019,8 +1019,8 @@ static bool load_elfboot(const char *kernel_filen=
ame,
>       return true;
>   }
>  =20
> -static void load_linux(PCMachineState *pcms,
> -                       FWCfgState *fw_cfg)
> +static void x86_load_linux(PCMachineState *pcms,
> +                           FWCfgState *fw_cfg)
>   {
>       uint16_t protocol;
>       int setup_size, kernel_size, cmdline_size;
> @@ -1374,7 +1374,7 @@ void pc_acpi_smi_interrupt(void *opaque, int irq,=
 int level)
>       }
>   }
>  =20
> -static void pc_new_cpu(PCMachineState *pcms, int64_t apic_id, Error **=
errp)
> +static void x86_new_cpu(PCMachineState *pcms, int64_t apic_id, Error *=
*errp)
>   {
>       Object *cpu =3D NULL;
>       Error *local_err =3D NULL;
> @@ -1490,14 +1490,14 @@ void pc_hot_add_cpu(MachineState *ms, const int=
64_t id, Error **errp)
>           return;
>       }
>  =20
> -    pc_new_cpu(PC_MACHINE(ms), apic_id, &local_err);
> +    x86_new_cpu(PC_MACHINE(ms), apic_id, &local_err);
>       if (local_err) {
>           error_propagate(errp, local_err);
>           return;
>       }
>   }
>  =20
> -void pc_cpus_init(PCMachineState *pcms)
> +void x86_cpus_init(PCMachineState *pcms)
>   {
>       int i;
>       const CPUArchIdList *possible_cpus;
> @@ -1518,7 +1518,7 @@ void pc_cpus_init(PCMachineState *pcms)
>                                                        ms->smp.max_cpus=
 - 1) + 1;
>       possible_cpus =3D mc->possible_cpu_arch_ids(ms);
>       for (i =3D 0; i < ms->smp.cpus; i++) {
> -        pc_new_cpu(pcms, possible_cpus->cpus[i].arch_id, &error_fatal)=
;
> +        x86_new_cpu(pcms, possible_cpus->cpus[i].arch_id, &error_fatal=
);
>       }
>   }
>  =20
> @@ -1621,7 +1621,7 @@ void xen_load_linux(PCMachineState *pcms)
>       fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
>       rom_set_fw(fw_cfg);
>  =20
> -    load_linux(pcms, fw_cfg);
> +    x86_load_linux(pcms, fw_cfg);
>       for (i =3D 0; i < nb_option_roms; i++) {
>           assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
>                  !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
> @@ -1756,7 +1756,7 @@ void pc_memory_init(PCMachineState *pcms,
>       }
>  =20
>       if (linux_boot) {
> -        load_linux(pcms, fw_cfg);
> +        x86_load_linux(pcms, fw_cfg);
>       }
>  =20
>       for (i =3D 0; i < nb_option_roms; i++) {
> @@ -2678,7 +2678,7 @@ static void pc_machine_wakeup(MachineState *machi=
ne)
>   }
>  =20
>   static CpuInstanceProperties
> -pc_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
> +x86_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
>   {
>       MachineClass *mc =3D MACHINE_GET_CLASS(ms);
>       const CPUArchIdList *possible_cpus =3D mc->possible_cpu_arch_ids(=
ms);
> @@ -2687,7 +2687,7 @@ pc_cpu_index_to_props(MachineState *ms, unsigned =
cpu_index)
>       return possible_cpus->cpus[cpu_index].props;
>   }
>  =20
> -static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int =
idx)
> +static int64_t x86_get_default_cpu_node_id(const MachineState *ms, int=
 idx)
>   {
>      X86CPUTopoInfo topo;
>      PCMachineState *pcms =3D PC_MACHINE(ms);
> @@ -2699,7 +2699,7 @@ static int64_t pc_get_default_cpu_node_id(const M=
achineState *ms, int idx)
>      return topo.pkg_id % ms->numa_state->num_nodes;
>   }
>  =20
> -static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
> +static const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms=
)
>   {
>       PCMachineState *pcms =3D PC_MACHINE(ms);
>       int i;
> @@ -2801,9 +2801,9 @@ static void pc_machine_class_init(ObjectClass *oc=
, void *data)
>       assert(!mc->get_hotplug_handler);
>       mc->get_hotplug_handler =3D pc_get_hotplug_handler;
>       mc->hotplug_allowed =3D pc_hotplug_allowed;
> -    mc->cpu_index_to_instance_props =3D pc_cpu_index_to_props;
> -    mc->get_default_cpu_node_id =3D pc_get_default_cpu_node_id;
> -    mc->possible_cpu_arch_ids =3D pc_possible_cpu_arch_ids;
> +    mc->cpu_index_to_instance_props =3D x86_cpu_index_to_props;
> +    mc->get_default_cpu_node_id =3D x86_get_default_cpu_node_id;
> +    mc->possible_cpu_arch_ids =3D x86_possible_cpu_arch_ids;
>       mc->auto_enable_numa_with_memhp =3D true;
>       mc->has_hotpluggable_cpus =3D true;
>       mc->default_boot_order =3D "cad";
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 6824b72124..de09e076cd 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -152,7 +152,7 @@ static void pc_init1(MachineState *machine,
>           }
>       }
>  =20
> -    pc_cpus_init(pcms);
> +    x86_cpus_init(pcms);
>  =20
>       if (kvm_enabled() && pcmc->kvmclock_enabled) {
>           kvmclock_create();
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 8fad20f314..894989b64e 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -179,7 +179,7 @@ static void pc_q35_init(MachineState *machine)
>           xen_hvm_init(pcms, &ram_memory);
>       }
>  =20
> -    pc_cpus_init(pcms);
> +    x86_cpus_init(pcms);
>  =20
>       kvmclock_create();
>  =20
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index a9983f0bfb..1ee254b15e 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -211,7 +211,7 @@ static void pc_system_flash_map(PCMachineState *pcm=
s,
>       }
>   }
>  =20
> -static void old_pc_system_rom_init(MemoryRegion *rom_memory, bool isap=
c_ram_fw)
> +static void x86_system_rom_init(MemoryRegion *rom_memory, bool isapc_r=
am_fw)
>   {
>       char *filename;
>       MemoryRegion *bios, *isa_bios;
> @@ -272,7 +272,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
>       BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
>  =20
>       if (!pcmc->pci_enabled) {
> -        old_pc_system_rom_init(rom_memory, true);
> +        x86_system_rom_init(rom_memory, true);
>           return;
>       }
>  =20
> @@ -293,7 +293,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
>  =20
>       if (!pflash_blk[0]) {
>           /* Machine property pflash0 not set, use ROM mode */
> -        old_pc_system_rom_init(rom_memory, false);
> +        x86_system_rom_init(rom_memory, false);
>       } else {
>           if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
>               /*
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 6df4f4b6fb..d12f42e9e5 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -195,7 +195,7 @@ bool pc_machine_is_smm_enabled(PCMachineState *pcms=
);
>   void pc_register_ferr_irq(qemu_irq irq);
>   void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
>  =20
> -void pc_cpus_init(PCMachineState *pcms);
> +void x86_cpus_init(PCMachineState *pcms);
>   void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)=
;
>   void pc_smp_parse(MachineState *ms, QemuOpts *opts);
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

