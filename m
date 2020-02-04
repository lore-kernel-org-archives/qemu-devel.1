Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E31C3524A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 04:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9126D20732
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 04:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lWk1uHQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9126D20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iypZ7-0000BC-Ql
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 23:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iypWj-0004ac-TQ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 23:09:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iypWh-0002h0-9J
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 23:09:29 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:54361)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iypWf-0002XZ-Ib; Mon, 03 Feb 2020 23:09:27 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48BWRP6kBdz9sfF; Tue,  4 Feb 2020 15:09:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580789361;
 bh=Y+NVAaVrJhpemoX5cdDgumHUoG+9BVg+eNfN5t2i4p4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lWk1uHQjRxQ02RaIks9ASwx7/Mo1wXzLW3kzt/eo9RftsxzCiiVSfKOFF6vEuk/VQ
 jEWzEIcBXjb0NM+HV0jTggxjEU4mfPQcJFBDv2AKX6tFrQlo/czEgSEviLfj5axtuo
 I3cHBiFN44HrMlKqDU8vS9LXcyeyeA/gLgvuHdS4=
Date: Tue, 4 Feb 2020 15:09:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH v5 4/4] spapr: Add Hcalls to support PAPR NVDIMM device
Message-ID: <20200204040915.GC60221@umbus.fritz.box>
References: <158038485571.16440.14734905006978949612.stgit@lep8c.aus.stglabs.ibm.com>
 <158038490304.16440.12988347988338519913.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
In-Reply-To: <158038490304.16440.12988347988338519913.stgit@lep8c.aus.stglabs.ibm.com>
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
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com, sbhat@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2020 at 05:48:28AM -0600, Shivaprasad G Bhat wrote:
> This patch implements few of the necessary hcalls for the nvdimm support.
>=20
> PAPR semantics is such that each NVDIMM device is comprising of multiple
> SCM(Storage Class Memory) blocks. The guest requests the hypervisor to
> bind each of the SCM blocks of the NVDIMM device using hcalls. There can
> be SCM block unbind requests in case of driver errors or unplug(not
> supported now) use cases. The NVDIMM label read/writes are done through
> hcalls.
>=20
> Since each virtual NVDIMM device is divided into multiple SCM blocks,
> the bind, unbind, and queries using hcalls on those blocks can come
> independently. This doesn't fit well into the qemu device semantics,
> where the map/unmap are done at the (whole)device/object level granularit=
y.
> The patch doesnt actually bind/unbind on hcalls but let it happen at the
> device_add/del phase itself instead.
>=20
> The guest kernel makes bind/unbind requests for the virtual NVDIMM device
> at the region level granularity. Without interleaving, each virtual NVDIMM
> device is presented as a separate guest physical address range. So, there
> is no way a partial bind/unbind request can come for the vNVDIMM in a
> hcall for a subset of SCM blocks of a virtual NVDIMM. Hence it is safe to
> do bind/unbind everything during the device_add/del.
>=20
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>

LGTM, apart from some minor nits noted below.

> ---
>  hw/ppc/Makefile.objs   |    2=20
>  hw/ppc/spapr_nvdimm.c  |  327 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr.h |    8 +
>  3 files changed, 335 insertions(+), 2 deletions(-)
>  create mode 100644 hw/ppc/spapr_nvdimm.c
>=20
> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> index a4bac57be6..c3d3cc56eb 100644
> --- a/hw/ppc/Makefile.objs
> +++ b/hw/ppc/Makefile.objs
> @@ -7,7 +7,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr.o spapr_caps.o spapr_vio=
=2Eo spapr_events.o
>  obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o spapr_rtas.o
>  obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o
>  obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o spapr_irq.o
> -obj-$(CONFIG_PSERIES) +=3D spapr_tpm_proxy.o
> +obj-$(CONFIG_PSERIES) +=3D spapr_tpm_proxy.o spapr_nvdimm.o
>  obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
>  obj-$(call land,$(CONFIG_PSERIES),$(CONFIG_LINUX)) +=3D spapr_pci_vfio.o=
 spapr_pci_nvlink2.o
>  # IBM PowerNV
> diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
> new file mode 100644
> index 0000000000..8d1c2dc009
> --- /dev/null
> +++ b/hw/ppc/spapr_nvdimm.c

It'd be nice to introduce this file in the previous patch and try to
keep as much of the NVDIMM code together, rather than bloating spapr.c
even further.

> @@ -0,0 +1,327 @@
> +/*
> + * QEMU PAPR Storage Class Memory Interfaces
> + *
> + * Copyright (c) 2019-2020, IBM Corporation.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/ppc/spapr.h"
> +#include "hw/ppc/spapr_drc.h"
> +#include "hw/mem/nvdimm.h"
> +#include "qemu/range.h"
> +#include "qemu/nvdimm-utils.h"
> +
> +static target_ulong h_scm_read_metadata(PowerPCCPU *cpu,
> +                                        SpaprMachineState *spapr,
> +                                        target_ulong opcode,
> +                                        target_ulong *args)
> +{
> +    uint32_t drc_index =3D args[0];
> +    uint64_t offset =3D args[1];
> +    uint64_t numBytesToRead =3D args[2];

That's a really long name for a local.  How about just 'size' or 'len'?

> +    SpaprDrc *drc =3D spapr_drc_by_index(drc_index);
> +    NVDIMMDevice *nvdimm;
> +    NVDIMMClass *ddc;
> +    uint64_t data =3D 0;
> +    uint8_t buf[8] =3D { 0 };
> +
> +    if (!drc || !drc->dev ||
> +        spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {
> +        return H_PARAMETER;
> +    }
> +
> +    if (numBytesToRead !=3D 1 && numBytesToRead !=3D 2 &&
> +        numBytesToRead !=3D 4 && numBytesToRead !=3D 8) {
> +        return H_P3;
> +    }
> +
> +    nvdimm =3D NVDIMM(drc->dev);
> +    if ((offset + numBytesToRead < offset) ||
> +        (nvdimm->label_size < numBytesToRead + offset)) {
> +        return H_P2;
> +    }
> +
> +    ddc =3D NVDIMM_GET_CLASS(nvdimm);
> +    ddc->read_label_data(nvdimm, buf, numBytesToRead, offset);
> +
> +    switch (numBytesToRead) {
> +    case 1:
> +        data =3D ldub_p(buf);
> +        break;
> +    case 2:
> +        data =3D lduw_be_p(buf);
> +        break;
> +    case 4:
> +        data =3D ldl_be_p(buf);
> +        break;
> +    case 8:
> +        data =3D ldq_be_p(buf);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    args[0] =3D data;
> +
> +    return H_SUCCESS;
> +}
> +
> +static target_ulong h_scm_write_metadata(PowerPCCPU *cpu,
> +                                         SpaprMachineState *spapr,
> +                                         target_ulong opcode,
> +                                         target_ulong *args)
> +{
> +    uint32_t drc_index =3D args[0];
> +    uint64_t offset =3D args[1];
> +    uint64_t data =3D args[2];
> +    uint64_t numBytesToWrite =3D args[3];
> +    SpaprDrc *drc =3D spapr_drc_by_index(drc_index);
> +    NVDIMMDevice *nvdimm;
> +    NVDIMMClass *ddc;
> +    uint8_t buf[8] =3D { 0 };
> +
> +    if (!drc || !drc->dev ||
> +        spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {
> +        return H_PARAMETER;
> +    }
> +
> +    if (numBytesToWrite !=3D 1 && numBytesToWrite !=3D 2 &&
> +        numBytesToWrite !=3D 4 && numBytesToWrite !=3D 8) {
> +        return H_P4;
> +    }
> +
> +    nvdimm =3D NVDIMM(drc->dev);
> +    if ((offset + numBytesToWrite < offset) ||
> +        (nvdimm->label_size < numBytesToWrite + offset)) {
> +        return H_P2;
> +    }
> +
> +    switch (numBytesToWrite) {
> +    case 1:
> +        if (data & 0xffffffffffffff00) {
> +            return H_P2;
> +        }
> +        stb_p(buf, data);
> +        break;
> +    case 2:
> +        if (data & 0xffffffffffff0000) {
> +            return H_P2;
> +        }
> +        stw_be_p(buf, data);
> +        break;
> +    case 4:
> +        if (data & 0xffffffff00000000) {
> +            return H_P2;
> +        }
> +        stl_be_p(buf, data);
> +        break;
> +    case 8:
> +        stq_be_p(buf, data);
> +        break;
> +    default:
> +            g_assert_not_reached();
> +    }
> +
> +    ddc =3D NVDIMM_GET_CLASS(nvdimm);
> +    ddc->write_label_data(nvdimm, buf, numBytesToWrite, offset);
> +
> +    return H_SUCCESS;
> +}
> +
> +static target_ulong h_scm_bind_mem(PowerPCCPU *cpu, SpaprMachineState *s=
papr,
> +                                   target_ulong opcode, target_ulong *ar=
gs)
> +{
> +    uint32_t drc_index =3D args[0];
> +    uint64_t starting_idx =3D args[1];
> +    uint64_t no_of_scm_blocks_to_bind =3D args[2];
> +    uint64_t target_logical_mem_addr =3D args[3];
> +    uint64_t continue_token =3D args[4];
> +    uint64_t size;
> +    uint64_t total_no_of_scm_blocks;
> +    SpaprDrc *drc =3D spapr_drc_by_index(drc_index);
> +    hwaddr addr;
> +    NVDIMMDevice *nvdimm;
> +
> +    if (!drc || !drc->dev ||
> +        spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {
> +        return H_PARAMETER;
> +    }
> +
> +    /*
> +     * Currently continue token should be zero qemu has already bound
> +     * everything and this hcall doesnt return H_BUSY.
> +     */
> +    if (continue_token > 0) {
> +        return H_P5;
> +    }
> +
> +    /* Currently qemu assigns the address. */
> +    if (target_logical_mem_addr !=3D 0xffffffffffffffff) {
> +        return H_OVERLAP;
> +    }
> +
> +    nvdimm =3D NVDIMM(drc->dev);
> +
> +    size =3D object_property_get_uint(OBJECT(nvdimm),
> +                                    PC_DIMM_SIZE_PROP, &error_abort);
> +
> +    total_no_of_scm_blocks =3D size / SPAPR_MINIMUM_SCM_BLOCK_SIZE;
> +
> +    if (starting_idx > total_no_of_scm_blocks) {
> +        return H_P2;
> +    }
> +
> +    if (((starting_idx + no_of_scm_blocks_to_bind) < starting_idx) ||
> +        ((starting_idx + no_of_scm_blocks_to_bind) > total_no_of_scm_blo=
cks)) {
> +        return H_P3;
> +    }
> +
> +    addr =3D object_property_get_uint(OBJECT(nvdimm),
> +                                    PC_DIMM_ADDR_PROP, &error_abort);
> +
> +    addr +=3D starting_idx * SPAPR_MINIMUM_SCM_BLOCK_SIZE;
> +
> +    /* Already bound, Return target logical address in R5 */
> +    args[1] =3D addr;
> +    args[2] =3D no_of_scm_blocks_to_bind;
> +
> +    return H_SUCCESS;
> +}
> +
> +static target_ulong h_scm_unbind_mem(PowerPCCPU *cpu, SpaprMachineState =
*spapr,
> +                                     target_ulong opcode, target_ulong *=
args)
> +{
> +    uint32_t drc_index =3D args[0];
> +    uint64_t starting_scm_logical_addr =3D args[1];
> +    uint64_t no_of_scm_blocks_to_unbind =3D args[2];
> +    uint64_t continue_token =3D args[3];
> +    uint64_t size_to_unbind;
> +    Range blockrange =3D range_empty;
> +    Range nvdimmrange =3D range_empty;
> +    SpaprDrc *drc =3D spapr_drc_by_index(drc_index);
> +    NVDIMMDevice *nvdimm;
> +    uint64_t size, addr;
> +
> +    if (!drc || !drc->dev ||
> +        spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {
> +        return H_PARAMETER;
> +    }
> +
> +    /* continue_token should be zero as this hcall doesn't return H_BUSY=
=2E */
> +    if (continue_token > 0) {
> +        return H_P4;
> +    }
> +
> +    /* Check if starting_scm_logical_addr is block aligned */
> +    if (!QEMU_IS_ALIGNED(starting_scm_logical_addr,
> +                         SPAPR_MINIMUM_SCM_BLOCK_SIZE)) {
> +        return H_P2;
> +    }
> +
> +    size_to_unbind =3D no_of_scm_blocks_to_unbind * SPAPR_MINIMUM_SCM_BL=
OCK_SIZE;
> +    if (no_of_scm_blocks_to_unbind =3D=3D 0 || no_of_scm_blocks_to_unbin=
d !=3D
> +                               size_to_unbind / SPAPR_MINIMUM_SCM_BLOCK_=
SIZE) {
> +        return H_P3;
> +    }
> +
> +    nvdimm =3D NVDIMM(drc->dev);
> +    size =3D object_property_get_int(OBJECT(nvdimm), PC_DIMM_SIZE_PROP,
> +                                   &error_abort);
> +    addr =3D object_property_get_int(OBJECT(nvdimm), PC_DIMM_ADDR_PROP,
> +                                   &error_abort);
> +
> +    range_init_nofail(&nvdimmrange, addr, size);
> +    range_init_nofail(&blockrange, starting_scm_logical_addr, size_to_un=
bind);
> +
> +    if (!range_contains_range(&nvdimmrange, &blockrange)) {
> +        return H_P3;
> +    }
> +
> +    args[1] =3D no_of_scm_blocks_to_unbind;
> +
> +    /* let unplug take care of actual unbind */
> +    return H_SUCCESS;
> +}
> +
> +#define H_UNBIND_SCOPE_ALL 0x1
> +#define H_UNBIND_SCOPE_DRC 0x2
> +
> +static target_ulong h_scm_unbind_all(PowerPCCPU *cpu, SpaprMachineState =
*spapr,
> +                                     target_ulong opcode, target_ulong *=
args)
> +{
> +    uint64_t target_scope =3D args[0];
> +    uint32_t drc_index =3D args[1];
> +    uint64_t continue_token =3D args[2];
> +    NVDIMMDevice *nvdimm;
> +    uint64_t size;
> +    uint64_t no_of_scm_blocks_unbound =3D 0;
> +
> +    /* continue_token should be zero as this hcall doesn't return H_BUSY=
=2E */
> +    if (continue_token > 0) {
> +        return H_P4;
> +    }
> +
> +    if (target_scope =3D=3D H_UNBIND_SCOPE_DRC) {
> +        SpaprDrc *drc =3D spapr_drc_by_index(drc_index);
> +
> +        if (!drc || !drc->dev ||
> +            spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {
> +            return H_P2;
> +        }
> +
> +        nvdimm =3D NVDIMM(drc->dev);
> +        size =3D object_property_get_int(OBJECT(nvdimm), PC_DIMM_SIZE_PR=
OP,
> +                                       &error_abort);
> +
> +        no_of_scm_blocks_unbound =3D size / SPAPR_MINIMUM_SCM_BLOCK_SIZE;
> +    } else if (target_scope =3D=3D  H_UNBIND_SCOPE_ALL) {
> +        GSList *list, *nvdimms;
> +
> +        nvdimms =3D nvdimm_get_device_list();
> +        for (list =3D nvdimms; list; list =3D list->next) {
> +            nvdimm =3D list->data;
> +            size =3D object_property_get_int(OBJECT(nvdimm), PC_DIMM_SIZ=
E_PROP,
> +                                           &error_abort);
> +
> +            no_of_scm_blocks_unbound +=3D size / SPAPR_MINIMUM_SCM_BLOCK=
_SIZE;
> +        }
> +        g_slist_free(nvdimms);
> +    } else {
> +        return H_PARAMETER;
> +    }
> +
> +    args[1] =3D no_of_scm_blocks_unbound;
> +
> +    /* let unplug take care of actual unbind */
> +    return H_SUCCESS;
> +}
> +
> +static void spapr_scm_register_types(void)
> +{
> +    /* qemu/scm specific hcalls */
> +    spapr_register_hypercall(H_SCM_READ_METADATA, h_scm_read_metadata);
> +    spapr_register_hypercall(H_SCM_WRITE_METADATA, h_scm_write_metadata);
> +    spapr_register_hypercall(H_SCM_BIND_MEM, h_scm_bind_mem);
> +    spapr_register_hypercall(H_SCM_UNBIND_MEM, h_scm_unbind_mem);
> +    spapr_register_hypercall(H_SCM_UNBIND_ALL, h_scm_unbind_all);
> +}
> +
> +type_init(spapr_scm_register_types)
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index ed2de4bae5..633ff5202b 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -287,6 +287,7 @@ struct SpaprMachineState {
>  #define H_P7              -60
>  #define H_P8              -61
>  #define H_P9              -62
> +#define H_OVERLAP         -68
>  #define H_UNSUPPORTED_FLAG -256
>  #define H_MULTI_THREADS_ACTIVE -9005
> =20
> @@ -494,8 +495,13 @@ struct SpaprMachineState {
>  #define H_INT_ESB               0x3C8
>  #define H_INT_SYNC              0x3CC
>  #define H_INT_RESET             0x3D0
> +#define H_SCM_READ_METADATA     0x3E4
> +#define H_SCM_WRITE_METADATA    0x3E8
> +#define H_SCM_BIND_MEM          0x3EC
> +#define H_SCM_UNBIND_MEM        0x3F0
> +#define H_SCM_UNBIND_ALL        0x3FC
> =20
> -#define MAX_HCALL_OPCODE        H_INT_RESET
> +#define MAX_HCALL_OPCODE        H_SCM_UNBIND_ALL
> =20
>  /* The hcalls above are standardized in PAPR and implemented by pHyp
>   * as well.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl447mgACgkQbDjKyiDZ
s5LbvBAAmj++lHWBsPVQts81KQSH3JHj7nMmgwKmS7Y5P98vjsMVwdjB6OTbHO79
rxPEisGNd3YcqNHYEshT1HhXH+WJ1ookt/K0Fjql2v+ovy7LIYqe+wx8loOiTSQ+
PkXraWFf6H2lf/hsR2qm/sb6kwA1NNv6cUQ3vypHOzSo+GgXijVHL9D/sdYC6wkF
SJYNFOpwl7rE65Ii3DN7H7Du/aCh6vyd/1mn1cMQLFB7uGfmB72LQH39sC+MAHQM
VmqSy7+lQHl85JGM83XGC7MqBOvr52/m+B+jSE59v4yxyvZu2uQHfyu4bDr1jm24
TN5v7E36iGK+96Xtuo52dr97ujAwCMQrQoH/MME9LZtWnkn8xbxgNN2+1MI+qA8H
Q4EnR0ztkFNQl7fOHodOzD7uEf4u0LgNhUnZQfweEKiQ1UZlg0VJT/MvkFlxaRWz
Qso1y47zlvejSn9FYpffNPSlHbTt6K9Djqo0+CmSvl2EGyON//o8I4XldQGr3oUD
yGcm0K6BQgy8VHrlJ5qGPPaW49WZnKVLLiDiOV7fCdSpEAbccMYDzIp9xJgNAQWO
Y3/4iV41TX8LejfnhiWHByFSTqQ+xfrqfXCbliQMtcFIKGW7TudbBN/y72T/Fwhr
jF8UG6leG34CBh7zV/hi3wst5c1VKmBGid+V2J68+SQnCTRlv/E=
=xqJ8
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--

