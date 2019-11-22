Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28F9C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 05:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBC82068E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 05:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mO1zrHJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBC82068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY1FD-0000kO-PP
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 00:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iY1EG-0007qP-TO
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 00:11:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iY1EE-0000E7-4H
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 00:11:36 -0500
Received: from ozlabs.org ([203.11.71.1]:36807)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iY1EC-0000C9-Oi; Fri, 22 Nov 2019 00:11:34 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47K4KD2KQlz9sPW; Fri, 22 Nov 2019 16:11:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574399488;
 bh=7nbw3Fg2W3BNj4HkQ9b6L+Zur0Ay54EiQzGe8eEMzME=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mO1zrHJ4clCB8pG3VfPNKzkqInG6aAL7vlDylQ8JWj8v/x490InvHIweaD4HsTcKq
 8LYFo6PoflsIA1et9q+sBteViR0ZofIfjEi8eM5/DAl+k7l9x7quk1h754TDn1ZrXt
 TTjjhpJD0z2wsAstMgkDF66PxVMTsC7QSFwwYWAo=
Date: Fri, 22 Nov 2019 16:11:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] spapr: Add Hcalls to support PAPR NVDIMM device
Message-ID: <20191122051121.GE5582@umbus.fritz.box>
References: <157107820388.27733.3565652855304038259.stgit@lep8c.aus.stglabs.ibm.com>
 <157107827730.27733.6442960086351627702.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iVEfEdCR/dAw5FFN"
Content-Disposition: inline
In-Reply-To: <157107827730.27733.6442960086351627702.stgit@lep8c.aus.stglabs.ibm.com>
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


--iVEfEdCR/dAw5FFN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2019 at 01:38:16PM -0500, Shivaprasad G Bhat wrote:
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

It's not clear to me what a "region" means in this context.

> device is presented as separate region. There is no way to configure the
> virtual NVDIMM interleaving for the guests today. So, there is no way a
> partial bind/unbind request can come for the vNVDIMM in a hcall for a
> subset of SCM blocks of a virtual NVDIMM. Hence it is safe to do
> bind/unbind everything during the device_add/del.
>=20
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
> ---
>  hw/ppc/spapr_hcall.c   |  300 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr.h |    8 +
>  2 files changed, 307 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 23e4bdb829..4e9ad96f7c 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c

This is large enough and sufficiently non-core that I'd suggest
putting it in its own file.

> @@ -18,6 +18,10 @@
>  #include "hw/ppc/spapr_ovec.h"
>  #include "mmu-book3s-v3.h"
>  #include "hw/mem/memory-device.h"
> +#include "hw/ppc/spapr_drc.h"
> +#include "hw/mem/nvdimm.h"
> +#include "qemu/range.h"
> +#include "qemu/nvdimm-utils.h"
> =20
>  static bool has_spr(PowerPCCPU *cpu, int spr)
>  {
> @@ -1961,6 +1965,295 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, =
SpaprMachineState *spapr,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong h_scm_read_metadata(PowerPCCPU *cpu,
> +                                        SpaprMachineState *spapr,
> +                                        target_ulong opcode,
> +                                        target_ulong *args)
> +{
> +    uint32_t drc_index =3D args[0];
> +    uint64_t offset =3D args[1];
> +    uint64_t numBytesToRead =3D args[2];
> +    SpaprDrc *drc =3D spapr_drc_by_index(drc_index);
> +    NVDIMMDevice *nvdimm;
> +    NVDIMMClass *ddc;
> +    __be64 data_be =3D 0;
> +    uint64_t data =3D 0;
> +
> +    if (drc && spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {

I'm pretty sure you want if (!drc || ... ) here.  Otherwise if the
given index is totally bogus you'll crash a few lines down.

> +        return H_PARAMETER;
> +    }
> +
> +    if (numBytesToRead !=3D 1 && numBytesToRead !=3D 2 &&
> +        numBytesToRead !=3D 4 && numBytesToRead !=3D 8) {
> +        return H_P3;
> +    }
> +
> +    nvdimm =3D NVDIMM(drc->dev);

What if the drc slot is not plugged at present (so drc->dev is NULL)?

> +    if ((offset + numBytesToRead < offset) ||
> +        (nvdimm->label_size < numBytesToRead + offset)) {
> +        return H_P2;
> +    }
> +
> +    ddc =3D NVDIMM_GET_CLASS(nvdimm);
> +    ddc->read_label_data(nvdimm, &data_be, numBytesToRead, offset);
> +
> +    switch (numBytesToRead) {
> +    case 1:
> +        data =3D data_be & 0xff;

The read_label_data above is only filling in the first byte of
data_be.  That only corresponds to data_be & 0xff if the host is
little endian which you shouldn't rely on.

Also, I'm not sure in what sense "data_be" is big-endian as the name
suggests.  AFAICT the label data is a byte-addressable array, which
means it doesn't really have an endianness.

I think what you're trying to do here is put the 0th byte of label
into the LSB of the return value ... the 7th byte of label data into
the MSB of the return value.

=46rom the point of view of the 64-bit value you're returning in a
register, that makes the label data effectively *LE* (LSB first), not
BE.  Since you're initializing data_be to 0, you can just load into it
and le64_to_cpu() without reference to numBytesToRead to accomplish
this.

> +        break;
> +    case 2:
> +        data =3D be16_to_cpu(data_be & 0xffff);
> +        break;
> +    case 4:
> +        data =3D be32_to_cpu(data_be & 0xffffffff);
> +        break;
> +    case 8:
> +        data =3D be64_to_cpu(data_be);
> +        break;
> +    default:
> +        break;
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
> +    DeviceState *dev;
> +    NVDIMMClass *ddc;
> +    __be64 data_be =3D 0;
> +
> +    if (drc && spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {

Same error for !drc as noted above.

> +        return H_PARAMETER;
> +    }
> +
> +    if (numBytesToWrite !=3D 1 && numBytesToWrite !=3D 2 &&
> +        numBytesToWrite !=3D 4 && numBytesToWrite !=3D 8) {
> +        return H_P4;
> +    }
> +
> +    dev =3D drc->dev;
> +    nvdimm =3D NVDIMM(dev);
> +
> +    switch (numBytesToWrite) {
> +    case 1:
> +        if (data & 0xffffffffffffff00) {
> +            return H_P2;
> +        }
> +        data_be =3D data & 0xff;
> +        break;
> +    case 2:
> +        if (data & 0xffffffffffff0000) {
> +            return H_P2;
> +        }
> +        data_be =3D cpu_to_be16(data & 0xffff);
> +        break;
> +    case 4:
> +        if (data & 0xffffffff00000000) {
> +            return H_P2;
> +        }
> +        data_be =3D cpu_to_be32(data & 0xffffffff);
> +        break;
> +    case 8:
> +        data_be =3D cpu_to_be64(data);
> +        break;
> +    default: /* lint */
> +            break;
> +    }

Euch, you can definitely find a less repetitive way to make these
checks than a big switch.  Also in mirror to the read function, AFAICT
what you actually want here is a cpu_to_le64().

> +
> +    ddc =3D NVDIMM_GET_CLASS(nvdimm);
> +    ddc->write_label_data(nvdimm, &data_be, numBytesToWrite, offset);
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
> +    DeviceState *dev;
> +    PCDIMMDevice *dimm;
> +    Error *local_err =3D NULL;
> +
> +    if (drc && spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {

Check !drc case again.

> +        return H_PARAMETER;
> +    }
> +
> +    dev =3D drc->dev;

And the !drc->dev case.

> +    dimm =3D PC_DIMM(dev);
> +
> +    size =3D object_property_get_uint(OBJECT(dimm),
> +                                    PC_DIMM_SIZE_PROP, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        return H_PARAMETER;
> +    }
> +
> +    total_no_of_scm_blocks =3D size / SPAPR_MINIMUM_SCM_BLOCK_SIZE;
> +
> +    if ((starting_idx > total_no_of_scm_blocks) ||
> +        (no_of_scm_blocks_to_bind > total_no_of_scm_blocks)) {

I think the second check is redundant with the check below.

> +        return H_P2;
> +    }
> +
> +    if (((starting_idx + no_of_scm_blocks_to_bind) < starting_idx) ||
> +        ((starting_idx + no_of_scm_blocks_to_bind) > total_no_of_scm_blo=
cks)) {
> +        return H_P3;
> +    }
> +
> +    /* Currently qemu assigns the address. */
> +    if (target_logical_mem_addr !=3D 0xffffffffffffffff) {
> +        return H_OVERLAP;
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
> +    addr =3D object_property_get_uint(OBJECT(dimm),
> +                                    PC_DIMM_ADDR_PROP, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        return H_PARAMETER;
> +    }
> +
> +    addr +=3D starting_idx * SPAPR_MINIMUM_SCM_BLOCK_SIZE;
> +
> +    /* Already bound, Return target logical address in R4 */
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
> +    DeviceState *dev;
> +    PCDIMMDevice *dimm;
> +    uint64_t size, addr;
> +
> +    if (drc && spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {

And again.

> +        return H_PARAMETER;
> +    }
> +
> +    /* Check if starting_scm_logical_addr is block aligned */
> +    if (!QEMU_IS_ALIGNED(starting_scm_logical_addr,
> +                         SPAPR_MINIMUM_SCM_BLOCK_SIZE)) {
> +        return H_P2;
> +    }
> +
> +    dev =3D drc->dev;

And again the drc->dev case.

> +    dimm =3D PC_DIMM(dev);
> +    size =3D object_property_get_int(OBJECT(dimm), PC_DIMM_SIZE_PROP, NU=
LL);
> +    addr =3D object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP, NU=
LL);
> +
> +    range_init_nofail(&nvdimmrange, addr, size);
> +
> +    size_to_unbind =3D no_of_scm_blocks_to_unbind * SPAPR_MINIMUM_SCM_BL=
OCK_SIZE;

Check for overflow in this multiply.

> +
> +
> +    range_init_nofail(&blockrange, starting_scm_logical_addr, size_to_un=
bind);
> +
> +    if (!range_contains_range(&nvdimmrange, &blockrange)) {
> +        return H_P3;
> +    }
> +
> +    /* continue_token should be zero as this hcall doesn't return H_BUSY=
=2E */
> +    if (continue_token > 0) {
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
> +    if (target_scope =3D=3D H_UNBIND_SCOPE_DRC) {
> +        DeviceState *dev;
> +        SpaprDrc *drc =3D spapr_drc_by_index(drc_index);
> +
> +        if (drc && spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM=
) {
> +            return H_P2;
> +        }
> +
> +        dev =3D drc->dev;
> +        nvdimm =3D NVDIMM(dev);
> +        size =3D object_property_get_int(OBJECT(nvdimm), PC_DIMM_SIZE_PR=
OP, NULL);
> +
> +        no_of_scm_blocks_unbound =3D size / SPAPR_MINIMUM_SCM_BLOCK_SIZE;
> +    } else if (target_scope =3D=3D  H_UNBIND_SCOPE_ALL) {
> +        GSList *list, *dimms;
> +
> +        dimms =3D nvdimm_get_device_list();
> +        for (list =3D dimms; list; list =3D list->next) {
> +            nvdimm =3D list->data;
> +            size =3D object_property_get_int(OBJECT(nvdimm), PC_DIMM_SIZ=
E_PROP,
> +                                           NULL);
> +
> +            no_of_scm_blocks_unbound +=3D size / SPAPR_MINIMUM_SCM_BLOCK=
_SIZE;
> +        }
> +        g_slist_free(dimms);
> +    } else {
> +        return H_PARAMETER;
> +    }
> +
> +    /* continue_token should be zero as this hcall doesn't return H_BUSY=
=2E */
> +    if (continue_token > 0) {
> +        return H_P4;
> +    }

Usually better to do simple checks like this before more complex logic
like you have above.

> +
> +    args[1] =3D no_of_scm_blocks_unbound;
> +
> +    /* let unplug take care of actual unbind */
> +    return H_SUCCESS;
> +}
> +
>  static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
>  static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_H=
CALL_BASE + 1];
>  static spapr_hcall_fn svm_hypercall_table[(SVM_HCALL_MAX - SVM_HCALL_BAS=
E) / 4 + 1];
> @@ -2079,6 +2372,13 @@ static void hypercall_register_types(void)
>      /* qemu/KVM-PPC specific hcalls */
>      spapr_register_hypercall(KVMPPC_H_RTAS, h_rtas);
> =20
> +    /* qemu/scm specific hcalls */
> +    spapr_register_hypercall(H_SCM_READ_METADATA, h_scm_read_metadata);
> +    spapr_register_hypercall(H_SCM_WRITE_METADATA, h_scm_write_metadata);
> +    spapr_register_hypercall(H_SCM_BIND_MEM, h_scm_bind_mem);
> +    spapr_register_hypercall(H_SCM_UNBIND_MEM, h_scm_unbind_mem);
> +    spapr_register_hypercall(H_SCM_UNBIND_ALL, h_scm_unbind_all);
> +
>      /* ibm,client-architecture-support support */
>      spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support=
);
> =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index a8cb3513d0..e1933e877d 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -286,6 +286,7 @@ struct SpaprMachineState {
>  #define H_P7              -60
>  #define H_P8              -61
>  #define H_P9              -62
> +#define H_OVERLAP         -68
>  #define H_UNSUPPORTED_FLAG -256
>  #define H_MULTI_THREADS_ACTIVE -9005
> =20
> @@ -493,8 +494,13 @@ struct SpaprMachineState {
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

--iVEfEdCR/dAw5FFN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3XbfYACgkQbDjKyiDZ
s5JbTQ/+NpcDPGWNN7M+SSp+tNqUk9jeQCfM40ie6Mu4ARECrQty2wNTxQScvl1E
cEUbJUSpgft4ikOMZcyx09IgnP48KfFonXslE6nZGoTTB8tNE7zLpxxOOcgstTk6
TELXiTEgPc2DB+2tzTd52I/mmcMNglvVhrf9F4F7sQoHnOVL1D2hCKDCx2FQGvuW
K26XOghKu6SG+w3YtgnSwbfT1IKH9XcA7o+sO06/EUSwLo/KxlQRqoN+yNY4ngPd
uxw00ycN6uymFTzq3AAOix5yEbGwSekMcxJcZ9I6pQKeq1k7gMP5v4qZ4vt8Q5uc
fh3ooPGDLYPauAFRPhI4mMIf2cCFjzr46bh7wpkzlbOjtNRnXa1fCKBYkbohqbd2
jA+EonjSIDQmBJiR3EydbMOnyeaB6fLpBP8JCbqGOGPa3hkKYfNepufudG4tDh6N
uHpHxpsEvX/jVNizNOFRpxauMECjUUKghobn38Ftj4WqldFPnIpmgPt4cbY51pBj
NOivbcQMXf/q1Gu44LAWiiHgXHcLYsKhvR67bMawYXrK9q6IEQjCsOOZWoSprhTK
HB8uUnl6Kz3tUTatuwmW0hllcHsv0z8/HFgHIozdNX6/QTF0z56ZD05TnJb+Gjq1
1lJpI+hR030ioyAc0nIil8DV5rz939ro0v8RiHW2PPQYxuTn33I=
=AmtQ
-----END PGP SIGNATURE-----

--iVEfEdCR/dAw5FFN--

