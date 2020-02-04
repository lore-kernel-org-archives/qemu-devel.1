Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A01C3524A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 04:10:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B050C20732
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 04:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZeuDcF/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B050C20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iypXc-0005zw-R1
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 23:10:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iypWk-0004bK-Ge
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 23:09:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iypWh-0002j1-QT
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 23:09:30 -0500
Received: from ozlabs.org ([203.11.71.1]:49597)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iypWf-0002XU-K6; Mon, 03 Feb 2020 23:09:27 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48BWRP6410z9sfG; Tue,  4 Feb 2020 15:09:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580789361;
 bh=PIBsQi1stmj1yZXhCDY3Jt6T3j1Tcu2cdQLYU7Gyes0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZeuDcF/LoWuRqN/z8B8rTym0l6hVo7VVa1dBKcs2oHNbcV4VITq4fT1IMUxEjDC6n
 pF0cZqxN7Fqy8nuikSiefZXPL4O/vxA0/kvhTLVexTyOKUgbbRr++gz5Z0J+kxFYfT
 bhcCO5duRYtS8aegXNIAJ67rfEVftUgp3yP6xQ2g=
Date: Tue, 4 Feb 2020 14:59:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH v5 3/4] spapr: Add NVDIMM device support
Message-ID: <20200204035900.GB60221@umbus.fritz.box>
References: <158038485571.16440.14734905006978949612.stgit@lep8c.aus.stglabs.ibm.com>
 <158038488675.16440.7063690858146740608.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <158038488675.16440.7063690858146740608.stgit@lep8c.aus.stglabs.ibm.com>
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


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2020 at 05:48:15AM -0600, Shivaprasad G Bhat wrote:
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

Looking pretty good now.  Just a few minor things to address now,
noted below.

> ---
>  default-configs/ppc64-softmmu.mak |    1=20
>  hw/mem/Kconfig                    |    2=20
>  hw/ppc/spapr.c                    |  212 +++++++++++++++++++++++++++++++=
++++--
>  hw/ppc/spapr_drc.c                |   18 +++
>  hw/ppc/spapr_events.c             |    4 +
>  include/hw/ppc/spapr.h            |   11 ++
>  include/hw/ppc/spapr_drc.h        |    9 ++
>  7 files changed, 243 insertions(+), 14 deletions(-)
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
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 02cf53fc5b..4ea73c31fe 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -79,6 +79,8 @@
>  #include "hw/ppc/spapr_cpu_core.h"
>  #include "hw/mem/memory-device.h"
>  #include "hw/ppc/spapr_tpm_proxy.h"
> +#include "hw/mem/nvdimm.h"
> +#include "qemu/nvdimm-utils.h"
> =20
>  #include "monitor/monitor.h"
> =20
> @@ -684,12 +686,22 @@ static int spapr_populate_drmem_v2(SpaprMachineStat=
e *spapr, void *fdt,
>              nr_entries++;
>          }
> =20
> -        /* Entry for DIMM */
>          drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, addr / lmb_size);
>          g_assert(drc);
> -        elem =3D spapr_get_drconf_cell(size / lmb_size, addr,
> -                                     spapr_drc_index(drc), node,
> -                                     SPAPR_LMB_FLAGS_ASSIGNED);
> +
> +        if (info->value->type =3D=3D MEMORY_DEVICE_INFO_KIND_DIMM) {
> +            /* Entry for DIMM */
> +            elem =3D spapr_get_drconf_cell(size / lmb_size, addr,
> +                                         spapr_drc_index(drc), node,
> +                                         SPAPR_LMB_FLAGS_ASSIGNED);
> +        } else if (info->value->type =3D=3D MEMORY_DEVICE_INFO_KIND_NVDI=
MM) {
> +            /*
> +             * Entry for the NVDIMM occupied area. The area is
> +             * hotpluggable after the NVDIMM is unplugged.
> +             */
> +            elem =3D spapr_get_drconf_cell(size / lmb_size, addr,
> +                                         spapr_drc_index(drc), -1, 0);
> +        }

Rather than having a separate case here, it should work to simply
'continue' the loop on NVDIMM entries.  Then the code above this to
insert unassigned DRCs for memory ranges that don't have (regular)
memory in them yet should already do what you need.

>          QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
>          nr_entries++;
>          cur_addr =3D addr + size;
> @@ -1130,6 +1142,85 @@ static void spapr_dt_hypervisor(SpaprMachineState =
*spapr, void *fdt)
>      }
>  }
> =20
> +static int spapr_dt_nvdimm(void *fdt, int parent_offset,
> +                           NVDIMMDevice *nvdimm)
> +{
> +    int child_offset;
> +    char buf[40];

Use g_strdup_printf() rather than fixed sized buffers, please.

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
>  void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
>  {
>      MachineState *machine =3D MACHINE(spapr);
> @@ -1265,6 +1356,11 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bo=
ol reset, size_t space)
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
> @@ -2366,6 +2462,16 @@ static void spapr_create_lmb_dr_connectors(SpaprMa=
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
> +    }
> +}
> +
>  /*
>   * If RAM size, maxmem size and individual node mem sizes aren't aligned
>   * to SPAPR_MEMORY_BLOCK_SIZE(256MB), then refuse to start the guest
> @@ -2582,6 +2688,7 @@ static void spapr_machine_init(MachineState *machin=
e)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(machine);
>      SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>      const char *kernel_filename =3D machine->kernel_filename;
>      const char *initrd_filename =3D machine->initrd_filename;
>      PCIHostState *phb;
> @@ -2807,6 +2914,10 @@ static void spapr_machine_init(MachineState *machi=
ne)
>          spapr_create_lmb_dr_connectors(spapr);
>      }
> =20
> +    if (mc->nvdimm_supported) {
> +        spapr_create_nvdimm_dr_connectors(spapr);
> +    }
> +
>      /* Set up RTAS event infrastructure */
>      spapr_events_init(spapr);
> =20
> @@ -3306,6 +3417,16 @@ static void spapr_nmi(NMIState *n, int cpu_index, =
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
> @@ -3368,13 +3489,34 @@ static void spapr_add_lmbs(DeviceState *dev, uint=
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
> @@ -3383,14 +3525,24 @@ static void spapr_memory_plug(HotplugHandler *hot=
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
> @@ -3408,6 +3560,8 @@ static void spapr_memory_pre_plug(HotplugHandler *h=
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
> @@ -3419,16 +3573,40 @@ static void spapr_memory_pre_plug(HotplugHandler =
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

Uh.. couldn't we just look at nvdimm->uuid, rather than getting the
string property and parsing it again?

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
> @@ -3568,6 +3746,12 @@ static void spapr_memory_unplug_request(HotplugHan=
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
> @@ -4362,6 +4546,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->update_dt_enabled =3D true;
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
>      mc->has_hotpluggable_cpus =3D true;
> +    mc->nvdimm_supported =3D true;
>      smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_ENABLED;
>      fwc->get_dev_path =3D spapr_get_fw_dev_path;
>      nc->nmi_monitor_handler =3D spapr_nmi;
> @@ -4467,6 +4652,7 @@ static void spapr_machine_4_2_class_options(Machine=
Class *mc)
>  {
>      spapr_machine_5_0_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
> +    mc->nvdimm_supported =3D false;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(4_2, "4.2", false);
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 17aeac3801..1e496b9fc9 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -709,6 +709,17 @@ static void spapr_drc_phb_class_init(ObjectClass *k,=
 void *data)
>      drck->dt_populate =3D spapr_phb_dt_populate;
>  }
> =20
> +static void spapr_drc_pmem_class_init(ObjectClass *k, void *data)
> +{
> +    SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
> +
> +    drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_PMEM;
> +    drck->typename =3D "PMEM";
> +    drck->drc_name_prefix =3D "PMEM ";
> +    drck->release =3D NULL;
> +    drck->dt_populate =3D spapr_pmem_dt_populate;
> +}
> +
>  static const TypeInfo spapr_dr_connector_info =3D {
>      .name          =3D TYPE_SPAPR_DR_CONNECTOR,
>      .parent        =3D TYPE_DEVICE,
> @@ -759,6 +770,12 @@ static const TypeInfo spapr_drc_phb_info =3D {
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
> @@ -1230,6 +1247,7 @@ static void spapr_drc_register_types(void)
>      type_register_static(&spapr_drc_pci_info);
>      type_register_static(&spapr_drc_lmb_info);
>      type_register_static(&spapr_drc_phb_info);
> +    type_register_static(&spapr_drc_pmem_info);
> =20
>      spapr_rtas_register(RTAS_SET_INDICATOR, "set-indicator",
>                          rtas_set_indicator);
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index e355e000d0..1731197af3 100644
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
> @@ -531,6 +532,9 @@ static void spapr_hotplug_req_event(uint8_t hp_id, ui=
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
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 61f005c6f6..ed2de4bae5 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -810,6 +810,8 @@ int spapr_core_dt_populate(SpaprDrc *drc, SpaprMachin=
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
> @@ -845,6 +847,15 @@ int spapr_rtc_import_offset(SpaprRtcState *rtc, int6=
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

You can use QEMU_BUILD_BUG_ON to ensure that the SCM block size is
aligned to the base LMB size.

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

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl447AIACgkQbDjKyiDZ
s5JOTg//YEGhKOFhKIA1d6SZaq0jaW07ZTfepYv8RNhwK3rfzvdDCLJ8dlgavIPX
jYbxechRoZOHU4/GlyYpRIPg9on7E76KrRpjHRLSzMaYYiRT9ZqJk/ee+De1Aa14
cv7ImqId9DpUO/Z0DYqPKwmfiaKAh6caJh6jpjuZ1Of3FNn4H5fClDIqcYLZF0gy
5bji7RHX6UcU+pduZ0JotrFg59UGWboBOvfK2ORYOibSeH+E6EoPOHnOZbjT7k4n
WBUhQOIc4UEFX2A0eBGmG8V/SmAD9GZK2a8Kr7UGajNx6h2G1lzcb2o5Nz+hj5Rm
tVQsjwksLWFbbNjs3TsC4JK5w7h6ew7OOv33RqdblIe6dp5mEUBXcDzxPi958SQb
myMbLlMxZr7yDKcmH5QMlpKMoeXoec81jQAJ6aQ5pVCkI3Qbww+cEdDnsqvRRBSy
RszRaRz7L1GF/MG6h+IFyZCMKj05gDg6pB1M3RPGxpe8xd2B7zlOfW1ISUMWIz+A
hNNda23tYWs5QRjpOnBLZD9auNe8vHjIwv37MRsn8cXCltUkupYn3qTRYrkeXsPW
1j5ZHE5g02XnJWCAdDFmdl5F7UlxY52DHSA5VbWFCrhszAzc3pZFUkP7iK24JFX7
RMHMtaBKowy1691k0sqrvnwJhqC+mdWDyrUmOJ8DXRxB5+InHlQ=
=LqGQ
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--

