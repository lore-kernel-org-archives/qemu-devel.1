Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ECEC32767
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 04:21:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A500421734
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 04:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aEm5azPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A500421734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioJt6-0006qf-Qy
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 23:21:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ioJsH-0006Fy-Go
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 23:20:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ioJsC-0007Bv-8P
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 23:20:17 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:33401 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ioJsA-00073q-EJ; Sun, 05 Jan 2020 23:20:12 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47rj361Jpxz9sPJ; Mon,  6 Jan 2020 15:20:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578284402;
 bh=5/ztkZBhJm/Ofa6GxEa/gfnO4tniKhStdJZcYba51WU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aEm5azPmaxfDKIko+hsHOHTTSuRGcTNTLSmN3FZ6QOIkGGkTxweOZwcayM4GyS5eY
 FaIcbslaqxH4HgUMzhWScNuumF7HfyvOlYEkLZLLAiXmr9og1h5CNyd1JQMiG2eudw
 7UirGt4JlTMLpECGm6S6stfrjiY1Nd3UWLGgdqTg=
Date: Mon, 6 Jan 2020 15:19:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu v2] spapr: Kill SLOF
Message-ID: <20200106041940.GV2098@umbus>
References: <20200105234242.78897-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aBaYPhOdNx+t7mr3"
Content-Disposition: inline
In-Reply-To: <20200105234242.78897-1-aik@ozlabs.ru>
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


--aBaYPhOdNx+t7mr3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2020 at 10:42:42AM +1100, Alexey Kardashevskiy wrote:
> The Petitboot bootloader is way more advanced than SLOF is ever going to
> be as Petitboot comes with the full-featured Linux kernel with all
> the drivers, and initramdisk with quite user friendly interface.
> The problem with ditching SLOF is that an unmodified pseries kernel can
> either start via:
> 1. kexec, this requires presence of RTAS and skips
> ibm,client-architecture-support entirely;
> 2. normal boot, this heavily relies on the OF1275 client interface to
> fetch the device tree and do early setup (claim memory).
>=20
> This adds a new bios-less mode to the pseries machine: "bios=3Don|off".
> When enabled, QEMU does not load SLOF and jumps to the kernel from
> "-kernel".
>=20
> The client interface is implemented exactly as RTAS - a 20 bytes blob,
> right next after the RTAS blob. The entry point is passed to the kernel
> via GPR5.
>=20
> This implements a handful of client interface methods just to get going.
> In particular, this implements the device tree fetching,
> ibm,client-architecture-support and instantiate-rtas.
>=20
> This implements changing FDT properties only for "linux,rtas-base" and
> "linux,rtas-entry", just to get early boot going.
>=20
> This assigns "phandles" to device tree nodes as there is no more SLOF
> and OF nodes addresses of which served as phandle values.
> This keeps predefined nodes (such as XICS/NVLINK/...) unchanged.
> phandles are regenerated at every FDT rebuild.
>=20
> When bios=3Doff, this adds "/chosen" every time QEMU builds a tree.
>=20
> This implements "claim" which the client (Linux) uses for memory
> allocation; this is also  used by QEMU for claiming kernel/initrd images,
> client interface entry point, RTAS and the initial stack.
>=20
> While at this, add a "kernel-addr" machine parameter to allow moving
> the kernel in memory. This is useful for debugging if the kernel is
> loaded at @0, although not necessary.
>=20
> This does not implement instances properly but in order to boot a VM,
> we only really need a stdout instance and the "/" instance for
> "call-method", we fake these.

As we've discussed, I really like the idea of this.  It think the
basic approach looks good too.

As you probably realize, there are quite a lot of things to be
polished though.  Comments below.

>=20
> The test command line:
>=20
> qemu-system-ppc64 \
> -nodefaults \
> -chardev stdio,id=3DSTDIO0,signal=3Doff,mux=3Don \
> -device spapr-vty,id=3Dsvty0,reg=3D0x71000110,chardev=3DSTDIO0 \
> -mon id=3DMON0,chardev=3DSTDIO0,mode=3Dreadline \
> -nographic \
> -vga none \
> -kernel vmldbg \
> -machine pseries,bios=3Doff \
> -m 4G \
> -enable-kvm \
> -initrd pb/rootfs.cpio.xz \
> img/u1804-64le.qcow2 \
> -snapshot \
> -smp 8,threads=3D8 \
> -L /home/aik/t/qemu-ppc64-bios/ \
> -trace events=3Dqemu_trace_events \
> -d guest_errors \
> -chardev socket,id=3DSOCKET0,server,nowait,path=3Dqemu.mon.ssh37874 \
> -mon chardev=3DSOCKET0,mode=3Dcontrol
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v2:
> * fixed claim()
> * added "setprop"
> * cleaner client interface and RTAS blobs management
> * boots to petitboot and further to the target system
> * more trace points
> ---
>  hw/ppc/Makefile.objs   |   1 +
>  include/hw/loader.h    |   1 +
>  include/hw/ppc/spapr.h |  25 ++-
>  hw/ppc/spapr.c         | 231 ++++++++++++++++++--
>  hw/ppc/spapr_client.c  | 464 +++++++++++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_hcall.c   |  49 +++--
>  hw/ppc/trace-events    |   9 +
>  7 files changed, 743 insertions(+), 37 deletions(-)
>  create mode 100644 hw/ppc/spapr_client.c
>=20
> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> index 101e9fc59185..ce31c0acd2fb 100644
> --- a/hw/ppc/Makefile.objs
> +++ b/hw/ppc/Makefile.objs
> @@ -6,6 +6,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o sp=
apr_rtas.o
>  obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o
>  obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o spapr_irq.o
>  obj-$(CONFIG_PSERIES) +=3D spapr_tpm_proxy.o
> +obj-$(CONFIG_PSERIES) +=3D spapr_client.o

This applies in a bunch of places here.  Just calling things "client"
is clear enough if you're already thinking about Open Firmware.  But
this appears in a bunch of places where you might come across it
without that context, in which case it could be kind of confusing.  So
I'd suggest using "of_client" or "of_client_interface" in most places
you're using "client".

>  obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
>  # IBM PowerNV
>  obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_ps=
i.o pnv_occ.o pnv_bmc.o
> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index 48a96cd55904..a2f58077a47e 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -262,6 +262,7 @@ MemoryRegion *rom_add_blob(const char *name, const vo=
id *blob, size_t len,
>  int rom_add_elf_program(const char *name, GMappedFile *mapped_file, void=
 *data,
>                          size_t datasize, size_t romsize, hwaddr addr,
>                          AddressSpace *as);
> +bool rom_intersect(uint64_t start, uint64_t size);

I don't see this called, so I'm guessing it's a stray chunk leftover.

>  int rom_check_and_register_reset(void);
>  void rom_set_fw(FWCfgState *f);
>  void rom_set_order_override(int order);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 61f005c6f686..876879d12029 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -105,6 +105,11 @@ struct SpaprCapabilities {
>      uint8_t caps[SPAPR_CAP_NUM];
>  };
> =20
> +typedef struct {
> +    uint64_t start;
> +    uint64_t size;
> +} spapr_of_claimed;

Please use the qemu convention of StudlyCaps for types.

>  /**
>   * SpaprMachineClass:
>   */
> @@ -158,8 +163,13 @@ struct SpaprMachineState {
>      uint32_t fdt_size;
>      uint32_t fdt_initial_size;
>      void *fdt_blob;
> +    uint32_t rtas_base;
>      long kernel_size;
>      bool kernel_le;
> +    uint64_t kernel_addr;

This would intersect with your other patch to allow changing the
kernel load address, yes?

> +    bool bios_enabled;
> +    GArray *claimed; /* array of spapr_of_claimed */
> +    uint64_t claimed_base;

I'd suggest moving all the client interface related fields to a
visually separated chunk in the structure definition.

>      uint32_t initrd_base;
>      long initrd_size;
>      uint64_t rtc_offset; /* Now used only during incoming migration */
> @@ -510,7 +520,8 @@ struct SpaprMachineState {
>  /* Client Architecture support */
>  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
>  #define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
> -#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
> +#define KVMPPC_H_CLIENT         (KVMPPC_HCALL_BASE + 0x5)
> +#define KVMPPC_HCALL_MAX        KVMPPC_H_CLIENT
> =20
>  /*
>   * The hcall range 0xEF00 to 0xEF80 is reserved for use in facilitating
> @@ -538,6 +549,12 @@ void spapr_register_hypercall(target_ulong opcode, s=
papr_hcall_fn fn);
>  target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
>                               target_ulong *args);
> =20
> +target_ulong do_client_architecture_support(PowerPCCPU *cpu,
> +                                            SpaprMachineState *spapr,
> +                                            target_ulong addr,
> +                                            target_ulong fdt_buf,
> +                                            target_ulong fdt_bufsize);
> +
>  /* Virtual Processor Area structure constants */
>  #define VPA_MIN_SIZE           640
>  #define VPA_SIZE_OFFSET        0x4
> @@ -769,6 +786,9 @@ struct SpaprEventLogEntry {
>  void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space=
);
>  void spapr_events_init(SpaprMachineState *sm);
>  void spapr_dt_events(SpaprMachineState *sm, void *fdt);
> +uint64_t spapr_do_client_claim(SpaprMachineState *sm, uint64_t virt,
> +                               uint64_t size, uint64_t align);
> +int spapr_h_client(SpaprMachineState *sm, target_ulong client_args);
>  void close_htab_fd(SpaprMachineState *spapr);
>  void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr);
>  void spapr_free_hpt(SpaprMachineState *spapr);
> @@ -891,4 +911,7 @@ void spapr_check_pagesize(SpaprMachineState *spapr, h=
waddr pagesize,
>  #define SPAPR_OV5_XIVE_BOTH     0x80 /* Only to advertise on the platfor=
m */
> =20
>  void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
> +
> +void spapr_instantiate_rtas(SpaprMachineState *spapr, uint32_t base);
> +
>  #endif /* HW_SPAPR_H */
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e62c89b3dd40..1c97534a0aea 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -896,6 +896,51 @@ out:
>      return ret;
>  }
> =20
> +/*
> + * Below is a compiled version of RTAS blob and OF client interface entr=
y point.
> + *
> + * gcc -nostdlib  -mbig -o spapr-rtas.img spapr-rtas.S
> + * objcopy  -O binary -j .text  spapr-rtas.img spapr-rtas.bin
> + *
> + *   .globl  _start
> + *   _start:
> + *           mr      4,3
> + *           lis     3,KVMPPC_H_RTAS@h
> + *           ori     3,3,KVMPPC_H_RTAS@l
> + *           sc      1
> + *           blr
> + *           mr      4,3
> + *           lis     3,KVMPPC_H_CLIENT@h
> + *           ori     3,3,KVMPPC_H_CLIENT@l
> + *           sc      1
> + *           blr
> + */
> +static struct {
> +    uint8_t rtas[20], client[20];
> +} QEMU_PACKED rtas_client_blob =3D {
> +    .rtas =3D {
> +        0x7c, 0x64, 0x1b, 0x78,
> +        0x3c, 0x60, 0x00, 0x00,
> +        0x60, 0x63, 0xf0, 0x00,
> +        0x44, 0x00, 0x00, 0x22,
> +        0x4e, 0x80, 0x00, 0x20
> +    },
> +    .client =3D {
> +        0x7c, 0x64, 0x1b, 0x78,
> +        0x3c, 0x60, 0x00, 0x00,
> +        0x60, 0x63, 0xf0, 0x05,
> +        0x44, 0x00, 0x00, 0x22,
> +        0x4e, 0x80, 0x00, 0x20
> +    }
> +};

I'd really prefer to read this in from a file (or files) which we
assemble (as with the existing spapr-rtas.img), rather than having a
magic array in qemu.

> +
> +void spapr_instantiate_rtas(SpaprMachineState *spapr, uint32_t base)
> +{
> +    spapr->rtas_base =3D base;
> +    cpu_physical_memory_write(base, rtas_client_blob.rtas,
> +                              sizeof(rtas_client_blob.rtas));
> +}
> +
>  static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>  {
>      MachineState *ms =3D MACHINE(spapr);
> @@ -980,6 +1025,13 @@ static void spapr_dt_rtas(SpaprMachineState *spapr,=
 void *fdt)
>      _FDT(fdt_setprop(fdt, rtas, "ibm,lrdr-capacity",
>                       lrdr_capacity, sizeof(lrdr_capacity)));
> =20
> +    _FDT(fdt_setprop_cell(fdt, rtas, "linux,rtas-base", spapr->rtas_base=
));
> +    _FDT(fdt_setprop_cell(fdt, rtas, "linux,rtas-entry", spapr->rtas_bas=
e));

IIUC, we shouldn't need to add these in bios=3Doff mode, yes?  Instead
the client must instantiate-rtas before attempting to use it.

> +    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size",
> +                          sizeof(rtas_client_blob.rtas)));
> +    _FDT(fdt_add_mem_rsv(fdt, spapr->rtas_base,
> +                         sizeof(rtas_client_blob.rtas)));

Nor should we need the mem_rsv with bios=3Doff.

> +
>      spapr_dt_rtas_tokens(fdt, rtas);
>  }
> =20
> @@ -1057,7 +1109,7 @@ static void spapr_dt_chosen(SpaprMachineState *spap=
r, void *fdt)
>      }
> =20
>      if (spapr->kernel_size) {
> -        uint64_t kprop[2] =3D { cpu_to_be64(KERNEL_LOAD_ADDR),
> +        uint64_t kprop[2] =3D { cpu_to_be64(spapr->kernel_addr),
>                                cpu_to_be64(spapr->kernel_size) };
> =20
>          _FDT(fdt_setprop(fdt, chosen, "qemu,boot-kernel",
> @@ -1104,6 +1156,9 @@ static void spapr_dt_chosen(SpaprMachineState *spap=
r, void *fdt)
>          _FDT(fdt_setprop_cell(fdt, chosen, "linux,pci-probe-only", 0));
>      }
> =20
> +    if (!spapr->bios_enabled) {
> +        _FDT(fdt_setprop_cell(fdt, chosen, "cpu", 0));

What is this for?

> +    }
>      spapr_dt_ov5_platform_support(spapr, fdt, chosen);
> =20
>      g_free(stdout_path);
> @@ -1133,6 +1188,28 @@ static void spapr_dt_hypervisor(SpaprMachineState =
*spapr, void *fdt)
>      }
>  }
> =20
> +static void spapr_fdt_add_phandles(void *fdt, int parent, uint32_t *phan=
dle)
> +{
> +    int proplen =3D 0, node;
> +    const void *prop;
> +    char tmp[256] =3D "BAAD";
> +
> +    fdt_get_path(fdt, parent, tmp, sizeof(tmp));

You don't actually appear to use tmp.  Is this a debugging leftover?

> +    prop =3D fdt_getprop_namelen(fdt, parent, "phandle", 7, &proplen);
> +    if (!prop) {
> +        _FDT(fdt_setprop_cell(fdt, parent, "phandle", *phandle));
> +        while (1) {
> +            ++*phandle;
> +            if (fdt_node_offset_by_phandle(fdt, *phandle) < 0) {
> +                break;
> +            }
> +        }
> +    }
> +    fdt_for_each_subnode(node, fdt, parent) {
> +        spapr_fdt_add_phandles(fdt, node, phandle);
> +    }

Oof, this is pretty inefficient, since fdt_node_offset_by_phandle()
will have to scan the whole tree, and you do it on every node.

Obviously, a "live" tree structure rather than fdt would be better
suited for this.  I'd like to move to that at some point, but it will
be a while before we're ready.

I guess this is fine for a PoC, but I think we can do a bit better
without too much extra complexity:
  * Rather than scanning for an existing node with the handle on each
    iteration, you can use fdt_find_max_phandle() once beforehand,
    and start your counter from there, being assured that it won't hit
    any existing phandles

  * The phandles are arbitrary, so you don't actually care about the
    tree structure here.  So instead of recursively descending the
    tree, you can just alter each node in the order they appear in the
    blob.  fdt_next_node() will let you do that, simply by ignoring
    the 'depth' parameter.  [In fact the structure ensures that will
    be a depth first traversal of the tree, just like you have here,
    not that it matters].

  * You should check for overflows of your phandle counter, though
    it's fine to treat that as a fatal error.

> +}
> +
>  void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
>  {
>      MachineState *machine =3D MACHINE(spapr);
> @@ -1245,7 +1322,8 @@ void *spapr_build_fdt(SpaprMachineState *spapr, boo=
l reset, size_t space)
>      /* Build memory reserve map */
>      if (reset) {
>          if (spapr->kernel_size) {
> -            _FDT((fdt_add_mem_rsv(fdt, KERNEL_LOAD_ADDR, spapr->kernel_s=
ize)));
> +            _FDT((fdt_add_mem_rsv(fdt, spapr->kernel_addr,
> +                                  spapr->kernel_size)));
>          }
>          if (spapr->initrd_size) {
>              _FDT((fdt_add_mem_rsv(fdt, spapr->initrd_base,
> @@ -1268,12 +1346,19 @@ void *spapr_build_fdt(SpaprMachineState *spapr, b=
ool reset, size_t space)
>          }
>      }
> =20
> +    if (!spapr->bios_enabled) {
> +        uint32_t phandle =3D 1;
> +
> +        spapr_fdt_add_phandles(fdt, fdt_path_offset(fdt, "/"), &phandle);
> +    }
> +
>      return fdt;
>  }
> =20
>  static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
>  {
> -    return (addr & 0x0fffffff) + KERNEL_LOAD_ADDR;
> +    SpaprMachineState *spapr =3D opaque;
> +    return (addr & 0x0fffffff) + spapr->kernel_addr;
>  }
> =20
>  static void emulate_spapr_hypercall(PPCVirtualHypervisor *vhyp,
> @@ -1660,6 +1745,60 @@ static void spapr_machine_reset(MachineState *mach=
ine)
>       */
>      fdt_addr =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FDT_MAX_SIZE;
> =20
> +    /* Set up the entry state */
> +    if (!spapr->bios_enabled) {
> +        if (spapr->claimed) {
> +            g_array_unref(spapr->claimed);
> +        }
> +        spapr->claimed =3D g_array_new(false, false, sizeof(spapr_of_cla=
imed));
> +        spapr->claimed_base =3D 0x10000; /* Avoid using the first system=
 page */
> +
> +        spapr_cpu_set_entry_state(first_ppc_cpu, spapr->kernel_addr, fdt=
_addr);
> +
> +        if (spapr_do_client_claim(spapr, spapr->kernel_addr,
> +                                  spapr->kernel_size, 0) =3D=3D -1) {
> +            error_report("Memory for kernel is in use");
> +            exit(1);
> +        }
> +        if (spapr_do_client_claim(spapr, spapr->initrd_base,
> +                                  spapr->initrd_size, 0) =3D=3D -1) {
> +            error_report("Memory for initramdisk is in use");
> +            exit(1);
> +        }
> +        first_ppc_cpu->env.gpr[1] =3D spapr_do_client_claim(spapr, 0, 0x=
40000,
> +                                                          0x10000);
> +        if (first_ppc_cpu->env.gpr[1] =3D=3D -1) {
> +            error_report("Memory for stack is in use");
> +            exit(1);
> +        }
> +
> +        first_ppc_cpu->env.gpr[5] =3D
> +            spapr_do_client_claim(spapr, 0, sizeof(rtas_client_blob.clie=
nt),
> +                                  sizeof(rtas_client_blob.client));
> +        if (first_ppc_cpu->env.gpr[5] =3D=3D -1) {
> +            error_report("Memory for OF client is in use");
> +            exit(1);
> +        }
> +        cpu_physical_memory_write(first_ppc_cpu->env.gpr[5],
> +                                  rtas_client_blob.client,
> +                                  sizeof(rtas_client_blob.client));
> +
> +        /* Allocate space for RTAS here so spapr_build_fdt() below picks=
 it */
> +        spapr->rtas_base =3D
> +            spapr_do_client_claim(spapr, 0, sizeof(rtas_client_blob.rtas=
),
> +                                  0x100);
> +        if (spapr->rtas_base =3D=3D -1) {
> +            error_report("Memory for RTAS is in use");
> +            exit(1);
> +        }
> +        cpu_physical_memory_write(spapr->rtas_base,
> +                                  rtas_client_blob.rtas,
> +                                  sizeof(rtas_client_blob.rtas));

The above is complex enough it might be worth having bios and nobios
variants of spapr_cpu_set_entry_state().

> +    } else {
> +        spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_=
addr);
> +        first_ppc_cpu->env.gpr[5] =3D 0; /* 0 =3D kexec !0 =3D prom_init=
 */
> +    }
> +
>      fdt =3D spapr_build_fdt(spapr, true, FDT_MAX_SIZE);
> =20
>      rc =3D fdt_pack(fdt);
> @@ -1675,10 +1814,14 @@ static void spapr_machine_reset(MachineState *mac=
hine)
>      spapr->fdt_initial_size =3D spapr->fdt_size;
>      spapr->fdt_blob =3D fdt;
> =20
> -    /* Set up the entry state */
> -    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr=
);
> -    first_ppc_cpu->env.gpr[5] =3D 0;
> -
> +    if (!spapr->bios_enabled) {
> +        /*
> +         * Claim FDT space so initramdisk/zImage are not unpacked over i=
t.
> +         * In practice Linux claim additional memory for FDT and fetches=
 it
> +         * using client interface's "getprop" call.
> +         */

IIUC, it shouldn't actually be necessary to put the fdt into guest
memory in nobios mode - it will be retrieved piecemeal via the client
interface instead, won't it?

> +        spapr_do_client_claim(spapr, fdt_addr, fdt_totalsize(fdt), 0);
> +    }
>      spapr->cas_reboot =3D false;
>  }
> =20
> @@ -2897,12 +3040,12 @@ static void spapr_machine_init(MachineState *mach=
ine)
>          uint64_t lowaddr =3D 0;
> =20
>          spapr->kernel_size =3D load_elf(kernel_filename, NULL,
> -                                      translate_kernel_address, NULL,
> +                                      translate_kernel_address, spapr,
>                                        NULL, &lowaddr, NULL, 1,
>                                        PPC_ELF_MACHINE, 0, 0);
>          if (spapr->kernel_size =3D=3D ELF_LOAD_WRONG_ENDIAN) {
>              spapr->kernel_size =3D load_elf(kernel_filename, NULL,
> -                                          translate_kernel_address, NULL=
, NULL,
> +                                          translate_kernel_address, spap=
r, NULL,
>                                            &lowaddr, NULL, 0, PPC_ELF_MAC=
HINE,
>                                            0, 0);
>              spapr->kernel_le =3D spapr->kernel_size > 0;
> @@ -2918,7 +3061,7 @@ static void spapr_machine_init(MachineState *machin=
e)
>              /* Try to locate the initrd in the gap between the kernel
>               * and the firmware. Add a bit of space just in case
>               */
> -            spapr->initrd_base =3D (KERNEL_LOAD_ADDR + spapr->kernel_size
> +            spapr->initrd_base =3D (spapr->kernel_addr + spapr->kernel_s=
ize
>                                    + 0x1ffff) & ~0xffff;
>              spapr->initrd_size =3D load_image_targphys(initrd_filename,
>                                                       spapr->initrd_base,
> @@ -2932,20 +3075,22 @@ static void spapr_machine_init(MachineState *mach=
ine)
>          }
>      }
> =20
> -    if (bios_name =3D=3D NULL) {
> -        bios_name =3D FW_FILE_NAME;
> +    if (spapr->bios_enabled) {
> +        if (bios_name =3D=3D NULL) {
> +            bios_name =3D FW_FILE_NAME;
> +        }
> +        filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> +        if (!filename) {
> +            error_report("Could not find LPAR firmware '%s'", bios_name);
> +            exit(1);
> +        }
> +        fw_size =3D load_image_targphys(filename, 0, FW_MAX_SIZE);
> +        if (fw_size <=3D 0) {
> +            error_report("Could not load LPAR firmware '%s'", filename);
> +            exit(1);
> +        }
> +        g_free(filename);
>      }
> -    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> -    if (!filename) {
> -        error_report("Could not find LPAR firmware '%s'", bios_name);
> -        exit(1);
> -    }
> -    fw_size =3D load_image_targphys(filename, 0, FW_MAX_SIZE);
> -    if (fw_size <=3D 0) {
> -        error_report("Could not load LPAR firmware '%s'", filename);
> -        exit(1);
> -    }
> -    g_free(filename);
> =20
>      /* FIXME: Should register things through the MachineState's qdev
>       * interface, this is a legacy from the sPAPREnvironment structure
> @@ -3162,6 +3307,32 @@ static void spapr_set_vsmt(Object *obj, Visitor *v=
, const char *name,
>      visit_type_uint32(v, name, (uint32_t *)opaque, errp);
>  }
> =20
> +static void spapr_get_kernel_addr(Object *obj, Visitor *v, const char *n=
ame,
> +                                  void *opaque, Error **errp)
> +{
> +    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
> +}
> +
> +static void spapr_set_kernel_addr(Object *obj, Visitor *v, const char *n=
ame,
> +                                  void *opaque, Error **errp)
> +{
> +    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
> +}

Might be clearer to split the adjustable kernel addr stuff out into a
separate patch - in fact, didn't you have such a patch before?

> +static bool spapr_get_bios_enabled(Object *obj, Error **errp)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> +
> +    return spapr->bios_enabled;
> +}
> +
> +static void spapr_set_bios_enabled(Object *obj, bool value, Error **errp)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> +
> +    spapr->bios_enabled =3D value;
> +}
> +
>  static char *spapr_get_ic_mode(Object *obj, Error **errp)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> @@ -3267,6 +3438,20 @@ static void spapr_instance_init(Object *obj)
>      object_property_add_bool(obj, "vfio-no-msix-emulation",
>                               spapr_get_msix_emulation, NULL, NULL);
> =20
> +    object_property_add(obj, "kernel-addr", "uint64", spapr_get_kernel_a=
ddr,
> +                        spapr_set_kernel_addr, NULL, &spapr->kernel_addr,
> +                        &error_abort);
> +    object_property_set_description(obj, "kernel-addr",
> +                                    stringify(KERNEL_LOAD_ADDR)
> +                                    " for -kernel is the default",
> +                                    NULL);
> +    spapr->kernel_addr =3D KERNEL_LOAD_ADDR;
> +    object_property_add_bool(obj, "bios", spapr_get_bios_enabled,
> +                            spapr_set_bios_enabled, NULL);
> +    object_property_set_description(obj, "bios", "Conrols whether to loa=
d bios",
> +                                    NULL);
> +    spapr->bios_enabled =3D true;
> +
>      /* The machine class defines the default interrupt controller mode */
>      spapr->irq =3D smc->irq;
>      object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
> diff --git a/hw/ppc/spapr_client.c b/hw/ppc/spapr_client.c
> new file mode 100644
> index 000000000000..a318eaae3c40
> --- /dev/null
> +++ b/hw/ppc/spapr_client.c
> @@ -0,0 +1,464 @@
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "qapi/error.h"
> +#include "exec/memory.h"
> +#include "hw/ppc/spapr.h"
> +#include "hw/ppc/spapr_vio.h"
> +#include "trace.h"
> +
> +struct prom_args {

StudlyCaps and typedef, please..

> +        __be32 service;
> +        __be32 nargs;
> +        __be32 nret;
> +        __be32 args[10];
> +};
> +
> +#define CLI_PH_MASK     0x0FFFFFFF
> +#define CLI_INST_PREFIX 0x20000000
> +
> +#define readstr(pa, buf) cpu_physical_memory_read((pa), (buf), sizeof(bu=
f))

I'd prefer "readbuf" or something, since this isn't actually looking
at any string structure.

> +#define readuint32(pa) ({ \
> +    uint32_t __tmp__; \
> +    cpu_physical_memory_read((pa), &__tmp__, sizeof(__tmp__)); \
> +    be32_to_cpu(__tmp__); })

You can simplify this with ldl_be_phys().  In fact, then you probably
don't need any wrapper at all.

> +
> +static bool _cmpservice(const char *s, size_t len,
> +                        unsigned nargs, unsigned nret,
> +                        const char *s1, size_t len1,
> +                        unsigned nargscheck, unsigned nretcheck)
> +{
> +    if (strncmp(s, s1, MAX(len, len1))) {
> +        return false;
> +    }
> +    if (nargscheck =3D=3D 0 && nretcheck =3D=3D 0) {
> +        return true;
> +    }
> +    if (nargs !=3D nargscheck || nret !=3D nretcheck) {
> +        trace_spapr_client_error_param(s, nargscheck, nretcheck, nargs, =
nret);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static uint32_t client_finddevice(const void *fdt, uint32_t nodeaddr)
> +{
> +    char node[256];
> +    int ret;
> +
> +    readstr(nodeaddr, node);
> +    ret =3D fdt_path_offset(fdt, node);
> +    if (ret >=3D 0) {
> +        ret =3D fdt_get_phandle(fdt, ret);
> +    }
> +
> +    return (uint32_t) ret;
> +}
> +
> +static uint32_t client_getprop(const void *fdt, uint32_t nodeph, uint32_=
t pname,
> +            uint32_t valaddr, uint32_t vallen)
> +{
> +    char propname[64];
> +    uint32_t ret =3D 0;
> +    int proplen =3D 0;
> +    const void *prop;
> +
> +    readstr(pname, propname);
> +
> +    prop =3D fdt_getprop_namelen(fdt, fdt_node_offset_by_phandle(fdt, no=
deph),
> +                               propname, strlen(propname), &proplen);

You can just use fdt_getprop().  By definition it's equivalent to
fdt_getprop_namelen(.., propname, strlen(propname), ...)

> +    if (prop) {
> +        int cb =3D MIN(proplen, vallen);
> +
> +        cpu_physical_memory_write(valaddr, prop, cb);
> +        ret =3D cb;
> +    } else if (strncmp(propname, "stdout", 6) =3D=3D 0 && vallen =3D=3D =
sizeof(ret)) {
> +        ret =3D cpu_to_be32(1);
> +        cpu_physical_memory_write(valaddr, &ret, MIN(vallen, sizeof(ret)=
));

I'm guessing the special casing of stdout is to fake the OF instancing
stuff, which I don't really understand.  Some comments to explain
what's going on here would be good.

> +    } else {
> +        ret =3D -1;
> +    }
> +    trace_spapr_client_getprop(nodeph, propname, ret);
> +
> +    return ret;
> +}
> +
> +static uint32_t client_setprop(SpaprMachineState *sm,
> +                               uint32_t nodeph, uint32_t pname,
> +                               uint32_t valaddr, uint32_t vallen)
> +{
> +    char propname[64];
> +    uint32_t ret =3D -1;
> +    int proplen =3D 0;
> +    const void *prop;
> +
> +    readstr(pname, propname);
> +    if (vallen =3D=3D sizeof(uint32_t) &&
> +        ((strncmp(propname, "linux,rtas-base", 15) =3D=3D 0) ||
> +         (strncmp(propname, "linux,rtas-entry", 16) =3D=3D 0))) {
> +
> +        sm->rtas_base =3D readuint32(valaddr);
> +        prop =3D fdt_getprop_namelen(sm->fdt_blob,
> +                                   fdt_node_offset_by_phandle(sm->fdt_bl=
ob,
> +                                                              nodeph),
> +                                   propname, strlen(propname), &proplen);
> +        if (proplen =3D=3D vallen) {
> +            *(uint32_t *) prop =3D cpu_to_be32(sm->rtas_base);
> +            ret =3D proplen;
> +        }

Is there a particular reason to restrict this to the rtas properties,
rather than just allowing the guest to fdt_setprop() something
arbitrary?

> +    }
> +    trace_spapr_client_setprop(nodeph, propname, ret);
> +
> +    return ret;
> +}
> +
> +static uint32_t client_getproplen(const void *fdt, uint32_t nodeph,
> +                                  uint32_t pname)
> +{
> +    char propname[64];
> +    uint32_t ret =3D 0;
> +    int proplen =3D 0;
> +    const void *prop;
> +
> +    readstr(pname, propname);
> +
> +    prop =3D fdt_getprop_namelen(fdt, fdt_node_offset_by_phandle(fdt, no=
deph),
> +                               propname, strlen(propname), &proplen);
> +    if (prop) {
> +        ret =3D proplen;
> +    } else if (strncmp(propname, "stdout", 6) =3D=3D 0) {
> +        ret =3D 4;
> +    } else {
> +        ret =3D -1;
> +    }
> +
> +    return ret;
> +}
> +
> +static uint32_t client_peer(const void *fdt, uint32_t phandle)
> +{
> +    int ret;
> +
> +    if (phandle =3D=3D 0) {
> +        ret =3D fdt_path_offset(fdt, "/");
> +    } else {
> +        ret =3D fdt_next_subnode(fdt, fdt_node_offset_by_phandle(fdt, ph=
andle));
> +    }
> +
> +    if (ret < 0) {
> +        ret =3D 0;
> +    } else {
> +        ret =3D fdt_get_phandle(fdt, ret);
> +    }
> +
> +    return ret;
> +}
> +
> +static uint32_t client_child(const void *fdt, uint32_t phandle)
> +{
> +    int ret =3D fdt_first_subnode(fdt, fdt_node_offset_by_phandle(fdt, p=
handle));
> +
> +    if (ret < 0) {
> +        ret =3D 0;
> +    } else {
> +        ret =3D fdt_get_phandle(fdt, ret);
> +    }
> +
> +    return ret;
> +}
> +
> +static uint32_t client_parent(const void *fdt, uint32_t phandle)
> +{
> +    int ret =3D fdt_parent_offset(fdt, fdt_node_offset_by_phandle(fdt, p=
handle));
> +
> +    if (ret < 0) {
> +        ret =3D 0;
> +    } else {
> +        ret =3D fdt_get_phandle(fdt, ret);
> +    }
> +
> +    return ret;
> +}
> +
> +static uint32_t client_open(uint32_t phandle)
> +{
> +    uint32_t ret =3D (phandle & CLI_PH_MASK) | CLI_INST_PREFIX;
> +
> +    return ret;
> +}
> +
> +static uint32_t client_instance_to_path(SpaprMachineState *sm,
> +                                        uint32_t instance, uint32_t buf,
> +                                        uint32_t len)
> +{
> +    uint32_t ph =3D instance & CLI_PH_MASK;
> +    char *stdout_path =3D spapr_vio_stdout_path(sm->vio_bus);
> +    int stdout_ph =3D fdt_path_offset(sm->fdt_blob, stdout_path);
> +
> +    if (ph =3D=3D stdout_ph) {
> +        len =3D MIN(len, strlen(stdout_path));
> +        cpu_physical_memory_write(buf, stdout_path, len);
> +    } else  {
> +        len =3D 0;
> +    }
> +    g_free(stdout_path);
> +
> +    return len;
> +}
> +
> +static uint32_t client_package_to_path(const void *fdt, uint32_t phandle,
> +                                       uint32_t buf, uint32_t len)
> +{
> +    char tmp[256];

Fixed sized buffers are icky.  You could either dynamically allocate
this based on the size the client gives, or you could use
memory_region_get_ram_ptr() to read the data from the tree directly
into guest memory.

> +    if (0 =3D=3D fdt_get_path(fdt, fdt_node_offset_by_phandle(fdt, phand=
le), tmp,
> +                          sizeof(tmp))) {
> +        tmp[sizeof(tmp) - 1] =3D 0;
> +        cpu_physical_memory_write(buf, tmp, MIN(len, strlen(tmp)));
> +    }
> +    return len;
> +}
> +
> +static uint32_t client_write(uint32_t instance, uint32_t buf, uint32_t l=
en)
> +{
> +    char tmp[len + 1]; /* TODO: do a loop as len might be enourmous*/
> +
> +    readstr(buf, tmp);
> +    tmp[len] =3D 0;
> +    printf("%s", tmp);

I'm guessing this is what's used for console output via OF.  This is
enough for a debugging PoC, but for real we'll need to have this
actually go via the appropriate qemu chardev.

> +
> +    return len;
> +}
> +
> +static bool client_claim_avail(SpaprMachineState *sm, uint64_t virt,
> +                               uint64_t size)
> +{
> +    int i;
> +    spapr_of_claimed *c;
> +
> +    for (i =3D 0; i < sm->claimed->len; ++i) {
> +        c =3D &g_array_index(sm->claimed, spapr_of_claimed, i);
> +        if ((c->start <=3D virt && virt < c->start + c->size) ||
> +            (virt <=3D c->start && c->start < virt + size)) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
> +uint64_t spapr_do_client_claim(SpaprMachineState *sm,

SpaprMachineState * are usually called 'spapr', not 'sm'.

> uint64_t virt,
> +                               uint64_t size, uint64_t align)
> +{
> +    uint32_t ret;
> +    spapr_of_claimed newclaim;
> +
> +    if (align =3D=3D 0) {
> +        if (!client_claim_avail(sm, virt, size)) {
> +            return -1;
> +        }
> +        ret =3D virt;
> +    } else {
> +        align =3D pow2ceil(align);
> +        sm->claimed_base =3D (sm->claimed_base + align - 1) & ~(align - =
1);
> +        while (1) {
> +            if (sm->claimed_base >=3D sm->rma_size) {
> +                perror("Out of memory");

This should be an error_report() rather than a perror().

> +                return -1;
> +            }
> +            if (client_claim_avail(sm, sm->claimed_base, size)) {
> +                break;
> +            }
> +            sm->claimed_base +=3D size;
> +        }
> +        ret =3D sm->claimed_base;
> +    }
> +
> +    sm->claimed_base =3D MAX(sm->claimed_base, ret) + size;

I understand the logic with claimed_base.  It looks like you're
implementing a bump allocator, but isn't the the client passing in the
address to claim anyway, so why do you need an allocator?

> +    newclaim.start =3D virt;
> +    newclaim.size =3D size;
> +    g_array_append_val(sm->claimed, newclaim);
> +    trace_spapr_client_claim(virt, size, align, ret);
> +
> +    return ret;
> +}
> +
> +static uint32_t client_claim(SpaprMachineState *sm, uint32_t virt,
> +                             uint32_t size, uint32_t align)
> +{
> +    return spapr_do_client_claim(sm, virt, size, align);

Um.. why this wrapper?

> +}
> +
> +static uint32_t client_nextprop(const void *fdt, uint32_t phandle,
> +                                uint32_t prevaddr, uint32_t nameaddr)
> +{
> +    int namelen =3D 0;
> +    int offset =3D fdt_node_offset_by_phandle(fdt, phandle);
> +    char prev[256];

Ew, fixed sized buffer.

> +    const struct fdt_property *prop;
> +    const char *tmp;
> +
> +    readstr(prevaddr, prev);
> +    for (offset =3D fdt_first_property_offset(fdt, offset);
> +         (offset >=3D 0);
> +         (offset =3D fdt_next_property_offset(fdt, offset))) {
> +
> +        prop =3D fdt_get_property_by_offset(fdt, offset, &namelen);

fdt_getprop_by_offset() also returns the property's name without
having to dick around with fdt_get_string() manually.

> +        if (!prop) {
> +            return 0;
> +        }
> +
> +        tmp =3D fdt_get_string(fdt, fdt32_ld(&prop->nameoff), &namelen);
> +        if (prev[0] =3D=3D 0 ||

=3D=3D '\0' please.

> +            strncmp(prev, tmp, MAX(namelen, strlen(prev))) =3D=3D 0) {

This will break very badly if the client passed a name larger than
sizeof(prev), since readstr() won't \0 terminate in that case IIUC.

> +            if (prev[0]) {
> +                offset =3D fdt_next_property_offset(fdt, offset);
> +                if (offset < 0) {
> +                    return 0;
> +                }
> +            }
> +            prop =3D fdt_get_property_by_offset(fdt, offset, &namelen);
> +            if (!prop) {
> +                return 0;
> +            }
> +
> +            tmp =3D fdt_get_string(fdt, fdt32_ld(&prop->nameoff), &namel=
en);
> +            cpu_physical_memory_write(nameaddr, tmp, namelen + 1);
> +            return 1;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static uint32_t client_call_method(SpaprMachineState *sm, uint32_t metho=
daddr,
> +                                   uint32_t param1, uint32_t param2,
> +                                   uint32_t *ret2)
> +{
> +    uint32_t ret =3D 0;
> +    char method[256];

More fixed sized buffers.

> +    readstr(methodaddr, method);
> +    if (strncmp(method, "ibm,client-architecture-support", 31) =3D=3D 0)=
 {
> +
> +#define FDT_MAX_SIZE            0x100000
> +        ret =3D do_client_architecture_support(POWERPC_CPU(first_cpu), s=
m, param2,
> +                                             0, FDT_MAX_SIZE);
> +        *ret2 =3D 0;
> +    } else if (strncmp(method, "instantiate-rtas", 16) =3D=3D 0) {
> +        uint32_t rtasbase =3D param2;
> +
> +        spapr_instantiate_rtas(sm, rtasbase);
> +        *ret2 =3D rtasbase;

In both these cases you ignore param1.  I'm guessing it has the handle
of the node on which you're calling the method?  In which case you
really should validate it.

> +    } else {
> +        trace_spapr_client_error_unknown_method(method);
> +        return -1;
> +    }
> +
> +    trace_spapr_client_method(method, param1, param2, ret);
> +
> +    return ret;
> +}
> +
> +static void client_quiesce(SpaprMachineState *sm)
> +{

Possibly want a flush of stdout here.

> +}
> +
> +int spapr_h_client(SpaprMachineState *sm, target_ulong client_args)
> +{
> +    struct prom_args args =3D { 0 };
> +    char service[64];

More fixed sized buffers.

> +    unsigned nargs, nret;
> +    int i, servicelen;
> +
> +    cpu_physical_memory_read(client_args, &args, sizeof(args));
> +    nargs =3D be32_to_cpu(args.nargs);
> +    nret =3D be32_to_cpu(args.nret);
> +    readstr(be32_to_cpu(args.service), service);
> +    servicelen =3D strlen(service);
> +
> +#define cmpservice(s, a, r) \
> +        _cmpservice(service, servicelen, nargs, nret, (s), sizeof(s), (a=
), (r))
> +
> +    if (cmpservice("finddevice", 1, 1)) {

Hrm.  Rather than this giant chain of if(cmp) checks, I'd prefer to
have a table of services as a data structure, which the code would
scan through.  That does mean you'd have to give the functions
implementing each service a common signature, so they'd need to parse
out their own parameters, but I still think it's the better option.
It also makes it closer to how we implement RTAS call dispatch.

> +        args.args[nargs] =3D client_finddevice(sm->fdt_blob,
> +                                             be32_to_cpu(args.args[0]));
> +    } else if (cmpservice("getprop", 4, 1)) {
> +        args.args[nargs] =3D client_getprop(sm->fdt_blob,
> +                                          be32_to_cpu(args.args[0]),
> +                                          be32_to_cpu(args.args[1]),
> +                                          be32_to_cpu(args.args[2]),
> +                                          be32_to_cpu(args.args[3]));
> +    } else if (cmpservice("getproplen", 2, 1)) {
> +        args.args[nargs] =3D client_getproplen(sm->fdt_blob,
> +                                             be32_to_cpu(args.args[0]),
> +                                             be32_to_cpu(args.args[1]));
> +    } else if (cmpservice("setprop", 4, 1)) {
> +        args.args[nargs] =3D client_setprop(sm,
> +                                          be32_to_cpu(args.args[0]),
> +                                          be32_to_cpu(args.args[1]),
> +                                          be32_to_cpu(args.args[2]),
> +                                          be32_to_cpu(args.args[3]));
> +    } else if (cmpservice("instance-to-path", 3, 1)) {
> +        args.args[nargs] =3D client_instance_to_path(sm,
> +                                                   be32_to_cpu(args.args=
[0]),
> +                                                   be32_to_cpu(args.args=
[1]),
> +                                                   be32_to_cpu(args.args=
[2]));
> +    } else if (cmpservice("package-to-path", 3, 1)) {
> +        args.args[nargs] =3D client_package_to_path(sm->fdt_blob,
> +                                                  be32_to_cpu(args.args[=
0]),
> +                                                  be32_to_cpu(args.args[=
1]),
> +                                                  be32_to_cpu(args.args[=
2]));
> +    } else if (cmpservice("write", 3, 1)) {
> +        args.args[nargs] =3D client_write(be32_to_cpu(args.args[0]),
> +                                        be32_to_cpu(args.args[1]),
> +                                        be32_to_cpu(args.args[2]));
> +    } else if (cmpservice("peer", 1, 1)) {
> +        args.args[nargs] =3D client_peer(sm->fdt_blob,
> +                                       be32_to_cpu(args.args[0]));
> +    } else if (cmpservice("child", 1, 1)) {
> +        args.args[nargs] =3D client_child(sm->fdt_blob,
> +                                        be32_to_cpu(args.args[0]));
> +    } else if (cmpservice("parent", 1, 1)) {
> +        args.args[nargs] =3D client_parent(sm->fdt_blob,
> +                                         be32_to_cpu(args.args[0]));
> +    } else if (cmpservice("open", 1, 1)) {
> +        args.args[nargs] =3D client_open(be32_to_cpu(args.args[0]));
> +    } else if (cmpservice("call-method", 3, 2)) {
> +        uint32_t ret2 =3D 0;
> +
> +        args.args[nargs] =3D client_call_method(sm,
> +                                              be32_to_cpu(args.args[0]),
> +                                              be32_to_cpu(args.args[1]),
> +                                              be32_to_cpu(args.args[2]),
> +                                              &ret2);
> +        args.args[nargs + 1] =3D ret2;
> +    } else if (cmpservice("claim", 3, 1)) {
> +        args.args[nargs] =3D client_claim(sm,
> +                                        be32_to_cpu(args.args[0]),
> +                                        be32_to_cpu(args.args[1]),
> +                                        be32_to_cpu(args.args[2]));
> +    } else if (cmpservice("nextprop", 3, 1)) {
> +        args.args[nargs] =3D client_nextprop(sm->fdt_blob,
> +                                           be32_to_cpu(args.args[0]),
> +                                           be32_to_cpu(args.args[1]),
> +                                           be32_to_cpu(args.args[2]));
> +    } else if (cmpservice("quiesce", 0, 0)) {
> +        client_quiesce(sm);
> +    } else if (cmpservice("exit", 0, 0)) {
> +        error_report("Stopped as the VM requested \"exit\"");
> +        vm_stop(RUN_STATE_PAUSED);
> +    } else {
> +        trace_spapr_client_error_unknown_service(service, nargs, nret);
> +        args.args[nargs] =3D -1;
> +    }
> +
> +    for (i =3D 0; i < nret; ++i) {
> +        args.args[nargs + i] =3D be32_to_cpu(args.args[nargs + i]);
> +    }
> +    cpu_physical_memory_write(client_args, &args, sizeof(args));
> +
> +    return H_SUCCESS;
> +}
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index f1799b1b707d..76f93ec37959 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1660,15 +1660,12 @@ static bool spapr_hotplugged_dev_before_cas(void)
>      return false;
>  }
> =20
> -static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
> -                                                  SpaprMachineState *spa=
pr,
> -                                                  target_ulong opcode,
> -                                                  target_ulong *args)
> +target_ulong do_client_architecture_support(PowerPCCPU *cpu,
> +                                            SpaprMachineState *spapr,
> +                                            target_ulong addr,
> +                                            target_ulong fdt_buf,
> +                                            target_ulong fdt_bufsize)
>  {
> -    /* Working address in data buffer */
> -    target_ulong addr =3D ppc64_phys_to_real(args[0]);
> -    target_ulong fdt_buf =3D args[1];
> -    target_ulong fdt_bufsize =3D args[2];
>      target_ulong ov_table;
>      uint32_t cas_pvr;
>      SpaprOptionVector *ov1_guest, *ov5_guest, *ov5_cas_old;
> @@ -1833,13 +1830,15 @@ static target_ulong h_client_architecture_support=
(PowerPCCPU *cpu,
> =20
>          fdt_bufsize -=3D sizeof(hdr);
> =20
> -        fdt =3D spapr_build_fdt(spapr, false, fdt_bufsize);
> +        fdt =3D spapr_build_fdt(spapr, !spapr->bios_enabled, fdt_bufsize=
);
>          _FDT((fdt_pack(fdt)));
> =20
> -        cpu_physical_memory_write(fdt_buf, &hdr, sizeof(hdr));
> -        cpu_physical_memory_write(fdt_buf + sizeof(hdr), fdt,
> -                                  fdt_totalsize(fdt));
> -        trace_spapr_cas_continue(fdt_totalsize(fdt) + sizeof(hdr));
> +        if (spapr->bios_enabled) {
> +            cpu_physical_memory_write(fdt_buf, &hdr, sizeof(hdr));
> +            cpu_physical_memory_write(fdt_buf + sizeof(hdr), fdt,
> +                                      fdt_totalsize(fdt));
> +            trace_spapr_cas_continue(fdt_totalsize(fdt) + sizeof(hdr));
> +        }
> =20
>          g_free(spapr->fdt_blob);
>          spapr->fdt_size =3D fdt_totalsize(fdt);
> @@ -1854,6 +1853,20 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
> +                                                  SpaprMachineState *spa=
pr,
> +                                                  target_ulong opcode,
> +                                                  target_ulong *args)
> +{
> +    /* Working address in data buffer */
> +    target_ulong addr =3D ppc64_phys_to_real(args[0]);
> +    target_ulong fdt_buf =3D args[1];
> +    target_ulong fdt_bufsize =3D args[2];
> +
> +    return do_client_architecture_support(cpu, spapr, addr, fdt_buf,
> +                                          fdt_bufsize);
> +}
> +
>  static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
>                                                SpaprMachineState *spapr,
>                                                target_ulong opcode,
> @@ -1998,6 +2011,14 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, S=
paprMachineState *spapr,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong h_client(PowerPCCPU *cpu, SpaprMachineState *spapr,
> +                             target_ulong opcode, target_ulong *args)
> +{
> +    target_ulong client_args =3D ppc64_phys_to_real(args[0]);
> +
> +    return spapr_h_client(spapr, client_args);
> +}
> +
>  static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
>  static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_H=
CALL_BASE + 1];
>  static spapr_hcall_fn svm_hypercall_table[(SVM_HCALL_MAX - SVM_HCALL_BAS=
E) / 4 + 1];
> @@ -2121,6 +2142,8 @@ static void hypercall_register_types(void)
> =20
>      spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
> =20
> +    spapr_register_hypercall(KVMPPC_H_CLIENT, h_client);
> +
>      /* Virtual Processor Home Node */
>      spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
>                               h_home_node_associativity);
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index 9ea620f23c85..92bce3e44693 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -21,6 +21,15 @@ spapr_update_dt(unsigned cb) "New blob %u bytes"
>  spapr_update_dt_failed_size(unsigned cbold, unsigned cbnew, unsigned mag=
ic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
>  spapr_update_dt_failed_check(unsigned cbold, unsigned cbnew, unsigned ma=
gic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
> =20
> +# spapr_client.c
> +spapr_client_error_param(const char *method, int nargscheck, int nretche=
ck, int nargs, int nret) "%s takes/returns %d/%d, not %d/%d"
> +spapr_client_error_unknown_service(const char *service, int nargs, int n=
ret) "%s args=3D%d rets=3D%d"
> +spapr_client_error_unknown_method(const char *method) "%s"
> +spapr_client_claim(uint32_t virt, uint32_t size, uint32_t align, uint32_=
t ret) "virt=3D0x%x size=3D0x%x align=3D0x%x =3D> 0x%x"
> +spapr_client_method(const char *method, uint32_t param1, uint32_t param2=
, uint32_t ret) "%s(0x%x, 0x%x) =3D> 0x%x"
> +spapr_client_getprop(uint32_t ph, const char *prop, uint32_t ret) "phand=
le=3D0x%x \"%s\" =3D> 0x%x"
> +spapr_client_setprop(uint32_t ph, const char *prop, uint32_t ret) "phand=
le=3D0x%x \"%s\" =3D> 0x%x"
> +
>  # spapr_hcall_tpm.c
>  spapr_h_tpm_comm(const char *device_path, uint64_t operation) "tpm_devic=
e_path=3D%s operation=3D0x%"PRIu64
>  spapr_tpm_execute(uint64_t data_in, uint64_t data_in_sz, uint64_t data_o=
ut, uint64_t data_out_sz) "data_in=3D0x%"PRIx64", data_in_sz=3D%"PRIu64", d=
ata_out=3D0x%"PRIx64", data_out_sz=3D%"PRIu64

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aBaYPhOdNx+t7mr3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4StVkACgkQbDjKyiDZ
s5LXDRAA5EAdAqG97p+BYcRcMjiY6zpg5YiL4XGbPTbyk9cccKwWSjLTaEVX/Wj4
cCjikMPk3BNKL00yqSmmKCxi06lU0DRj/wxuINMCmWGd0tNHTKjdhb4te9vmdHCM
RknLwlFfAXksbrAq+b6CMWIQ66cDIkSVU0RmJrUzkoLsgcB2lQHAuydLCOoGfC2a
aj8efwmL5z1Ipq/SWbOy1f4nZei4VafTfkexAlkQNgPjp+8y3CQezqhlZEuA0ZbN
m1KFt9Akov2Fm+UYr7eTpOpsrCG3QYgvA5ZgXL6KDDFdBhrPrHIFM0mCH+fXfSW4
cPGADA4QJ9pSlqtGkyrcOA/ZvM6KV7DYKPd2Tc4okaFFUwE9lFFARNVpe4BAMzGe
tLOWysR2lLjRnrno1AKbPWhTvSqu30OqN+f03goAaeBYolowM2GdhaDdaqW5J09p
o8EFlwQt/lMkNv4Qwtn0FS+Ubftv4nzNyrz+zNnvxXesLUig7TTp/HahubG/bLGA
xijFwC16s/jhMTFNsO12qLreOc9WTsn/9u+PeK/6d7IFDoGVECgSnjT38oHYwnLf
aMuFT89m/YFjT2d0j14d8zh9tOMlirpa2b0rGaWGpHqTHAvjsXV3SU5cBLhNaAG4
FMk7ni1rjxJvDDtwR52ZXfyKJSRRCC025kODNrfniGY0RBx1fTY=
=gp6X
-----END PGP SIGNATURE-----

--aBaYPhOdNx+t7mr3--

