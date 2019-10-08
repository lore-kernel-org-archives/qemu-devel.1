Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974B8C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 18:59:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ADFD21721
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 18:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADFD21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHui4-0005s5-FK
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 14:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iHugw-0004v9-25
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iHugt-0007lL-7p
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:58:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iHugs-0007l4-VI
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 14:58:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 754D91895A4A;
 Tue,  8 Oct 2019 18:58:33 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-109.rdu2.redhat.com
 [10.10.120.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B398819C69;
 Tue,  8 Oct 2019 18:58:31 +0000 (UTC)
Subject: Re: [PATCH 3/4] hw/i386: add facility to expose CPU topology over
 fw-cfg
From: Laszlo Ersek <lersek@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20191008105259.5378-1-lersek@redhat.com>
 <20191008105259.5378-4-lersek@redhat.com>
Message-ID: <4d47793c-7dfe-a8b6-8704-aca493689577@redhat.com>
Date: Tue, 8 Oct 2019 20:58:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191008105259.5378-4-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Tue, 08 Oct 2019 18:58:33 +0000 (UTC)
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo, Igor,

On 10/08/19 12:52, Laszlo Ersek wrote:
> FW_CFG_MAX_CPUS exposes the (exclusive) maximum APIC ID to guest firmwa=
re,
> due to historical reasons. That value is not useful to edk2, however. F=
or
> supporting VCPU hotplug, edk2 needs:
>=20
> - the boot CPU count (already exposed in FW_CFG_NB_CPUS),
>=20
> - and the maximum foreseen CPU count (tracked in
>   "MachineState.smp.max_cpus", but not currently exposed).
>=20
> Add a new fw-cfg file to expose "max_cpus".
>=20
> While at it, expose the rest of the topology too (die / core / thread
> counts), because I expect that the VCPU hotplug feature for OVMF will
> ultimately need those too, and the data size is not large.

In fact, it seems like OVMF will have to synthesize the new
(hot-plugged) VCPU's *APIC-ID* from the following information sources:

- the topology information described above (die / core / thread counts), =
and

- the "modern" CPU hotplug interface (docs/specs/acpi_cpu_hotplug.txt).

Now, if I understand correctly, the "CPU selector" ([0x0-0x3]) specifies
a CPU *index*. Therefore, in the hotplug SMI handler (running on one of
the pre-existent CPUs), OVMF will have to translate the new CPU's
selector (the new CPU's *index*) to its *APIC-ID*, based on the topology
information (numbers of dies / cores / threads).

(That's because existent SMM infrastructure in edk2 uses the initial
APIC-ID as the key for referencing CPUs.)

Algorithmically, I think this translation is doable in OVMF  -- after
all, it is implemented in the x86_apicid_from_cpu_idx() function
already, in "include/hw/i386/topology.h". And that function does not
need more information either:

static inline apic_id_t x86_apicid_from_cpu_idx(unsigned nr_dies,
                                                unsigned nr_cores,
                                                unsigned nr_threads,
                                                unsigned cpu_index)

Therefore, my plan is to implement the same translation logic in OVMF.

Now, the questions:

- Am I right to think that the "CPU selector" register in the "modern"
ACPI hotplug interface operates in the *same domain* as the "cpu_index"
parameter of x86_apicid_from_cpu_idx()?

- As we progress through CPU indices, x86_apicid_from_cpu_idx() first
fills threads in a core, then cores in a die, then dies in a socket.
Will this logic remain the same, forever?

If any of the two questions above is answered with "no", then OVMF will
need an fw_cfg blob that is different from the current proposal.

Namely, OVMF will need a *full* "cpu_index -> APIC-ID" map, up to (and
excluding) "max_cpus".

The pc_possible_cpu_arch_ids() function in "hw/i386/pc.c" already
calculates a similar map:

        ms->possible_cpus->cpus[i].arch_id =3D
x86_cpu_apic_id_from_index(pcms, i);

So, basically that map is what OVMF would have to receive over fw_cfg,
*if* the "cpu_index -> APIC-ID" mapping is not considered guest ABI.
Should I write v2 for that?

Please comment!

Thanks,
Laszlo


> This is
> slightly complicated by the fact that the die count is specific to
> PCMachineState, but fw_cfg_arch_create() intends to be PC-independent (=
see
> commit 149c50cabcc4).
>=20
> For now, the feature is temporarily disabled.
>=20
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Ref: https://bugzilla.tianocore.org/show_bug.cgi?id=3D1515
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  hw/i386/fw_cfg.h | 30 +++++++++++++++++++++++++++++-
>  hw/i386/fw_cfg.c | 26 ++++++++++++++++++++++++--
>  hw/i386/pc.c     |  4 ++--
>  3 files changed, 55 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
> index e0856a376996..d742435b9793 100644
> --- a/hw/i386/fw_cfg.h
> +++ b/hw/i386/fw_cfg.h
> @@ -18,9 +18,37 @@
>  #define FW_CFG_E820_TABLE       (FW_CFG_ARCH_LOCAL + 3)
>  #define FW_CFG_HPET             (FW_CFG_ARCH_LOCAL + 4)
> =20
> +/**
> + * FWCfgX86Topology: expose the X86 CPU topology to guest firmware ove=
r fw-cfg.
> + *
> + * All fields have little-endian encoding.
> + *
> + * @dies:     Number of dies per package (aka socket). Set it to 1 unl=
ess the
> + *            concrete MachineState subclass defines it differently.
> + * @cores:    Corresponds to @CpuTopology.@cores.
> + * @threads:  Corresponds to @CpuTopology.@threads.
> + * @max_cpus: Corresponds to @CpuTopology.@max_cpus.
> + *
> + * Firmware can derive the package (aka socket) count with the followi=
ng
> + * formula:
> + *
> + *   DIV_ROUND_UP(@max_cpus, @dies * @cores * @threads)
> + *
> + * Firmware can derive APIC ID field widths and offsets per the standa=
rd
> + * calculations in "include/hw/i386/topology.h".
> + */
> +typedef struct FWCfgX86Topology {
> +  uint32_t dies;
> +  uint32_t cores;
> +  uint32_t threads;
> +  uint32_t max_cpus;
> +} QEMU_PACKED FWCfgX86Topology;
> +
>  FWCfgState *fw_cfg_arch_create(MachineState *ms,
>                                 uint16_t boot_cpus,
> -                               uint16_t apic_id_limit);
> +                               uint16_t apic_id_limit,
> +                               unsigned smp_dies,
> +                               bool expose_topology);
>  void fw_cfg_build_smbios(MachineState *ms, FWCfgState *fw_cfg);
>  void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_cfg=
);
> =20
> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> index 39b6bc60520c..33d09875014f 100644
> --- a/hw/i386/fw_cfg.c
> +++ b/hw/i386/fw_cfg.c
> @@ -85,9 +85,26 @@ void fw_cfg_build_smbios(MachineState *ms, FWCfgStat=
e *fw_cfg)
>      }
>  }
> =20
> +static void fw_cfg_expose_topology(FWCfgState *fw_cfg,
> +                                   unsigned dies,
> +                                   unsigned cores,
> +                                   unsigned threads,
> +                                   unsigned max_cpus)
> +{
> +    FWCfgX86Topology *topo =3D g_new(FWCfgX86Topology, 1);
> +
> +    topo->dies     =3D cpu_to_le32(dies);
> +    topo->cores    =3D cpu_to_le32(cores);
> +    topo->threads  =3D cpu_to_le32(threads);
> +    topo->max_cpus =3D cpu_to_le32(max_cpus);
> +    fw_cfg_add_file(fw_cfg, "etc/x86-smp-topology", topo, sizeof *topo=
);
> +}
> +
>  FWCfgState *fw_cfg_arch_create(MachineState *ms,
> -                                      uint16_t boot_cpus,
> -                                      uint16_t apic_id_limit)
> +                               uint16_t boot_cpus,
> +                               uint16_t apic_id_limit,
> +                               unsigned smp_dies,
> +                               bool expose_topology)
>  {
>      FWCfgState *fw_cfg;
>      uint64_t *numa_fw_cfg;
> @@ -143,6 +160,11 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
>                       (1 + apic_id_limit + nb_numa_nodes) *
>                       sizeof(*numa_fw_cfg));
> =20
> +    if (expose_topology) {
> +        fw_cfg_expose_topology(fw_cfg, smp_dies, ms->smp.cores,
> +                               ms->smp.threads, ms->smp.max_cpus);
> +    }
> +
>      return fw_cfg;
>  }
> =20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index bcda50efcc23..bb72b12edad2 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1738,8 +1738,8 @@ void pc_memory_init(PCMachineState *pcms,
>                                          option_rom_mr,
>                                          1);
> =20
> -    fw_cfg =3D fw_cfg_arch_create(machine,
> -                                pcms->boot_cpus, pcms->apic_id_limit);
> +    fw_cfg =3D fw_cfg_arch_create(machine, pcms->boot_cpus, pcms->apic=
_id_limit,
> +                                pcms->smp_dies, false);
> =20
>      rom_set_fw(fw_cfg);
> =20
>=20


