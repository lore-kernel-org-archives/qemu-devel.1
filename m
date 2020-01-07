Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1248C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:26:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 972472073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UGiJX1yN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972472073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iokAw-0004va-82
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 03:25:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iojPT-0005Pc-H4
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:36:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iojPN-0007jM-4Q
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:36:15 -0500
Received: from ozlabs.org ([203.11.71.1]:49977)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iojPL-0007f7-GV; Tue, 07 Jan 2020 02:36:09 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47sPLq5FyRz9sRG; Tue,  7 Jan 2020 18:36:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578382563;
 bh=49v/SB/j1HnfHDO/P2cLwM7tDPXBmAsJgImEqxx5ABc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UGiJX1yN4p7FVQXkYqy96TZ6njvTgsydDNxYHmMHVDb3pw0wLEcWcHsCsyeIM8JYJ
 0R5KXDsRjORw93K0OP3fMjGifKUsTUDvxm54F5MaHVFnxOyzzZLHf/djY54oxK5r2X
 7tL4ByOGrlsmvDRBV9e+FDnmYclc1TNeJjUzUkVo=
Date: Tue, 7 Jan 2020 16:26:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu v2] spapr: Kill SLOF
Message-ID: <20200107052604.GH2098@umbus>
References: <20200105234242.78897-1-aik@ozlabs.ru>
 <20200106041940.GV2098@umbus>
 <80157816-7859-3450-6a2c-ab151be5ee94@ozlabs.ru>
 <20200106085042.GW2098@umbus>
 <741e9b5e-6a7d-66a4-451d-e37c30697b2b@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8zu1PYoF5C4kwccn"
Content-Disposition: inline
In-Reply-To: <741e9b5e-6a7d-66a4-451d-e37c30697b2b@ozlabs.ru>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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


--8zu1PYoF5C4kwccn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2020 at 11:34:13PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 06/01/2020 19:50, David Gibson wrote:
> > On Mon, Jan 06, 2020 at 05:28:55PM +1100, Alexey Kardashevskiy wrote:
> > >=20
> > >=20
> > > On 06/01/2020 15:19, David Gibson wrote:
> > > > On Mon, Jan 06, 2020 at 10:42:42AM +1100, Alexey Kardashevskiy wrot=
e:
> > > > > The Petitboot bootloader is way more advanced than SLOF is ever g=
oing to
> > > > > be as Petitboot comes with the full-featured Linux kernel with all
> > > > > the drivers, and initramdisk with quite user friendly interface.
> > > > > The problem with ditching SLOF is that an unmodified pseries kern=
el can
> > > > > either start via:
> > > > > 1. kexec, this requires presence of RTAS and skips
> > > > > ibm,client-architecture-support entirely;
> > > > > 2. normal boot, this heavily relies on the OF1275 client interfac=
e to
> > > > > fetch the device tree and do early setup (claim memory).
> > > > >=20
> > > > > This adds a new bios-less mode to the pseries machine: "bios=3Don=
|off".
> > > > > When enabled, QEMU does not load SLOF and jumps to the kernel from
> > > > > "-kernel".
> > > > >=20
> > > > > The client interface is implemented exactly as RTAS - a 20 bytes =
blob,
> > > > > right next after the RTAS blob. The entry point is passed to the =
kernel
> > > > > via GPR5.
> > > > >=20
> > > > > This implements a handful of client interface methods just to get=
 going.
> > > > > In particular, this implements the device tree fetching,
> > > > > ibm,client-architecture-support and instantiate-rtas.
> > > > >=20
> > > > > This implements changing FDT properties only for "linux,rtas-base=
" and
> > > > > "linux,rtas-entry", just to get early boot going.
> > > > >=20
> > > > > This assigns "phandles" to device tree nodes as there is no more =
SLOF
> > > > > and OF nodes addresses of which served as phandle values.
> > > > > This keeps predefined nodes (such as XICS/NVLINK/...) unchanged.
> > > > > phandles are regenerated at every FDT rebuild.
> > > > >=20
> > > > > When bios=3Doff, this adds "/chosen" every time QEMU builds a tre=
e.
> > > > >=20
> > > > > This implements "claim" which the client (Linux) uses for memory
> > > > > allocation; this is also  used by QEMU for claiming kernel/initrd=
 images,
> > > > > client interface entry point, RTAS and the initial stack.
> > > > >=20
> > > > > While at this, add a "kernel-addr" machine parameter to allow mov=
ing
> > > > > the kernel in memory. This is useful for debugging if the kernel =
is
> > > > > loaded at @0, although not necessary.
> > > > >=20
> > > > > This does not implement instances properly but in order to boot a=
 VM,
> > > > > we only really need a stdout instance and the "/" instance for
> > > > > "call-method", we fake these.
> > > >=20
> > > > As we've discussed, I really like the idea of this.  It think the
> > > > basic approach looks good too.
> > > >=20
> > > > As you probably realize, there are quite a lot of things to be
> > > > polished though.  Comments below.
> > > >=20
> > > > >=20
> > > > > The test command line:
> > > > >=20
> > > > > qemu-system-ppc64 \
> > > > > -nodefaults \
> > > > > -chardev stdio,id=3DSTDIO0,signal=3Doff,mux=3Don \
> > > > > -device spapr-vty,id=3Dsvty0,reg=3D0x71000110,chardev=3DSTDIO0 \
> > > > > -mon id=3DMON0,chardev=3DSTDIO0,mode=3Dreadline \
> > > > > -nographic \
> > > > > -vga none \
> > > > > -kernel vmldbg \
> > > > > -machine pseries,bios=3Doff \
> > > > > -m 4G \
> > > > > -enable-kvm \
> > > > > -initrd pb/rootfs.cpio.xz \
> > > > > img/u1804-64le.qcow2 \
> > > > > -snapshot \
> > > > > -smp 8,threads=3D8 \
> > > > > -L /home/aik/t/qemu-ppc64-bios/ \
> > > > > -trace events=3Dqemu_trace_events \
> > > > > -d guest_errors \
> > > > > -chardev socket,id=3DSOCKET0,server,nowait,path=3Dqemu.mon.ssh378=
74 \
> > > > > -mon chardev=3DSOCKET0,mode=3Dcontrol
> > > > >=20
> > > > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > > > ---
> > > > > Changes:
> > > > > v2:
> > > > > * fixed claim()
> > > > > * added "setprop"
> > > > > * cleaner client interface and RTAS blobs management
> > > > > * boots to petitboot and further to the target system
> > > > > * more trace points
> > > > > ---
> > > > >   hw/ppc/Makefile.objs   |   1 +
> > > > >   include/hw/loader.h    |   1 +
> > > > >   include/hw/ppc/spapr.h |  25 ++-
> > > > >   hw/ppc/spapr.c         | 231 ++++++++++++++++++--
> > > > >   hw/ppc/spapr_client.c  | 464 ++++++++++++++++++++++++++++++++++=
+++++++
> > > > >   hw/ppc/spapr_hcall.c   |  49 +++--
> > > > >   hw/ppc/trace-events    |   9 +
> > > > >   7 files changed, 743 insertions(+), 37 deletions(-)
> > > > >   create mode 100644 hw/ppc/spapr_client.c
> > > > >=20
> > > > > diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> > > > > index 101e9fc59185..ce31c0acd2fb 100644
> > > > > --- a/hw/ppc/Makefile.objs
> > > > > +++ b/hw/ppc/Makefile.objs
> > > > > @@ -6,6 +6,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_io=
mmu.o spapr_rtas.o
> > > > >   obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o
> > > > >   obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o spapr_=
irq.o
> > > > >   obj-$(CONFIG_PSERIES) +=3D spapr_tpm_proxy.o
> > > > > +obj-$(CONFIG_PSERIES) +=3D spapr_client.o
> > > >=20
> > > > This applies in a bunch of places here.  Just calling things "clien=
t"
> > > > is clear enough if you're already thinking about Open Firmware.  But
> > > > this appears in a bunch of places where you might come across it
> > > > without that context, in which case it could be kind of confusing. =
 So
> > > > I'd suggest using "of_client" or "of_client_interface" in most plac=
es
> > > > you're using "client".
> > > >=20
> > > > >   obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
> > > > >   # IBM PowerNV
> > > > >   obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc=
=2Eo pnv_psi.o pnv_occ.o pnv_bmc.o
> > > > > diff --git a/include/hw/loader.h b/include/hw/loader.h
> > > > > index 48a96cd55904..a2f58077a47e 100644
> > > > > --- a/include/hw/loader.h
> > > > > +++ b/include/hw/loader.h
> > > > > @@ -262,6 +262,7 @@ MemoryRegion *rom_add_blob(const char *name, =
const void *blob, size_t len,
> > > > >   int rom_add_elf_program(const char *name, GMappedFile *mapped_f=
ile, void *data,
> > > > >                           size_t datasize, size_t romsize, hwaddr=
 addr,
> > > > >                           AddressSpace *as);
> > > > > +bool rom_intersect(uint64_t start, uint64_t size);
> > > >=20
> > > > I don't see this called, so I'm guessing it's a stray chunk leftove=
r.
> > > >=20
> > > > >   int rom_check_and_register_reset(void);
> > > > >   void rom_set_fw(FWCfgState *f);
> > > > >   void rom_set_order_override(int order);
> > > > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > > > index 61f005c6f686..876879d12029 100644
> > > > > --- a/include/hw/ppc/spapr.h
> > > > > +++ b/include/hw/ppc/spapr.h
> > > > > @@ -105,6 +105,11 @@ struct SpaprCapabilities {
> > > > >       uint8_t caps[SPAPR_CAP_NUM];
> > > > >   };
> > > > > +typedef struct {
> > > > > +    uint64_t start;
> > > > > +    uint64_t size;
> > > > > +} spapr_of_claimed;
> > > >=20
> > > > Please use the qemu convention of StudlyCaps for types.
> > > >=20
> > > > >   /**
> > > > >    * SpaprMachineClass:
> > > > >    */
> > > > > @@ -158,8 +163,13 @@ struct SpaprMachineState {
> > > > >       uint32_t fdt_size;
> > > > >       uint32_t fdt_initial_size;
> > > > >       void *fdt_blob;
> > > > > +    uint32_t rtas_base;
> > > > >       long kernel_size;
> > > > >       bool kernel_le;
> > > > > +    uint64_t kernel_addr;
> > > >=20
> > > > This would intersect with your other patch to allow changing the
> > > > kernel load address, yes?
> > >=20
> > >=20
> > > This includes kernel_addr, it is a single patch now. More about this =
below.
> >=20
> > Hm, ok.
> >=20
> > > > > +    bool bios_enabled;
> > > > > +    GArray *claimed; /* array of spapr_of_claimed */
> > > > > +    uint64_t claimed_base;
> > > >=20
> > > > I'd suggest moving all the client interface related fields to a
> > > > visually separated chunk in the structure definition.
> > > >=20
> > > > >       uint32_t initrd_base;
> > > > >       long initrd_size;
> > > > >       uint64_t rtc_offset; /* Now used only during incoming migra=
tion */
> > > > > @@ -510,7 +520,8 @@ struct SpaprMachineState {
> > > > >   /* Client Architecture support */
> > > > >   #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
> > > > >   #define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
> > > > > -#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
> > > > > +#define KVMPPC_H_CLIENT         (KVMPPC_HCALL_BASE + 0x5)
> > > > > +#define KVMPPC_HCALL_MAX        KVMPPC_H_CLIENT
> > > > >   /*
> > > > >    * The hcall range 0xEF00 to 0xEF80 is reserved for use in faci=
litating
> > > > > @@ -538,6 +549,12 @@ void spapr_register_hypercall(target_ulong o=
pcode, spapr_hcall_fn fn);
> > > > >   target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opco=
de,
> > > > >                                target_ulong *args);
> > > > > +target_ulong do_client_architecture_support(PowerPCCPU *cpu,
> > > > > +                                            SpaprMachineState *s=
papr,
> > > > > +                                            target_ulong addr,
> > > > > +                                            target_ulong fdt_buf,
> > > > > +                                            target_ulong fdt_buf=
size);
> > > > > +
> > > > >   /* Virtual Processor Area structure constants */
> > > > >   #define VPA_MIN_SIZE           640
> > > > >   #define VPA_SIZE_OFFSET        0x4
> > > > > @@ -769,6 +786,9 @@ struct SpaprEventLogEntry {
> > > > >   void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, siz=
e_t space);
> > > > >   void spapr_events_init(SpaprMachineState *sm);
> > > > >   void spapr_dt_events(SpaprMachineState *sm, void *fdt);
> > > > > +uint64_t spapr_do_client_claim(SpaprMachineState *sm, uint64_t v=
irt,
> > > > > +                               uint64_t size, uint64_t align);
> > > > > +int spapr_h_client(SpaprMachineState *sm, target_ulong client_ar=
gs);
> > > > >   void close_htab_fd(SpaprMachineState *spapr);
> > > > >   void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr);
> > > > >   void spapr_free_hpt(SpaprMachineState *spapr);
> > > > > @@ -891,4 +911,7 @@ void spapr_check_pagesize(SpaprMachineState *=
spapr, hwaddr pagesize,
> > > > >   #define SPAPR_OV5_XIVE_BOTH     0x80 /* Only to advertise on th=
e platform */
> > > > >   void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
> > > > > +
> > > > > +void spapr_instantiate_rtas(SpaprMachineState *spapr, uint32_t b=
ase);
> > > > > +
> > > > >   #endif /* HW_SPAPR_H */
> > > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > > index e62c89b3dd40..1c97534a0aea 100644
> > > > > --- a/hw/ppc/spapr.c
> > > > > +++ b/hw/ppc/spapr.c
> > > > > @@ -896,6 +896,51 @@ out:
> > > > >       return ret;
> > > > >   }
> > > > > +/*
> > > > > + * Below is a compiled version of RTAS blob and OF client interf=
ace entry point.
> > > > > + *
> > > > > + * gcc -nostdlib  -mbig -o spapr-rtas.img spapr-rtas.S
> > > > > + * objcopy  -O binary -j .text  spapr-rtas.img spapr-rtas.bin
> > > > > + *
> > > > > + *   .globl  _start
> > > > > + *   _start:
> > > > > + *           mr      4,3
> > > > > + *           lis     3,KVMPPC_H_RTAS@h
> > > > > + *           ori     3,3,KVMPPC_H_RTAS@l
> > > > > + *           sc      1
> > > > > + *           blr
> > > > > + *           mr      4,3
> > > > > + *           lis     3,KVMPPC_H_CLIENT@h
> > > > > + *           ori     3,3,KVMPPC_H_CLIENT@l
> > > > > + *           sc      1
> > > > > + *           blr
> > > > > + */
> > > > > +static struct {
> > > > > +    uint8_t rtas[20], client[20];
> > > > > +} QEMU_PACKED rtas_client_blob =3D {
> > > > > +    .rtas =3D {
> > > > > +        0x7c, 0x64, 0x1b, 0x78,
> > > > > +        0x3c, 0x60, 0x00, 0x00,
> > > > > +        0x60, 0x63, 0xf0, 0x00,
> > > > > +        0x44, 0x00, 0x00, 0x22,
> > > > > +        0x4e, 0x80, 0x00, 0x20
> > > > > +    },
> > > > > +    .client =3D {
> > > > > +        0x7c, 0x64, 0x1b, 0x78,
> > > > > +        0x3c, 0x60, 0x00, 0x00,
> > > > > +        0x60, 0x63, 0xf0, 0x05,
> > > > > +        0x44, 0x00, 0x00, 0x22,
> > > > > +        0x4e, 0x80, 0x00, 0x20
> > > > > +    }
> > > > > +};
> > > >=20
> > > > I'd really prefer to read this in from a file (or files) which we
> > > > assemble (as with the existing spapr-rtas.img), rather than having a
> > > > magic array in qemu.
> > >=20
> > > Two considerations here:
> > > 1. This blob is not going to change (at least often)
> >=20
> > True, but I'd still prefer to build it from a .S rather than have the
> > binary written out.  We already had this until recently (when we moved
> > the RTAS image into SLOF), and it's really not too hard to manage.
>=20
>=20
> But what is exactly the benefit? It is not going to change. I can look in=
to
> making it a .S, compile it to a binary an include this binary into
> qemu-system-ppc64 as a byte array, just need to refresh my gcc/ldd memori=
es
> but a separate file is too much for this imho.

Hmm, you have a point.  I'll rethink this based on what you and Peter
have said.

> > > 2. A new file which needs to be packaged/signed/copied.
> >=20
> > Eh, again, we had this for RTAS until very recently and it really
> > wasn't that much hassle.
>=20
> I keep secure VMs in mind. And SLOF is a separate package, why was
> not RTAS?

I'm not sure why secure VMs are relevant here.  RTAS was a built as a
separate image, but not a separate source package, simply because it
is tiny and even more closely coupled to qemu.

> > > > > +void spapr_instantiate_rtas(SpaprMachineState *spapr, uint32_t b=
ase)
> > > > > +{
> > > > > +    spapr->rtas_base =3D base;
> > > > > +    cpu_physical_memory_write(base, rtas_client_blob.rtas,
> > > > > +                              sizeof(rtas_client_blob.rtas));
> > > > > +}
> > > > > +
> > > > >   static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
> > > > >   {
> > > > >       MachineState *ms =3D MACHINE(spapr);
> > > > > @@ -980,6 +1025,13 @@ static void spapr_dt_rtas(SpaprMachineState=
 *spapr, void *fdt)
> > > > >       _FDT(fdt_setprop(fdt, rtas, "ibm,lrdr-capacity",
> > > > >                        lrdr_capacity, sizeof(lrdr_capacity)));
> > > > > +    _FDT(fdt_setprop_cell(fdt, rtas, "linux,rtas-base", spapr->r=
tas_base));
> > > > > +    _FDT(fdt_setprop_cell(fdt, rtas, "linux,rtas-entry", spapr->=
rtas_base));
> > > >=20
> > > > IIUC, we shouldn't need to add these in bios=3Doff mode, yes?  Inst=
ead
> > > > the client must instantiate-rtas before attempting to use it.
> > >=20
> > >=20
> > > Well. Here is what happens:
> > >=20
> > > 1. spapr machine reset creates FDT, lets say without rtas-entry
> > > 2. linux calls ibm,client-interface-support
> >=20
> > I assume you mean ibm,client-architecture-support?
>=20
> Yes.
>=20
> >=20
> > > 3. the QEMU handler rebuilds the FDT
> >=20
> > Oh.. not directly relevant here, but that might be an issue.  Do we
> > need to ensure that phandles are stable across the CAS call?
>=20
> We already have predefined values for phandles we care about.

Right that we care about on the qemu side.  But my concern is that a
client could poke around the device tree, retrieving some phandles,
then call CAS, then attempt to examine those nodes again using the
phandles it retrieved beforehand.

I think we're going to have to not support that, because keeping the
phandles consistent across CAS would be really fiddly in most cases
and truly impossible in some cases, I'm pretty sure.

> > > 4. linux calls "instantiate-rtas"
> > > 5. linux stores "linux,rtas-base" and "linux,rtas-entry" in the FDT
> > > using "setprop" client call
> > > 6. linux fetches the tree by traversing it and packs it into FDT blob=
 itself
> > > 7. linux calls quiesce
> > > 8. linux uses "linux,rtas-entry" from FDT to call RTAS.
> > >=20
> > > Because in 5) I only allow in-place property update and only for
> > > "linux,rtas-base" and "linux,rtas-entry", these do not make to the tr=
ee
> > > and there is no "linux,rtas-entry" in the FDT.
> > >=20
> > > There are choices:
> > >=20
> > > 1. I can extend "setprop" (tricky as FDT is flattened by then?)
> >=20
> > I actually don't think this should be too hard - though maybe I've
> > missed something, so I'd say this is my frontrunning option.
>=20
> fdt_splice_() fails because of lack of space in the FDT (you pointed to it
> below). Not calling fdt_pack() fixed it as it just keeps FDT blob rather
> big. Not sure it is worth further optimizations at this point.

Probably not.  Maybe we could fdt_pack() at quiesce time, at which
point we shouldn't have any further dt changes.

> > > 2. simply store rtas base in spapr->rtas_base and do complete FDT reb=
uild
> >=20
> > I don't think that's viable - phandles definitely shouldn't change
> > across an instantiate-rtas call.
> >=20
> > > 3. (currently) I basically have 2 placeholders for these
> > > "linux,rtas-base" and "linux,rtas-entry".
> >=20
> > Hm, ok.
> >=20
> > > Or we can avoid flattening FDT at all for bios=3Doff (as nobody wants
> > > flattened device tree, my "fetch-fdt" never made it to upstream Linux=
),
> > > then 1) is easy (if it is a problem to begin with).
> >=20
> > Right, but we need a live DT library to make it happen, which means
> > someone finding time to write it.
>=20
> I dropped fdt_pack() and change properties via fdt_setprop() - works
> just fine.

Great.

> > > > > +    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size",
> > > > > +                          sizeof(rtas_client_blob.rtas)));
> > > > > +    _FDT(fdt_add_mem_rsv(fdt, spapr->rtas_base,
> > > > > +                         sizeof(rtas_client_blob.rtas)));
> > > >=20
> > > > Nor should we need the mem_rsv with bios=3Doff.
> > >=20
> > > True. If not the "setprop" limitation from above, I would only need
> > > "rtas-size" here.
> > >=20
> > >=20
> > > >=20
> > > > > +
> > > > >       spapr_dt_rtas_tokens(fdt, rtas);
> > > > >   }
> > > > > @@ -1057,7 +1109,7 @@ static void spapr_dt_chosen(SpaprMachineSta=
te *spapr, void *fdt)
> > > > >       }
> > > > >       if (spapr->kernel_size) {
> > > > > -        uint64_t kprop[2] =3D { cpu_to_be64(KERNEL_LOAD_ADDR),
> > > > > +        uint64_t kprop[2] =3D { cpu_to_be64(spapr->kernel_addr),
> > > > >                                 cpu_to_be64(spapr->kernel_size) };
> > > > >           _FDT(fdt_setprop(fdt, chosen, "qemu,boot-kernel",
> > > > > @@ -1104,6 +1156,9 @@ static void spapr_dt_chosen(SpaprMachineSta=
te *spapr, void *fdt)
> > > > >           _FDT(fdt_setprop_cell(fdt, chosen, "linux,pci-probe-onl=
y", 0));
> > > > >       }
> > > > > +    if (!spapr->bios_enabled) {
> > > > > +        _FDT(fdt_setprop_cell(fdt, chosen, "cpu", 0));
> > > >=20
> > > > What is this for?
> > >=20
> > > Looks like a leftover, I did this for prom_find_boot_cpu() but after
> > > double checking and trying it looks like it can proceed without this =
chunk.
> >=20
> > Ok.
> >=20
> > > >=20
> > > > > +    }
> > > > >       spapr_dt_ov5_platform_support(spapr, fdt, chosen);
> > > > >       g_free(stdout_path);
> > > > > @@ -1133,6 +1188,28 @@ static void spapr_dt_hypervisor(SpaprMachi=
neState *spapr, void *fdt)
> > > > >       }
> > > > >   }
> > > > > +static void spapr_fdt_add_phandles(void *fdt, int parent, uint32=
_t *phandle)
> > > > > +{
> > > > > +    int proplen =3D 0, node;
> > > > > +    const void *prop;
> > > > > +    char tmp[256] =3D "BAAD";
> > > > > +
> > > > > +    fdt_get_path(fdt, parent, tmp, sizeof(tmp));
> > > >=20
> > > > You don't actually appear to use tmp.  Is this a debugging leftover?
> > >=20
> > > Yes it is.
> > >=20
> > >=20
> > > >=20
> > > > > +    prop =3D fdt_getprop_namelen(fdt, parent, "phandle", 7, &pro=
plen);
> > > > > +    if (!prop) {
> > > > > +        _FDT(fdt_setprop_cell(fdt, parent, "phandle", *phandle));
> > > > > +        while (1) {
> > > > > +            ++*phandle;
> > > > > +            if (fdt_node_offset_by_phandle(fdt, *phandle) < 0) {
> > > > > +                break;
> > > > > +            }
> > > > > +        }
> > > > > +    }
> > > > > +    fdt_for_each_subnode(node, fdt, parent) {
> > > > > +        spapr_fdt_add_phandles(fdt, node, phandle);
> > > > > +    }
> > > >=20
> > > > Oof, this is pretty inefficient, since fdt_node_offset_by_phandle()
> > > > will have to scan the whole tree, and you do it on every node.
> > >=20
> > >=20
> > > Inefficient indeed but for a VM with ~30 devices it is not that bad :)
> > >=20
> > >=20
> > > > Obviously, a "live" tree structure rather than fdt would be better
> > > > suited for this.  I'd like to move to that at some point, but it wi=
ll
> > > > be a while before we're ready.
> > >=20
> > > I could have a cache/hashmap of phandles...
> >=20
> > We could, but I doubt it's worth the trouble.  Keeping the offsets in
> > there up to date against setprops or other changes could actually a
> > fair bit of hassle, I suspect.
> >=20
> > > > I guess this is fine for a PoC, but I think we can do a bit better
> > > > without too much extra complexity:
> > > >    * Rather than scanning for an existing node with the handle on e=
ach
> > > >      iteration, you can use fdt_find_max_phandle() once beforehand,
> > > >      and start your counter from there, being assured that it won't=
 hit
> > > >      any existing phandles
> > >=20
> > > I'd like to avoid that as NPU/GPU phandles are quite huge and we will
> > > have huge gaps between phandles numbers which is not so much of a big
> > > deal but annoying to debug.
> >=20
> > Hrm.  So huge we'll actually be short of space above them?
>=20
>=20
> No, but "randomness" is annoying.
>=20
>=20
> > > >    * The phandles are arbitrary, so you don't actually care about t=
he
> > > >      tree structure here.  So instead of recursively descending the
> > > >      tree, you can just alter each node in the order they appear in=
 the
> > > >      blob.  fdt_next_node() will let you do that, simply by ignoring
> > > >      the 'depth' parameter.  [In fact the structure ensures that wi=
ll
> > > >      be a depth first traversal of the tree, just like you have her=
e,
> > > >      not that it matters].
> > >=20
> > > ... but this one is better.
> > >=20
> > > Unlike many others, fdt_next_node() does not have a comment in
> > > dtc/libfdt/libfdt.h so I was not sure about what *depth is for and I
> > > basically ignored fdt_next_node().
> >=20
> > Yeah, it's kind of subtle - mostly intended as an internal primitive -
> > but it suits your needs here.  It moves to the next node in the
> > structure block - regardless of whether it's a sibling, child or
> > sibling-of-ancestor.  *depth, if a pointer is supplied, is updated to
> > reflect which case it is.
> >=20
> > > >    * You should check for overflows of your phandle counter, though
> > > >      it's fine to treat that as a fatal error.
> > >=20
> > > Ok.
> > >=20
> > >=20
> > > > > +}
> > > > > +
> > > > >   void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, siz=
e_t space)
> > > > >   {
> > > > >       MachineState *machine =3D MACHINE(spapr);
> > > > > @@ -1245,7 +1322,8 @@ void *spapr_build_fdt(SpaprMachineState *sp=
apr, bool reset, size_t space)
> > > > >       /* Build memory reserve map */
> > > > >       if (reset) {
> > > > >           if (spapr->kernel_size) {
> > > > > -            _FDT((fdt_add_mem_rsv(fdt, KERNEL_LOAD_ADDR, spapr->=
kernel_size)));
> > > > > +            _FDT((fdt_add_mem_rsv(fdt, spapr->kernel_addr,
> > > > > +                                  spapr->kernel_size)));
> > > > >           }
> > > > >           if (spapr->initrd_size) {
> > > > >               _FDT((fdt_add_mem_rsv(fdt, spapr->initrd_base,
> > > > > @@ -1268,12 +1346,19 @@ void *spapr_build_fdt(SpaprMachineState *=
spapr, bool reset, size_t space)
> > > > >           }
> > > > >       }
> > > > > +    if (!spapr->bios_enabled) {
> > > > > +        uint32_t phandle =3D 1;
> > > > > +
> > > > > +        spapr_fdt_add_phandles(fdt, fdt_path_offset(fdt, "/"), &=
phandle);
> > > > > +    }
> > > > > +
> > > > >       return fdt;
> > > > >   }
> > > > >   static uint64_t translate_kernel_address(void *opaque, uint64_t=
 addr)
> > > > >   {
> > > > > -    return (addr & 0x0fffffff) + KERNEL_LOAD_ADDR;
> > > > > +    SpaprMachineState *spapr =3D opaque;
> > > > > +    return (addr & 0x0fffffff) + spapr->kernel_addr;
> > > > >   }
> > > > >   static void emulate_spapr_hypercall(PPCVirtualHypervisor *vhyp,
> > > > > @@ -1660,6 +1745,60 @@ static void spapr_machine_reset(MachineSta=
te *machine)
> > > > >        */
> > > > >       fdt_addr =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FDT_MAX_=
SIZE;
> > > > > +    /* Set up the entry state */
> > > > > +    if (!spapr->bios_enabled) {
> > > > > +        if (spapr->claimed) {
> > > > > +            g_array_unref(spapr->claimed);
> > > > > +        }
> > > > > +        spapr->claimed =3D g_array_new(false, false, sizeof(spap=
r_of_claimed));
> > > > > +        spapr->claimed_base =3D 0x10000; /* Avoid using the firs=
t system page */
> > > > > +
> > > > > +        spapr_cpu_set_entry_state(first_ppc_cpu, spapr->kernel_a=
ddr, fdt_addr);
> > > > > +
> > > > > +        if (spapr_do_client_claim(spapr, spapr->kernel_addr,
> > > > > +                                  spapr->kernel_size, 0) =3D=3D =
-1) {
> > > > > +            error_report("Memory for kernel is in use");
> > > > > +            exit(1);
> > > > > +        }
> > > > > +        if (spapr_do_client_claim(spapr, spapr->initrd_base,
> > > > > +                                  spapr->initrd_size, 0) =3D=3D =
-1) {
> > > > > +            error_report("Memory for initramdisk is in use");
> > > > > +            exit(1);
> > > > > +        }
> > > > > +        first_ppc_cpu->env.gpr[1] =3D spapr_do_client_claim(spap=
r, 0, 0x40000,
> > > > > +                                                          0x1000=
0);
> > > > > +        if (first_ppc_cpu->env.gpr[1] =3D=3D -1) {
> > > > > +            error_report("Memory for stack is in use");
> > > > > +            exit(1);
> > > > > +        }
> > > > > +
> > > > > +        first_ppc_cpu->env.gpr[5] =3D
> > > > > +            spapr_do_client_claim(spapr, 0, sizeof(rtas_client_b=
lob.client),
> > > > > +                                  sizeof(rtas_client_blob.client=
));
> > > > > +        if (first_ppc_cpu->env.gpr[5] =3D=3D -1) {
> > > > > +            error_report("Memory for OF client is in use");
> > > > > +            exit(1);
> > > > > +        }
> > > > > +        cpu_physical_memory_write(first_ppc_cpu->env.gpr[5],
> > > > > +                                  rtas_client_blob.client,
> > > > > +                                  sizeof(rtas_client_blob.client=
));
> > > > > +
> > > > > +        /* Allocate space for RTAS here so spapr_build_fdt() bel=
ow picks it */
> > > > > +        spapr->rtas_base =3D
> > > > > +            spapr_do_client_claim(spapr, 0, sizeof(rtas_client_b=
lob.rtas),
> > > > > +                                  0x100);
> > > > > +        if (spapr->rtas_base =3D=3D -1) {
> > > > > +            error_report("Memory for RTAS is in use");
> > > > > +            exit(1);
> > > > > +        }
> > > > > +        cpu_physical_memory_write(spapr->rtas_base,
> > > > > +                                  rtas_client_blob.rtas,
> > > > > +                                  sizeof(rtas_client_blob.rtas));
> > > >=20
> > > > The above is complex enough it might be worth having bios and nobios
> > > > variants of spapr_cpu_set_entry_state().
> > >=20
> > > Probably yes, when it settles. I'd rather prefer having kernel/initrd
> > > claiming code where we load them but these are Roms and when we "load"
> > > them, they are not loaded, they are loaded from a machine reset handl=
er but:
> > >=20
> > > may be we could add a hook to Roms to be called every time an image is
> > > actually written to the guest memory and
> > >=20
> > > this is when I would "claim" these chunks and
> > >=20
> > > this would make the chunk above shorter and we won't need a separate
> > > spapr_cpu_set_entry_state().
> >=20
> > Hm, ok.  Well let's see how it turns out.
> >=20
> > Fwiw, I have considered replacing those load_targphys() things with
> > explicit write in at reset time.  load_targphys() is, IIUC, mostly
> > used for loading things like ROMs which exist in physical memory but
> > don't go into regular RAM.  So if it turns out not to really match our
> > needs here, that's ok.
>=20
>=20
> Agree, may be later. I want to keep this a single patch.
>=20
>=20
>=20
> > > > > +    } else {
> > > > > +        spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POI=
NT, fdt_addr);
> > > > > +        first_ppc_cpu->env.gpr[5] =3D 0; /* 0 =3D kexec !0 =3D p=
rom_init */
> > > > > +    }
> > > > > +
> > > > >       fdt =3D spapr_build_fdt(spapr, true, FDT_MAX_SIZE);
> > > > >       rc =3D fdt_pack(fdt);
> > > > > @@ -1675,10 +1814,14 @@ static void spapr_machine_reset(MachineSt=
ate *machine)
> > > > >       spapr->fdt_initial_size =3D spapr->fdt_size;
> > > > >       spapr->fdt_blob =3D fdt;
> > > > > -    /* Set up the entry state */
> > > > > -    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, =
fdt_addr);
> > > > > -    first_ppc_cpu->env.gpr[5] =3D 0;
> > > > > -
> > > > > +    if (!spapr->bios_enabled) {
> > > > > +        /*
> > > > > +         * Claim FDT space so initramdisk/zImage are not unpacke=
d over it.
> > > > > +         * In practice Linux claim additional memory for FDT and=
 fetches it
> > > > > +         * using client interface's "getprop" call.
> > > > > +         */
> > > >=20
> > > > IIUC, it shouldn't actually be necessary to put the fdt into guest
> > > > memory in nobios mode - it will be retrieved piecemeal via the clie=
nt
> > > > interface instead, won't it?
> > >=20
> > > Huh. I was under the impression that we pass the FDT to a VM via GPR3
> > > and it is safer to avoid "claim" from claiming this memory (even thou=
gh
> > > Linux is not using it).
> >=20
> > Well, depends what you mean.  I mean that's the "fdt boot" convention,
> > which you've used previously for the nobios boot with an aware guest
> > image.  We use a similar convention for firing up SLOF itself.  But if
> > we're starting with a (simulated) OF entry condition, then as long as
> > we have a working client interface, we don't need an fdt blob anywhere
> > guest visible.
> >=20
> > > Now I realize that this GPR3 is QEMU<->SLOF convention (or some OFW
> > > binding - what is it exactly?) and Linux rather expects initramdisk
> > > start/size in GPR3/4 and this did not hit me just because GPR4 is alw=
ays
> > > 0 so Linux falls back to the device tree for initramdisk location.
> > >=20
> > >=20
> > >=20
> > >=20
> > > >=20
> > > > > +        spapr_do_client_claim(spapr, fdt_addr, fdt_totalsize(fdt=
), 0);
> > > > > +    }
> > > > >       spapr->cas_reboot =3D false;
> > > > >   }
> > > > > @@ -2897,12 +3040,12 @@ static void spapr_machine_init(MachineSta=
te *machine)
> > > > >           uint64_t lowaddr =3D 0;
> > > > >           spapr->kernel_size =3D load_elf(kernel_filename, NULL,
> > > > > -                                      translate_kernel_address, =
NULL,
> > > > > +                                      translate_kernel_address, =
spapr,
> > > > >                                         NULL, &lowaddr, NULL, 1,
> > > > >                                         PPC_ELF_MACHINE, 0, 0);
> > > > >           if (spapr->kernel_size =3D=3D ELF_LOAD_WRONG_ENDIAN) {
> > > > >               spapr->kernel_size =3D load_elf(kernel_filename, NU=
LL,
> > > > > -                                          translate_kernel_addre=
ss, NULL, NULL,
> > > > > +                                          translate_kernel_addre=
ss, spapr, NULL,
> > > > >                                             &lowaddr, NULL, 0, PP=
C_ELF_MACHINE,
> > > > >                                             0, 0);
> > > > >               spapr->kernel_le =3D spapr->kernel_size > 0;
> > > > > @@ -2918,7 +3061,7 @@ static void spapr_machine_init(MachineState=
 *machine)
> > > > >               /* Try to locate the initrd in the gap between the =
kernel
> > > > >                * and the firmware. Add a bit of space just in case
> > > > >                */
> > > > > -            spapr->initrd_base =3D (KERNEL_LOAD_ADDR + spapr->ke=
rnel_size
> > > > > +            spapr->initrd_base =3D (spapr->kernel_addr + spapr->=
kernel_size
> > > > >                                     + 0x1ffff) & ~0xffff;
> > > > >               spapr->initrd_size =3D load_image_targphys(initrd_f=
ilename,
> > > > >                                                        spapr->ini=
trd_base,
> > > > > @@ -2932,20 +3075,22 @@ static void spapr_machine_init(MachineSta=
te *machine)
> > > > >           }
> > > > >       }
> > > > > -    if (bios_name =3D=3D NULL) {
> > > > > -        bios_name =3D FW_FILE_NAME;
> > > > > +    if (spapr->bios_enabled) {
> > > > > +        if (bios_name =3D=3D NULL) {
> > > > > +            bios_name =3D FW_FILE_NAME;
> > > > > +        }
> > > > > +        filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_na=
me);
> > > > > +        if (!filename) {
> > > > > +            error_report("Could not find LPAR firmware '%s'", bi=
os_name);
> > > > > +            exit(1);
> > > > > +        }
> > > > > +        fw_size =3D load_image_targphys(filename, 0, FW_MAX_SIZE=
);
> > > > > +        if (fw_size <=3D 0) {
> > > > > +            error_report("Could not load LPAR firmware '%s'", fi=
lename);
> > > > > +            exit(1);
> > > > > +        }
> > > > > +        g_free(filename);
> > > > >       }
> > > > > -    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> > > > > -    if (!filename) {
> > > > > -        error_report("Could not find LPAR firmware '%s'", bios_n=
ame);
> > > > > -        exit(1);
> > > > > -    }
> > > > > -    fw_size =3D load_image_targphys(filename, 0, FW_MAX_SIZE);
> > > > > -    if (fw_size <=3D 0) {
> > > > > -        error_report("Could not load LPAR firmware '%s'", filena=
me);
> > > > > -        exit(1);
> > > > > -    }
> > > > > -    g_free(filename);
> > > > >       /* FIXME: Should register things through the MachineState's=
 qdev
> > > > >        * interface, this is a legacy from the sPAPREnvironment st=
ructure
> > > > > @@ -3162,6 +3307,32 @@ static void spapr_set_vsmt(Object *obj, Vi=
sitor *v, const char *name,
> > > > >       visit_type_uint32(v, name, (uint32_t *)opaque, errp);
> > > > >   }
> > > > > +static void spapr_get_kernel_addr(Object *obj, Visitor *v, const=
 char *name,
> > > > > +                                  void *opaque, Error **errp)
> > > > > +{
> > > > > +    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
> > > > > +}
> > > > > +
> > > > > +static void spapr_set_kernel_addr(Object *obj, Visitor *v, const=
 char *name,
> > > > > +                                  void *opaque, Error **errp)
> > > > > +{
> > > > > +    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
> > > > > +}
> > > >=20
> > > > Might be clearer to split the adjustable kernel addr stuff out into=
 a
> > > > separate patch - in fact, didn't you have such a patch before?
> > >=20
> > >=20
> > > I did but it was not useful on its own and the whole "bios=3Doff" fea=
ture
> > > does not need to be "series" at this stage. Also having it separate
> > > (before or after "kill slof") means changing same lines in 2 patches =
of
> > > the same patchset which is never really good.
> >=20
> > Hm, ok.  What's the reason you require the changeable load location
> > for nobios?
>=20
>=20
> I do not require it. It is purely for debugging. You can basically set
> address to 0, run qemu with -s and do step debugging with debug symbols f=
rom
> vmlinux (well, keep switching endianness), otherwise you would need to
> calculate offset (0x400000 or whatever it is) for every breakpoint you se=
t.
> Once I passed the prom_init() debugging stage (which did not work because=
 I
> did not provide stack), I have not used it for last couple of days.
>=20
> So I could ditch it now but we could use it to reduce (small but still) m=
emory fragmentation by placing vmlinux at 0. Dunno.

Ok.

> > > > > +static bool spapr_get_bios_enabled(Object *obj, Error **errp)
> > > > > +{
> > > > > +    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> > > > > +
> > > > > +    return spapr->bios_enabled;
> > > > > +}
> > > > > +
> > > > > +static void spapr_set_bios_enabled(Object *obj, bool value, Erro=
r **errp)
> > > > > +{
> > > > > +    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> > > > > +
> > > > > +    spapr->bios_enabled =3D value;
> > > > > +}
> > > > > +
> > > > >   static char *spapr_get_ic_mode(Object *obj, Error **errp)
> > > > >   {
> > > > >       SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> > > > > @@ -3267,6 +3438,20 @@ static void spapr_instance_init(Object *ob=
j)
> > > > >       object_property_add_bool(obj, "vfio-no-msix-emulation",
> > > > >                                spapr_get_msix_emulation, NULL, NU=
LL);
> > > > > +    object_property_add(obj, "kernel-addr", "uint64", spapr_get_=
kernel_addr,
> > > > > +                        spapr_set_kernel_addr, NULL, &spapr->ker=
nel_addr,
> > > > > +                        &error_abort);
> > > > > +    object_property_set_description(obj, "kernel-addr",
> > > > > +                                    stringify(KERNEL_LOAD_ADDR)
> > > > > +                                    " for -kernel is the default=
",
> > > > > +                                    NULL);
> > > > > +    spapr->kernel_addr =3D KERNEL_LOAD_ADDR;
> > > > > +    object_property_add_bool(obj, "bios", spapr_get_bios_enabled,
> > > > > +                            spapr_set_bios_enabled, NULL);
> > > > > +    object_property_set_description(obj, "bios", "Conrols whethe=
r to load bios",
> > > > > +                                    NULL);
> > > > > +    spapr->bios_enabled =3D true;
> > > > > +
> > > > >       /* The machine class defines the default interrupt controll=
er mode */
> > > > >       spapr->irq =3D smc->irq;
> > > > >       object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
> > > > > diff --git a/hw/ppc/spapr_client.c b/hw/ppc/spapr_client.c
> > > > > new file mode 100644
> > > > > index 000000000000..a318eaae3c40
> > > > > --- /dev/null
> > > > > +++ b/hw/ppc/spapr_client.c
> > > > > @@ -0,0 +1,464 @@
> > > > > +#include "qemu/osdep.h"
> > > > > +#include "qemu-common.h"
> > > > > +#include "qapi/error.h"
> > > > > +#include "exec/memory.h"
> > > > > +#include "hw/ppc/spapr.h"
> > > > > +#include "hw/ppc/spapr_vio.h"
> > > > > +#include "trace.h"
> > > > > +
> > > > > +struct prom_args {
> > > >=20
> > > > StudlyCaps and typedef, please..
> > > >=20
> > > > > +        __be32 service;
> > > > > +        __be32 nargs;
> > > > > +        __be32 nret;
> > > > > +        __be32 args[10];
> > >=20
> > >=20
> > > btw we do not generally have __be32 (and x86 build fails), I am
> > > replacing these with uint32_t.
> >=20
> > Ok, good.
> >=20
> > > > > +};
> > > > > +
> > > > > +#define CLI_PH_MASK     0x0FFFFFFF
> > > > > +#define CLI_INST_PREFIX 0x20000000
> > > > > +
> > > > > +#define readstr(pa, buf) cpu_physical_memory_read((pa), (buf), s=
izeof(buf))
> > > >=20
> > > > I'd prefer "readbuf" or something, since this isn't actually looking
> > > > at any string structure.
> > > >=20
> > > > > +#define readuint32(pa) ({ \
> > > > > +    uint32_t __tmp__; \
> > > > > +    cpu_physical_memory_read((pa), &__tmp__, sizeof(__tmp__)); \
> > > > > +    be32_to_cpu(__tmp__); })
> > > >=20
> > > > You can simplify this with ldl_be_phys().  In fact, then you probab=
ly
> > > > don't need any wrapper at all.
> > >=20
> > > Ah right. There are too many of these, was quicker to type this :)
> > >=20
> > >=20
> > > > > +
> > > > > +static bool _cmpservice(const char *s, size_t len,
> > > > > +                        unsigned nargs, unsigned nret,
> > > > > +                        const char *s1, size_t len1,
> > > > > +                        unsigned nargscheck, unsigned nretcheck)
> > > > > +{
> > > > > +    if (strncmp(s, s1, MAX(len, len1))) {
> > > > > +        return false;
> > > > > +    }
> > > > > +    if (nargscheck =3D=3D 0 && nretcheck =3D=3D 0) {
> > > > > +        return true;
> > > > > +    }
> > > > > +    if (nargs !=3D nargscheck || nret !=3D nretcheck) {
> > > > > +        trace_spapr_client_error_param(s, nargscheck, nretcheck,=
 nargs, nret);
> > > > > +        return false;
> > > > > +    }
> > > > > +
> > > > > +    return true;
> > > > > +}
> > > > > +
> > > > > +static uint32_t client_finddevice(const void *fdt, uint32_t node=
addr)
> > > > > +{
> > > > > +    char node[256];
> > > > > +    int ret;
> > > > > +
> > > > > +    readstr(nodeaddr, node);
> > > > > +    ret =3D fdt_path_offset(fdt, node);
> > > > > +    if (ret >=3D 0) {
> > > > > +        ret =3D fdt_get_phandle(fdt, ret);
> > > > > +    }
> > > > > +
> > > > > +    return (uint32_t) ret;
> > > > > +}
> > > > > +
> > > > > +static uint32_t client_getprop(const void *fdt, uint32_t nodeph,=
 uint32_t pname,
> > > > > +            uint32_t valaddr, uint32_t vallen)
> > > > > +{
> > > > > +    char propname[64];
> > > > > +    uint32_t ret =3D 0;
> > > > > +    int proplen =3D 0;
> > > > > +    const void *prop;
> > > > > +
> > > > > +    readstr(pname, propname);
> > > > > +
> > > > > +    prop =3D fdt_getprop_namelen(fdt, fdt_node_offset_by_phandle=
(fdt, nodeph),
> > > > > +                               propname, strlen(propname), &prop=
len);
> > > >=20
> > > > You can just use fdt_getprop().  By definition it's equivalent to
> > > > fdt_getprop_namelen(.., propname, strlen(propname), ...)
> > > >=20
> > > > > +    if (prop) {
> > > > > +        int cb =3D MIN(proplen, vallen);
> > > > > +
> > > > > +        cpu_physical_memory_write(valaddr, prop, cb);
> > > > > +        ret =3D cb;
> > > > > +    } else if (strncmp(propname, "stdout", 6) =3D=3D 0 && vallen=
 =3D=3D sizeof(ret)) {
> > > > > +        ret =3D cpu_to_be32(1);
> > > > > +        cpu_physical_memory_write(valaddr, &ret, MIN(vallen, siz=
eof(ret)));
> > > >=20
> > > > I'm guessing the special casing of stdout is to fake the OF instanc=
ing
> > > > stuff, which I don't really understand.  Some comments to explain
> > > > what's going on here would be good.
> > >=20
> > >=20
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/arch/powerpc/kernel/prom_init.c#n2219
> > >=20
> > > This thing wants ihandle which is stored as /chosen/stdout and which =
we
> > > do not have as there are no instances.
> > >=20
> > > If this property is not there, prom_panic() happens.
> > >=20
> > > I could implement some primitive intances, I'll look into this.
> >=20
> > Ok, that's roughly as I guessed.  This seems like a reasonable way of
> > handling this for now without having to implement a notion of
> > instances - but it would be good to have some comment saying what's
> > going on here.
> >=20
> > We might need to implement at least basic awareness of instances
> > if/when we need to be a bit more flexible about what input/output
> > devices we use for the console.
> >=20
> > > > > +    } else {
> > > > > +        ret =3D -1;
> > > > > +    }
> > > > > +    trace_spapr_client_getprop(nodeph, propname, ret);
> > > > > +
> > > > > +    return ret;
> > > > > +}
> > > > > +
> > > > > +static uint32_t client_setprop(SpaprMachineState *sm,
> > > > > +                               uint32_t nodeph, uint32_t pname,
> > > > > +                               uint32_t valaddr, uint32_t vallen)
> > > > > +{
> > > > > +    char propname[64];
> > > > > +    uint32_t ret =3D -1;
> > > > > +    int proplen =3D 0;
> > > > > +    const void *prop;
> > > > > +
> > > > > +    readstr(pname, propname);
> > > > > +    if (vallen =3D=3D sizeof(uint32_t) &&
> > > > > +        ((strncmp(propname, "linux,rtas-base", 15) =3D=3D 0) ||
> > > > > +         (strncmp(propname, "linux,rtas-entry", 16) =3D=3D 0))) {
> > > > > +
> > > > > +        sm->rtas_base =3D readuint32(valaddr);
> > > > > +        prop =3D fdt_getprop_namelen(sm->fdt_blob,
> > > > > +                                   fdt_node_offset_by_phandle(sm=
->fdt_blob,
> > > > > +                                                              no=
deph),
> > > > > +                                   propname, strlen(propname), &=
proplen);
> > > > > +        if (proplen =3D=3D vallen) {
> > > > > +            *(uint32_t *) prop =3D cpu_to_be32(sm->rtas_base);
> > > > > +            ret =3D proplen;
> > > > > +        }
> > > >=20
> > > > Is there a particular reason to restrict this to the rtas propertie=
s,
> > > > rather than just allowing the guest to fdt_setprop() something
> > > > arbitrary?
> > >=20
> > > The FDT is flatten and I am not quite sure if libfdt can handle updat=
ing
> > > properties if the length has changed.
> >=20
> > fdt_setprop() will handle updating properties with changed length (in
> > fact there's a special fdt_setprop_inplace() optimized for the case
> > where you don't need that).  It's not particularly efficient, but it
> > should work fine for the cases we have here.  In fact, I think you're
> > already relying on this for the code that adds the phandles to
> > everything.
>=20
> Well, I used to add phandles before calling fdt_pack() so it is not exact=
ly the same.

Ah, right, that's why adding the phandles worked.

> > One complication is that it can return FDT_ERR_NOSPACE if there isn't
> > enough buffer for the increased thing.  We could either trap that,
> > resize and retry, or we could leave a bunch of extra space.  The
> > latter would be basically equivalent to not doing fdt_pack() on the
> > blob in the nobios case.
>=20
>=20
> This is what I ended up doing.
>=20
>=20
> > > Also, more importantly, potentially property changes like this may ha=
ve
> > > to be reflected in the QEMU device tree so I allowed only the propert=
ies
> > > which I know how to deal with.
> >=20
> > That's a reasonable concern, but the nice thing about not having SLOF
> > is that there's only one copy of the device tree - the blob in qemu.
> > So a setprop() on that is automatically a setprop() everywhere (this
> > is another reason not to write the fdt into guest memory in the nobios
> > case - it will become stale as soon as the client changes anything).
>=20
>=20
> True to a degree. It is "setprop" to the current fdt blob which we do not
> analyze after we build the fdt. We either need to do parse the tree before
> we rebuild it as CAS so we do not lose the updates or do selective changes
> to the QEMUs objects from the "setprop" handler (this is what I do
> now).

Hrm.. do those setprops happen before CAS?  I would have thought we'd
call CAS before instantiating RTAS.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8zu1PYoF5C4kwccn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4UFmoACgkQbDjKyiDZ
s5JUYRAAsx9Foo7fX1017IzyqFo/YmpHub0/BI1z5WqO7L+W/GaFUdSNujFElDpK
nTyDSGz7ua7PK+dHllbPjqH6+5bRwfk1RFRo35N3Yz/qwe5EGDnhIgyme0u/a+8e
2d6bysOqHlZSMzygD0+O3xO9BGQUied4lX7CcecBv9nJcGDY9C5rAZvuPfhvTGQ1
RZcel9ZmvRmHhHqVCYrmX9q2Mb9wjJWyEgi/XCKDfnk1HqaDzazU/1JjQPOIevoa
0lFviBGo9WxmhLSYKSbAZ60TSlUkKd7uY3peRCQiZ2lb6TGRsANOL8jrFsAkOcjg
20ovAwNHxvvpNGtXBPiNOyPNIAZgcziTx5fWHLLpd02q3bhEKoDkpfAK56v5xphT
YNUxHJlov6UUqes/SzE5P7AHvbtzdKDCipqaYyp2l3P6YmXyzJ9WSzEC8YlolllD
xLQ4unQAmdoPo6hERrFkmBmG5PxVSIiASGRqpqMbDBv8/zpVdX492SQVQwzzKhjp
Qhj0ZxbOnkE8WUCkcjiQF0tRJW3VLQKWeORZHhx0wmGiNesAzfNWaVt4CVMjflR7
P3mj/x6EZzkIv8Ukt797VIxmuEWCIUbscb+Ivz4kYLOh8O7JcY+X42w5aPXWex2+
oxyu8HYRdgoRZLfZEgadRxY5RQeBBSmCuPkD3ygoAzyAjCyX1+0=
=7AyQ
-----END PGP SIGNATURE-----

--8zu1PYoF5C4kwccn--

