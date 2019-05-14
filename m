Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA15C04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 02:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3AE208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 02:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KxcsZCuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3AE208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37930 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQN8d-0004JT-RB
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 22:25:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQN7X-0003iB-8Y
	for qemu-devel@nongnu.org; Mon, 13 May 2019 22:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQN7R-0002fG-0I
	for qemu-devel@nongnu.org; Mon, 13 May 2019 22:24:47 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:49367)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hQN7N-0001wL-I6; Mon, 13 May 2019 22:24:40 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4531hr4LdWz9sBV; Tue, 14 May 2019 12:24:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557800652;
	bh=imWuJQFuF+L+ZjdpIR6EOmVb9ivkq8MZ3TPPnBdZSdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KxcsZCuNQ2tc3ZtmgpMCOe2W7FCSv6t8y/FtFBmEvNYZ/G6IS+vjgZMLJ7PFWZ6NE
	KwhNvGGYuX8WiuuFIetlLLRPmLGsBYkBCKnqz7b5KZLT8VAD+5Tp0CXsHzpCaGji/Y
	QplmCwmnjZAgHBzMwTgmRddVrJp+z5n+POT10zVQ=
Date: Tue, 14 May 2019 12:22:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID: <20190514022254.GF6441@umbus.fritz.box>
References: <155773946961.49142.5208084426066783536.stgit@lep8c.aus.stglabs.ibm.com>
	<155773963257.49142.17067912880307967487.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FEz7ebHBGB6b2e8X"
Content-Disposition: inline
In-Reply-To: <155773963257.49142.17067912880307967487.stgit@lep8c.aus.stglabs.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [RFC v2 PATCH 2/3] spapr: Add NVDIMM device support
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
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, qemu-ppc@nongnu.org,
	xiaoguangrong.eric@gmail.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2019 at 04:28:02AM -0500, Shivaprasad G Bhat wrote:
> Add support for NVDIMM devices for sPAPR. Piggyback on existing nvdimm
> device interface in QEMU to support virtual NVDIMM devices for Power (May=
 have
> to re-look at this later).  Create the required DT entries for the
> device (some entries have dummy values right now).
>=20
> The patch creates the required DT node and sends a hotplug
> interrupt to the guest. Guest is expected to undertake the normal
> DR resource add path in response and start issuing PAPR SCM hcalls.
>=20
> This is how it can be used ..
> Add nvdimm=3Don to the qemu machine argument.
> Ex : -machine pseries,nvdimm=3Don
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
> ---
>  default-configs/ppc64-softmmu.mak |    1=20
>  hw/mem/Kconfig                    |    2=20
>  hw/mem/nvdimm.c                   |   43 ++++++++
>  hw/ppc/spapr.c                    |  202 +++++++++++++++++++++++++++++++=
++++--
>  hw/ppc/spapr_drc.c                |   18 +++
>  hw/ppc/spapr_events.c             |    4 +
>  include/hw/mem/nvdimm.h           |    6 +
>  include/hw/ppc/spapr.h            |   12 ++
>  include/hw/ppc/spapr_drc.h        |    9 ++
>  9 files changed, 286 insertions(+), 11 deletions(-)
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
> index f221ec7a9a..deaebaaaa5 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -93,11 +93,54 @@ out:
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
> +    if (strcmp(value, "") =3D=3D 0) {
> +        error_setg(&local_err, "Property '%s.%s' %s is required"
> +                   " at least 0x%lx", object_get_typename(obj),
> +                   name, value, MIN_NAMESPACE_LABEL_SIZE);
> +        goto out;
> +    }
> +
> +    if (qemu_uuid_parse(value, &nvdimm->uuid) !=3D 0) {
> +        error_setg(errp, "Invalid UUID");
> +        return;
> +    }
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
>  }
> =20
>  static void nvdimm_finalize(Object *obj)
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2ef3ce4362..b6951577e7 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -74,6 +74,7 @@
>  #include "qemu/cutils.h"
>  #include "hw/ppc/spapr_cpu_core.h"
>  #include "hw/mem/memory-device.h"
> +#include "hw/mem/nvdimm.h"
> =20
>  #include <libfdt.h>
> =20
> @@ -699,6 +700,7 @@ static int spapr_populate_drmem_v2(SpaprMachineState =
*spapr, void *fdt,
>      uint8_t *int_buf, *cur_index;
>      int ret;
>      uint64_t lmb_size =3D SPAPR_MEMORY_BLOCK_SIZE;
> +    uint64_t scm_block_size =3D SPAPR_MINIMUM_SCM_BLOCK_SIZE;
>      uint64_t addr, cur_addr, size;
>      uint32_t nr_boot_lmbs =3D (machine->device_memory->base / lmb_size);
>      uint64_t mem_end =3D machine->device_memory->base +
> @@ -735,12 +737,20 @@ static int spapr_populate_drmem_v2(SpaprMachineStat=
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
> +        if (info->value->type =3D=3D MEMORY_DEVICE_INFO_KIND_NVDIMM) {
> +            /* Entry for NVDIMM */
> +            drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM, addr / scm_bloc=
k_size);
> +            g_assert(drc);
> +            elem =3D spapr_get_drconf_cell(size / scm_block_size, addr,
> +                                         spapr_drc_index(drc), -1, 0);
> +        } else {
> +            /* Entry for DIMM */
> +            drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, addr / lmb_size);
> +            g_assert(drc);
> +            elem =3D spapr_get_drconf_cell(size / lmb_size, addr,
> +                                         spapr_drc_index(drc), node,
> +                                         SPAPR_LMB_FLAGS_ASSIGNED);
> +        }
>          QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
>          nr_entries++;
>          cur_addr =3D addr + size;
> @@ -1235,6 +1245,87 @@ static void spapr_dt_hypervisor(SpaprMachineState =
*spapr, void *fdt)
>      }
>  }
> =20
> +static int spapr_populate_nvdimm_node(void *fdt, int parent_offset,
> +                                      NVDIMMDevice *nvdimm)

spapr_dt_*() is the new preferred naming convention for DT creation
functions.

> +{
> +    int child_offset;
> +    char buf[40];
> +    SpaprDrc *drc;
> +    uint32_t drc_idx;
> +    uint32_t node =3D object_property_get_uint(OBJECT(nvdimm), PC_DIMM_N=
ODE_PROP,
> +                                             &error_abort);
> +    uint64_t addr =3D object_property_get_uint(OBJECT(nvdimm), PC_DIMM_A=
DDR_PROP,
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
> +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM,
> +                          addr / SPAPR_MINIMUM_SCM_BLOCK_SIZE);
> +    g_assert(drc);
> +
> +    drc_idx =3D spapr_drc_index(drc);
> +
> +    sprintf(buf, "pmem@%x", drc_idx);

This doesn't look right.  According to the PAPR fragment I have, the
name is supposed to be "ibm,pmemory" and the reg is supposed to be
(addr, size) pairs, not DRC indices.

Or do I have an out of date document?

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
> +    /*NB : What it should be? */

If you don't have a good value, can you just leave it out?

> +    _FDT(fdt_setprop_cell(fdt, child_offset, "ibm,latency-attribute", 82=
8));
> +
> +    _FDT((fdt_setprop_u64(fdt, child_offset, "ibm,block-size",
> +                          SPAPR_MINIMUM_SCM_BLOCK_SIZE)));
> +    _FDT((fdt_setprop_u64(fdt, child_offset, "ibm,number-of-blocks",
> +                          size / SPAPR_MINIMUM_SCM_BLOCK_SIZE)));
> +    _FDT((fdt_setprop_cell(fdt, child_offset, "ibm,metadata-size", lsize=
)));
> +
> +    return child_offset;
> +}
> +
> +static void spapr_dt_nvdimm(void *fdt)

I'd suggest spapr_dt_nvdimms() or spapr_dt_persistent_memory(), with
spapr_dt_nvdimm() for the single-NVDIMM functions earlier.

> +{
> +    int offset =3D fdt_subnode_offset(fdt, 0, "persistent-memory");
> +    GSList *dimms =3D NULL;
> +
> +    if (offset < 0) {
> +        offset =3D fdt_add_subnode(fdt, 0, "persistent-memory");
> +        _FDT(offset);
> +        _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 0x2)));

Hmm.  So the docuiment I have specifies #address-cells =3D 1 here, but
that doesn't make sense with the reg format it specifies for the
children.  So *something* is screwy.  Is there an up to date PAPR
specification for persistent memory I can get?

> +        _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 0x0)));
> +        _FDT((fdt_setprop_string(fdt, offset, "device_type",
> +                                 "ibm,persistent-memory")));
> +    }
> +
> +    /*NB : Add drc-info array here */
> +
> +    /* Create DT entries for cold plugged NVDIMM devices */
> +    dimms =3D nvdimm_get_device_list();
> +    for (; dimms; dimms =3D dimms->next) {
> +        NVDIMMDevice *nvdimm =3D dimms->data;
> +
> +        spapr_populate_nvdimm_node(fdt, offset, nvdimm);
> +    }
> +    g_slist_free(dimms);
> +    return;
> +}
> +
>  static void *spapr_build_fdt(SpaprMachineState *spapr)
>  {
>      MachineState *machine =3D MACHINE(spapr);
> @@ -1368,6 +1459,11 @@ static void *spapr_build_fdt(SpaprMachineState *sp=
apr)
>          }
>      }
> =20
> +    /* NVDIMM devices */
> +    if (spapr->nvdimm_enabled) {
> +        spapr_dt_nvdimm(fdt);
> +    }
> +
>      return fdt;
>  }
> =20
> @@ -3324,6 +3420,20 @@ static void spapr_set_host_serial(Object *obj, con=
st char *value, Error **errp)
>      spapr->host_serial =3D g_strdup(value);
>  }
> =20
> +static bool spapr_get_nvdimm(Object *obj, Error **errp)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> +
> +    return spapr->nvdimm_enabled;
> +}
> +
> +static void spapr_set_nvdimm(Object *obj, bool value, Error **errp)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> +
> +    spapr->nvdimm_enabled =3D value;
> +}
> +
>  static void spapr_instance_init(Object *obj)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> @@ -3380,6 +3490,12 @@ static void spapr_instance_init(Object *obj)
>          &error_abort);
>      object_property_set_description(obj, "host-serial",
>          "Host serial number to advertise in guest device tree", &error_a=
bort);
> +
> +    object_property_add_bool(obj, "nvdimm",
> +                            spapr_get_nvdimm, spapr_set_nvdimm, NULL);

Is there actually a reason to have a property for this, rather than
just always having it on?

> +    object_property_set_description(obj, "nvdimm",
> +                                    "Enable support for nvdimm devices",
> +                                    NULL);
>  }
> =20
>  static void spapr_machine_finalizefn(Object *obj)
> @@ -3404,6 +3520,16 @@ static void spapr_nmi(NMIState *n, int cpu_index, =
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
> +    *fdt_start_offset =3D spapr_populate_nvdimm_node(fdt, 0, nvdimm);
> +
> +    return 0;
> +}
> +
>  int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
>                            void *fdt, int *fdt_start_offset, Error **errp)
>  {
> @@ -3466,12 +3592,37 @@ static void spapr_add_lmbs(DeviceState *dev, uint=
64_t addr_start, uint64_t size,
>      }
>  }
> =20
> +static void spapr_add_nvdimm(DeviceState *dev, uint64_t addr, Error **er=
rp)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_hotplug_handler(=
dev));
> +    SpaprDrc *drc;
> +    bool hotplugged =3D spapr_drc_hotplugged(dev);
> +    Error *local_err =3D NULL;
> +
> +    spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM,
> +                           addr / SPAPR_MINIMUM_SCM_BLOCK_SIZE);

This still seems bogus to me.  The whole point of DRCs is that they
exist *before* the device is plugged as a handle for the guest side
plug mechanisms.  Creating them only when the device is added doesn't
make sense.

> +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM,
> +                          addr / SPAPR_MINIMUM_SCM_BLOCK_SIZE);
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
> +    bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>      uint64_t size, addr;
> =20
>      size =3D memory_device_get_region_size(MEMORY_DEVICE(dev), &error_ab=
ort);
> @@ -3487,8 +3638,14 @@ static void spapr_memory_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>          goto out_unplug;
>      }
> =20
> -    spapr_add_lmbs(dev, addr, size, spapr_ovec_test(ms->ov5_cas, OV5_HP_=
EVT),
> -                   &local_err);
> +    if (!is_nvdimm) {
> +        spapr_add_lmbs(dev, addr, size,
> +                       spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
> +                       &local_err);
> +    } else {
> +        spapr_add_nvdimm(dev, addr, &local_err);
> +    }
> +
>      if (local_err) {
>          goto out_unplug;
>      }
> @@ -3506,6 +3663,7 @@ static void spapr_memory_pre_plug(HotplugHandler *h=
otplug_dev, DeviceState *dev,
>  {
>      const SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(hotplug_dev=
);
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(hotplug_dev);
> +    bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
>      Error *local_err =3D NULL;
>      uint64_t size;
> @@ -3523,10 +3681,28 @@ static void spapr_memory_pre_plug(HotplugHandler =
*hotplug_dev, DeviceState *dev,
>          return;
>      }
> =20
> -    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
> +    if (!is_nvdimm && size % SPAPR_MEMORY_BLOCK_SIZE) {
>          error_setg(errp, "Hotplugged memory size must be a multiple of "
> -                      "%" PRIu64 " MB", SPAPR_MEMORY_BLOCK_SIZE / MiB);
> +                          "%" PRIu64 " MB", SPAPR_MEMORY_BLOCK_SIZE / Mi=
B);
>          return;
> +    } else if (is_nvdimm) {
> +        char *uuidstr =3D NULL;
> +        QemuUUID uuid;
> +        if (size % SPAPR_MINIMUM_SCM_BLOCK_SIZE) {
> +            error_setg(errp, "NVDIMM memory size excluding the label are=
a"

Is this reference to the label area still accurate?

> +                       " must be a multiple of "
> +                       "%" PRIu64 "MB",
> +                       SPAPR_MINIMUM_SCM_BLOCK_SIZE / MiB);
> +            return;
> +        }
> +
> +        uuidstr =3D object_property_get_str(OBJECT(dimm), NVDIMM_UUID_PR=
OP, NULL);
> +        qemu_uuid_parse(uuidstr, &uuid);
> +        if (qemu_uuid_is_null(&uuid)) {
> +            error_setg(errp, "NVDIMM device requires the uuid to be set"=
);
> +            return;
> +        }
> +        g_free(uuidstr);
>      }
> =20
>      memdev =3D object_property_get_link(OBJECT(dimm), PC_DIMM_MEMDEV_PRO=
P,
> @@ -3666,6 +3842,12 @@ static void spapr_memory_unplug_request(HotplugHan=
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
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 597f236b9c..983440a711 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -707,6 +707,17 @@ static void spapr_drc_phb_class_init(ObjectClass *k,=
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
> +    drck->drc_name_prefix =3D "PMEM ";
> +    drck->release =3D NULL;
> +    drck->dt_populate =3D spapr_pmem_dt_populate;
> +}
> +
>  static const TypeInfo spapr_dr_connector_info =3D {
>      .name          =3D TYPE_SPAPR_DR_CONNECTOR,
>      .parent        =3D TYPE_DEVICE,
> @@ -757,6 +768,12 @@ static const TypeInfo spapr_drc_phb_info =3D {
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
> @@ -1226,6 +1243,7 @@ static void spapr_drc_register_types(void)
>      type_register_static(&spapr_drc_pci_info);
>      type_register_static(&spapr_drc_lmb_info);
>      type_register_static(&spapr_drc_phb_info);
> +    type_register_static(&spapr_drc_pmem_info);
> =20
>      spapr_rtas_register(RTAS_SET_INDICATOR, "set-indicator",
>                          rtas_set_indicator);
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index ae0f093f59..1141203a87 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -193,6 +193,7 @@ struct rtas_event_log_v6_hp {
>  #define RTAS_LOG_V6_HP_TYPE_SLOT                         3
>  #define RTAS_LOG_V6_HP_TYPE_PHB                          4
>  #define RTAS_LOG_V6_HP_TYPE_PCI                          5
> +#define RTAS_LOG_V6_HP_TYPE_PMEM                         6
>      uint8_t hotplug_action;
>  #define RTAS_LOG_V6_HP_ACTION_ADD                        1
>  #define RTAS_LOG_V6_HP_ACTION_REMOVE                     2
> @@ -529,6 +530,9 @@ static void spapr_hotplug_req_event(uint8_t hp_id, ui=
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
> index bad4fc04b5..3089615e17 100644
> --- a/include/hw/mem/nvdimm.h
> +++ b/include/hw/mem/nvdimm.h
> @@ -49,6 +49,7 @@
>                                                 TYPE_NVDIMM)
> =20
>  #define NVDIMM_LABEL_SIZE_PROP "label-size"
> +#define NVDIMM_UUID_PROP "uuid"
>  #define NVDIMM_UNARMED_PROP    "unarmed"
> =20
>  struct NVDIMMDevice {
> @@ -83,6 +84,11 @@ struct NVDIMMDevice {
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
> index 7e32f309c2..394ea26335 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -202,6 +202,7 @@ struct SpaprMachineState {
>      SpaprCapabilities def, eff, mig;
> =20
>      unsigned gpu_numa_id;
> +    bool nvdimm_enabled;
>  };
> =20
>  #define H_SUCCESS         0
> @@ -794,6 +795,8 @@ int spapr_core_dt_populate(SpaprDrc *drc, SpaprMachin=
eState *spapr,
>  void spapr_lmb_release(DeviceState *dev);
>  int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
>                            void *fdt, int *fdt_start_offset, Error **errp=
);
> +int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
> +                          void *fdt, int *fdt_start_offset, Error **errp=
);
>  void spapr_phb_release(DeviceState *dev);
>  int spapr_phb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
>                            void *fdt, int *fdt_start_offset, Error **errp=
);
> @@ -829,6 +832,15 @@ int spapr_rtc_import_offset(SpaprRtcState *rtc, int6=
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
> index fad0a887f9..8b7ce41a0f 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -79,6 +79,13 @@
>  #define SPAPR_DRC_PHB(obj) OBJECT_CHECK(SpaprDrc, (obj), \
>                                          TYPE_SPAPR_DRC_PHB)
> =20
> +#define TYPE_SPAPR_DRC_PMEM "spapr-drc-pmem"
> +#define SPAPR_DRC_PMEM_GET_CLASS(obj) \
> +        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_PMEM)
> +#define SPAPR_DRC_PMEM_CLASS(klass) \
> +        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, TYPE_SPAPR_DRC_PMEM)
> +#define SPAPR_DRC_PMEM(obj) OBJECT_CHECK(SpaprDrc, (obj), \
> +                                        TYPE_SPAPR_DRC_PMEM)
>  /*
>   * Various hotplug types managed by SpaprDrc
>   *
> @@ -96,6 +103,7 @@ typedef enum {
>      SPAPR_DR_CONNECTOR_TYPE_SHIFT_VIO =3D 3,
>      SPAPR_DR_CONNECTOR_TYPE_SHIFT_PCI =3D 4,
>      SPAPR_DR_CONNECTOR_TYPE_SHIFT_LMB =3D 8,
> +    SPAPR_DR_CONNECTOR_TYPE_SHIFT_PMEM =3D 9,
>  } SpaprDrcTypeShift;
> =20
>  typedef enum {
> @@ -105,6 +113,7 @@ typedef enum {
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

--FEz7ebHBGB6b2e8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzaJnsACgkQbDjKyiDZ
s5JSLg/9FLUqQjoSlWgVtqNGee+FIB2iPJw0Sp9Bom8q2J5FAZsX4TfZVHB8zesR
pRNxRp8Ve9By8jORrfqgtUtlO2u+xrerr5zGZ+2SAY03CLHmgKSAVWb/OLFgpm7K
vG5LL0a//59DesJoJa7UUyDNMWJqTTPQ9uNlsLK90ZXeHgaW+6UbmercbCiVWHE8
QO9BoLViT/sYgzXoj+m7KtpjYe2gvZ2+KWMz6Wue2BEfbyjIz4fNdX4xBPuJeFxm
Bp7u632ksgW7F+m5pZiP7tcgk2H6q53ddVOluCSIC1m6Sd+cGUSWwODRSELhM5lp
H/Ewg7mtq2ixj+rS1FDuTFGdLgUjqovgZD+LMtY1lNi0BNLIJ8dfQb4PCoV4v1dQ
j4p5yFAK4FSu/3yROhfXvFhgiEWczJNtFzSq103XwJ5CwW00/BcFOg9hOOdWi8wm
lFtRjJMJBxTBK8L1RaX+AOoTs7NpwKD9V2m/Njjk1O6Dt0y3Lf208/tupr/5JHld
be5MRS5p9RdNaCioUfQDLJJfmwgOgs2i+yIbd+FhSp7THw4GWRYTndv7jXf/LnLp
Ph8XbJVwEtftQ7RtzuuqseaILte0ARW5TlIQFtGgAQ26BUg4qCBWzgbRSAaDxiaN
qb/DCLy3XAWDfacht1hn+JBjd0ZLmz42kleRPBZe3P+/5SiPdpE=
=zt61
-----END PGP SIGNATURE-----

--FEz7ebHBGB6b2e8X--

