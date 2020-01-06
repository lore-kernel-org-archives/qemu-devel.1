Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF0EC32771
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 08:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9E220848
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 08:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JACx+AIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9E220848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioO79-0000Jc-Qu
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 03:51:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ioO6N-0008EA-Fk
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 03:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ioO6E-0006NS-H3
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 03:51:07 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:52271 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ioO6B-0006Jv-Fi; Mon, 06 Jan 2020 03:50:58 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47rq3Y3pYyz9sQp; Mon,  6 Jan 2020 19:50:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578300649;
 bh=jIFJJHnWlnu+tM8M1Ggtgct62ZOEO1ErrOpCcB8vJ2g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JACx+AIcPu3K6aFvZl8qFqP/HzJscTjXAJeOMeM0U8vargyfcv64zFSCrna1wfgEV
 kv3lUDwQ1PQhSMWZl6RT3weDhajfxCBHFeLfI1ghAfO2SHPnGYK8L8EjuJCAqzh9AY
 qTthNM4+FdS81EGDmhajWqtYc/voaaQDhikNZ3sk=
Date: Mon, 6 Jan 2020 19:50:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu v2] spapr: Kill SLOF
Message-ID: <20200106085042.GW2098@umbus>
References: <20200105234242.78897-1-aik@ozlabs.ru>
 <20200106041940.GV2098@umbus>
 <80157816-7859-3450-6a2c-ab151be5ee94@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="reSNjdE3Iylkp4B8"
Content-Disposition: inline
In-Reply-To: <80157816-7859-3450-6a2c-ab151be5ee94@ozlabs.ru>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--reSNjdE3Iylkp4B8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2020 at 05:28:55PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 06/01/2020 15:19, David Gibson wrote:
> > On Mon, Jan 06, 2020 at 10:42:42AM +1100, Alexey Kardashevskiy wrote:
> >> The Petitboot bootloader is way more advanced than SLOF is ever going =
to
> >> be as Petitboot comes with the full-featured Linux kernel with all
> >> the drivers, and initramdisk with quite user friendly interface.
> >> The problem with ditching SLOF is that an unmodified pseries kernel can
> >> either start via:
> >> 1. kexec, this requires presence of RTAS and skips
> >> ibm,client-architecture-support entirely;
> >> 2. normal boot, this heavily relies on the OF1275 client interface to
> >> fetch the device tree and do early setup (claim memory).
> >>
> >> This adds a new bios-less mode to the pseries machine: "bios=3Don|off".
> >> When enabled, QEMU does not load SLOF and jumps to the kernel from
> >> "-kernel".
> >>
> >> The client interface is implemented exactly as RTAS - a 20 bytes blob,
> >> right next after the RTAS blob. The entry point is passed to the kernel
> >> via GPR5.
> >>
> >> This implements a handful of client interface methods just to get goin=
g.
> >> In particular, this implements the device tree fetching,
> >> ibm,client-architecture-support and instantiate-rtas.
> >>
> >> This implements changing FDT properties only for "linux,rtas-base" and
> >> "linux,rtas-entry", just to get early boot going.
> >>
> >> This assigns "phandles" to device tree nodes as there is no more SLOF
> >> and OF nodes addresses of which served as phandle values.
> >> This keeps predefined nodes (such as XICS/NVLINK/...) unchanged.
> >> phandles are regenerated at every FDT rebuild.
> >>
> >> When bios=3Doff, this adds "/chosen" every time QEMU builds a tree.
> >>
> >> This implements "claim" which the client (Linux) uses for memory
> >> allocation; this is also  used by QEMU for claiming kernel/initrd imag=
es,
> >> client interface entry point, RTAS and the initial stack.
> >>
> >> While at this, add a "kernel-addr" machine parameter to allow moving
> >> the kernel in memory. This is useful for debugging if the kernel is
> >> loaded at @0, although not necessary.
> >>
> >> This does not implement instances properly but in order to boot a VM,
> >> we only really need a stdout instance and the "/" instance for
> >> "call-method", we fake these.
> >=20
> > As we've discussed, I really like the idea of this.  It think the
> > basic approach looks good too.
> >=20
> > As you probably realize, there are quite a lot of things to be
> > polished though.  Comments below.
> >=20
> >>
> >> The test command line:
> >>
> >> qemu-system-ppc64 \
> >> -nodefaults \
> >> -chardev stdio,id=3DSTDIO0,signal=3Doff,mux=3Don \
> >> -device spapr-vty,id=3Dsvty0,reg=3D0x71000110,chardev=3DSTDIO0 \
> >> -mon id=3DMON0,chardev=3DSTDIO0,mode=3Dreadline \
> >> -nographic \
> >> -vga none \
> >> -kernel vmldbg \
> >> -machine pseries,bios=3Doff \
> >> -m 4G \
> >> -enable-kvm \
> >> -initrd pb/rootfs.cpio.xz \
> >> img/u1804-64le.qcow2 \
> >> -snapshot \
> >> -smp 8,threads=3D8 \
> >> -L /home/aik/t/qemu-ppc64-bios/ \
> >> -trace events=3Dqemu_trace_events \
> >> -d guest_errors \
> >> -chardev socket,id=3DSOCKET0,server,nowait,path=3Dqemu.mon.ssh37874 \
> >> -mon chardev=3DSOCKET0,mode=3Dcontrol
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >> Changes:
> >> v2:
> >> * fixed claim()
> >> * added "setprop"
> >> * cleaner client interface and RTAS blobs management
> >> * boots to petitboot and further to the target system
> >> * more trace points
> >> ---
> >>  hw/ppc/Makefile.objs   |   1 +
> >>  include/hw/loader.h    |   1 +
> >>  include/hw/ppc/spapr.h |  25 ++-
> >>  hw/ppc/spapr.c         | 231 ++++++++++++++++++--
> >>  hw/ppc/spapr_client.c  | 464 +++++++++++++++++++++++++++++++++++++++++
> >>  hw/ppc/spapr_hcall.c   |  49 +++--
> >>  hw/ppc/trace-events    |   9 +
> >>  7 files changed, 743 insertions(+), 37 deletions(-)
> >>  create mode 100644 hw/ppc/spapr_client.c
> >>
> >> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> >> index 101e9fc59185..ce31c0acd2fb 100644
> >> --- a/hw/ppc/Makefile.objs
> >> +++ b/hw/ppc/Makefile.objs
> >> @@ -6,6 +6,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o=
 spapr_rtas.o
> >>  obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o
> >>  obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o spapr_irq.o
> >>  obj-$(CONFIG_PSERIES) +=3D spapr_tpm_proxy.o
> >> +obj-$(CONFIG_PSERIES) +=3D spapr_client.o
> >=20
> > This applies in a bunch of places here.  Just calling things "client"
> > is clear enough if you're already thinking about Open Firmware.  But
> > this appears in a bunch of places where you might come across it
> > without that context, in which case it could be kind of confusing.  So
> > I'd suggest using "of_client" or "of_client_interface" in most places
> > you're using "client".
> >=20
> >>  obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
> >>  # IBM PowerNV
> >>  obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv=
_psi.o pnv_occ.o pnv_bmc.o
> >> diff --git a/include/hw/loader.h b/include/hw/loader.h
> >> index 48a96cd55904..a2f58077a47e 100644
> >> --- a/include/hw/loader.h
> >> +++ b/include/hw/loader.h
> >> @@ -262,6 +262,7 @@ MemoryRegion *rom_add_blob(const char *name, const=
 void *blob, size_t len,
> >>  int rom_add_elf_program(const char *name, GMappedFile *mapped_file, v=
oid *data,
> >>                          size_t datasize, size_t romsize, hwaddr addr,
> >>                          AddressSpace *as);
> >> +bool rom_intersect(uint64_t start, uint64_t size);
> >=20
> > I don't see this called, so I'm guessing it's a stray chunk leftover.
> >=20
> >>  int rom_check_and_register_reset(void);
> >>  void rom_set_fw(FWCfgState *f);
> >>  void rom_set_order_override(int order);
> >> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >> index 61f005c6f686..876879d12029 100644
> >> --- a/include/hw/ppc/spapr.h
> >> +++ b/include/hw/ppc/spapr.h
> >> @@ -105,6 +105,11 @@ struct SpaprCapabilities {
> >>      uint8_t caps[SPAPR_CAP_NUM];
> >>  };
> >> =20
> >> +typedef struct {
> >> +    uint64_t start;
> >> +    uint64_t size;
> >> +} spapr_of_claimed;
> >=20
> > Please use the qemu convention of StudlyCaps for types.
> >=20
> >>  /**
> >>   * SpaprMachineClass:
> >>   */
> >> @@ -158,8 +163,13 @@ struct SpaprMachineState {
> >>      uint32_t fdt_size;
> >>      uint32_t fdt_initial_size;
> >>      void *fdt_blob;
> >> +    uint32_t rtas_base;
> >>      long kernel_size;
> >>      bool kernel_le;
> >> +    uint64_t kernel_addr;
> >=20
> > This would intersect with your other patch to allow changing the
> > kernel load address, yes?
>=20
>=20
> This includes kernel_addr, it is a single patch now. More about this belo=
w.

Hm, ok.

> >> +    bool bios_enabled;
> >> +    GArray *claimed; /* array of spapr_of_claimed */
> >> +    uint64_t claimed_base;
> >=20
> > I'd suggest moving all the client interface related fields to a
> > visually separated chunk in the structure definition.
> >=20
> >>      uint32_t initrd_base;
> >>      long initrd_size;
> >>      uint64_t rtc_offset; /* Now used only during incoming migration */
> >> @@ -510,7 +520,8 @@ struct SpaprMachineState {
> >>  /* Client Architecture support */
> >>  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
> >>  #define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
> >> -#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
> >> +#define KVMPPC_H_CLIENT         (KVMPPC_HCALL_BASE + 0x5)
> >> +#define KVMPPC_HCALL_MAX        KVMPPC_H_CLIENT
> >> =20
> >>  /*
> >>   * The hcall range 0xEF00 to 0xEF80 is reserved for use in facilitati=
ng
> >> @@ -538,6 +549,12 @@ void spapr_register_hypercall(target_ulong opcode=
, spapr_hcall_fn fn);
> >>  target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
> >>                               target_ulong *args);
> >> =20
> >> +target_ulong do_client_architecture_support(PowerPCCPU *cpu,
> >> +                                            SpaprMachineState *spapr,
> >> +                                            target_ulong addr,
> >> +                                            target_ulong fdt_buf,
> >> +                                            target_ulong fdt_bufsize);
> >> +
> >>  /* Virtual Processor Area structure constants */
> >>  #define VPA_MIN_SIZE           640
> >>  #define VPA_SIZE_OFFSET        0x4
> >> @@ -769,6 +786,9 @@ struct SpaprEventLogEntry {
> >>  void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t sp=
ace);
> >>  void spapr_events_init(SpaprMachineState *sm);
> >>  void spapr_dt_events(SpaprMachineState *sm, void *fdt);
> >> +uint64_t spapr_do_client_claim(SpaprMachineState *sm, uint64_t virt,
> >> +                               uint64_t size, uint64_t align);
> >> +int spapr_h_client(SpaprMachineState *sm, target_ulong client_args);
> >>  void close_htab_fd(SpaprMachineState *spapr);
> >>  void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr);
> >>  void spapr_free_hpt(SpaprMachineState *spapr);
> >> @@ -891,4 +911,7 @@ void spapr_check_pagesize(SpaprMachineState *spapr=
, hwaddr pagesize,
> >>  #define SPAPR_OV5_XIVE_BOTH     0x80 /* Only to advertise on the plat=
form */
> >> =20
> >>  void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
> >> +
> >> +void spapr_instantiate_rtas(SpaprMachineState *spapr, uint32_t base);
> >> +
> >>  #endif /* HW_SPAPR_H */
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index e62c89b3dd40..1c97534a0aea 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -896,6 +896,51 @@ out:
> >>      return ret;
> >>  }
> >> =20
> >> +/*
> >> + * Below is a compiled version of RTAS blob and OF client interface e=
ntry point.
> >> + *
> >> + * gcc -nostdlib  -mbig -o spapr-rtas.img spapr-rtas.S
> >> + * objcopy  -O binary -j .text  spapr-rtas.img spapr-rtas.bin
> >> + *
> >> + *   .globl  _start
> >> + *   _start:
> >> + *           mr      4,3
> >> + *           lis     3,KVMPPC_H_RTAS@h
> >> + *           ori     3,3,KVMPPC_H_RTAS@l
> >> + *           sc      1
> >> + *           blr
> >> + *           mr      4,3
> >> + *           lis     3,KVMPPC_H_CLIENT@h
> >> + *           ori     3,3,KVMPPC_H_CLIENT@l
> >> + *           sc      1
> >> + *           blr
> >> + */
> >> +static struct {
> >> +    uint8_t rtas[20], client[20];
> >> +} QEMU_PACKED rtas_client_blob =3D {
> >> +    .rtas =3D {
> >> +        0x7c, 0x64, 0x1b, 0x78,
> >> +        0x3c, 0x60, 0x00, 0x00,
> >> +        0x60, 0x63, 0xf0, 0x00,
> >> +        0x44, 0x00, 0x00, 0x22,
> >> +        0x4e, 0x80, 0x00, 0x20
> >> +    },
> >> +    .client =3D {
> >> +        0x7c, 0x64, 0x1b, 0x78,
> >> +        0x3c, 0x60, 0x00, 0x00,
> >> +        0x60, 0x63, 0xf0, 0x05,
> >> +        0x44, 0x00, 0x00, 0x22,
> >> +        0x4e, 0x80, 0x00, 0x20
> >> +    }
> >> +};
> >=20
> > I'd really prefer to read this in from a file (or files) which we
> > assemble (as with the existing spapr-rtas.img), rather than having a
> > magic array in qemu.
>=20
> Two considerations here:
> 1. This blob is not going to change (at least often)

True, but I'd still prefer to build it from a .S rather than have the
binary written out.  We already had this until recently (when we moved
the RTAS image into SLOF), and it's really not too hard to manage.

> 2. A new file which needs to be packaged/signed/copied.

Eh, again, we had this for RTAS until very recently and it really
wasn't that much hassle.

> >> +void spapr_instantiate_rtas(SpaprMachineState *spapr, uint32_t base)
> >> +{
> >> +    spapr->rtas_base =3D base;
> >> +    cpu_physical_memory_write(base, rtas_client_blob.rtas,
> >> +                              sizeof(rtas_client_blob.rtas));
> >> +}
> >> +
> >>  static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
> >>  {
> >>      MachineState *ms =3D MACHINE(spapr);
> >> @@ -980,6 +1025,13 @@ static void spapr_dt_rtas(SpaprMachineState *spa=
pr, void *fdt)
> >>      _FDT(fdt_setprop(fdt, rtas, "ibm,lrdr-capacity",
> >>                       lrdr_capacity, sizeof(lrdr_capacity)));
> >> =20
> >> +    _FDT(fdt_setprop_cell(fdt, rtas, "linux,rtas-base", spapr->rtas_b=
ase));
> >> +    _FDT(fdt_setprop_cell(fdt, rtas, "linux,rtas-entry", spapr->rtas_=
base));
> >=20
> > IIUC, we shouldn't need to add these in bios=3Doff mode, yes?  Instead
> > the client must instantiate-rtas before attempting to use it.
>=20
>=20
> Well. Here is what happens:
>=20
> 1. spapr machine reset creates FDT, lets say without rtas-entry
> 2. linux calls ibm,client-interface-support

I assume you mean ibm,client-architecture-support?

> 3. the QEMU handler rebuilds the FDT

Oh.. not directly relevant here, but that might be an issue.  Do we
need to ensure that phandles are stable across the CAS call?

> 4. linux calls "instantiate-rtas"
> 5. linux stores "linux,rtas-base" and "linux,rtas-entry" in the FDT
> using "setprop" client call
> 6. linux fetches the tree by traversing it and packs it into FDT blob its=
elf
> 7. linux calls quiesce
> 8. linux uses "linux,rtas-entry" from FDT to call RTAS.
>=20
> Because in 5) I only allow in-place property update and only for
> "linux,rtas-base" and "linux,rtas-entry", these do not make to the tree
> and there is no "linux,rtas-entry" in the FDT.
>=20
> There are choices:
>=20
> 1. I can extend "setprop" (tricky as FDT is flattened by then?)

I actually don't think this should be too hard - though maybe I've
missed something, so I'd say this is my frontrunning option.

> 2. simply store rtas base in spapr->rtas_base and do complete FDT rebuild

I don't think that's viable - phandles definitely shouldn't change
across an instantiate-rtas call.

> 3. (currently) I basically have 2 placeholders for these
> "linux,rtas-base" and "linux,rtas-entry".

Hm, ok.

> Or we can avoid flattening FDT at all for bios=3Doff (as nobody wants
> flattened device tree, my "fetch-fdt" never made it to upstream Linux),
> then 1) is easy (if it is a problem to begin with).

Right, but we need a live DT library to make it happen, which means
someone finding time to write it.

> >> +    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size",
> >> +                          sizeof(rtas_client_blob.rtas)));
> >> +    _FDT(fdt_add_mem_rsv(fdt, spapr->rtas_base,
> >> +                         sizeof(rtas_client_blob.rtas)));
> >=20
> > Nor should we need the mem_rsv with bios=3Doff.
>=20
> True. If not the "setprop" limitation from above, I would only need
> "rtas-size" here.
>=20
>=20
> >=20
> >> +
> >>      spapr_dt_rtas_tokens(fdt, rtas);
> >>  }
> >> =20
> >> @@ -1057,7 +1109,7 @@ static void spapr_dt_chosen(SpaprMachineState *s=
papr, void *fdt)
> >>      }
> >> =20
> >>      if (spapr->kernel_size) {
> >> -        uint64_t kprop[2] =3D { cpu_to_be64(KERNEL_LOAD_ADDR),
> >> +        uint64_t kprop[2] =3D { cpu_to_be64(spapr->kernel_addr),
> >>                                cpu_to_be64(spapr->kernel_size) };
> >> =20
> >>          _FDT(fdt_setprop(fdt, chosen, "qemu,boot-kernel",
> >> @@ -1104,6 +1156,9 @@ static void spapr_dt_chosen(SpaprMachineState *s=
papr, void *fdt)
> >>          _FDT(fdt_setprop_cell(fdt, chosen, "linux,pci-probe-only", 0)=
);
> >>      }
> >> =20
> >> +    if (!spapr->bios_enabled) {
> >> +        _FDT(fdt_setprop_cell(fdt, chosen, "cpu", 0));
> >=20
> > What is this for?
>=20
> Looks like a leftover, I did this for prom_find_boot_cpu() but after
> double checking and trying it looks like it can proceed without this chun=
k.

Ok.

> >=20
> >> +    }
> >>      spapr_dt_ov5_platform_support(spapr, fdt, chosen);
> >> =20
> >>      g_free(stdout_path);
> >> @@ -1133,6 +1188,28 @@ static void spapr_dt_hypervisor(SpaprMachineSta=
te *spapr, void *fdt)
> >>      }
> >>  }
> >> =20
> >> +static void spapr_fdt_add_phandles(void *fdt, int parent, uint32_t *p=
handle)
> >> +{
> >> +    int proplen =3D 0, node;
> >> +    const void *prop;
> >> +    char tmp[256] =3D "BAAD";
> >> +
> >> +    fdt_get_path(fdt, parent, tmp, sizeof(tmp));
> >=20
> > You don't actually appear to use tmp.  Is this a debugging leftover?
>=20
> Yes it is.
>=20
>=20
> >=20
> >> +    prop =3D fdt_getprop_namelen(fdt, parent, "phandle", 7, &proplen);
> >> +    if (!prop) {
> >> +        _FDT(fdt_setprop_cell(fdt, parent, "phandle", *phandle));
> >> +        while (1) {
> >> +            ++*phandle;
> >> +            if (fdt_node_offset_by_phandle(fdt, *phandle) < 0) {
> >> +                break;
> >> +            }
> >> +        }
> >> +    }
> >> +    fdt_for_each_subnode(node, fdt, parent) {
> >> +        spapr_fdt_add_phandles(fdt, node, phandle);
> >> +    }
> >=20
> > Oof, this is pretty inefficient, since fdt_node_offset_by_phandle()
> > will have to scan the whole tree, and you do it on every node.
>=20
>=20
> Inefficient indeed but for a VM with ~30 devices it is not that bad :)
>=20
>=20
> > Obviously, a "live" tree structure rather than fdt would be better
> > suited for this.  I'd like to move to that at some point, but it will
> > be a while before we're ready.
>=20
> I could have a cache/hashmap of phandles...

We could, but I doubt it's worth the trouble.  Keeping the offsets in
there up to date against setprops or other changes could actually a
fair bit of hassle, I suspect.

> > I guess this is fine for a PoC, but I think we can do a bit better
> > without too much extra complexity:
> >   * Rather than scanning for an existing node with the handle on each
> >     iteration, you can use fdt_find_max_phandle() once beforehand,
> >     and start your counter from there, being assured that it won't hit
> >     any existing phandles
>=20
> I'd like to avoid that as NPU/GPU phandles are quite huge and we will
> have huge gaps between phandles numbers which is not so much of a big
> deal but annoying to debug.

Hrm.  So huge we'll actually be short of space above them?

> >   * The phandles are arbitrary, so you don't actually care about the
> >     tree structure here.  So instead of recursively descending the
> >     tree, you can just alter each node in the order they appear in the
> >     blob.  fdt_next_node() will let you do that, simply by ignoring
> >     the 'depth' parameter.  [In fact the structure ensures that will
> >     be a depth first traversal of the tree, just like you have here,
> >     not that it matters].
>=20
> ... but this one is better.
>=20
> Unlike many others, fdt_next_node() does not have a comment in
> dtc/libfdt/libfdt.h so I was not sure about what *depth is for and I
> basically ignored fdt_next_node().

Yeah, it's kind of subtle - mostly intended as an internal primitive -
but it suits your needs here.  It moves to the next node in the
structure block - regardless of whether it's a sibling, child or
sibling-of-ancestor.  *depth, if a pointer is supplied, is updated to
reflect which case it is.

> >   * You should check for overflows of your phandle counter, though
> >     it's fine to treat that as a fatal error.
>=20
> Ok.
>=20
>=20
> >> +}
> >> +
> >>  void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t sp=
ace)
> >>  {
> >>      MachineState *machine =3D MACHINE(spapr);
> >> @@ -1245,7 +1322,8 @@ void *spapr_build_fdt(SpaprMachineState *spapr, =
bool reset, size_t space)
> >>      /* Build memory reserve map */
> >>      if (reset) {
> >>          if (spapr->kernel_size) {
> >> -            _FDT((fdt_add_mem_rsv(fdt, KERNEL_LOAD_ADDR, spapr->kerne=
l_size)));
> >> +            _FDT((fdt_add_mem_rsv(fdt, spapr->kernel_addr,
> >> +                                  spapr->kernel_size)));
> >>          }
> >>          if (spapr->initrd_size) {
> >>              _FDT((fdt_add_mem_rsv(fdt, spapr->initrd_base,
> >> @@ -1268,12 +1346,19 @@ void *spapr_build_fdt(SpaprMachineState *spapr=
, bool reset, size_t space)
> >>          }
> >>      }
> >> =20
> >> +    if (!spapr->bios_enabled) {
> >> +        uint32_t phandle =3D 1;
> >> +
> >> +        spapr_fdt_add_phandles(fdt, fdt_path_offset(fdt, "/"), &phand=
le);
> >> +    }
> >> +
> >>      return fdt;
> >>  }
> >> =20
> >>  static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
> >>  {
> >> -    return (addr & 0x0fffffff) + KERNEL_LOAD_ADDR;
> >> +    SpaprMachineState *spapr =3D opaque;
> >> +    return (addr & 0x0fffffff) + spapr->kernel_addr;
> >>  }
> >> =20
> >>  static void emulate_spapr_hypercall(PPCVirtualHypervisor *vhyp,
> >> @@ -1660,6 +1745,60 @@ static void spapr_machine_reset(MachineState *m=
achine)
> >>       */
> >>      fdt_addr =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FDT_MAX_SIZE;
> >> =20
> >> +    /* Set up the entry state */
> >> +    if (!spapr->bios_enabled) {
> >> +        if (spapr->claimed) {
> >> +            g_array_unref(spapr->claimed);
> >> +        }
> >> +        spapr->claimed =3D g_array_new(false, false, sizeof(spapr_of_=
claimed));
> >> +        spapr->claimed_base =3D 0x10000; /* Avoid using the first sys=
tem page */
> >> +
> >> +        spapr_cpu_set_entry_state(first_ppc_cpu, spapr->kernel_addr, =
fdt_addr);
> >> +
> >> +        if (spapr_do_client_claim(spapr, spapr->kernel_addr,
> >> +                                  spapr->kernel_size, 0) =3D=3D -1) {
> >> +            error_report("Memory for kernel is in use");
> >> +            exit(1);
> >> +        }
> >> +        if (spapr_do_client_claim(spapr, spapr->initrd_base,
> >> +                                  spapr->initrd_size, 0) =3D=3D -1) {
> >> +            error_report("Memory for initramdisk is in use");
> >> +            exit(1);
> >> +        }
> >> +        first_ppc_cpu->env.gpr[1] =3D spapr_do_client_claim(spapr, 0,=
 0x40000,
> >> +                                                          0x10000);
> >> +        if (first_ppc_cpu->env.gpr[1] =3D=3D -1) {
> >> +            error_report("Memory for stack is in use");
> >> +            exit(1);
> >> +        }
> >> +
> >> +        first_ppc_cpu->env.gpr[5] =3D
> >> +            spapr_do_client_claim(spapr, 0, sizeof(rtas_client_blob.c=
lient),
> >> +                                  sizeof(rtas_client_blob.client));
> >> +        if (first_ppc_cpu->env.gpr[5] =3D=3D -1) {
> >> +            error_report("Memory for OF client is in use");
> >> +            exit(1);
> >> +        }
> >> +        cpu_physical_memory_write(first_ppc_cpu->env.gpr[5],
> >> +                                  rtas_client_blob.client,
> >> +                                  sizeof(rtas_client_blob.client));
> >> +
> >> +        /* Allocate space for RTAS here so spapr_build_fdt() below pi=
cks it */
> >> +        spapr->rtas_base =3D
> >> +            spapr_do_client_claim(spapr, 0, sizeof(rtas_client_blob.r=
tas),
> >> +                                  0x100);
> >> +        if (spapr->rtas_base =3D=3D -1) {
> >> +            error_report("Memory for RTAS is in use");
> >> +            exit(1);
> >> +        }
> >> +        cpu_physical_memory_write(spapr->rtas_base,
> >> +                                  rtas_client_blob.rtas,
> >> +                                  sizeof(rtas_client_blob.rtas));
> >=20
> > The above is complex enough it might be worth having bios and nobios
> > variants of spapr_cpu_set_entry_state().
>=20
> Probably yes, when it settles. I'd rather prefer having kernel/initrd
> claiming code where we load them but these are Roms and when we "load"
> them, they are not loaded, they are loaded from a machine reset handler b=
ut:
>=20
> may be we could add a hook to Roms to be called every time an image is
> actually written to the guest memory and
>=20
> this is when I would "claim" these chunks and
>=20
> this would make the chunk above shorter and we won't need a separate
> spapr_cpu_set_entry_state().

Hm, ok.  Well let's see how it turns out.

Fwiw, I have considered replacing those load_targphys() things with
explicit write in at reset time.  load_targphys() is, IIUC, mostly
used for loading things like ROMs which exist in physical memory but
don't go into regular RAM.  So if it turns out not to really match our
needs here, that's ok.

> >> +    } else {
> >> +        spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, f=
dt_addr);
> >> +        first_ppc_cpu->env.gpr[5] =3D 0; /* 0 =3D kexec !0 =3D prom_i=
nit */
> >> +    }
> >> +
> >>      fdt =3D spapr_build_fdt(spapr, true, FDT_MAX_SIZE);
> >> =20
> >>      rc =3D fdt_pack(fdt);
> >> @@ -1675,10 +1814,14 @@ static void spapr_machine_reset(MachineState *=
machine)
> >>      spapr->fdt_initial_size =3D spapr->fdt_size;
> >>      spapr->fdt_blob =3D fdt;
> >> =20
> >> -    /* Set up the entry state */
> >> -    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_a=
ddr);
> >> -    first_ppc_cpu->env.gpr[5] =3D 0;
> >> -
> >> +    if (!spapr->bios_enabled) {
> >> +        /*
> >> +         * Claim FDT space so initramdisk/zImage are not unpacked ove=
r it.
> >> +         * In practice Linux claim additional memory for FDT and fetc=
hes it
> >> +         * using client interface's "getprop" call.
> >> +         */
> >=20
> > IIUC, it shouldn't actually be necessary to put the fdt into guest
> > memory in nobios mode - it will be retrieved piecemeal via the client
> > interface instead, won't it?
>=20
> Huh. I was under the impression that we pass the FDT to a VM via GPR3
> and it is safer to avoid "claim" from claiming this memory (even though
> Linux is not using it).

Well, depends what you mean.  I mean that's the "fdt boot" convention,
which you've used previously for the nobios boot with an aware guest
image.  We use a similar convention for firing up SLOF itself.  But if
we're starting with a (simulated) OF entry condition, then as long as
we have a working client interface, we don't need an fdt blob anywhere
guest visible.

> Now I realize that this GPR3 is QEMU<->SLOF convention (or some OFW
> binding - what is it exactly?) and Linux rather expects initramdisk
> start/size in GPR3/4 and this did not hit me just because GPR4 is always
> 0 so Linux falls back to the device tree for initramdisk location.
>=20
>=20
>=20
>=20
> >=20
> >> +        spapr_do_client_claim(spapr, fdt_addr, fdt_totalsize(fdt), 0);
> >> +    }
> >>      spapr->cas_reboot =3D false;
> >>  }
> >> =20
> >> @@ -2897,12 +3040,12 @@ static void spapr_machine_init(MachineState *m=
achine)
> >>          uint64_t lowaddr =3D 0;
> >> =20
> >>          spapr->kernel_size =3D load_elf(kernel_filename, NULL,
> >> -                                      translate_kernel_address, NULL,
> >> +                                      translate_kernel_address, spapr,
> >>                                        NULL, &lowaddr, NULL, 1,
> >>                                        PPC_ELF_MACHINE, 0, 0);
> >>          if (spapr->kernel_size =3D=3D ELF_LOAD_WRONG_ENDIAN) {
> >>              spapr->kernel_size =3D load_elf(kernel_filename, NULL,
> >> -                                          translate_kernel_address, N=
ULL, NULL,
> >> +                                          translate_kernel_address, s=
papr, NULL,
> >>                                            &lowaddr, NULL, 0, PPC_ELF_=
MACHINE,
> >>                                            0, 0);
> >>              spapr->kernel_le =3D spapr->kernel_size > 0;
> >> @@ -2918,7 +3061,7 @@ static void spapr_machine_init(MachineState *mac=
hine)
> >>              /* Try to locate the initrd in the gap between the kernel
> >>               * and the firmware. Add a bit of space just in case
> >>               */
> >> -            spapr->initrd_base =3D (KERNEL_LOAD_ADDR + spapr->kernel_=
size
> >> +            spapr->initrd_base =3D (spapr->kernel_addr + spapr->kerne=
l_size
> >>                                    + 0x1ffff) & ~0xffff;
> >>              spapr->initrd_size =3D load_image_targphys(initrd_filenam=
e,
> >>                                                       spapr->initrd_ba=
se,
> >> @@ -2932,20 +3075,22 @@ static void spapr_machine_init(MachineState *m=
achine)
> >>          }
> >>      }
> >> =20
> >> -    if (bios_name =3D=3D NULL) {
> >> -        bios_name =3D FW_FILE_NAME;
> >> +    if (spapr->bios_enabled) {
> >> +        if (bios_name =3D=3D NULL) {
> >> +            bios_name =3D FW_FILE_NAME;
> >> +        }
> >> +        filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> >> +        if (!filename) {
> >> +            error_report("Could not find LPAR firmware '%s'", bios_na=
me);
> >> +            exit(1);
> >> +        }
> >> +        fw_size =3D load_image_targphys(filename, 0, FW_MAX_SIZE);
> >> +        if (fw_size <=3D 0) {
> >> +            error_report("Could not load LPAR firmware '%s'", filenam=
e);
> >> +            exit(1);
> >> +        }
> >> +        g_free(filename);
> >>      }
> >> -    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> >> -    if (!filename) {
> >> -        error_report("Could not find LPAR firmware '%s'", bios_name);
> >> -        exit(1);
> >> -    }
> >> -    fw_size =3D load_image_targphys(filename, 0, FW_MAX_SIZE);
> >> -    if (fw_size <=3D 0) {
> >> -        error_report("Could not load LPAR firmware '%s'", filename);
> >> -        exit(1);
> >> -    }
> >> -    g_free(filename);
> >> =20
> >>      /* FIXME: Should register things through the MachineState's qdev
> >>       * interface, this is a legacy from the sPAPREnvironment structure
> >> @@ -3162,6 +3307,32 @@ static void spapr_set_vsmt(Object *obj, Visitor=
 *v, const char *name,
> >>      visit_type_uint32(v, name, (uint32_t *)opaque, errp);
> >>  }
> >> =20
> >> +static void spapr_get_kernel_addr(Object *obj, Visitor *v, const char=
 *name,
> >> +                                  void *opaque, Error **errp)
> >> +{
> >> +    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
> >> +}
> >> +
> >> +static void spapr_set_kernel_addr(Object *obj, Visitor *v, const char=
 *name,
> >> +                                  void *opaque, Error **errp)
> >> +{
> >> +    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
> >> +}
> >=20
> > Might be clearer to split the adjustable kernel addr stuff out into a
> > separate patch - in fact, didn't you have such a patch before?
>=20
>=20
> I did but it was not useful on its own and the whole "bios=3Doff" feature
> does not need to be "series" at this stage. Also having it separate
> (before or after "kill slof") means changing same lines in 2 patches of
> the same patchset which is never really good.

Hm, ok.  What's the reason you require the changeable load location
for nobios?

> >> +static bool spapr_get_bios_enabled(Object *obj, Error **errp)
> >> +{
> >> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> >> +
> >> +    return spapr->bios_enabled;
> >> +}
> >> +
> >> +static void spapr_set_bios_enabled(Object *obj, bool value, Error **e=
rrp)
> >> +{
> >> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> >> +
> >> +    spapr->bios_enabled =3D value;
> >> +}
> >> +
> >>  static char *spapr_get_ic_mode(Object *obj, Error **errp)
> >>  {
> >>      SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> >> @@ -3267,6 +3438,20 @@ static void spapr_instance_init(Object *obj)
> >>      object_property_add_bool(obj, "vfio-no-msix-emulation",
> >>                               spapr_get_msix_emulation, NULL, NULL);
> >> =20
> >> +    object_property_add(obj, "kernel-addr", "uint64", spapr_get_kerne=
l_addr,
> >> +                        spapr_set_kernel_addr, NULL, &spapr->kernel_a=
ddr,
> >> +                        &error_abort);
> >> +    object_property_set_description(obj, "kernel-addr",
> >> +                                    stringify(KERNEL_LOAD_ADDR)
> >> +                                    " for -kernel is the default",
> >> +                                    NULL);
> >> +    spapr->kernel_addr =3D KERNEL_LOAD_ADDR;
> >> +    object_property_add_bool(obj, "bios", spapr_get_bios_enabled,
> >> +                            spapr_set_bios_enabled, NULL);
> >> +    object_property_set_description(obj, "bios", "Conrols whether to =
load bios",
> >> +                                    NULL);
> >> +    spapr->bios_enabled =3D true;
> >> +
> >>      /* The machine class defines the default interrupt controller mod=
e */
> >>      spapr->irq =3D smc->irq;
> >>      object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
> >> diff --git a/hw/ppc/spapr_client.c b/hw/ppc/spapr_client.c
> >> new file mode 100644
> >> index 000000000000..a318eaae3c40
> >> --- /dev/null
> >> +++ b/hw/ppc/spapr_client.c
> >> @@ -0,0 +1,464 @@
> >> +#include "qemu/osdep.h"
> >> +#include "qemu-common.h"
> >> +#include "qapi/error.h"
> >> +#include "exec/memory.h"
> >> +#include "hw/ppc/spapr.h"
> >> +#include "hw/ppc/spapr_vio.h"
> >> +#include "trace.h"
> >> +
> >> +struct prom_args {
> >=20
> > StudlyCaps and typedef, please..
> >=20
> >> +        __be32 service;
> >> +        __be32 nargs;
> >> +        __be32 nret;
> >> +        __be32 args[10];
>=20
>=20
> btw we do not generally have __be32 (and x86 build fails), I am
> replacing these with uint32_t.

Ok, good.

> >> +};
> >> +
> >> +#define CLI_PH_MASK     0x0FFFFFFF
> >> +#define CLI_INST_PREFIX 0x20000000
> >> +
> >> +#define readstr(pa, buf) cpu_physical_memory_read((pa), (buf), sizeof=
(buf))
> >=20
> > I'd prefer "readbuf" or something, since this isn't actually looking
> > at any string structure.
> >=20
> >> +#define readuint32(pa) ({ \
> >> +    uint32_t __tmp__; \
> >> +    cpu_physical_memory_read((pa), &__tmp__, sizeof(__tmp__)); \
> >> +    be32_to_cpu(__tmp__); })
> >=20
> > You can simplify this with ldl_be_phys().  In fact, then you probably
> > don't need any wrapper at all.
>=20
> Ah right. There are too many of these, was quicker to type this :)
>=20
>=20
> >> +
> >> +static bool _cmpservice(const char *s, size_t len,
> >> +                        unsigned nargs, unsigned nret,
> >> +                        const char *s1, size_t len1,
> >> +                        unsigned nargscheck, unsigned nretcheck)
> >> +{
> >> +    if (strncmp(s, s1, MAX(len, len1))) {
> >> +        return false;
> >> +    }
> >> +    if (nargscheck =3D=3D 0 && nretcheck =3D=3D 0) {
> >> +        return true;
> >> +    }
> >> +    if (nargs !=3D nargscheck || nret !=3D nretcheck) {
> >> +        trace_spapr_client_error_param(s, nargscheck, nretcheck, narg=
s, nret);
> >> +        return false;
> >> +    }
> >> +
> >> +    return true;
> >> +}
> >> +
> >> +static uint32_t client_finddevice(const void *fdt, uint32_t nodeaddr)
> >> +{
> >> +    char node[256];
> >> +    int ret;
> >> +
> >> +    readstr(nodeaddr, node);
> >> +    ret =3D fdt_path_offset(fdt, node);
> >> +    if (ret >=3D 0) {
> >> +        ret =3D fdt_get_phandle(fdt, ret);
> >> +    }
> >> +
> >> +    return (uint32_t) ret;
> >> +}
> >> +
> >> +static uint32_t client_getprop(const void *fdt, uint32_t nodeph, uint=
32_t pname,
> >> +            uint32_t valaddr, uint32_t vallen)
> >> +{
> >> +    char propname[64];
> >> +    uint32_t ret =3D 0;
> >> +    int proplen =3D 0;
> >> +    const void *prop;
> >> +
> >> +    readstr(pname, propname);
> >> +
> >> +    prop =3D fdt_getprop_namelen(fdt, fdt_node_offset_by_phandle(fdt,=
 nodeph),
> >> +                               propname, strlen(propname), &proplen);
> >=20
> > You can just use fdt_getprop().  By definition it's equivalent to
> > fdt_getprop_namelen(.., propname, strlen(propname), ...)
> >=20
> >> +    if (prop) {
> >> +        int cb =3D MIN(proplen, vallen);
> >> +
> >> +        cpu_physical_memory_write(valaddr, prop, cb);
> >> +        ret =3D cb;
> >> +    } else if (strncmp(propname, "stdout", 6) =3D=3D 0 && vallen =3D=
=3D sizeof(ret)) {
> >> +        ret =3D cpu_to_be32(1);
> >> +        cpu_physical_memory_write(valaddr, &ret, MIN(vallen, sizeof(r=
et)));
> >=20
> > I'm guessing the special casing of stdout is to fake the OF instancing
> > stuff, which I don't really understand.  Some comments to explain
> > what's going on here would be good.
>=20
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/powerpc/kernel/prom_init.c#n2219
>=20
> This thing wants ihandle which is stored as /chosen/stdout and which we
> do not have as there are no instances.
>=20
> If this property is not there, prom_panic() happens.
>=20
> I could implement some primitive intances, I'll look into this.

Ok, that's roughly as I guessed.  This seems like a reasonable way of
handling this for now without having to implement a notion of
instances - but it would be good to have some comment saying what's
going on here.

We might need to implement at least basic awareness of instances
if/when we need to be a bit more flexible about what input/output
devices we use for the console.

> >> +    } else {
> >> +        ret =3D -1;
> >> +    }
> >> +    trace_spapr_client_getprop(nodeph, propname, ret);
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static uint32_t client_setprop(SpaprMachineState *sm,
> >> +                               uint32_t nodeph, uint32_t pname,
> >> +                               uint32_t valaddr, uint32_t vallen)
> >> +{
> >> +    char propname[64];
> >> +    uint32_t ret =3D -1;
> >> +    int proplen =3D 0;
> >> +    const void *prop;
> >> +
> >> +    readstr(pname, propname);
> >> +    if (vallen =3D=3D sizeof(uint32_t) &&
> >> +        ((strncmp(propname, "linux,rtas-base", 15) =3D=3D 0) ||
> >> +         (strncmp(propname, "linux,rtas-entry", 16) =3D=3D 0))) {
> >> +
> >> +        sm->rtas_base =3D readuint32(valaddr);
> >> +        prop =3D fdt_getprop_namelen(sm->fdt_blob,
> >> +                                   fdt_node_offset_by_phandle(sm->fdt=
_blob,
> >> +                                                              nodeph),
> >> +                                   propname, strlen(propname), &propl=
en);
> >> +        if (proplen =3D=3D vallen) {
> >> +            *(uint32_t *) prop =3D cpu_to_be32(sm->rtas_base);
> >> +            ret =3D proplen;
> >> +        }
> >=20
> > Is there a particular reason to restrict this to the rtas properties,
> > rather than just allowing the guest to fdt_setprop() something
> > arbitrary?
>=20
> The FDT is flatten and I am not quite sure if libfdt can handle updating
> properties if the length has changed.

fdt_setprop() will handle updating properties with changed length (in
fact there's a special fdt_setprop_inplace() optimized for the case
where you don't need that).  It's not particularly efficient, but it
should work fine for the cases we have here.  In fact, I think you're
already relying on this for the code that adds the phandles to
everything.

One complication is that it can return FDT_ERR_NOSPACE if there isn't
enough buffer for the increased thing.  We could either trap that,
resize and retry, or we could leave a bunch of extra space.  The
latter would be basically equivalent to not doing fdt_pack() on the
blob in the nobios case.

> Also, more importantly, potentially property changes like this may have
> to be reflected in the QEMU device tree so I allowed only the properties
> which I know how to deal with.

That's a reasonable concern, but the nice thing about not having SLOF
is that there's only one copy of the device tree - the blob in qemu.
So a setprop() on that is automatically a setprop() everywhere (this
is another reason not to write the fdt into guest memory in the nobios
case - it will become stale as soon as the client changes anything).

> >> +    }
> >> +    trace_spapr_client_setprop(nodeph, propname, ret);
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static uint32_t client_getproplen(const void *fdt, uint32_t nodeph,
> >> +                                  uint32_t pname)
> >> +{
> >> +    char propname[64];
> >> +    uint32_t ret =3D 0;
> >> +    int proplen =3D 0;
> >> +    const void *prop;
> >> +
> >> +    readstr(pname, propname);
> >> +
> >> +    prop =3D fdt_getprop_namelen(fdt, fdt_node_offset_by_phandle(fdt,=
 nodeph),
> >> +                               propname, strlen(propname), &proplen);
> >> +    if (prop) {
> >> +        ret =3D proplen;
> >> +    } else if (strncmp(propname, "stdout", 6) =3D=3D 0) {
> >> +        ret =3D 4;
> >> +    } else {
> >> +        ret =3D -1;
> >> +    }
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static uint32_t client_peer(const void *fdt, uint32_t phandle)
> >> +{
> >> +    int ret;
> >> +
> >> +    if (phandle =3D=3D 0) {
> >> +        ret =3D fdt_path_offset(fdt, "/");
> >> +    } else {
> >> +        ret =3D fdt_next_subnode(fdt, fdt_node_offset_by_phandle(fdt,=
 phandle));
> >> +    }
> >> +
> >> +    if (ret < 0) {
> >> +        ret =3D 0;
> >> +    } else {
> >> +        ret =3D fdt_get_phandle(fdt, ret);
> >> +    }
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static uint32_t client_child(const void *fdt, uint32_t phandle)
> >> +{
> >> +    int ret =3D fdt_first_subnode(fdt, fdt_node_offset_by_phandle(fdt=
, phandle));
> >> +
> >> +    if (ret < 0) {
> >> +        ret =3D 0;
> >> +    } else {
> >> +        ret =3D fdt_get_phandle(fdt, ret);
> >> +    }
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static uint32_t client_parent(const void *fdt, uint32_t phandle)
> >> +{
> >> +    int ret =3D fdt_parent_offset(fdt, fdt_node_offset_by_phandle(fdt=
, phandle));
> >> +
> >> +    if (ret < 0) {
> >> +        ret =3D 0;
> >> +    } else {
> >> +        ret =3D fdt_get_phandle(fdt, ret);
> >> +    }
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static uint32_t client_open(uint32_t phandle)
> >> +{
> >> +    uint32_t ret =3D (phandle & CLI_PH_MASK) | CLI_INST_PREFIX;
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static uint32_t client_instance_to_path(SpaprMachineState *sm,
> >> +                                        uint32_t instance, uint32_t b=
uf,
> >> +                                        uint32_t len)
> >> +{
> >> +    uint32_t ph =3D instance & CLI_PH_MASK;
> >> +    char *stdout_path =3D spapr_vio_stdout_path(sm->vio_bus);
> >> +    int stdout_ph =3D fdt_path_offset(sm->fdt_blob, stdout_path);
> >> +
> >> +    if (ph =3D=3D stdout_ph) {
> >> +        len =3D MIN(len, strlen(stdout_path));
> >> +        cpu_physical_memory_write(buf, stdout_path, len);
> >> +    } else  {
> >> +        len =3D 0;
> >> +    }
> >> +    g_free(stdout_path);
> >> +
> >> +    return len;
> >> +}
> >> +
> >> +static uint32_t client_package_to_path(const void *fdt, uint32_t phan=
dle,
> >> +                                       uint32_t buf, uint32_t len)
> >> +{
> >> +    char tmp[256];
> >=20
> > Fixed sized buffers are icky.  You could either dynamically allocate
> > this based on the size the client gives, or you could use
> > memory_region_get_ram_ptr() to read the data from the tree directly
> > into guest memory.
>=20
> True, will fix.
>=20
>=20
> >> +    if (0 =3D=3D fdt_get_path(fdt, fdt_node_offset_by_phandle(fdt, ph=
andle), tmp,
> >> +                          sizeof(tmp))) {
> >> +        tmp[sizeof(tmp) - 1] =3D 0;
> >> +        cpu_physical_memory_write(buf, tmp, MIN(len, strlen(tmp)));
> >> +    }
> >> +    return len;
> >> +}
> >> +
> >> +static uint32_t client_write(uint32_t instance, uint32_t buf, uint32_=
t len)
> >> +{
> >> +    char tmp[len + 1]; /* TODO: do a loop as len might be enourmous*/
> >> +
> >> +    readstr(buf, tmp);
> >> +    tmp[len] =3D 0;
> >> +    printf("%s", tmp);
> >=20
> > I'm guessing this is what's used for console output via OF.  This is
> > enough for a debugging PoC, but for real we'll need to have this
> > actually go via the appropriate qemu chardev.
>=20
> Yes, this is for PoC. instance need to be tracked back to the actual
> device and I just do not have instances now.
>=20
>=20
> >> +
> >> +    return len;
> >> +}
> >> +
> >> +static bool client_claim_avail(SpaprMachineState *sm, uint64_t virt,
> >> +                               uint64_t size)
> >> +{
> >> +    int i;
> >> +    spapr_of_claimed *c;
> >> +
> >> +    for (i =3D 0; i < sm->claimed->len; ++i) {
> >> +        c =3D &g_array_index(sm->claimed, spapr_of_claimed, i);
> >> +        if ((c->start <=3D virt && virt < c->start + c->size) ||
> >> +            (virt <=3D c->start && c->start < virt + size)) {
> >> +            return false;
> >> +        }
> >> +    }
> >> +
> >> +    return true;
> >> +}
> >> +
> >> +uint64_t spapr_do_client_claim(SpaprMachineState *sm,
> >=20
> > SpaprMachineState * are usually called 'spapr', not 'sm'.
>=20
> Ok I'll fix but include/hw/ppc/spapr.h disagrees with you, this was the
> place where I added the very first function prototype which started all
> this :)

Oops, I'll try to fix that.

> >> uint64_t virt,
> >> +                               uint64_t size, uint64_t align)
> >> +{
> >> +    uint32_t ret;
> >> +    spapr_of_claimed newclaim;
> >> +
> >> +    if (align =3D=3D 0) {
> >> +        if (!client_claim_avail(sm, virt, size)) {
> >> +            return -1;
> >> +        }
> >> +        ret =3D virt;
> >> +    } else {
> >> +        align =3D pow2ceil(align);
> >> +        sm->claimed_base =3D (sm->claimed_base + align - 1) & ~(align=
 - 1);
> >> +        while (1) {
> >> +            if (sm->claimed_base >=3D sm->rma_size) {
> >> +                perror("Out of memory");
> >=20
> > This should be an error_report() rather than a perror().
> >=20
> >> +                return -1;
> >> +            }
> >> +            if (client_claim_avail(sm, sm->claimed_base, size)) {
> >> +                break;
> >> +            }
> >> +            sm->claimed_base +=3D size;
> >> +        }
> >> +        ret =3D sm->claimed_base;
> >> +    }
> >> +
> >> +    sm->claimed_base =3D MAX(sm->claimed_base, ret) + size;
> >=20
> > I understand the logic with claimed_base.  It looks like you're
> > implementing a bump allocator, but isn't the the client passing in the
> > address to claim anyway, so why do you need an allocator?
>=20
>=20
> The client passes 3 numbers - address, size, align, the address is only
> used when align=3D=3D0. So it is either allocating or claiming. I was not
> quite sure if address=3D=3D0 mode is (not) used, especially for zImage.

Ah, ok.  Some comments to clarify that would be nice.

> Having said that, I noticed that Linux always calls "claim" with
> non-zero address and increments it until it succeeded so I can ignore
> allocating case when called by Linux. I still need some
> allocator/claimer for myself though.
>=20
>=20
> >=20
> >> +    newclaim.start =3D virt;
> >> +    newclaim.size =3D size;
> >> +    g_array_append_val(sm->claimed, newclaim);
> >> +    trace_spapr_client_claim(virt, size, align, ret);
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static uint32_t client_claim(SpaprMachineState *sm, uint32_t virt,
> >> +                             uint32_t size, uint32_t align)
> >> +{
> >> +    return spapr_do_client_claim(sm, virt, size, align);
> >=20
> > Um.. why this wrapper?
>=20
>=20
> It grew to this. And I may add separate claim() and alloc() and only
> call claim() from here.
>=20
> >=20
> >> +}
> >> +
> >> +static uint32_t client_nextprop(const void *fdt, uint32_t phandle,
> >> +                                uint32_t prevaddr, uint32_t nameaddr)
> >> +{
> >> +    int namelen =3D 0;
> >> +    int offset =3D fdt_node_offset_by_phandle(fdt, phandle);
> >> +    char prev[256];
> >=20
> > Ew, fixed sized buffer.
> >=20
> >> +    const struct fdt_property *prop;
> >> +    const char *tmp;
> >> +
> >> +    readstr(prevaddr, prev);
> >> +    for (offset =3D fdt_first_property_offset(fdt, offset);
> >> +         (offset >=3D 0);
> >> +         (offset =3D fdt_next_property_offset(fdt, offset))) {
> >> +
> >> +        prop =3D fdt_get_property_by_offset(fdt, offset, &namelen);
> >=20
> > fdt_getprop_by_offset() also returns the property's name without
> > having to dick around with fdt_get_string() manually.
>=20
>=20
> Ah you're right.
>=20
>=20
> >=20
> >> +        if (!prop) {
> >> +            return 0;
> >> +        }
> >> +
> >> +        tmp =3D fdt_get_string(fdt, fdt32_ld(&prop->nameoff), &namele=
n);
> >> +        if (prev[0] =3D=3D 0 ||
> >=20
> > =3D=3D '\0' please.
> >=20
> >> +            strncmp(prev, tmp, MAX(namelen, strlen(prev))) =3D=3D 0) {
> >=20
> > This will break very badly if the client passed a name larger than
> > sizeof(prev), since readstr() won't \0 terminate in that case IIUC.
> >=20
> >> +            if (prev[0]) {
> >> +                offset =3D fdt_next_property_offset(fdt, offset);
> >> +                if (offset < 0) {
> >> +                    return 0;
> >> +                }
> >> +            }
> >> +            prop =3D fdt_get_property_by_offset(fdt, offset, &namelen=
);
> >> +            if (!prop) {
> >> +                return 0;
> >> +            }
> >> +
> >> +            tmp =3D fdt_get_string(fdt, fdt32_ld(&prop->nameoff), &na=
melen);
> >> +            cpu_physical_memory_write(nameaddr, tmp, namelen + 1);
> >> +            return 1;
> >> +        }
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static uint32_t client_call_method(SpaprMachineState *sm, uint32_t me=
thodaddr,
> >> +                                   uint32_t param1, uint32_t param2,
> >> +                                   uint32_t *ret2)
> >> +{
> >> +    uint32_t ret =3D 0;
> >> +    char method[256];
> >=20
> > More fixed sized buffers.
> >=20
> >> +    readstr(methodaddr, method);
> >> +    if (strncmp(method, "ibm,client-architecture-support", 31) =3D=3D=
 0) {
> >> +
> >> +#define FDT_MAX_SIZE            0x100000
> >> +        ret =3D do_client_architecture_support(POWERPC_CPU(first_cpu)=
, sm, param2,
> >> +                                             0, FDT_MAX_SIZE);
> >> +        *ret2 =3D 0;
> >> +    } else if (strncmp(method, "instantiate-rtas", 16) =3D=3D 0) {
> >> +        uint32_t rtasbase =3D param2;
> >> +
> >> +        spapr_instantiate_rtas(sm, rtasbase);
> >> +        *ret2 =3D rtasbase;
> >=20
> > In both these cases you ignore param1.  I'm guessing it has the handle
> > of the node on which you're calling the method?  In which case you
> > really should validate it.
>=20
> It is an ihandle which I do not do now.

Ah... ok.

> >> +    } else {
> >> +        trace_spapr_client_error_unknown_method(method);
> >> +        return -1;
> >> +    }
> >> +
> >> +    trace_spapr_client_method(method, param1, param2, ret);
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static void client_quiesce(SpaprMachineState *sm)
> >> +{
> >=20
> > Possibly want a flush of stdout here.
> >=20
> >> +}
> >> +
> >> +int spapr_h_client(SpaprMachineState *sm, target_ulong client_args)
> >> +{
> >> +    struct prom_args args =3D { 0 };
> >> +    char service[64];
> >=20
> > More fixed sized buffers.
> >=20
> >> +    unsigned nargs, nret;
> >> +    int i, servicelen;
> >> +
> >> +    cpu_physical_memory_read(client_args, &args, sizeof(args));
> >> +    nargs =3D be32_to_cpu(args.nargs);
> >> +    nret =3D be32_to_cpu(args.nret);
> >> +    readstr(be32_to_cpu(args.service), service);
> >> +    servicelen =3D strlen(service);
> >> +
> >> +#define cmpservice(s, a, r) \
> >> +        _cmpservice(service, servicelen, nargs, nret, (s), sizeof(s),=
 (a), (r))
> >> +
> >> +    if (cmpservice("finddevice", 1, 1)) {
> >=20
> > Hrm.  Rather than this giant chain of if(cmp) checks, I'd prefer to
> > have a table of services as a data structure, which the code would
> > scan through.  That does mean you'd have to give the functions
> > implementing each service a common signature, so they'd need to parse
> > out their own parameters, but I still think it's the better option.
> > It also makes it closer to how we implement RTAS call dispatch.
>=20
>=20
> I seriously doubt it will make the code simpler/shorter/easier; and it
> will move certain checks from compile time to run time. Dispatch tables
> make sense for "call-method" but for the others not so much. Thanks,
>=20
>=20
> >> +        args.args[nargs] =3D client_finddevice(sm->fdt_blob,
> >> +                                             be32_to_cpu(args.args[0]=
));
> >> +    } else if (cmpservice("getprop", 4, 1)) {
> >> +        args.args[nargs] =3D client_getprop(sm->fdt_blob,
> >> +                                          be32_to_cpu(args.args[0]),
> >> +                                          be32_to_cpu(args.args[1]),
> >> +                                          be32_to_cpu(args.args[2]),
> >> +                                          be32_to_cpu(args.args[3]));
> >> +    } else if (cmpservice("getproplen", 2, 1)) {
> >> +        args.args[nargs] =3D client_getproplen(sm->fdt_blob,
> >> +                                             be32_to_cpu(args.args[0]=
),
> >> +                                             be32_to_cpu(args.args[1]=
));
> >> +    } else if (cmpservice("setprop", 4, 1)) {
> >> +        args.args[nargs] =3D client_setprop(sm,
> >> +                                          be32_to_cpu(args.args[0]),
> >> +                                          be32_to_cpu(args.args[1]),
> >> +                                          be32_to_cpu(args.args[2]),
> >> +                                          be32_to_cpu(args.args[3]));
> >> +    } else if (cmpservice("instance-to-path", 3, 1)) {
> >> +        args.args[nargs] =3D client_instance_to_path(sm,
> >> +                                                   be32_to_cpu(args.a=
rgs[0]),
> >> +                                                   be32_to_cpu(args.a=
rgs[1]),
> >> +                                                   be32_to_cpu(args.a=
rgs[2]));
> >> +    } else if (cmpservice("package-to-path", 3, 1)) {
> >> +        args.args[nargs] =3D client_package_to_path(sm->fdt_blob,
> >> +                                                  be32_to_cpu(args.ar=
gs[0]),
> >> +                                                  be32_to_cpu(args.ar=
gs[1]),
> >> +                                                  be32_to_cpu(args.ar=
gs[2]));
> >> +    } else if (cmpservice("write", 3, 1)) {
> >> +        args.args[nargs] =3D client_write(be32_to_cpu(args.args[0]),
> >> +                                        be32_to_cpu(args.args[1]),
> >> +                                        be32_to_cpu(args.args[2]));
> >> +    } else if (cmpservice("peer", 1, 1)) {
> >> +        args.args[nargs] =3D client_peer(sm->fdt_blob,
> >> +                                       be32_to_cpu(args.args[0]));
> >> +    } else if (cmpservice("child", 1, 1)) {
> >> +        args.args[nargs] =3D client_child(sm->fdt_blob,
> >> +                                        be32_to_cpu(args.args[0]));
> >> +    } else if (cmpservice("parent", 1, 1)) {
> >> +        args.args[nargs] =3D client_parent(sm->fdt_blob,
> >> +                                         be32_to_cpu(args.args[0]));
> >> +    } else if (cmpservice("open", 1, 1)) {
> >> +        args.args[nargs] =3D client_open(be32_to_cpu(args.args[0]));
> >> +    } else if (cmpservice("call-method", 3, 2)) {
> >> +        uint32_t ret2 =3D 0;
> >> +
> >> +        args.args[nargs] =3D client_call_method(sm,
> >> +                                              be32_to_cpu(args.args[0=
]),
> >> +                                              be32_to_cpu(args.args[1=
]),
> >> +                                              be32_to_cpu(args.args[2=
]),
> >> +                                              &ret2);
> >> +        args.args[nargs + 1] =3D ret2;
> >> +    } else if (cmpservice("claim", 3, 1)) {
> >> +        args.args[nargs] =3D client_claim(sm,
> >> +                                        be32_to_cpu(args.args[0]),
> >> +                                        be32_to_cpu(args.args[1]),
> >> +                                        be32_to_cpu(args.args[2]));
> >> +    } else if (cmpservice("nextprop", 3, 1)) {
> >> +        args.args[nargs] =3D client_nextprop(sm->fdt_blob,
> >> +                                           be32_to_cpu(args.args[0]),
> >> +                                           be32_to_cpu(args.args[1]),
> >> +                                           be32_to_cpu(args.args[2]));
> >> +    } else if (cmpservice("quiesce", 0, 0)) {
> >> +        client_quiesce(sm);
> >> +    } else if (cmpservice("exit", 0, 0)) {
> >> +        error_report("Stopped as the VM requested \"exit\"");
> >> +        vm_stop(RUN_STATE_PAUSED);
> >> +    } else {
> >> +        trace_spapr_client_error_unknown_service(service, nargs, nret=
);
> >> +        args.args[nargs] =3D -1;
> >> +    }
> >> +
> >> +    for (i =3D 0; i < nret; ++i) {
> >> +        args.args[nargs + i] =3D be32_to_cpu(args.args[nargs + i]);
> >> +    }
> >> +    cpu_physical_memory_write(client_args, &args, sizeof(args));
> >> +
> >> +    return H_SUCCESS;
> >> +}
> >> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> >> index f1799b1b707d..76f93ec37959 100644
> >> --- a/hw/ppc/spapr_hcall.c
> >> +++ b/hw/ppc/spapr_hcall.c
> >> @@ -1660,15 +1660,12 @@ static bool spapr_hotplugged_dev_before_cas(vo=
id)
> >>      return false;
> >>  }
> >> =20
> >> -static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
> >> -                                                  SpaprMachineState *=
spapr,
> >> -                                                  target_ulong opcode,
> >> -                                                  target_ulong *args)
> >> +target_ulong do_client_architecture_support(PowerPCCPU *cpu,
> >> +                                            SpaprMachineState *spapr,
> >> +                                            target_ulong addr,
> >> +                                            target_ulong fdt_buf,
> >> +                                            target_ulong fdt_bufsize)
> >>  {
> >> -    /* Working address in data buffer */
> >> -    target_ulong addr =3D ppc64_phys_to_real(args[0]);
> >> -    target_ulong fdt_buf =3D args[1];
> >> -    target_ulong fdt_bufsize =3D args[2];
> >>      target_ulong ov_table;
> >>      uint32_t cas_pvr;
> >>      SpaprOptionVector *ov1_guest, *ov5_guest, *ov5_cas_old;
> >> @@ -1833,13 +1830,15 @@ static target_ulong h_client_architecture_supp=
ort(PowerPCCPU *cpu,
> >> =20
> >>          fdt_bufsize -=3D sizeof(hdr);
> >> =20
> >> -        fdt =3D spapr_build_fdt(spapr, false, fdt_bufsize);
> >> +        fdt =3D spapr_build_fdt(spapr, !spapr->bios_enabled, fdt_bufs=
ize);
> >>          _FDT((fdt_pack(fdt)));
> >> =20
> >> -        cpu_physical_memory_write(fdt_buf, &hdr, sizeof(hdr));
> >> -        cpu_physical_memory_write(fdt_buf + sizeof(hdr), fdt,
> >> -                                  fdt_totalsize(fdt));
> >> -        trace_spapr_cas_continue(fdt_totalsize(fdt) + sizeof(hdr));
> >> +        if (spapr->bios_enabled) {
> >> +            cpu_physical_memory_write(fdt_buf, &hdr, sizeof(hdr));
> >> +            cpu_physical_memory_write(fdt_buf + sizeof(hdr), fdt,
> >> +                                      fdt_totalsize(fdt));
> >> +            trace_spapr_cas_continue(fdt_totalsize(fdt) + sizeof(hdr)=
);
> >> +        }
> >> =20
> >>          g_free(spapr->fdt_blob);
> >>          spapr->fdt_size =3D fdt_totalsize(fdt);
> >> @@ -1854,6 +1853,20 @@ static target_ulong h_client_architecture_suppo=
rt(PowerPCCPU *cpu,
> >>      return H_SUCCESS;
> >>  }
> >> =20
> >> +static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
> >> +                                                  SpaprMachineState *=
spapr,
> >> +                                                  target_ulong opcode,
> >> +                                                  target_ulong *args)
> >> +{
> >> +    /* Working address in data buffer */
> >> +    target_ulong addr =3D ppc64_phys_to_real(args[0]);
> >> +    target_ulong fdt_buf =3D args[1];
> >> +    target_ulong fdt_bufsize =3D args[2];
> >> +
> >> +    return do_client_architecture_support(cpu, spapr, addr, fdt_buf,
> >> +                                          fdt_bufsize);
> >> +}
> >> +
> >>  static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
> >>                                                SpaprMachineState *spap=
r,
> >>                                                target_ulong opcode,
> >> @@ -1998,6 +2011,14 @@ static target_ulong h_update_dt(PowerPCCPU *cpu=
, SpaprMachineState *spapr,
> >>      return H_SUCCESS;
> >>  }
> >> =20
> >> +static target_ulong h_client(PowerPCCPU *cpu, SpaprMachineState *spap=
r,
> >> +                             target_ulong opcode, target_ulong *args)
> >> +{
> >> +    target_ulong client_args =3D ppc64_phys_to_real(args[0]);
> >> +
> >> +    return spapr_h_client(spapr, client_args);
> >> +}
> >> +
> >>  static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1=
];
> >>  static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPP=
C_HCALL_BASE + 1];
> >>  static spapr_hcall_fn svm_hypercall_table[(SVM_HCALL_MAX - SVM_HCALL_=
BASE) / 4 + 1];
> >> @@ -2121,6 +2142,8 @@ static void hypercall_register_types(void)
> >> =20
> >>      spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
> >> =20
> >> +    spapr_register_hypercall(KVMPPC_H_CLIENT, h_client);
> >> +
> >>      /* Virtual Processor Home Node */
> >>      spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
> >>                               h_home_node_associativity);
> >> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> >> index 9ea620f23c85..92bce3e44693 100644
> >> --- a/hw/ppc/trace-events
> >> +++ b/hw/ppc/trace-events
> >> @@ -21,6 +21,15 @@ spapr_update_dt(unsigned cb) "New blob %u bytes"
> >>  spapr_update_dt_failed_size(unsigned cbold, unsigned cbnew, unsigned =
magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
> >>  spapr_update_dt_failed_check(unsigned cbold, unsigned cbnew, unsigned=
 magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
> >> =20
> >> +# spapr_client.c
> >> +spapr_client_error_param(const char *method, int nargscheck, int nret=
check, int nargs, int nret) "%s takes/returns %d/%d, not %d/%d"
> >> +spapr_client_error_unknown_service(const char *service, int nargs, in=
t nret) "%s args=3D%d rets=3D%d"
> >> +spapr_client_error_unknown_method(const char *method) "%s"
> >> +spapr_client_claim(uint32_t virt, uint32_t size, uint32_t align, uint=
32_t ret) "virt=3D0x%x size=3D0x%x align=3D0x%x =3D> 0x%x"
> >> +spapr_client_method(const char *method, uint32_t param1, uint32_t par=
am2, uint32_t ret) "%s(0x%x, 0x%x) =3D> 0x%x"
> >> +spapr_client_getprop(uint32_t ph, const char *prop, uint32_t ret) "ph=
andle=3D0x%x \"%s\" =3D> 0x%x"
> >> +spapr_client_setprop(uint32_t ph, const char *prop, uint32_t ret) "ph=
andle=3D0x%x \"%s\" =3D> 0x%x"
> >> +
> >>  # spapr_hcall_tpm.c
> >>  spapr_h_tpm_comm(const char *device_path, uint64_t operation) "tpm_de=
vice_path=3D%s operation=3D0x%"PRIu64
> >>  spapr_tpm_execute(uint64_t data_in, uint64_t data_in_sz, uint64_t dat=
a_out, uint64_t data_out_sz) "data_in=3D0x%"PRIx64", data_in_sz=3D%"PRIu64"=
, data_out=3D0x%"PRIx64", data_out_sz=3D%"PRIu64
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--reSNjdE3Iylkp4B8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4S9N8ACgkQbDjKyiDZ
s5Kn5BAAnfx27DMsguwKKixrUqGyDK1GiGcmMfEIFa6yhbHWGIQsbLs+zwmECcJO
NOpMPxswvlNqwzM69TxRLP9WO+yk7+qokJtROgD08Ze1Y+PXlexzbaUd3BrIq+J0
KUnUf+1jyrytpDiUTXz7qqYrmSzImzmSgOh4LctJURTwSi8P0LL1emQdTCo1wIIq
refZy4YZazi1u+OZKdQw+IOYVS0Yor4FqWwEqY0roa61HUdDRVEmHYDz98QckHFs
fkpRpJkGaOc/wZ6supF497okQi/0KZ0PDlS2voOnzzjm1QgUXud5z/rhG7lt5EK5
L86vSDyyIoWVxOeZVap2aORLPCxsSEkHA3lND+hO/sDoX7d9gVlHOsHJOQowngML
Susd9l3KB7K16lgTQkENGDzAsQ3DyqkMFyrBbkEjzk1Jbxb+i63E3bC2zvtmxZPF
dnT/HJH8mmY3hhWPRri6uW0iTfKXzlyg78nPY71wH9EWWOVl1aRssJ8NkiQjOxf5
DEizkPZ7DoSTc8m38VILpwq0PNk3oB+SaJ52ikBjX6GFKlQ6Y3XMvsUhUz8rtvvK
K51U4j8DSBifvegDMMMw5XQ96+r8qI/ynUhWmj/s89y/C0JSTuICs75f3nHCTzLN
hREdorW5LVqiWuMPBfKN1pyyMeTNMT8/H/ofIhxzM/l+3sQN/zo=
=QZT1
-----END PGP SIGNATURE-----

--reSNjdE3Iylkp4B8--

