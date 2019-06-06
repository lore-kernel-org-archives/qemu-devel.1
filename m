Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF79CC28CC5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 03:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A1E72070B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 03:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Nht3DY2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1E72070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53601 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYipj-0006CK-KS
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 23:12:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hYiko-0002nC-7t
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 23:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hYikj-0000Uu-J7
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 23:07:50 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60355)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hYikh-0008Vh-CS; Wed, 05 Jun 2019 23:07:45 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45K9ZN66Ggz9s9y; Thu,  6 Jun 2019 13:07:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559790460;
	bh=UbFRRGCpjaRPre/8KwJagQhq7z16re20x8946eKKOlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nht3DY2KlH5Vd7goZOLKER6ssNMS0KjUh/Fbf6ex870lb3Sl8dwsQi1JMyIlhUPMf
	pQzzOu2YqroTzrDhNRRJ6WrrCYmBKmbMD1KOZLEv3BwtozSn4422KtWwXHFaLpzdcH
	Ysh+w88VKpiG+m6cmcRXc2aiirLjDummDg+60Bc8=
Date: Thu, 6 Jun 2019 13:07:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190606030732.GL10319@umbus.fritz.box>
References: <20190518205428.90532-1-like.xu@linux.intel.com>
	<20190518205428.90532-5-like.xu@linux.intel.com>
	<20190606025241.GM22416@habkost.net>
	<20190606025456.GN22416@habkost.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J2pR2RtFp0tAjF3C"
Content-Disposition: inline
In-Reply-To: <20190606025456.GN22416@habkost.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v3 04/10] hw/ppc: Replace global smp
 variables with machine smp properties
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Like Xu <like.xu@linux.intel.com>,
	qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	=?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
	Igor Mammedov <imammedo@redhat.com>,
	Alistair Francis <alistair23@gmail.com>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--J2pR2RtFp0tAjF3C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2019 at 11:54:56PM -0300, Eduardo Habkost wrote:
> On Wed, Jun 05, 2019 at 11:52:41PM -0300, Eduardo Habkost wrote:
> > On Sun, May 19, 2019 at 04:54:22AM +0800, Like Xu wrote:
> > > The global smp variables in ppc are replaced with smp machine propert=
ies.
> > >=20
> > > A local variable of the same name would be introduced in the declarat=
ion
> > > phase if it's used widely in the context OR replace it on the spot if=
 it's
> > > only used once. No semantic changes.
> > >=20
> > > Signed-off-by: Like Xu <like.xu@linux.intel.com>
> >=20
> > Any objections from the ppc maintainers to queueing this through
> > the Machine Core tree?
>=20
> Oops, CCing the ppc maintainers.

No objection here.

Acked-by: David Gibson <david@gibson.dropbear.id.au>

>=20
> >=20
> > > ---
> > >  hw/ppc/e500.c         |  3 +++
> > >  hw/ppc/mac_newworld.c |  3 ++-
> > >  hw/ppc/mac_oldworld.c |  3 ++-
> > >  hw/ppc/pnv.c          |  6 ++++--
> > >  hw/ppc/prep.c         |  4 ++--
> > >  hw/ppc/spapr.c        | 34 ++++++++++++++++++++++++++--------
> > >  hw/ppc/spapr_rtas.c   |  4 +++-
> > >  7 files changed, 42 insertions(+), 15 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> > > index beb2efd694..5e42e5a059 100644
> > > --- a/hw/ppc/e500.c
> > > +++ b/hw/ppc/e500.c
> > > @@ -307,6 +307,7 @@ static int ppce500_load_device_tree(PPCE500Machin=
eState *pms,
> > >                                      bool dry_run)
> > >  {
> > >      MachineState *machine =3D MACHINE(pms);
> > > +    unsigned int smp_cpus =3D machine->smp.cpus;
> > >      const PPCE500MachineClass *pmc =3D PPCE500_MACHINE_GET_CLASS(pms=
);
> > >      CPUPPCState *env =3D first_cpu->env_ptr;
> > >      int ret =3D -1;
> > > @@ -734,6 +735,7 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE50=
0MachineState *pms,
> > >      SysBusDevice *s;
> > >      int i, j, k;
> > >      MachineState *machine =3D MACHINE(pms);
> > > +    unsigned int smp_cpus =3D machine->smp.cpus;
> > >      const PPCE500MachineClass *pmc =3D PPCE500_MACHINE_GET_CLASS(pms=
);
> > > =20
> > >      dev =3D qdev_create(NULL, TYPE_OPENPIC);
> > > @@ -846,6 +848,7 @@ void ppce500_init(MachineState *machine)
> > >      struct boot_info *boot_info;
> > >      int dt_size;
> > >      int i;
> > > +    unsigned int smp_cpus =3D machine->smp.cpus;
> > >      /* irq num for pin INTA, INTB, INTC and INTD is 1, 2, 3 and
> > >       * 4 respectively */
> > >      unsigned int pci_irq_nrs[PCI_NUM_PINS] =3D {1, 2, 3, 4};
> > > diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> > > index 02d8559621..257b26ee24 100644
> > > --- a/hw/ppc/mac_newworld.c
> > > +++ b/hw/ppc/mac_newworld.c
> > > @@ -135,6 +135,7 @@ static void ppc_core99_init(MachineState *machine)
> > >      DeviceState *dev, *pic_dev;
> > >      hwaddr nvram_addr =3D 0xFFF04000;
> > >      uint64_t tbfreq;
> > > +    unsigned int smp_cpus =3D machine->smp.cpus;
> > > =20
> > >      linux_boot =3D (kernel_filename !=3D NULL);
> > > =20
> > > @@ -464,7 +465,7 @@ static void ppc_core99_init(MachineState *machine)
> > >      sysbus_mmio_map(s, 1, CFG_ADDR + 2);
> > > =20
> > >      fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)smp_cpus);
> > > -    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)max_cpus);
> > > +    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)machine->smp.m=
ax_cpus);
> > >      fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
> > >      fw_cfg_add_i16(fw_cfg, FW_CFG_MACHINE_ID, machine_arch);
> > >      fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, kernel_base);
> > > diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> > > index 460cbc7923..1968f05a6c 100644
> > > --- a/hw/ppc/mac_oldworld.c
> > > +++ b/hw/ppc/mac_oldworld.c
> > > @@ -99,6 +99,7 @@ static void ppc_heathrow_init(MachineState *machine)
> > >      DeviceState *dev, *pic_dev;
> > >      BusState *adb_bus;
> > >      int bios_size;
> > > +    unsigned int smp_cpus =3D machine->smp.cpus;
> > >      uint16_t ppc_boot_device;
> > >      DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
> > >      void *fw_cfg;
> > > @@ -322,7 +323,7 @@ static void ppc_heathrow_init(MachineState *machi=
ne)
> > >      sysbus_mmio_map(s, 1, CFG_ADDR + 2);
> > > =20
> > >      fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)smp_cpus);
> > > -    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)max_cpus);
> > > +    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)machine->smp.m=
ax_cpus);
> > >      fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
> > >      fw_cfg_add_i16(fw_cfg, FW_CFG_MACHINE_ID, ARCH_HEATHROW);
> > >      fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, kernel_base);
> > > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > > index 1e8c505936..3bb15338de 100644
> > > --- a/hw/ppc/pnv.c
> > > +++ b/hw/ppc/pnv.c
> > > @@ -678,7 +678,8 @@ static void pnv_init(MachineState *machine)
> > >          object_property_add_child(OBJECT(pnv), chip_name, chip, &err=
or_fatal);
> > >          object_property_set_int(chip, PNV_CHIP_HWID(i), "chip-id",
> > >                                  &error_fatal);
> > > -        object_property_set_int(chip, smp_cores, "nr-cores", &error_=
fatal);
> > > +        object_property_set_int(chip, machine->smp.cores,
> > > +                                "nr-cores", &error_fatal);
> > >          object_property_set_bool(chip, true, "realized", &error_fata=
l);
> > >      }
> > >      g_free(chip_typename);
> > > @@ -1134,6 +1135,7 @@ static void pnv_chip_instance_init(Object *obj)
> > > =20
> > >  static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
> > >  {
> > > +    MachineState *ms =3D MACHINE(qdev_get_machine());
> > >      Error *error =3D NULL;
> > >      PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> > >      const char *typename =3D pnv_chip_core_typename(chip);
> > > @@ -1168,7 +1170,7 @@ static void pnv_chip_core_realize(PnvChip *chip=
, Error **errp)
> > >          snprintf(core_name, sizeof(core_name), "core[%d]", core_hwid=
);
> > >          object_property_add_child(OBJECT(chip), core_name, OBJECT(pn=
v_core),
> > >                                    &error_fatal);
> > > -        object_property_set_int(OBJECT(pnv_core), smp_threads, "nr-t=
hreads",
> > > +        object_property_set_int(OBJECT(pnv_core), ms->smp.threads, "=
nr-threads",
> > >                                  &error_fatal);
> > >          object_property_set_int(OBJECT(pnv_core), core_hwid,
> > >                                  CPU_CORE_PROP_CORE_ID, &error_fatal);
> > > diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> > > index b7f459d475..968fd3ade2 100644
> > > --- a/hw/ppc/prep.c
> > > +++ b/hw/ppc/prep.c
> > > @@ -428,7 +428,7 @@ static void ppc_prep_init(MachineState *machine)
> > >      linux_boot =3D (kernel_filename !=3D NULL);
> > > =20
> > >      /* init CPUs */
> > > -    for (i =3D 0; i < smp_cpus; i++) {
> > > +    for (i =3D 0; i < machine->smp.cpus; i++) {
> > >          cpu =3D POWERPC_CPU(cpu_create(machine->cpu_type));
> > >          env =3D &cpu->env;
> > > =20
> > > @@ -765,7 +765,7 @@ static void ibm_40p_init(MachineState *machine)
> > >          boot_device =3D machine->boot_order[0];
> > >      }
> > > =20
> > > -    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)max_cpus);
> > > +    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)machine->smp.m=
ax_cpus);
> > >      fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)machine->ram_s=
ize);
> > >      fw_cfg_add_i16(fw_cfg, FW_CFG_MACHINE_ID, ARCH_PREP);
> > > =20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 7fb34decb9..25da337f84 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -105,6 +105,9 @@
> > >   */
> > >  static int spapr_vcpu_id(SpaprMachineState *spapr, int cpu_index)
> > >  {
> > > +    MachineState *ms =3D MACHINE(spapr);
> > > +    unsigned int smp_threads =3D ms->smp.threads;
> > > +
> > >      assert(spapr->vsmt);
> > >      return
> > >          (cpu_index / smp_threads) * spapr->vsmt + cpu_index % smp_th=
reads;
> > > @@ -152,8 +155,10 @@ static void pre_2_10_vmstate_unregister_dummy_ic=
p(int i)
> > > =20
> > >  int spapr_max_server_number(SpaprMachineState *spapr)
> > >  {
> > > +    MachineState *ms =3D MACHINE(spapr);
> > > +
> > >      assert(spapr->vsmt);
> > > -    return DIV_ROUND_UP(max_cpus * spapr->vsmt, smp_threads);
> > > +    return DIV_ROUND_UP(ms->smp.max_cpus * spapr->vsmt, ms->smp.thre=
ads);
> > >  }
> > > =20
> > >  static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU =
*cpu,
> > > @@ -286,6 +291,7 @@ static void spapr_populate_pa_features(SpaprMachi=
neState *spapr,
> > > =20
> > >  static int spapr_fixup_cpu_dt(void *fdt, SpaprMachineState *spapr)
> > >  {
> > > +    MachineState *ms =3D MACHINE(spapr);
> > >      int ret =3D 0, offset, cpus_offset;
> > >      CPUState *cs;
> > >      char cpu_model[32];
> > > @@ -295,7 +301,7 @@ static int spapr_fixup_cpu_dt(void *fdt, SpaprMac=
hineState *spapr)
> > >          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > >          DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
> > >          int index =3D spapr_get_vcpu_id(cpu);
> > > -        int compat_smt =3D MIN(smp_threads, ppc_compat_max_vthreads(=
cpu));
> > > +        int compat_smt =3D MIN(ms->smp.threads, ppc_compat_max_vthre=
ads(cpu));
> > > =20
> > >          if (!spapr_is_thread0_in_vcore(spapr, cpu)) {
> > >              continue;
> > > @@ -441,6 +447,7 @@ static int spapr_populate_memory(SpaprMachineStat=
e *spapr, void *fdt)
> > >  static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offse=
t,
> > >                                    SpaprMachineState *spapr)
> > >  {
> > > +    MachineState *ms =3D MACHINE(spapr);
> > >      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > >      CPUPPCState *env =3D &cpu->env;
> > >      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cs);
> > > @@ -452,7 +459,8 @@ static void spapr_populate_cpu_dt(CPUState *cs, v=
oid *fdt, int offset,
> > >      uint32_t cpufreq =3D kvm_enabled() ? kvmppc_get_clockfreq() : 10=
00000000;
> > >      uint32_t page_sizes_prop[64];
> > >      size_t page_sizes_prop_size;
> > > -    uint32_t vcpus_per_socket =3D smp_threads * smp_cores;
> > > +    unsigned int smp_threads =3D ms->smp.threads;
> > > +    uint32_t vcpus_per_socket =3D smp_threads * ms->smp.cores;
> > >      uint32_t pft_size_prop[] =3D {0, cpu_to_be32(spapr->htab_shift)};
> > >      int compat_smt =3D MIN(smp_threads, ppc_compat_max_vthreads(cpu)=
);
> > >      SpaprDrc *drc;
> > > @@ -1022,6 +1030,7 @@ int spapr_h_cas_compose_response(SpaprMachineSt=
ate *spapr,
> > > =20
> > >  static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
> > >  {
> > > +    MachineState *ms =3D MACHINE(spapr);
> > >      int rtas;
> > >      GString *hypertas =3D g_string_sized_new(256);
> > >      GString *qemu_hypertas =3D g_string_sized_new(256);
> > > @@ -1032,7 +1041,7 @@ static void spapr_dt_rtas(SpaprMachineState *sp=
apr, void *fdt)
> > >          cpu_to_be32(max_device_addr >> 32),
> > >          cpu_to_be32(max_device_addr & 0xffffffff),
> > >          0, cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE),
> > > -        cpu_to_be32(max_cpus / smp_threads),
> > > +        cpu_to_be32(ms->smp.max_cpus / ms->smp.threads),
> > >      };
> > >      uint32_t maxdomain =3D cpu_to_be32(spapr->gpu_numa_id > 1 ? 1 : =
0);
> > >      uint32_t maxdomains[] =3D {
> > > @@ -2540,7 +2549,7 @@ static void spapr_validate_node_memory(MachineS=
tate *machine, Error **errp)
> > >  /* find cpu slot in machine->possible_cpus by core_id */
> > >  static CPUArchId *spapr_find_cpu_slot(MachineState *ms, uint32_t id,=
 int *idx)
> > >  {
> > > -    int index =3D id / smp_threads;
> > > +    int index =3D id / ms->smp.threads;
> > > =20
> > >      if (index >=3D ms->possible_cpus->len) {
> > >          return NULL;
> > > @@ -2553,10 +2562,12 @@ static CPUArchId *spapr_find_cpu_slot(Machine=
State *ms, uint32_t id, int *idx)
> > > =20
> > >  static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **er=
rp)
> > >  {
> > > +    MachineState *ms =3D MACHINE(spapr);
> > >      Error *local_err =3D NULL;
> > >      bool vsmt_user =3D !!spapr->vsmt;
> > >      int kvm_smt =3D kvmppc_smt_threads();
> > >      int ret;
> > > +    unsigned int smp_threads =3D ms->smp.threads;
> > > =20
> > >      if (!kvm_enabled() && (smp_threads > 1)) {
> > >          error_setg(&local_err, "TCG cannot support more than 1 threa=
d/core "
> > > @@ -2630,6 +2641,9 @@ static void spapr_init_cpus(SpaprMachineState *=
spapr)
> > >      SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
> > >      const char *type =3D spapr_get_cpu_core_type(machine->cpu_type);
> > >      const CPUArchIdList *possible_cpus;
> > > +    unsigned int smp_cpus =3D machine->smp.cpus;
> > > +    unsigned int smp_threads =3D machine->smp.threads;
> > > +    unsigned int max_cpus =3D machine->smp.max_cpus;
> > >      int boot_cores_nr =3D smp_cpus / smp_threads;
> > >      int i;
> > > =20
> > > @@ -3856,6 +3870,7 @@ static void spapr_core_pre_plug(HotplugHandler =
*hotplug_dev, DeviceState *dev,
> > >      const char *type =3D object_get_typename(OBJECT(dev));
> > >      CPUArchId *core_slot;
> > >      int index;
> > > +    unsigned int smp_threads =3D machine->smp.threads;
> > > =20
> > >      if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
> > >          error_setg(&local_err, "CPU hotplug not supported for this m=
achine");
> > > @@ -4110,14 +4125,16 @@ spapr_cpu_index_to_props(MachineState *machin=
e, unsigned cpu_index)
> > > =20
> > >  static int64_t spapr_get_default_cpu_node_id(const MachineState *ms,=
 int idx)
> > >  {
> > > -    return idx / smp_cores % nb_numa_nodes;
> > > +    return idx / ms->smp.cores % nb_numa_nodes;
> > >  }
> > > =20
> > >  static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState=
 *machine)
> > >  {
> > >      int i;
> > > +    unsigned int smp_threads =3D machine->smp.threads;
> > > +    unsigned int smp_cpus =3D machine->smp.cpus;
> > >      const char *core_type;
> > > -    int spapr_max_cores =3D max_cpus / smp_threads;
> > > +    int spapr_max_cores =3D machine->smp.max_cpus / smp_threads;
> > >      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> > > =20
> > >      if (!mc->has_hotpluggable_cpus) {
> > > @@ -4240,6 +4257,7 @@ int spapr_get_vcpu_id(PowerPCCPU *cpu)
> > >  void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp)
> > >  {
> > >      SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > > +    MachineState *ms =3D MACHINE(spapr);
> > >      int vcpu_id;
> > > =20
> > >      vcpu_id =3D spapr_vcpu_id(spapr, cpu_index);
> > > @@ -4248,7 +4266,7 @@ void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu=
_index, Error **errp)
> > >          error_setg(errp, "Can't create CPU with id %d in KVM", vcpu_=
id);
> > >          error_append_hint(errp, "Adjust the number of cpus to %d "
> > >                            "or try to raise the number of threads per=
 core\n",
> > > -                          vcpu_id * smp_threads / spapr->vsmt);
> > > +                          vcpu_id * ms->smp.threads / spapr->vsmt);
> > >          return;
> > >      }
> > > =20
> > > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > > index ee24212765..c9ffe9786c 100644
> > > --- a/hw/ppc/spapr_rtas.c
> > > +++ b/hw/ppc/spapr_rtas.c
> > > @@ -231,6 +231,8 @@ static void rtas_ibm_get_system_parameter(PowerPC=
CPU *cpu,
> > >                                            target_ulong args,
> > >                                            uint32_t nret, target_ulon=
g rets)
> > >  {
> > > +    MachineState *ms =3D MACHINE(qdev_get_machine());
> > > +    unsigned int max_cpus =3D ms->smp.max_cpus;
> > >      target_ulong parameter =3D rtas_ld(args, 0);
> > >      target_ulong buffer =3D rtas_ld(args, 1);
> > >      target_ulong length =3D rtas_ld(args, 2);
> > > @@ -244,7 +246,7 @@ static void rtas_ibm_get_system_parameter(PowerPC=
CPU *cpu,
> > >                                            "MaxPlatProcs=3D%d",
> > >                                            max_cpus,
> > >                                            current_machine->ram_size =
/ MiB,
> > > -                                          smp_cpus,
> > > +                                          ms->smp.cpus,
> > >                                            max_cpus);
> > >          ret =3D sysparm_st(buffer, length, param_val, strlen(param_v=
al) + 1);
> > >          g_free(param_val);
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--J2pR2RtFp0tAjF3C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlz4g3MACgkQbDjKyiDZ
s5Jg6hAA44V2Vh6o5ZBwoLI1q1ZEp/nsjMpNmCu0NP/f6wN39L6Wu4J7vvkYnl0g
MBKphnnZCevs5Y5Ap3vvxZqXv/CXB9JdXGiNDvxSHwcjoHylquOv+zzF9KxhkZ3v
FSuuPr6w+4+k+XucI0J1gA8JqHdXTi0+ElnoBrZxwK+4DrTLcuM+Mp4lAxrum8AV
BVZVPJKlVjQlHL0E2DFa/mPcbYZ804xFL4rVhOewIxTklriD2bsHfTOSZlu1Ps35
3EqNTZrtu1/KKFol1BQpUgMVlSMTxQKnzN8S3LYG+iYqM2PZNZRb/U1UfL8i5ovm
PmJRfvB05hiIljxXbn7I7iPzWNYQJxPyz6UIfTCxTcgsQsZVR5C5KgV0OCgBvs7D
KZn9ZEWZo2MQwPxJ0/YFUzXIr2BVOZBVlLkhqW8Ro8hRBcN4hU7O4ghAw5/k7DZP
B3HTJSFsFykL/ubWhHDoA3JIj0RNiO9GGtPOcAFsUoa7NdjsEUzBx1X+0n5Te+kh
yzFp3ygjX83VD1pXW5IZ4kvJU0WfnPK2s8OMBldNLWPkHtnQ2Hyx/hrZVQh0J0Hr
9VP+rdskJAEDCcGTUF57L2P9GJrGxJWxEd4phvShp7lBpCeSbS7yRVDZ+T1LGQwz
A4LeuGn8/CjN0+WZd7Gk2mglq+KDK/rF8HkmsjmhE/5z153Dwn4=
=uAO/
-----END PGP SIGNATURE-----

--J2pR2RtFp0tAjF3C--

