Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489FFC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:01:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D42A20679
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D42A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIY4Q-0007TW-9E
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 09:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iIXrg-0001zT-E4
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iIXrd-0007Gp-Io
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:48:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61540)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iIXrd-0007GN-AK
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:48:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A2F6D300D219;
 Thu, 10 Oct 2019 12:48:15 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3311260BE1;
 Thu, 10 Oct 2019 12:48:14 +0000 (UTC)
Date: Thu, 10 Oct 2019 14:48:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/4] hw/i386: add facility to expose CPU topology over
 fw-cfg
Message-ID: <20191010144812.20fd8b5d@redhat.com>
In-Reply-To: <20191010055733-mutt-send-email-mst@kernel.org>
References: <20191008105259.5378-1-lersek@redhat.com>
 <20191008105259.5378-4-lersek@redhat.com>
 <20191008175931.483af366@redhat.com>
 <20191010055733-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 10 Oct 2019 12:48:15 +0000 (UTC)
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Oct 2019 06:01:51 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Oct 08, 2019 at 05:59:31PM +0200, Igor Mammedov wrote:
> > On Tue,  8 Oct 2019 12:52:58 +0200
> > Laszlo Ersek <lersek@redhat.com> wrote:
> >  =20
> > > FW_CFG_MAX_CPUS exposes the (exclusive) maximum APIC ID to guest firm=
ware,
> > > due to historical reasons. That value is not useful to edk2, however.=
 For
> > > supporting VCPU hotplug, edk2 needs:
> > >=20
> > > - the boot CPU count (already exposed in FW_CFG_NB_CPUS),
> > >=20
> > > - and the maximum foreseen CPU count (tracked in
> > >   "MachineState.smp.max_cpus", but not currently exposed). =20
> > one can get it with current QEMU without adding new fgcfg
> > (albeit in a bit awkward way)
> >=20
> > max_cpu count can be derived indirectly as result of cpu hotplug
> > enumeration (IO interface at 0x0cd8-0xcf7) by writing/reading
> > to/from selector register (see ACPI_CPU_SELECTOR_OFFSET_WR)
> > until read value stops changing values (i.e. max cpu count
> > is reached). One also can figure out present/non-present
> > cpu status by reading flags register. =20
>=20
> Right but so far ACPI was the only driver of CPU hotplug, right?
even if its only user is ACPI now, like any other ABI it's
fixed and given that requirements to CPU hotplug ABI from ACPI
and firmware pretty much the same, I don't really see a reason
not to reuse it, since whole hotplug process orchestrated
by ACPI anyway.

> I don't think firmware should poke it directly, it is
> not really clean or especially scalable.
> Fine for ACPI but not great as a HV/guest interface.
Building an alternative ABI that will duplicate already
existing one, doesn't sound like a great idea to me.

Could you elaborate why do you think it's not a good idea
to re-use already existing CPU hotplug ABI in firmware?

Or even better suggest an algorithm how CPU hotplug should
work with SMM enabled OVMF.

 * in generic case, CPUs are asynchronously hotplugged and
   OSMP also asynchronously processing hotplug events.
   (So at the moment OSPM tells firmware to handle hotplug
    there are 1-n CPUs to handle and more might be coming)

> > > Add a new fw-cfg file to expose "max_cpus".
> > >=20
> > > While at it, expose the rest of the topology too (die / core / thread
> > > counts), because I expect that the VCPU hotplug feature for OVMF will
> > > ultimately need those too, and the data size is not large. This is
> > > slightly complicated by the fact that the die count is specific to
> > > PCMachineState, but fw_cfg_arch_create() intends to be PC-independent=
 (see
> > > commit 149c50cabcc4). =20
> > Could you clarify why topology info is necessary?
> >=20
> > Potentially it's possible to extend cpu hotplug ABI to report
> > arch specific apic-id (x86) or mpidr (arm) if firmware really
> > needs to know topology and let guest to decode it according
> > to CPU's spec.
> >=20
> > So far there were no need for it as all possible cpus are
> > described in ACPI tables passed to guest, but I'm not going
> > to suggest to parse them on firmware side as it's too complicated :) =20
>=20
> We can always add a QEMU specific data table by the way.
> Format would be up to us and would be easy to parse.
> I don't see a big advantage as compared to fw cfg though.

it doesn't really matter if it's ACPI blob or fw_cfg,
what firmware needs is a table of possible CPUs with APIC IDs.

But if we go this route (i.e. not reuse CPU hotplug interface),
the table alone is not enough, one would need to build a protocol
between ACPI and firmware to communicate what CPUs to (un)hotplug.
It's basically repeating what current CPU hotplug interface does.

> > PS:
> > The reason we started building ACPI tables in QEMU, was never
> > ending story of adding more ABI and supporting it afterwards.
> > So I'd try to avoid doing it if it can be helped. =20
>=20
> Absolutely. We should try to keep all ACPI generation in QEMU.
> But this value is not for ACPI, is it?
I'm not sure what you are trying to say here.
=20
=20
>=20
> > > For now, the feature is temporarily disabled.
> > >=20
> > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > > Cc: Igor Mammedov <imammedo@redhat.com>
> > > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > > Cc: Richard Henderson <rth@twiddle.net>
> > > Ref: https://bugzilla.tianocore.org/show_bug.cgi?id=3D1515
> > > Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> > > ---
> > >  hw/i386/fw_cfg.h | 30 +++++++++++++++++++++++++++++-
> > >  hw/i386/fw_cfg.c | 26 ++++++++++++++++++++++++--
> > >  hw/i386/pc.c     |  4 ++--
> > >  3 files changed, 55 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
> > > index e0856a376996..d742435b9793 100644
> > > --- a/hw/i386/fw_cfg.h
> > > +++ b/hw/i386/fw_cfg.h
> > > @@ -18,9 +18,37 @@
> > >  #define FW_CFG_E820_TABLE       (FW_CFG_ARCH_LOCAL + 3)
> > >  #define FW_CFG_HPET             (FW_CFG_ARCH_LOCAL + 4)
> > > =20
> > > +/**
> > > + * FWCfgX86Topology: expose the X86 CPU topology to guest firmware o=
ver fw-cfg.
> > > + *
> > > + * All fields have little-endian encoding.
> > > + *
> > > + * @dies:     Number of dies per package (aka socket). Set it to 1 u=
nless the
> > > + *            concrete MachineState subclass defines it differently.
> > > + * @cores:    Corresponds to @CpuTopology.@cores.
> > > + * @threads:  Corresponds to @CpuTopology.@threads.
> > > + * @max_cpus: Corresponds to @CpuTopology.@max_cpus.
> > > + *
> > > + * Firmware can derive the package (aka socket) count with the follo=
wing
> > > + * formula:
> > > + *
> > > + *   DIV_ROUND_UP(@max_cpus, @dies * @cores * @threads)
> > > + *
> > > + * Firmware can derive APIC ID field widths and offsets per the stan=
dard
> > > + * calculations in "include/hw/i386/topology.h".
> > > + */
> > > +typedef struct FWCfgX86Topology {
> > > +  uint32_t dies;
> > > +  uint32_t cores;
> > > +  uint32_t threads;
> > > +  uint32_t max_cpus;
> > > +} QEMU_PACKED FWCfgX86Topology;
> > > +
> > >  FWCfgState *fw_cfg_arch_create(MachineState *ms,
> > >                                 uint16_t boot_cpus,
> > > -                               uint16_t apic_id_limit);
> > > +                               uint16_t apic_id_limit,
> > > +                               unsigned smp_dies,
> > > +                               bool expose_topology);
> > >  void fw_cfg_build_smbios(MachineState *ms, FWCfgState *fw_cfg);
> > >  void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_c=
fg);
> > > =20
> > > diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> > > index 39b6bc60520c..33d09875014f 100644
> > > --- a/hw/i386/fw_cfg.c
> > > +++ b/hw/i386/fw_cfg.c
> > > @@ -85,9 +85,26 @@ void fw_cfg_build_smbios(MachineState *ms, FWCfgSt=
ate *fw_cfg)
> > >      }
> > >  }
> > > =20
> > > +static void fw_cfg_expose_topology(FWCfgState *fw_cfg,
> > > +                                   unsigned dies,
> > > +                                   unsigned cores,
> > > +                                   unsigned threads,
> > > +                                   unsigned max_cpus)
> > > +{
> > > +    FWCfgX86Topology *topo =3D g_new(FWCfgX86Topology, 1);
> > > +
> > > +    topo->dies     =3D cpu_to_le32(dies);
> > > +    topo->cores    =3D cpu_to_le32(cores);
> > > +    topo->threads  =3D cpu_to_le32(threads);
> > > +    topo->max_cpus =3D cpu_to_le32(max_cpus);
> > > +    fw_cfg_add_file(fw_cfg, "etc/x86-smp-topology", topo, sizeof *to=
po);
> > > +}
> > > +
> > >  FWCfgState *fw_cfg_arch_create(MachineState *ms,
> > > -                                      uint16_t boot_cpus,
> > > -                                      uint16_t apic_id_limit)
> > > +                               uint16_t boot_cpus,
> > > +                               uint16_t apic_id_limit,
> > > +                               unsigned smp_dies,
> > > +                               bool expose_topology)
> > >  {
> > >      FWCfgState *fw_cfg;
> > >      uint64_t *numa_fw_cfg;
> > > @@ -143,6 +160,11 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
> > >                       (1 + apic_id_limit + nb_numa_nodes) *
> > >                       sizeof(*numa_fw_cfg));
> > > =20
> > > +    if (expose_topology) {
> > > +        fw_cfg_expose_topology(fw_cfg, smp_dies, ms->smp.cores,
> > > +                               ms->smp.threads, ms->smp.max_cpus);
> > > +    }
> > > +
> > >      return fw_cfg;
> > >  }
> > > =20
> > > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > index bcda50efcc23..bb72b12edad2 100644
> > > --- a/hw/i386/pc.c
> > > +++ b/hw/i386/pc.c
> > > @@ -1738,8 +1738,8 @@ void pc_memory_init(PCMachineState *pcms,
> > >                                          option_rom_mr,
> > >                                          1);
> > > =20
> > > -    fw_cfg =3D fw_cfg_arch_create(machine,
> > > -                                pcms->boot_cpus, pcms->apic_id_limit=
);
> > > +    fw_cfg =3D fw_cfg_arch_create(machine, pcms->boot_cpus, pcms->ap=
ic_id_limit,
> > > +                                pcms->smp_dies, false);
> > > =20
> > >      rom_set_fw(fw_cfg);
> > >   =20


