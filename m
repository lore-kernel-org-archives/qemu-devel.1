Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2883C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 05:12:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF832068E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 05:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="R4d0cxmx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF832068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY1FH-0000sS-IE
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 00:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iY1EH-0007qQ-4Z
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 00:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iY1ED-0000Dy-Ve
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 00:11:37 -0500
Received: from ozlabs.org ([203.11.71.1]:46051)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iY1EC-0000C6-Nu; Fri, 22 Nov 2019 00:11:33 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47K4KD1hgRz9sPc; Fri, 22 Nov 2019 16:11:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574399488;
 bh=NziZxkQkS9xHlLFCtOQt+kBjRFCKyVANSJySyPD2qnA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R4d0cxmxSyF3a28E3jA7LG3XOKA0JP6WswU1jY9QxOCbAEodbkKx6t5fvrjsxdsYN
 azMTII63t4jFXdO4mv2OTacYNjKKfwrceOJXDX6soLHYGmNySFLVYeLrEgLoM7PFKM
 f/3PWounnIovjTCZOXp1agVoRGHWStscrSyyFh+I=
Date: Fri, 22 Nov 2019 15:30:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH v3 2/3] spapr: Add NVDIMM device support
Message-ID: <20191122043045.GD5582@umbus.fritz.box>
References: <157107820388.27733.3565652855304038259.stgit@lep8c.aus.stglabs.ibm.com>
 <157107826404.27733.10134514695430511105.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Wi9qHyd/iQw4GpTM"
Content-Disposition: inline
In-Reply-To: <157107826404.27733.10134514695430511105.stgit@lep8c.aus.stglabs.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com, sbhat@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Wi9qHyd/iQw4GpTM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2019 at 01:37:50PM -0500, Shivaprasad G Bhat wrote:
> Add support for NVDIMM devices for sPAPR. Piggyback on existing nvdimm
> device interface in QEMU to support virtual NVDIMM devices for Power.
> Create the required DT entries for the device (some entries have
> dummy values right now).
>=20
> The patch creates the required DT node and sends a hotplug
> interrupt to the guest. Guest is expected to undertake the normal
> DR resource add path in response and start issuing PAPR SCM hcalls.
>=20
> The device support is verified based on the machine version unlike x86.
>=20
> This is how it can be used ..
> Ex :
> For coldplug, the device to be added in qemu command line as shown below
> -object memory-backend-file,id=3Dmemnvdimm0,prealloc=3Dyes,mem-path=3D/tm=
p/nvdimm0,share=3Dyes,size=3D1073872896
> -device nvdimm,label-size=3D128k,uuid=3D75a3cdd7-6a2f-4791-8d15-fe0a920e8=
e9e,memdev=3Dmemnvdimm0,id=3Dnvdimm0,slot=3D0
>=20
> For hotplug, the device to be added from monitor as below
> object_add memory-backend-file,id=3Dmemnvdimm0,prealloc=3Dyes,mem-path=3D=
/tmp/nvdimm0,share=3Dyes,size=3D1073872896
> device_add nvdimm,label-size=3D128k,uuid=3D75a3cdd7-6a2f-4791-8d15-fe0a92=
0e8e9e,memdev=3Dmemnvdimm0,id=3Dnvdimm0,slot=3D0
>=20
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
>                [Early implementation]
> ---
>  default-configs/ppc64-softmmu.mak |    1=20
>  hw/mem/Kconfig                    |    2=20
>  hw/mem/nvdimm.c                   |   40 +++++++
>  hw/ppc/spapr.c                    |  218 +++++++++++++++++++++++++++++++=
+++---
>  hw/ppc/spapr_drc.c                |   18 +++
>  hw/ppc/spapr_events.c             |    4 +
>  include/hw/mem/nvdimm.h           |    7 +
>  include/hw/ppc/spapr.h            |   11 ++
>  include/hw/ppc/spapr_drc.h        |    9 ++
>  9 files changed, 293 insertions(+), 17 deletions(-)
>=20
> diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-so=
ftmmu.mak
> index cca52665d9..ae0841fa3a 100644
> --- a/default-configs/ppc64-softmmu.mak
> +++ b/default-configs/ppc64-softmmu.mak
> @@ -8,3 +8,4 @@ CONFIG_POWERNV=3Dy
> =20
>  # For pSeries
>  CONFIG_PSERIES=3Dy
> +CONFIG_NVDIMM=3Dy
> diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
> index 620fd4cb59..2ad052a536 100644
> --- a/hw/mem/Kconfig
> +++ b/hw/mem/Kconfig
> @@ -8,4 +8,4 @@ config MEM_DEVICE
>  config NVDIMM
>      bool
>      default y
> -    depends on PC
> +    depends on (PC || PSERIES)
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index 375f9a588a..e1238b5bed 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -69,11 +69,51 @@ out:
>      error_propagate(errp, local_err);
>  }
> =20
> +static void nvdimm_get_uuid(Object *obj, Visitor *v, const char *name,
> +                                  void *opaque, Error **errp)
> +{
> +    NVDIMMDevice *nvdimm =3D NVDIMM(obj);
> +    char *value =3D NULL;
> +
> +    value =3D qemu_uuid_unparse_strdup(&nvdimm->uuid);
> +
> +    visit_type_str(v, name, &value, errp);
> +    g_free(value);
> +}
> +
> +
> +static void nvdimm_set_uuid(Object *obj, Visitor *v, const char *name,
> +                                  void *opaque, Error **errp)
> +{
> +    NVDIMMDevice *nvdimm =3D NVDIMM(obj);
> +    Error *local_err =3D NULL;
> +    char *value;
> +
> +    visit_type_str(v, name, &value, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +
> +    if (qemu_uuid_parse(value, &nvdimm->uuid) !=3D 0) {
> +        error_setg(errp, "Property '%s.%s' has invalid value",
> +                   object_get_typename(obj), name);
> +        goto out;
> +    }
> +    g_free(value);
> +
> +out:
> +    error_propagate(errp, local_err);
> +}
> +
> +
>  static void nvdimm_init(Object *obj)
>  {
>      object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "int",
>                          nvdimm_get_label_size, nvdimm_set_label_size, NU=
LL,
>                          NULL, NULL);
> +
> +    object_property_add(obj, NVDIMM_UUID_PROP, "QemuUUID", nvdimm_get_uu=
id,
> +                        nvdimm_set_uuid, NULL, NULL, NULL);

Adding a property to the generic NVDIMM device feels like it should go
in a separate patch.

>  }
> =20
>  static void nvdimm_finalize(Object *obj)
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 08a2a5a770..eb5c205078 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -80,6 +80,8 @@
>  #include "hw/ppc/spapr_cpu_core.h"
>  #include "hw/mem/memory-device.h"
>  #include "hw/ppc/spapr_tpm_proxy.h"
> +#include "hw/mem/nvdimm.h"
> +#include "qemu/nvdimm-utils.h"
> =20
>  #include <libfdt.h>
> =20
> @@ -716,7 +718,8 @@ static int spapr_populate_drmem_v2(SpaprMachineState =
*spapr, void *fdt,
>      uint8_t *int_buf, *cur_index;
>      int ret;
>      uint64_t lmb_size =3D SPAPR_MEMORY_BLOCK_SIZE;
> -    uint64_t addr, cur_addr, size;
> +    uint64_t addr, cur_addr, size, slot;
> +    uint64_t scm_block_size =3D SPAPR_MINIMUM_SCM_BLOCK_SIZE;
>      uint32_t nr_boot_lmbs =3D (machine->device_memory->base / lmb_size);
>      uint64_t mem_end =3D machine->device_memory->base +
>                         memory_region_size(&machine->device_memory->mr);
> @@ -741,6 +744,7 @@ static int spapr_populate_drmem_v2(SpaprMachineState =
*spapr, void *fdt,
>          addr =3D di->addr;
>          size =3D di->size;
>          node =3D di->node;
> +        slot =3D di->slot;
> =20
>          /* Entry for hot-pluggable area */
>          if (cur_addr < addr) {
> @@ -752,12 +756,20 @@ static int spapr_populate_drmem_v2(SpaprMachineStat=
e *spapr, void *fdt,
>              nr_entries++;
>          }
> =20
> -        /* Entry for DIMM */
> -        drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, addr / lmb_size);
> -        g_assert(drc);
> -        elem =3D spapr_get_drconf_cell(size / lmb_size, addr,
> -                                     spapr_drc_index(drc), node,
> -                                     SPAPR_LMB_FLAGS_ASSIGNED);
> +        if (info->value->type =3D=3D MEMORY_DEVICE_INFO_KIND_DIMM) {
> +            /* Entry for DIMM */
> +            drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, addr / lmb_size);
> +            g_assert(drc);
> +            elem =3D spapr_get_drconf_cell(size / lmb_size, addr,
> +                                         spapr_drc_index(drc), node,
> +                                         SPAPR_LMB_FLAGS_ASSIGNED);
> +        } else if (info->value->type =3D=3D MEMORY_DEVICE_INFO_KIND_NVDI=
MM) {
> +            /* Entry for NVDIMM */
> +            drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM, slot);
> +            g_assert(drc);
> +            elem =3D spapr_get_drconf_cell(size / scm_block_size, addr,
> +                                         spapr_drc_index(drc), -1, 0);
> +        }

Ok.  A number of queries about this.

1) The PAPR spec for ibm,dynamic-memory-v2 says that the first word in
each entry is the number of LMBs, but for NVDIMMs you use the
not-necessarily-equal scm_block_size instead.  Does the NVDIMM
amendment for PAPR really specify to use different block sizes for
these cases?  (In which case that's a really stupid spec decision, but
that wouldn't surprise me at this point).

2) Similarly, the ibm,dynamic-memory-v2 description says that the
memory block described by the entry has a whole batch of contiguous
DRCs starting at the DRC index given and continuing for #LMBs DRCs.
For NVDIMMs it appears that you just have one DRC for the whole
NVDIMM.  Is that right?

3) You're not setting *any* extra flags on the entry.  How is the
guest supposed to know which are NVDIMM entries and which are regular
DIMM entries?  AFAICT in this version the NVDIMM slots are
indistinguishable from the unassigned hotplug memory (which makes the
difference in LMB and DRC numbering even more troubling).

4) AFAICT these are _present_ NVDIMMs, so why is
SPAPR_LMB_FLAGS_ASSIGNED not set for them?  (and why is the node
forced to -1, regardless of di->node).

>          QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
>          nr_entries++;
>          cur_addr =3D addr + size;
> @@ -1261,6 +1273,85 @@ static void spapr_dt_hypervisor(SpaprMachineState =
*spapr, void *fdt)
>      }
>  }
> =20
> +static int spapr_dt_nvdimm(void *fdt, int parent_offset,
> +                           NVDIMMDevice *nvdimm)
> +{
> +    int child_offset;
> +    char buf[40];
> +    SpaprDrc *drc;
> +    uint32_t drc_idx;
> +    uint32_t node =3D object_property_get_uint(OBJECT(nvdimm), PC_DIMM_N=
ODE_PROP,
> +                                             &error_abort);
> +    uint64_t slot =3D object_property_get_uint(OBJECT(nvdimm), PC_DIMM_S=
LOT_PROP,
> +                                             &error_abort);
> +    uint32_t associativity[] =3D {
> +        cpu_to_be32(0x4), /* length */
> +        cpu_to_be32(0x0), cpu_to_be32(0x0),
> +        cpu_to_be32(0x0), cpu_to_be32(node)
> +    };
> +    uint64_t lsize =3D nvdimm->label_size;
> +    uint64_t size =3D object_property_get_int(OBJECT(nvdimm), PC_DIMM_SI=
ZE_PROP,
> +                                            NULL);
> +
> +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM, slot);
> +    g_assert(drc);
> +
> +    drc_idx =3D spapr_drc_index(drc);
> +
> +    sprintf(buf, "ibm,pmemory@%x", drc_idx);
> +    child_offset =3D fdt_add_subnode(fdt, parent_offset, buf);
> +    _FDT(child_offset);
> +
> +    _FDT((fdt_setprop_cell(fdt, child_offset, "reg", drc_idx)));
> +    _FDT((fdt_setprop_string(fdt, child_offset, "compatible", "ibm,pmemo=
ry")));
> +    _FDT((fdt_setprop_string(fdt, child_offset, "device_type", "ibm,pmem=
ory")));
> +
> +    _FDT((fdt_setprop(fdt, child_offset, "ibm,associativity", associativ=
ity,
> +                      sizeof(associativity))));
> +
> +    qemu_uuid_unparse(&nvdimm->uuid, buf);
> +    _FDT((fdt_setprop_string(fdt, child_offset, "ibm,unit-guid", buf)));
> +
> +    _FDT((fdt_setprop_cell(fdt, child_offset, "ibm,my-drc-index", drc_id=
x)));
> +
> +    _FDT((fdt_setprop_u64(fdt, child_offset, "ibm,block-size",
> +                          SPAPR_MINIMUM_SCM_BLOCK_SIZE)));
> +    _FDT((fdt_setprop_u64(fdt, child_offset, "ibm,number-of-blocks",
> +                          size / SPAPR_MINIMUM_SCM_BLOCK_SIZE)));
> +    _FDT((fdt_setprop_cell(fdt, child_offset, "ibm,metadata-size", lsize=
)));
> +
> +    _FDT((fdt_setprop_string(fdt, child_offset, "ibm,pmem-application",
> +                             "operating-system")));
> +    _FDT(fdt_setprop(fdt, child_offset, "ibm,cache-flush-required", NULL=
, 0));
> +
> +    return child_offset;
> +}
> +
> +static void spapr_dt_persistent_memory(void *fdt)
> +{
> +    int offset =3D fdt_subnode_offset(fdt, 0, "persistent-memory");
> +    GSList *iter, *nvdimms =3D nvdimm_get_device_list();
> +
> +    if (offset < 0) {
> +        offset =3D fdt_add_subnode(fdt, 0, "persistent-memory");
> +        _FDT(offset);
> +        _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 0x1)));
> +        _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 0x0)));
> +        _FDT((fdt_setprop_string(fdt, offset, "device_type",
> +                                 "ibm,persistent-memory")));
> +    }
> +
> +    /* Create DT entries for cold plugged NVDIMM devices */
> +    for (iter =3D nvdimms; iter; iter =3D iter->next) {
> +        NVDIMMDevice *nvdimm =3D iter->data;
> +
> +        spapr_dt_nvdimm(fdt, offset, nvdimm);
> +    }
> +    g_slist_free(nvdimms);
> +
> +    return;
> +}
> +
>  static void *spapr_build_fdt(SpaprMachineState *spapr)
>  {
>      MachineState *machine =3D MACHINE(spapr);
> @@ -1392,6 +1483,11 @@ static void *spapr_build_fdt(SpaprMachineState *sp=
apr)
>          }
>      }
> =20
> +    /* NVDIMM devices */
> +    if (mc->nvdimm_supported) {
> +        spapr_dt_persistent_memory(fdt);
> +    }
> +
>      return fdt;
>  }
> =20
> @@ -2521,6 +2617,16 @@ static void spapr_create_lmb_dr_connectors(SpaprMa=
chineState *spapr)
>      }
>  }
> =20
> +static void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr)
> +{
> +    MachineState *machine =3D MACHINE(spapr);
> +    int i;
> +
> +    for (i =3D 0; i < machine->ram_slots; i++) {
> +        spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM, i);

What happens if you try to plug an NVDIMM to one of these slots, but a
regular DIMM has already taken it?

> +    }
> +}
> +
>  /*
>   * If RAM size, maxmem size and individual node mem sizes aren't aligned
>   * to SPAPR_MEMORY_BLOCK_SIZE(256MB), then refuse to start the guest
> @@ -2734,6 +2840,7 @@ static void spapr_machine_init(MachineState *machin=
e)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(machine);
>      SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>      const char *kernel_filename =3D machine->kernel_filename;
>      const char *initrd_filename =3D machine->initrd_filename;
>      PCIHostState *phb;
> @@ -2915,6 +3022,10 @@ static void spapr_machine_init(MachineState *machi=
ne)
>          spapr_create_lmb_dr_connectors(spapr);
>      }
> =20
> +    if (mc->nvdimm_supported) {
> +        spapr_create_nvdimm_dr_connectors(spapr);
> +    }
> +
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, "spapr-rtas.bin");
>      if (!filename) {
>          error_report("Could not find LPAR rtas '%s'", "spapr-rtas.bin");
> @@ -3436,6 +3547,16 @@ static void spapr_nmi(NMIState *n, int cpu_index, =
Error **errp)
>      }
>  }
> =20
> +int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
> +                           void *fdt, int *fdt_start_offset, Error **err=
p)
> +{
> +    NVDIMMDevice *nvdimm =3D NVDIMM(drc->dev);
> +
> +    *fdt_start_offset =3D spapr_dt_nvdimm(fdt, 0, nvdimm);
> +
> +    return 0;
> +}
> +
>  int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
>                            void *fdt, int *fdt_start_offset, Error **errp)
>  {
> @@ -3498,13 +3619,34 @@ static void spapr_add_lmbs(DeviceState *dev, uint=
64_t addr_start, uint64_t size,
>      }
>  }
> =20
> +static void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **er=
rp)
> +{
> +    SpaprDrc *drc;
> +    bool hotplugged =3D spapr_drc_hotplugged(dev);
> +    Error *local_err =3D NULL;
> +
> +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM, slot);
> +    g_assert(drc);
> +
> +    spapr_drc_attach(drc, dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    if (hotplugged) {
> +        spapr_hotplug_req_add_by_index(drc);
> +    }
> +}
> +
>  static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *=
dev,
>                                Error **errp)
>  {
>      Error *local_err =3D NULL;
>      SpaprMachineState *ms =3D SPAPR_MACHINE(hotplug_dev);
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
> -    uint64_t size, addr;
> +    uint64_t size, addr, slot;
> +    bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
> =20
>      size =3D memory_device_get_region_size(MEMORY_DEVICE(dev), &error_ab=
ort);
> =20
> @@ -3513,14 +3655,24 @@ static void spapr_memory_plug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
>          goto out;
>      }
> =20
> -    addr =3D object_property_get_uint(OBJECT(dimm),
> -                                    PC_DIMM_ADDR_PROP, &local_err);
> -    if (local_err) {
> -        goto out_unplug;
> +    if (!is_nvdimm) {
> +        addr =3D object_property_get_uint(OBJECT(dimm),
> +                                        PC_DIMM_ADDR_PROP, &local_err);
> +        if (local_err) {
> +            goto out_unplug;
> +        }
> +        spapr_add_lmbs(dev, addr, size,
> +                       spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
> +                       &local_err);
> +    } else {
> +        slot =3D object_property_get_uint(OBJECT(dimm),
> +                                        PC_DIMM_SLOT_PROP, &local_err);
> +        if (local_err) {
> +            goto out_unplug;
> +        }
> +        spapr_add_nvdimm(dev, slot, &local_err);
>      }
> =20
> -    spapr_add_lmbs(dev, addr, size, spapr_ovec_test(ms->ov5_cas, OV5_HP_=
EVT),
> -                   &local_err);
>      if (local_err) {
>          goto out_unplug;
>      }
> @@ -3538,6 +3690,8 @@ static void spapr_memory_pre_plug(HotplugHandler *h=
otplug_dev, DeviceState *dev,
>  {
>      const SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(hotplug_dev=
);
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(hotplug_dev);
> +    const MachineClass *mc =3D MACHINE_CLASS(smc);
> +    bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
>      Error *local_err =3D NULL;
>      uint64_t size;
> @@ -3549,16 +3703,40 @@ static void spapr_memory_pre_plug(HotplugHandler =
*hotplug_dev, DeviceState *dev,
>          return;
>      }
> =20
> +    if (is_nvdimm && !mc->nvdimm_supported) {
> +        error_setg(errp, "NVDIMM hotplug not supported for this machine"=
);
> +        return;
> +    }
> +
>      size =3D memory_device_get_region_size(MEMORY_DEVICE(dimm), &local_e=
rr);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
>      }
> =20
> -    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
> +    if (!is_nvdimm && size % SPAPR_MEMORY_BLOCK_SIZE) {
>          error_setg(errp, "Hotplugged memory size must be a multiple of "
> -                      "%" PRIu64 " MB", SPAPR_MEMORY_BLOCK_SIZE / MiB);
> +                   "%" PRIu64 " MB", SPAPR_MEMORY_BLOCK_SIZE / MiB);
>          return;
> +    } else if (is_nvdimm) {
> +        char *uuidstr =3D NULL;
> +        QemuUUID uuid;
> +
> +        if (size % SPAPR_MINIMUM_SCM_BLOCK_SIZE) {
> +            error_setg(errp, "NVDIMM memory size excluding the label are=
a"
> +                       " must be a multiple of %" PRIu64 "MB",
> +                       SPAPR_MINIMUM_SCM_BLOCK_SIZE / MiB);
> +            return;
> +        }
> +
> +        uuidstr =3D object_property_get_str(OBJECT(dimm), NVDIMM_UUID_PR=
OP, NULL);
> +        qemu_uuid_parse(uuidstr, &uuid);
> +        g_free(uuidstr);
> +
> +        if (qemu_uuid_is_null(&uuid)) {
> +            error_setg(errp, "NVDIMM device requires the uuid to be set"=
);
> +            return;
> +        }
>      }
> =20
>      memdev =3D object_property_get_link(OBJECT(dimm), PC_DIMM_MEMDEV_PRO=
P,
> @@ -3698,6 +3876,12 @@ static void spapr_memory_unplug_request(HotplugHan=
dler *hotplug_dev,
>      int i;
>      SpaprDrc *drc;
> =20
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
> +        error_setg(&local_err,
> +                   "nvdimm device hot unplug is not supported yet.");
> +        goto out;
> +    }
> +
>      size =3D memory_device_get_region_size(MEMORY_DEVICE(dimm), &error_a=
bort);
>      nr_lmbs =3D size / SPAPR_MEMORY_BLOCK_SIZE;
> =20
> @@ -4453,6 +4637,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->update_dt_enabled =3D true;
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
>      mc->has_hotpluggable_cpus =3D true;
> +    mc->nvdimm_supported =3D true;
>      smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_ENABLED;
>      fwc->get_dev_path =3D spapr_get_fw_dev_path;
>      nc->nmi_monitor_handler =3D spapr_nmi;
> @@ -4558,6 +4743,7 @@ static void spapr_machine_4_1_class_options(Machine=
Class *mc)
>      };
> =20
>      spapr_machine_4_2_class_options(mc);
> +    mc->nvdimm_supported =3D false;

This is too late for qemu-4.2, so this will have to move to the
machine_4_2 function.

>      smc->linux_pci_probe =3D false;
>      compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
>      compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 62f1a42592..815167e42f 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -708,6 +708,17 @@ static void spapr_drc_phb_class_init(ObjectClass *k,=
 void *data)
>      drck->dt_populate =3D spapr_phb_dt_populate;
>  }
> =20
> +static void spapr_drc_pmem_class_init(ObjectClass *k, void *data)
> +{
> +    SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
> +
> +    drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_PMEM;
> +    drck->typename =3D "MEM";

This is the same as the typename for LMB DRCs.  Doesn't that mean that
ibm,drc-types will end up with a duplicate in it?

> +    drck->drc_name_prefix =3D "PMEM ";
> +    drck->release =3D NULL;
> +    drck->dt_populate =3D spapr_pmem_dt_populate;
> +}
> +
>  static const TypeInfo spapr_dr_connector_info =3D {
>      .name          =3D TYPE_SPAPR_DR_CONNECTOR,
>      .parent        =3D TYPE_DEVICE,
> @@ -758,6 +769,12 @@ static const TypeInfo spapr_drc_phb_info =3D {
>      .class_init    =3D spapr_drc_phb_class_init,
>  };
> =20
> +static const TypeInfo spapr_drc_pmem_info =3D {
> +    .name          =3D TYPE_SPAPR_DRC_PMEM,
> +    .parent        =3D TYPE_SPAPR_DRC_LOGICAL,
> +    .class_init    =3D spapr_drc_pmem_class_init,
> +};
> +
>  /* helper functions for external users */
> =20
>  SpaprDrc *spapr_drc_by_index(uint32_t index)
> @@ -1229,6 +1246,7 @@ static void spapr_drc_register_types(void)
>      type_register_static(&spapr_drc_pci_info);
>      type_register_static(&spapr_drc_lmb_info);
>      type_register_static(&spapr_drc_phb_info);
> +    type_register_static(&spapr_drc_pmem_info);
> =20
>      spapr_rtas_register(RTAS_SET_INDICATOR, "set-indicator",
>                          rtas_set_indicator);
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 0e4c19523a..b9a4d1607c 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -194,6 +194,7 @@ struct rtas_event_log_v6_hp {
>  #define RTAS_LOG_V6_HP_TYPE_SLOT                         3
>  #define RTAS_LOG_V6_HP_TYPE_PHB                          4
>  #define RTAS_LOG_V6_HP_TYPE_PCI                          5
> +#define RTAS_LOG_V6_HP_TYPE_PMEM                         6
>      uint8_t hotplug_action;
>  #define RTAS_LOG_V6_HP_ACTION_ADD                        1
>  #define RTAS_LOG_V6_HP_ACTION_REMOVE                     2
> @@ -530,6 +531,9 @@ static void spapr_hotplug_req_event(uint8_t hp_id, ui=
nt8_t hp_action,
>      case SPAPR_DR_CONNECTOR_TYPE_PHB:
>          hp->hotplug_type =3D RTAS_LOG_V6_HP_TYPE_PHB;
>          break;
> +    case SPAPR_DR_CONNECTOR_TYPE_PMEM:
> +        hp->hotplug_type =3D RTAS_LOG_V6_HP_TYPE_PMEM;
> +        break;
>      default:
>          /* we shouldn't be signaling hotplug events for resources
>           * that don't support them
> diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
> index 523a9b3d4a..4807ca615b 100644
> --- a/include/hw/mem/nvdimm.h
> +++ b/include/hw/mem/nvdimm.h
> @@ -25,6 +25,7 @@
> =20
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/acpi/bios-linker-loader.h"
> +#include "qemu/uuid.h"
> =20
>  #define NVDIMM_DEBUG 0
>  #define nvdimm_debug(fmt, ...)                                \
> @@ -49,6 +50,7 @@
>                                                 TYPE_NVDIMM)
> =20
>  #define NVDIMM_LABEL_SIZE_PROP "label-size"
> +#define NVDIMM_UUID_PROP       "uuid"
>  #define NVDIMM_UNARMED_PROP    "unarmed"
> =20
>  struct NVDIMMDevice {
> @@ -83,6 +85,11 @@ struct NVDIMMDevice {
>       * the guest write persistence.
>       */
>      bool unarmed;
> +
> +    /*
> +     * The PPC64 - spapr requires each nvdimm device have a uuid.
> +     */
> +    QemuUUID uuid;
>  };
>  typedef struct NVDIMMDevice NVDIMMDevice;
> =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 03111fd55b..a8cb3513d0 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -811,6 +811,8 @@ int spapr_core_dt_populate(SpaprDrc *drc, SpaprMachin=
eState *spapr,
>  void spapr_lmb_release(DeviceState *dev);
>  int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
>                            void *fdt, int *fdt_start_offset, Error **errp=
);
> +int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
> +                           void *fdt, int *fdt_start_offset, Error **err=
p);
>  void spapr_phb_release(DeviceState *dev);
>  int spapr_phb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
>                            void *fdt, int *fdt_start_offset, Error **errp=
);
> @@ -846,6 +848,15 @@ int spapr_rtc_import_offset(SpaprRtcState *rtc, int6=
4_t legacy_offset);
>  #define SPAPR_LMB_FLAGS_DRC_INVALID 0x00000020
>  #define SPAPR_LMB_FLAGS_RESERVED 0x00000080
> =20
> +/*
> + * The nvdimm size should be aligned to SCM block size.
> + * The SCM block size should be aligned to SPAPR_MEMORY_BLOCK_SIZE
> + * inorder to have SCM regions not to overlap with dimm memory regions.
> + * The SCM devices can have variable block sizes. For now, fixing the
> + * block size to the minimum value.
> + */
> +#define SPAPR_MINIMUM_SCM_BLOCK_SIZE SPAPR_MEMORY_BLOCK_SIZE
> +
>  void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
> =20
>  #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index 83f03cc577..df3d958a66 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -78,6 +78,13 @@
>  #define SPAPR_DRC_PHB(obj) OBJECT_CHECK(SpaprDrc, (obj), \
>                                          TYPE_SPAPR_DRC_PHB)
> =20
> +#define TYPE_SPAPR_DRC_PMEM "spapr-drc-pmem"
> +#define SPAPR_DRC_PMEM_GET_CLASS(obj) \
> +        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_PMEM)
> +#define SPAPR_DRC_PMEM_CLASS(klass) \
> +        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, TYPE_SPAPR_DRC_PMEM)
> +#define SPAPR_DRC_PMEM(obj) OBJECT_CHECK(SpaprDrc, (obj), \
> +                                         TYPE_SPAPR_DRC_PMEM)
>  /*
>   * Various hotplug types managed by SpaprDrc
>   *
> @@ -95,6 +102,7 @@ typedef enum {
>      SPAPR_DR_CONNECTOR_TYPE_SHIFT_VIO =3D 3,
>      SPAPR_DR_CONNECTOR_TYPE_SHIFT_PCI =3D 4,
>      SPAPR_DR_CONNECTOR_TYPE_SHIFT_LMB =3D 8,
> +    SPAPR_DR_CONNECTOR_TYPE_SHIFT_PMEM =3D 9,
>  } SpaprDrcTypeShift;
> =20
>  typedef enum {
> @@ -104,6 +112,7 @@ typedef enum {
>      SPAPR_DR_CONNECTOR_TYPE_VIO =3D 1 << SPAPR_DR_CONNECTOR_TYPE_SHIFT_V=
IO,
>      SPAPR_DR_CONNECTOR_TYPE_PCI =3D 1 << SPAPR_DR_CONNECTOR_TYPE_SHIFT_P=
CI,
>      SPAPR_DR_CONNECTOR_TYPE_LMB =3D 1 << SPAPR_DR_CONNECTOR_TYPE_SHIFT_L=
MB,
> +    SPAPR_DR_CONNECTOR_TYPE_PMEM =3D 1 << SPAPR_DR_CONNECTOR_TYPE_SHIFT_=
PMEM,
>  } SpaprDrcType;
> =20
>  /*
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Wi9qHyd/iQw4GpTM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3XZHMACgkQbDjKyiDZ
s5IsShAAgrSHIaex6kDSEemilWh1hTRHBRcxGo9xfNoCq2GDZdfHjB4AcoCN170c
GL2jCbeQlqYmm18zjyxj/BCZ5LBuLfuyX42Fa0u17qyDTsS2gYMP4bwoPslmLBhJ
z60In1uC7IItto8SlQXwuooPbVPVffOHNJdHp83UkeWlawfLD47I2E4N9U7C2x9o
kFnKwxrBQOZSZUIsO17RsGYeDey2+OP20495NNHJ/cuPHGFblhRD7SKsIUIjUh17
Bs6cSzSZ4dkt1CoNaNaE37C29w8ByAA9KhTh3bTwj54tXjNKPuZ/20WpSYKQB+DU
iDHaJCDgm5P0/QtjrztkzYWidnMav5SqBqXMq1EQFfZcZ/8MsmSQ5w4GSVDd3WlU
tj9LoykYCegIJV+aUiYajr9C1/bq/sPjfectvhq6gldGl+EUbKOQSzXE0sgiZtke
7mb0aFV4yqYg2Ykw3B9pAJii2vxBO1Yz4XDnJ6aPLs1dwnIfTkBfQP4f+W73tOW+
gnnblzWEZsQtm2S4BWRf4+sMsdVDbJAZpBCwTYsUejoZkB+CEdR9VVgiOsWYnlNx
r85GjKs9+f35JRH49uSo7s4nod22yO/cKqpKDSxNmNkbfJEpIngasZaIalTRXbug
Xw0g0J9pYcOOTElT2kWbAbLoO9KhNEHquSYBnvloBBmVMLI/hd0=
=rTaV
-----END PGP SIGNATURE-----

--Wi9qHyd/iQw4GpTM--

