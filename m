Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877A1C282CE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 01:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26C9F2081C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 01:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="b2qVBMpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C9F2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55919 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTcgR-0001p6-IN
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 21:38:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTcfe-0001XG-BW
	for qemu-devel@nongnu.org; Wed, 22 May 2019 21:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTcfc-0007Ws-MN
	for qemu-devel@nongnu.org; Wed, 22 May 2019 21:37:26 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:46283)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hTcfa-0007Lg-5F; Wed, 22 May 2019 21:37:24 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 458XDP12FXz9s5c; Thu, 23 May 2019 11:37:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558575429;
	bh=SjLABzlxT2WO4KtjRdP4Kiva31BwVExDA2uG8PprdK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b2qVBMpqbc1ifSGswLiI8pEts1OufHwfgJ+rSKpemHgtS9N2OQWiX6KAJpghyjmDp
	MD4UTH091X3J31+MT2Lzxn5SgaLl3gBBvstQOCoKOVHZu6DYAJrRIleCtKXtcEWHNs
	shfHChHpFSgSaieZ5NDoKyk5+twJ5NjN/e5j8g5o=
Date: Thu, 23 May 2019 10:46:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Fabiano Rosas <farosas@linux.ibm.com>
Message-ID: <20190523004633.GQ30423@umbus.fritz.box>
References: <155773946961.49142.5208084426066783536.stgit@lep8c.aus.stglabs.ibm.com>
	<155773968985.49142.1164691973469833295.stgit@lep8c.aus.stglabs.ibm.com>
	<875zq25plp.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DMLl6fZPX8o7hGmc"
Content-Disposition: inline
In-Reply-To: <875zq25plp.fsf@linux.ibm.com>
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
Cc: xiaoguangrong.eric@gmail.com, Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	mst@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
	imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--DMLl6fZPX8o7hGmc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2019 at 03:08:34PM -0300, Fabiano Rosas wrote:
> Shivaprasad G Bhat <sbhat@linux.ibm.com> writes:
>=20
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 6c16d2b120..b6e7d04dcf 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -3,11 +3,13 @@
> >  #include "sysemu/hw_accel.h"
> >  #include "sysemu/sysemu.h"
> >  #include "qemu/log.h"
> > +#include "qemu/range.h"
> >  #include "qemu/error-report.h"
> >  #include "cpu.h"
> >  #include "exec/exec-all.h"
> >  #include "helper_regs.h"
> >  #include "hw/ppc/spapr.h"
> > +#include "hw/ppc/spapr_drc.h"
> >  #include "hw/ppc/spapr_cpu_core.h"
> >  #include "mmu-hash64.h"
> >  #include "cpu-models.h"
> > @@ -16,6 +18,7 @@
> >  #include "hw/ppc/spapr_ovec.h"
> >  #include "mmu-book3s-v3.h"
> >  #include "hw/mem/memory-device.h"
> > +#include "hw/mem/nvdimm.h"
> > =20
> >  static bool has_spr(PowerPCCPU *cpu, int spr)
> >  {
> > @@ -1795,6 +1798,199 @@ static target_ulong h_update_dt(PowerPCCPU *cpu=
, SpaprMachineState *spapr,
> >      return H_SUCCESS;
> >  }
> > =20
> > +static target_ulong h_scm_read_metadata(PowerPCCPU *cpu,
> > +                                        SpaprMachineState *spapr,
> > +                                        target_ulong opcode,
> > +                                        target_ulong *args)
> > +{
> > +    uint32_t drc_index =3D args[0];
> > +    uint64_t offset =3D args[1];
> > +    uint64_t numBytesToRead =3D args[2];
>=20
> This variable's case is inconsistent with the rest of the file.
>=20
> > +    SpaprDrc *drc =3D spapr_drc_by_index(drc_index);
> > +    NVDIMMDevice *nvdimm =3D NULL;
> > +    NVDIMMClass *ddc =3D NULL;
> > +
> > +    if (drc && spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {
> > +        return H_PARAMETER;
> > +    }
> > +
> > +    if (numBytesToRead !=3D 1 && numBytesToRead !=3D 2 &&
> > +        numBytesToRead !=3D 4 && numBytesToRead !=3D 8) {
> > +        return H_P3;
> > +    }
> > +
> > +    nvdimm =3D NVDIMM(drc->dev);
> > +    if ((offset + numBytesToRead < offset) ||
> > +        (nvdimm->label_size < numBytesToRead + offset)) {
> > +        return H_P2;
> > +    }
>=20
> Won't the first clause always be false? Considering they're both
> uint64_t.

Generally yes, but that's caleed supplied input, so we need to protect
against 64-bit overflow.

>=20
> > +
> > +    ddc =3D NVDIMM_GET_CLASS(nvdimm);
> > +    ddc->read_label_data(nvdimm, &args[0], numBytesToRead, offset);
> > +
> > +    return H_SUCCESS;
> > +}
> > +
> > +
> > +static target_ulong h_scm_write_metadata(PowerPCCPU *cpu,
> > +                                         SpaprMachineState *spapr,
> > +                                         target_ulong opcode,
> > +                                         target_ulong *args)
> > +{
> > +    uint32_t drc_index =3D args[0];
> > +    uint64_t offset =3D args[1];
> > +    uint64_t data =3D args[2];
> > +    int8_t numBytesToWrite =3D args[3];
>=20
> Likewise.
>=20
> > +    SpaprDrc *drc =3D spapr_drc_by_index(drc_index);
> > +    NVDIMMDevice *nvdimm =3D NULL;
> > +    DeviceState *dev =3D NULL;
> > +    NVDIMMClass *ddc =3D NULL;
> > +
> > +    if (drc && spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {
> > +        return H_PARAMETER;
> > +    }
> > +
> > +    if (numBytesToWrite !=3D 1 && numBytesToWrite !=3D 2 &&
> > +        numBytesToWrite !=3D 4 && numBytesToWrite !=3D 8) {
> > +        return H_P4;
> > +    }
> > +
> > +    dev =3D drc->dev;
> > +    nvdimm =3D NVDIMM(dev);
> > +    if ((nvdimm->label_size < numBytesToWrite + offset) ||
> > +        (offset + numBytesToWrite < offset)) {
> > +        return H_P2;
> > +    }
> > +
> > +    ddc =3D NVDIMM_GET_CLASS(nvdimm);
> > +    ddc->write_label_data(nvdimm, &data, numBytesToWrite, offset);
> > +
> > +    return H_SUCCESS;
> > +}
> > +
> > +static target_ulong h_scm_bind_mem(PowerPCCPU *cpu, SpaprMachineState =
*spapr,
> > +                                        target_ulong opcode,
> > +                                        target_ulong *args)
> > +{
> > +    uint32_t drc_index =3D args[0];
> > +    uint64_t starting_idx =3D args[1];
> > +    uint64_t no_of_scm_blocks_to_bind =3D args[2];
> > +    uint64_t target_logical_mem_addr =3D args[3];
> > +    uint64_t continue_token =3D args[4];
> > +    uint64_t size;
> > +    uint64_t total_no_of_scm_blocks;
> > +
> > +    SpaprDrc *drc =3D spapr_drc_by_index(drc_index);
> > +    hwaddr addr;
> > +    DeviceState *dev =3D NULL;
> > +    PCDIMMDevice *dimm =3D NULL;
> > +    Error *local_err =3D NULL;
> > +
> > +    if (drc && spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {
> > +        return H_PARAMETER;
> > +    }
> > +
> > +    dev =3D drc->dev;
> > +    dimm =3D PC_DIMM(dev);
> > +
> > +    size =3D object_property_get_uint(OBJECT(dimm),
> > +                                    PC_DIMM_SIZE_PROP, &local_err);
> > +    if (local_err) {
> > +        error_report_err(local_err);
> > +        return H_PARAMETER;
> > +    }
> > +
> > +    total_no_of_scm_blocks =3D size / SPAPR_MINIMUM_SCM_BLOCK_SIZE;
> > +
> > +    if ((starting_idx > total_no_of_scm_blocks) ||
> > +        (no_of_scm_blocks_to_bind > total_no_of_scm_blocks)) {
> > +        return H_P2;
> > +    }
> > +
> > +    if (((starting_idx + no_of_scm_blocks_to_bind) < starting_idx) ||
> > +        ((starting_idx + no_of_scm_blocks_to_bind) > total_no_of_scm_b=
locks)) {
> > +        return H_P3;
> > +    }
>=20
> Same here.
>=20
> > +
> > +    /* Currently qemu assigns the address. */
> > +    if (target_logical_mem_addr !=3D 0xffffffffffffffff) {
> > +        return H_OVERLAP;
> > +    }
> > +
> > +    /*
> > +     * Currently continue token should be zero qemu has already bound
> > +     * everything and this hcall doesnt return H_BUSY.
> > +     */
> > +    if (continue_token > 0) {
> > +        return H_P5;
> > +    }
> > +
> > +    /* NB : Already bound, Return target logical address in R4 */
> > +    addr =3D object_property_get_uint(OBJECT(dimm),
> > +                                    PC_DIMM_ADDR_PROP, &local_err);
> > +    if (local_err) {
> > +        error_report_err(local_err);
> > +        return H_PARAMETER;
> > +    }
> > +
> > +    args[1] =3D addr;
> > +    args[2] =3D no_of_scm_blocks_to_bind;
> > +
> > +    return H_SUCCESS;
> > +}
> > +
> > +static target_ulong h_scm_unbind_mem(PowerPCCPU *cpu, SpaprMachineStat=
e *spapr,
> > +                                        target_ulong opcode,
> > +                                        target_ulong *args)
> > +{
> > +    uint32_t drc_index =3D args[0];
> > +    uint64_t starting_scm_logical_addr =3D args[1];
> > +    uint64_t no_of_scm_blocks_to_unbind =3D args[2];
> > +    uint64_t size_to_unbind;
> > +    uint64_t continue_token =3D args[3];
> > +    Range blockrange =3D range_empty;
> > +    Range nvdimmrange =3D range_empty;
> > +    SpaprDrc *drc =3D spapr_drc_by_index(drc_index);
> > +    DeviceState *dev =3D NULL;
> > +    PCDIMMDevice *dimm =3D NULL;
> > +    uint64_t size, addr;
> > +
> > +    if (drc && spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {
> > +        return H_PARAMETER;
> > +    }
> > +
> > +    /* Check if starting_scm_logical_addr is block aligned */
> > +    if (!QEMU_IS_ALIGNED(starting_scm_logical_addr,
> > +                         SPAPR_MINIMUM_SCM_BLOCK_SIZE)) {
> > +        return H_P2;
> > +    }
> > +
> > +    dev =3D drc->dev;
> > +    dimm =3D PC_DIMM(dev);
> > +    size =3D object_property_get_int(OBJECT(dimm), PC_DIMM_SIZE_PROP, =
NULL);
> > +    addr =3D object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP, =
NULL);
> > +
> > +    range_init_nofail(&nvdimmrange, addr, size);
> > +
> > +    size_to_unbind =3D no_of_scm_blocks_to_unbind * SPAPR_MINIMUM_SCM_=
BLOCK_SIZE;
> > +
> > +
> > +    range_init_nofail(&blockrange, starting_scm_logical_addr, size_to_=
unbind);
> > +
> > +    if (!range_contains_range(&nvdimmrange, &blockrange)) {
> > +        return H_P3;
> > +    }
> > +
> > +    if (continue_token > 0) {
> > +        return H_P3;
> > +    }
> > +
> > +    args[1] =3D no_of_scm_blocks_to_unbind;
> > +
> > +    /*NB : dont do anything, let object_del take care of this for now.=
 */
> > +    return H_SUCCESS;
> > +}
> > +
> >  static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
> >  static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC=
_HCALL_BASE + 1];
> > =20
> > @@ -1894,6 +2090,12 @@ static void hypercall_register_types(void)
> >      /* qemu/KVM-PPC specific hcalls */
> >      spapr_register_hypercall(KVMPPC_H_RTAS, h_rtas);
> > =20
> > +    /* qemu/scm specific hcalls */
> > +    spapr_register_hypercall(H_SCM_READ_METADATA, h_scm_read_metadata);
> > +    spapr_register_hypercall(H_SCM_WRITE_METADATA, h_scm_write_metadat=
a);
> > +    spapr_register_hypercall(H_SCM_BIND_MEM, h_scm_bind_mem);
> > +    spapr_register_hypercall(H_SCM_UNBIND_MEM, h_scm_unbind_mem);
> > +
> >      /* ibm,client-architecture-support support */
> >      spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_suppo=
rt);
> > =20
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index 394ea26335..48e2cc9d67 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -283,6 +283,7 @@ struct SpaprMachineState {
> >  #define H_P7              -60
> >  #define H_P8              -61
> >  #define H_P9              -62
> > +#define H_OVERLAP         -68
> >  #define H_UNSUPPORTED_FLAG -256
> >  #define H_MULTI_THREADS_ACTIVE -9005
> > =20
> > @@ -490,8 +491,12 @@ struct SpaprMachineState {
> >  #define H_INT_ESB               0x3C8
> >  #define H_INT_SYNC              0x3CC
> >  #define H_INT_RESET             0x3D0
> > +#define H_SCM_READ_METADATA     0x3E4
> > +#define H_SCM_WRITE_METADATA    0x3E8
> > +#define H_SCM_BIND_MEM          0x3EC
> > +#define H_SCM_UNBIND_MEM        0x3F0
> > =20
> > -#define MAX_HCALL_OPCODE        H_INT_RESET
> > +#define MAX_HCALL_OPCODE        H_SCM_UNBIND_MEM
> > =20
> >  /* The hcalls above are standardized in PAPR and implemented by pHyp
> >   * as well.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DMLl6fZPX8o7hGmc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzl7WYACgkQbDjKyiDZ
s5L3hRAAk/RKZzZZ+S7upSbGX46pd2hiUbUXm9TYlsmzn5ICcFrAUcd60f1bVc5p
vBv2LGGB0AfVJNijqgV0uu0zjtH5f+Env1CIFas7zAtouxQpOAk+sHL32qM8Ewwz
qBzpKoqPNrL/Yyi0owwzzxfUgDnnr/c2Q0gpmMvJyXAWB1F+HD4Gj3eRdrEps5hj
PXjcNihFWUuWNLzEBn/tkElTqQ4bf0HFpqZFDUvnLI4pXcWT9VOgJKVLrXj/Sp+D
1O20KdB0nVxHPGvgUp4k88o7xoOUY9claGVEPBm2rMO0heFSLIjNUfpup+dAkIy3
IuhmNHPDgLG7dk1wlboNmEMUzA6pAEbSQYYm7yUCeYEVUIM+fqCz+Re/Zs3U3WvP
VZaTTshoAq7kt07OVG25SwgnGhc1VWFwHtuJAjomak9yc86DA5cxUJlIOihIbkQA
VBvNlcmYPxUp6zzr9xMYwlFrSvc87zTfyCHlwonC9O8VHmzJJsRxG2m04IsyHRLc
gLhttgH8BJ15+b+VRql7aXI0h2c35HC1XrUgrH2UVj+wjIhW7HunsNEyEC5HRiBK
0t7zNqetChylkQrUBfQHroVc+6Ez5jKlZLtuhVujEg0s1ByKAuXP1QhGekzeS29q
gjppMLOQGJQ0WA1F85A2Ay8/xLKIWuZ7NhmbDggkbWGcPiGYVNw=
=Jr5P
-----END PGP SIGNATURE-----

--DMLl6fZPX8o7hGmc--

