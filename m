Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B05DC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 04:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41E212086A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 04:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="f3KzeSiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E212086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39016 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQPDq-0004GA-Nu
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 00:39:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQPCq-0003si-E1
	for qemu-devel@nongnu.org; Tue, 14 May 2019 00:38:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQPCo-0003lq-FK
	for qemu-devel@nongnu.org; Tue, 14 May 2019 00:38:24 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:45333)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hQPCn-0003Wm-BG; Tue, 14 May 2019 00:38:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4534gY1RFKz9sBr; Tue, 14 May 2019 14:38:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557808697;
	bh=ofSAnoDMz09yDfzweqfjl7/3YBtshBHYWsFvpVTgJkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3KzeSiHgGhj+IlohiLFClaadJq05SZmm5dR1zerg2VWbt2bCyADpFp+yrUmUMxFw
	Jl8I8eAYXZRc/oUi9wSqMpmGbO0DEuuHg1OQNuQXLe2q3OO+jZGwlZ+miR4Im+ZBe6
	C/AnPrT4C/mUCo2CEdSEoS+SCIHQmolCwz/xhGnc=
Date: Tue, 14 May 2019 14:38:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID: <20190514043811.GG6441@umbus.fritz.box>
References: <155773946961.49142.5208084426066783536.stgit@lep8c.aus.stglabs.ibm.com>
	<155773968985.49142.1164691973469833295.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p8PhoBjPxaQXD0vg"
Content-Disposition: inline
In-Reply-To: <155773968985.49142.1164691973469833295.stgit@lep8c.aus.stglabs.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [RFC v2 PATCH 3/3] spapr: Add Hcalls to support
 PAPR NVDIMM device
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


--p8PhoBjPxaQXD0vg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2019 at 04:28:36AM -0500, Shivaprasad G Bhat wrote:
> This patch implements few of the necessary hcalls for the nvdimm support.
>=20
> PAPR semantics is such that each NVDIMM device is comprising of multiple
> SCM(Storage Class Memory) blocks. The guest requests the hypervisor to bi=
nd
> each of the SCM blocks of the NVDIMM device using hcalls. There can be
> SCM block unbind requests in case of driver errors or unplug(not supporte=
d now)
> use cases. The NVDIMM label read/writes are done through hcalls.
>=20
> Since each virtual NVDIMM device is divided into multiple SCM blocks, the=
 bind,
> unbind, and queries using hcalls on those blocks can come independently. =
This
> doesn't fit well into the qemu device semantics, where the map/unmap are =
done
> at the (whole)device/object level granularity. The patch doesnt actually
> bind/unbind on hcalls but let it happen at the object_add/del phase itself
> instead.
>=20
> The guest kernel makes bind/unbind requests for the virtual NVDIMM device=
 at the
> region level granularity. Without interleaving, each virtual NVDIMM devic=
e is
> presented as separate region. There is no way to configure the virtual NV=
DIMM
> interleaving for the guests today. So, there is no way a partial bind/unb=
ind
> request can come for the vNVDIMM in a hcall for a subset of SCM blocks of=
 a
> virtual NVDIMM. Hence it is safe to do bind/unbind everything during the
> object_add/del.
>=20
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
>  hw/ppc/spapr_hcall.c   |  202 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr.h |    7 +-
>  2 files changed, 208 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 6c16d2b120..b6e7d04dcf 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -3,11 +3,13 @@
>  #include "sysemu/hw_accel.h"
>  #include "sysemu/sysemu.h"
>  #include "qemu/log.h"
> +#include "qemu/range.h"
>  #include "qemu/error-report.h"
>  #include "cpu.h"
>  #include "exec/exec-all.h"
>  #include "helper_regs.h"
>  #include "hw/ppc/spapr.h"
> +#include "hw/ppc/spapr_drc.h"
>  #include "hw/ppc/spapr_cpu_core.h"
>  #include "mmu-hash64.h"
>  #include "cpu-models.h"
> @@ -16,6 +18,7 @@
>  #include "hw/ppc/spapr_ovec.h"
>  #include "mmu-book3s-v3.h"
>  #include "hw/mem/memory-device.h"
> +#include "hw/mem/nvdimm.h"
> =20
>  static bool has_spr(PowerPCCPU *cpu, int spr)
>  {
> @@ -1795,6 +1798,199 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, =
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
> +    NVDIMMDevice *nvdimm =3D NULL;
> +    NVDIMMClass *ddc =3D NULL;
> +
> +    if (drc && spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {
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
> +    ddc->read_label_data(nvdimm, &args[0], numBytesToRead, offset);

I'm pretty sure this will need some sort of byteswap.  args[0] is
effectively in host native order (since it maps to a register, not
memory).  But the guest will have to assume some byteorder (BE, I'm
guessing, because PAPR) in order to map that register to an in-memory
byteorder.  So, you'll need to compensate for that here.

> +    return H_SUCCESS;
> +}
> +
> +
> +static target_ulong h_scm_write_metadata(PowerPCCPU *cpu,
> +                                         SpaprMachineState *spapr,
> +                                         target_ulong opcode,
> +                                         target_ulong *args)
> +{
> +    uint32_t drc_index =3D args[0];
> +    uint64_t offset =3D args[1];
> +    uint64_t data =3D args[2];
> +    int8_t numBytesToWrite =3D args[3];
> +    SpaprDrc *drc =3D spapr_drc_by_index(drc_index);
> +    NVDIMMDevice *nvdimm =3D NULL;
> +    DeviceState *dev =3D NULL;
> +    NVDIMMClass *ddc =3D NULL;
> +
> +    if (drc && spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {
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
> +    if ((nvdimm->label_size < numBytesToWrite + offset) ||
> +        (offset + numBytesToWrite < offset)) {
> +        return H_P2;
> +    }
> +
> +    ddc =3D NVDIMM_GET_CLASS(nvdimm);
> +    ddc->write_label_data(nvdimm, &data, numBytesToWrite, offset);

Likewise here.

> +
> +    return H_SUCCESS;
> +}
> +
> +static target_ulong h_scm_bind_mem(PowerPCCPU *cpu, SpaprMachineState *s=
papr,
> +                                        target_ulong opcode,
> +                                        target_ulong *args)
> +{
> +    uint32_t drc_index =3D args[0];
> +    uint64_t starting_idx =3D args[1];
> +    uint64_t no_of_scm_blocks_to_bind =3D args[2];
> +    uint64_t target_logical_mem_addr =3D args[3];
> +    uint64_t continue_token =3D args[4];
> +    uint64_t size;
> +    uint64_t total_no_of_scm_blocks;
> +
> +    SpaprDrc *drc =3D spapr_drc_by_index(drc_index);
> +    hwaddr addr;
> +    DeviceState *dev =3D NULL;
> +    PCDIMMDevice *dimm =3D NULL;
> +    Error *local_err =3D NULL;
> +
> +    if (drc && spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {
> +        return H_PARAMETER;
> +    }
> +
> +    dev =3D drc->dev;
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

So, only supporting one mode of the interface is reasonable.  However,
it seems a somewhat unnatural way to handle the PAPR interface.  It
seems to me it would be more natural to instantiate the underlying
NVDIMM objects so that they're not in address_space_memory, but rather
in their own initially inaccssible address_space.  Then the BIND call
would alias a chunk of address_space_memory into the NVDIMMs address
space.

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
> +    /* NB : Already bound, Return target logical address in R4 */
> +    addr =3D object_property_get_uint(OBJECT(dimm),
> +                                    PC_DIMM_ADDR_PROP, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        return H_PARAMETER;
> +    }
> +
> +    args[1] =3D addr;

Don't you need to adjust this if start_idx is non-zero?

> +    args[2] =3D no_of_scm_blocks_to_bind;
> +
> +    return H_SUCCESS;
> +}
> +
> +static target_ulong h_scm_unbind_mem(PowerPCCPU *cpu, SpaprMachineState =
*spapr,
> +                                        target_ulong opcode,
> +                                        target_ulong *args)
> +{
> +    uint32_t drc_index =3D args[0];
> +    uint64_t starting_scm_logical_addr =3D args[1];
> +    uint64_t no_of_scm_blocks_to_unbind =3D args[2];
> +    uint64_t size_to_unbind;
> +    uint64_t continue_token =3D args[3];
> +    Range blockrange =3D range_empty;
> +    Range nvdimmrange =3D range_empty;
> +    SpaprDrc *drc =3D spapr_drc_by_index(drc_index);
> +    DeviceState *dev =3D NULL;
> +    PCDIMMDevice *dimm =3D NULL;
> +    uint64_t size, addr;
> +
> +    if (drc && spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {
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
> +
> +
> +    range_init_nofail(&blockrange, starting_scm_logical_addr, size_to_un=
bind);
> +
> +    if (!range_contains_range(&nvdimmrange, &blockrange)) {
> +        return H_P3;
> +    }
> +
> +    if (continue_token > 0) {
> +        return H_P3;
> +    }
> +
> +    args[1] =3D no_of_scm_blocks_to_unbind;
> +
> +    /*NB : dont do anything, let object_del take care of this for now. */
> +    return H_SUCCESS;
> +}
> +
>  static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
>  static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_H=
CALL_BASE + 1];
> =20
> @@ -1894,6 +2090,12 @@ static void hypercall_register_types(void)
>      /* qemu/KVM-PPC specific hcalls */
>      spapr_register_hypercall(KVMPPC_H_RTAS, h_rtas);
> =20
> +    /* qemu/scm specific hcalls */
> +    spapr_register_hypercall(H_SCM_READ_METADATA, h_scm_read_metadata);
> +    spapr_register_hypercall(H_SCM_WRITE_METADATA, h_scm_write_metadata);
> +    spapr_register_hypercall(H_SCM_BIND_MEM, h_scm_bind_mem);
> +    spapr_register_hypercall(H_SCM_UNBIND_MEM, h_scm_unbind_mem);
> +
>      /* ibm,client-architecture-support support */
>      spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support=
);
> =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 394ea26335..48e2cc9d67 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -283,6 +283,7 @@ struct SpaprMachineState {
>  #define H_P7              -60
>  #define H_P8              -61
>  #define H_P9              -62
> +#define H_OVERLAP         -68
>  #define H_UNSUPPORTED_FLAG -256
>  #define H_MULTI_THREADS_ACTIVE -9005
> =20
> @@ -490,8 +491,12 @@ struct SpaprMachineState {
>  #define H_INT_ESB               0x3C8
>  #define H_INT_SYNC              0x3CC
>  #define H_INT_RESET             0x3D0
> +#define H_SCM_READ_METADATA     0x3E4
> +#define H_SCM_WRITE_METADATA    0x3E8
> +#define H_SCM_BIND_MEM          0x3EC
> +#define H_SCM_UNBIND_MEM        0x3F0
> =20
> -#define MAX_HCALL_OPCODE        H_INT_RESET
> +#define MAX_HCALL_OPCODE        H_SCM_UNBIND_MEM
> =20
>  /* The hcalls above are standardized in PAPR and implemented by pHyp
>   * as well.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--p8PhoBjPxaQXD0vg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzaRjEACgkQbDjKyiDZ
s5J2yg/+KC5W/pWASRow05WfVu6gALbgTj2UqItVa3cDvDg8dGhY0Z4aWfsw23R5
jow6EdlGkT9BLGT1vEHpR2nj4GB9pTmBpkmpLrjgX8/imfP8otUfvqrpATk8oBHk
esImnb2XcB5KJOmQn913MF0Y/kcSKhO/5AOW5oh7Hg10LhimOqXkjvPCBK7UJW9K
4IskuZWBwTAYtCmlmAhVDSgtkrJngth7pdrxQ5/eNcNpRU3xy6iTVj3HLOvgXexB
hh9sYGMpsUkS7W0pf6WAu7owNQ6wQbYLpLJAz5vmPpt9Ahl6X8wFL/9/6S+9Saz7
flJbvhxrj9oXdRv9HzeP3MsZYp4REwQU4emjGC3a20BZ5FJnoAI9+glulmoKuHCV
6suCQpHBZbb9QIdpbhYTbB98MZwMZj+YK70ybt/6Dotvo+SgOxwBexYA4etwoDd2
7cCaJcOzy9mDTrtP1DTbqxZNA99Mlm3YSreako63BQMvW85syU0uorT5qPYGCkrw
fe8jaOZZgQ+EpXPW1OZzk4z0kulwdUlWpzNH5gmmx2CWQrjYQVRuImd+jKCIEAQt
2RAjvPTwbu5/rT3LVRZlbYDpJiyqtNVUqjYxcybiu9nUpEYN7MiaL9ndE/z0G0Xv
PsVlLyLdEQctm7isr2p9hk7FUzAt8C9D/rXHu0mdlP3dDoPDzGY=
=bVi/
-----END PGP SIGNATURE-----

--p8PhoBjPxaQXD0vg--

