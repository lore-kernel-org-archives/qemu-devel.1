Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42264C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0757921A4C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0757921A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFxzb-0006cR-4E
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 06:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iFxyg-00060V-Sz
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iFxyf-0000jh-AH
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:04:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57234)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iFxyf-0000il-1Q
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:04:53 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 82FBA8667D
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 10:04:49 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id l3so914158wmf.8
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 03:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=czHMSKJshV++2UoiI6X4rs7zIyf1tSYILq3dpBSOg/U=;
 b=Iz8fjTxkytFE615Si+xAIrHozCkELViruP2BswGOMg2S0AVBOjsx7mxq22nWHU9iLm
 p2XFDAankhOKxPmkqNBWkkeUyeI5hG+YUyzC+CqOL495t/urn8PuXEu12Yx4VYmZc7p5
 qaMQcEPKcOZSqoMZMEuZwXbwZl+JDOI1yCGHwNrSSVpBYkAKk5SgS9YUqBBGf67pqqcd
 iUArEx3DKnhcO9IVhIGfsQRRLqtvQlKNbvUaY1K4ZDcm70iX7ov9qF+RcIJqh7+gHjyh
 px6qyzNEj62a1Du5KEiJYDew3VkCTxi4AEw/V7TrEDbAjHSC0i5Eot6gesN5iHfZ5Dqh
 yDAw==
X-Gm-Message-State: APjAAAV+Q8/aWWmtIwYsnnrqHti69nNdEcG7MZeuIKc/1Co017hFd15F
 aAS2uhoi5YaBx6HyLp2u/1W+ve7lhb3bEHwlKGJwY8NHFWD12q0xqsdLS8ALZ82OyaZV4CiIzVY
 6hT9XBBTWHYdXIoI=
X-Received: by 2002:a05:600c:2252:: with SMTP id
 a18mr294685wmm.141.1570097088100; 
 Thu, 03 Oct 2019 03:04:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyujV5aaxaOkfSHSrHpMdCOpd41SSM9oPykVccKTkhS0JRpIIrtTiNpE7WrCDxFeqgdLF8oAA==
X-Received: by 2002:a05:600c:2252:: with SMTP id
 a18mr294659wmm.141.1570097087777; 
 Thu, 03 Oct 2019 03:04:47 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id a14sm1894286wmm.44.2019.10.03.03.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2019 03:04:46 -0700 (PDT)
References: <20191002113103.45023-1-slp@redhat.com>
 <20191002113103.45023-3-slp@redhat.com>
 <5d305923-d640-25ae-c539-cc0206ac9f2a@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 02/10] hw/i386/pc: rename functions shared with non-PC
 machines
In-reply-to: <5d305923-d640-25ae-c539-cc0206ac9f2a@redhat.com>
Date: Thu, 03 Oct 2019 12:04:44 +0200
Message-ID: <87mueii1qb.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, pbonzini@redhat.com, imammedo@redhat.com,
 sgarzare@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Sergio,
>
> Depending of the IDE developers use, the patch subject is not always
> prepended to the patch description.
>
> You can add: "The following functions are named *pc* but are not
> PC-machine specific but generic to the X86 architecture, rename them:"

OK, thanks for the tip.

> On 10/2/19 1:30 PM, Sergio Lopez wrote:
>> load_linux                 -> x86_load_linux
>> pc_new_cpu                 -> x86_new_cpu
>
> Maybe we can rename this one 'x86_cpu_new'?

OK.

>> pc_cpus_init               -> x86_cpus_init
>> pc_cpu_index_to_props      -> x86_cpu_index_to_props
>> pc_get_default_cpu_node_id -> x86_get_default_cpu_node_id
>> pc_possible_cpu_arch_ids   -> x86_possible_cpu_arch_ids
>> old_pc_system_rom_init     -> x86_system_rom_init
>
> This one as 'x86_bios_rom_init'?

Probably that's a better name.

> Nit: Adding 2 spaces before each line would ease readability.

Ack.

>>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>>   hw/i386/pc.c         | 28 ++++++++++++++--------------
>>   hw/i386/pc_piix.c    |  2 +-
>>   hw/i386/pc_q35.c     |  2 +-
>>   hw/i386/pc_sysfw.c   |  6 +++---
>>   include/hw/i386/pc.h |  2 +-
>>   5 files changed, 20 insertions(+), 20 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index bcda50efcc..029bc23e7c 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1019,8 +1019,8 @@ static bool load_elfboot(const char *kernel_filena=
me,
>>       return true;
>>   }
>>   -static void load_linux(PCMachineState *pcms,
>> -                       FWCfgState *fw_cfg)
>> +static void x86_load_linux(PCMachineState *pcms,
>> +                           FWCfgState *fw_cfg)
>>   {
>>       uint16_t protocol;
>>       int setup_size, kernel_size, cmdline_size;
>> @@ -1374,7 +1374,7 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, =
int level)
>>       }
>>   }
>>   -static void pc_new_cpu(PCMachineState *pcms, int64_t apic_id,
>> Error **errp)
>> +static void x86_new_cpu(PCMachineState *pcms, int64_t apic_id, Error **=
errp)
>>   {
>>       Object *cpu =3D NULL;
>>       Error *local_err =3D NULL;
>> @@ -1490,14 +1490,14 @@ void pc_hot_add_cpu(MachineState *ms, const int6=
4_t id, Error **errp)
>>           return;
>>       }
>>   -    pc_new_cpu(PC_MACHINE(ms), apic_id, &local_err);
>> +    x86_new_cpu(PC_MACHINE(ms), apic_id, &local_err);
>>       if (local_err) {
>>           error_propagate(errp, local_err);
>>           return;
>>       }
>>   }
>>   -void pc_cpus_init(PCMachineState *pcms)
>> +void x86_cpus_init(PCMachineState *pcms)
>>   {
>>       int i;
>>       const CPUArchIdList *possible_cpus;
>> @@ -1518,7 +1518,7 @@ void pc_cpus_init(PCMachineState *pcms)
>>                                                        ms->smp.max_cpus =
- 1) + 1;
>>       possible_cpus =3D mc->possible_cpu_arch_ids(ms);
>>       for (i =3D 0; i < ms->smp.cpus; i++) {
>> -        pc_new_cpu(pcms, possible_cpus->cpus[i].arch_id, &error_fatal);
>> +        x86_new_cpu(pcms, possible_cpus->cpus[i].arch_id, &error_fatal);
>>       }
>>   }
>>   @@ -1621,7 +1621,7 @@ void xen_load_linux(PCMachineState *pcms)
>>       fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
>>       rom_set_fw(fw_cfg);
>>   -    load_linux(pcms, fw_cfg);
>> +    x86_load_linux(pcms, fw_cfg);
>>       for (i =3D 0; i < nb_option_roms; i++) {
>>           assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
>>                  !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
>> @@ -1756,7 +1756,7 @@ void pc_memory_init(PCMachineState *pcms,
>>       }
>>         if (linux_boot) {
>> -        load_linux(pcms, fw_cfg);
>> +        x86_load_linux(pcms, fw_cfg);
>>       }
>>         for (i =3D 0; i < nb_option_roms; i++) {
>> @@ -2678,7 +2678,7 @@ static void pc_machine_wakeup(MachineState *machin=
e)
>>   }
>>     static CpuInstanceProperties
>> -pc_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
>> +x86_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
>>   {
>>       MachineClass *mc =3D MACHINE_GET_CLASS(ms);
>>       const CPUArchIdList *possible_cpus =3D mc->possible_cpu_arch_ids(m=
s);
>> @@ -2687,7 +2687,7 @@ pc_cpu_index_to_props(MachineState *ms, unsigned c=
pu_index)
>>       return possible_cpus->cpus[cpu_index].props;
>>   }
>>   -static int64_t pc_get_default_cpu_node_id(const MachineState *ms,
>> int idx)
>> +static int64_t x86_get_default_cpu_node_id(const MachineState *ms, int =
idx)
>>   {
>>      X86CPUTopoInfo topo;
>>      PCMachineState *pcms =3D PC_MACHINE(ms);
>> @@ -2699,7 +2699,7 @@ static int64_t pc_get_default_cpu_node_id(const Ma=
chineState *ms, int idx)
>>      return topo.pkg_id % ms->numa_state->num_nodes;
>>   }
>>   -static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState
>> *ms)
>> +static const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>>   {
>>       PCMachineState *pcms =3D PC_MACHINE(ms);
>>       int i;
>> @@ -2801,9 +2801,9 @@ static void pc_machine_class_init(ObjectClass *oc,=
 void *data)
>>       assert(!mc->get_hotplug_handler);
>>       mc->get_hotplug_handler =3D pc_get_hotplug_handler;
>>       mc->hotplug_allowed =3D pc_hotplug_allowed;
>> -    mc->cpu_index_to_instance_props =3D pc_cpu_index_to_props;
>> -    mc->get_default_cpu_node_id =3D pc_get_default_cpu_node_id;
>> -    mc->possible_cpu_arch_ids =3D pc_possible_cpu_arch_ids;
>> +    mc->cpu_index_to_instance_props =3D x86_cpu_index_to_props;
>> +    mc->get_default_cpu_node_id =3D x86_get_default_cpu_node_id;
>> +    mc->possible_cpu_arch_ids =3D x86_possible_cpu_arch_ids;
>>       mc->auto_enable_numa_with_memhp =3D true;
>>       mc->has_hotpluggable_cpus =3D true;
>>       mc->default_boot_order =3D "cad";
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index 6824b72124..de09e076cd 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -152,7 +152,7 @@ static void pc_init1(MachineState *machine,
>>           }
>>       }
>>   -    pc_cpus_init(pcms);
>> +    x86_cpus_init(pcms);
>>         if (kvm_enabled() && pcmc->kvmclock_enabled) {
>>           kvmclock_create();
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index 8fad20f314..894989b64e 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -179,7 +179,7 @@ static void pc_q35_init(MachineState *machine)
>>           xen_hvm_init(pcms, &ram_memory);
>>       }
>>   -    pc_cpus_init(pcms);
>> +    x86_cpus_init(pcms);
>>         kvmclock_create();
>>   diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
>> index a9983f0bfb..1ee254b15e 100644
>> --- a/hw/i386/pc_sysfw.c
>> +++ b/hw/i386/pc_sysfw.c
>> @@ -211,7 +211,7 @@ static void pc_system_flash_map(PCMachineState *pcms,
>>       }
>>   }
>>   -static void old_pc_system_rom_init(MemoryRegion *rom_memory, bool
>> isapc_ram_fw)
>> +static void x86_system_rom_init(MemoryRegion *rom_memory, bool isapc_ra=
m_fw)
>>   {
>>       char *filename;
>>       MemoryRegion *bios, *isa_bios;
>> @@ -272,7 +272,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
>>       BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
>>         if (!pcmc->pci_enabled) {
>> -        old_pc_system_rom_init(rom_memory, true);
>> +        x86_system_rom_init(rom_memory, true);
>>           return;
>>       }
>>   @@ -293,7 +293,7 @@ void pc_system_firmware_init(PCMachineState
>> *pcms,
>>         if (!pflash_blk[0]) {
>>           /* Machine property pflash0 not set, use ROM mode */
>> -        old_pc_system_rom_init(rom_memory, false);
>> +        x86_system_rom_init(rom_memory, false);
>>       } else {
>>           if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
>>               /*
>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> index 6df4f4b6fb..d12f42e9e5 100644
>> --- a/include/hw/i386/pc.h
>> +++ b/include/hw/i386/pc.h
>> @@ -195,7 +195,7 @@ bool pc_machine_is_smm_enabled(PCMachineState *pcms);
>>   void pc_register_ferr_irq(qemu_irq irq);
>>   void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
>>   -void pc_cpus_init(PCMachineState *pcms);
>> +void x86_cpus_init(PCMachineState *pcms);
>>   void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp);
>>   void pc_smp_parse(MachineState *ms, QemuOpts *opts);
>>=20=20=20
>>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2Vx7wACgkQ9GknjS8M
AjWaaw/8CXF30a9dZUAYCJMr/f+vUyZtyKVWJG6Nx1cvpEFOP8NGtG/8DXTdyFwq
8SaEqYt8UgfJRh0wbOU/heRAIdYEMHOYtomNknnInrrz2x5YLYi6Ww5Xo3UMtQlV
YA1JV5JL7FnSRMOR4Uik8Kh/vmNMKK5vj3phUsK4cNdXG1ckGE/4r+dJiS1EvluA
TQL/uUBtRrXERNgZeqvMaqSpV0VAZORBYzIwg0HlzN17jztoeJUCAUSok/VrmGV8
nXHSq6I0cEO3xojT9F0LyEUwHM+qhrxVh4FR2EBJUfiVAVRuJVxFL0UdE7GhMV/S
P1IwlzzuQnee3xRCwnrqCEJr2B+DYdsXqnLqpXU/tnQXP/iSuLx3tWonFpinMn28
8W87X1XsBqbpab8MonJfDGOOwsvHIc/xOtSqIGyECba1BcfJg9VCDUjmJyCeI/mn
vkVP2rWVCfbQx+CkcRMvVAM9IBUWorSYLcVRxXmEvwFeF7hnlu7f0nKEk2MARrCT
xIyjM7jJcl1UP2S4qZE2Xc4u0Dr4qZvTA2+L/USMH9WFl1M5Ldie+eOyxDX+uM4/
gaz5YELEU4+K5opYwn+seCZA1ijXZuiMB4USowelK3o1yEwZ1jToLY1EdXp9uWAg
y5eKtRXps7Yryl5ZmCMjWWHFy4iaHATKQW/ihO+w5ZCm49rzLwc=
=NLZi
-----END PGP SIGNATURE-----
--=-=-=--

