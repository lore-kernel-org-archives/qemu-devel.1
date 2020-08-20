Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF665C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 03:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE9F32078B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 03:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MoOsAsRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9F32078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8bj3-0005TZ-1O
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 23:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8biI-00040K-On; Wed, 19 Aug 2020 23:58:06 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35989 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8biG-0007LE-2g; Wed, 19 Aug 2020 23:58:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BX9ps6rVbz9sTN; Thu, 20 Aug 2020 13:57:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597895877;
 bh=VOBGGYxOOzcNq9pdAo1WZXjvFrzdlGNT41G+2GJ0sAg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MoOsAsRofug2n29sTtmENKVe8dUJssobpIPy4nLfuQKaxmqSIVNBuHxEqkqF9bgLO
 fP0l+yLJY7nI4nQERtvYqqDdU7vNIi5mT9/f6NPArhw6Xg5KTu12m/uIEGboJ7kzPa
 lDIhvyn6Oinx64CFlZGVmq51yqYcyNImQxohN0PI=
Date: Thu, 20 Aug 2020 12:14:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 03/10] spapr: robustify NVLink2 NUMA node logic
Message-ID: <20200820021425.GJ271315@yekko.fritz.box>
References: <20200814205424.543857-1-danielhb413@gmail.com>
 <20200814205424.543857-4-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HcccYpVZDxQ8hzPO"
Content-Disposition: inline
In-Reply-To: <20200814205424.543857-4-danielhb413@gmail.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 23:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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


--HcccYpVZDxQ8hzPO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2020 at 05:54:17PM -0300, Daniel Henrique Barboza wrote:
> NVLink2 GPUs are allocated in their own NUMA node, at maximum
> distance from every other resource in the board. The existing
> logic makes some assumptions that don't scale well:
>=20
> - only NVLink2 GPUs will ever require such mechanism, meaning
> that the GPU logic is tightly coupled with the NUMA setup of
> the machine, via how ibm,max-associativity-domains is set.
>=20
> - the code is relying on the lack of support for sparse NUMA
> nodes in QEMU. Eventually this support can be implemented, and
> then the assumption that spapr->gpu_numa_id represents the total
> of NUMA nodes plus all generated NUMA ids for the GPUs, which
> relies on all QEMU NUMA nodes not being sparsed, has a good
> potential for disaster.
>=20
> This patch aims to fix both assumptions by creating a generic
> mechanism to get an available NUMA node, regardless of the
> NUMA setup being sparse or not. The idea is to rename the existing
> spapr->gpu_numa_id to spapr->current_numa_id and add a new
> spapr->extra_numa_nodes attribute. They are used in a new function
> called spapr_pci_get_available_numa_id(), that takes into account
> that the NUMA conf can be sparsed or not, to retrieve an available
> NUMA id for the caller. Each consecutive call of
> spapr_pci_get_available_numa_id() will generate a new ID, up
> to the limit of numa_state->num_nodes + spapr->extra_numa_nodes
> exceeding MAX_NODES. This is a generic code being used only by
> NVLink2 ATM, being available to be used in the future by any
> other device.
>=20
> With this new function in place, we can decouple
> ibm,max-associativity-domains logic from NVLink2 logic by
> using the new spapr->extra_numa_nodes to define the maxdomains
> of the forth NUMA level. Instead of defining it as gpu_numa_id,
> use num_nodes + extra_numa_nodes. This also makes it resilient
> to any future change in the support of sparse NUMA nodes.
>=20
> Despite all the code juggling, no functional change was made
> because sparse NUMA nodes isn't a thing and we do not support
> distinct NUMA distances via user input. Next patches will
> change that.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hw/ppc/spapr.c              | 15 ++++++++++-----
>  hw/ppc/spapr_pci.c          | 33 +++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_pci_nvlink2.c  | 10 ++++++----
>  include/hw/pci-host/spapr.h |  2 ++
>  include/hw/ppc/spapr.h      |  4 +++-
>  5 files changed, 54 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3b16edaf4c..22e78cfc84 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -910,13 +910,13 @@ static void spapr_dt_rtas(SpaprMachineState *spapr,=
 void *fdt)
>          cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE & 0xffffffff),
>          cpu_to_be32(ms->smp.max_cpus / ms->smp.threads),
>      };
> -    uint32_t maxdomain =3D cpu_to_be32(spapr->gpu_numa_id > 1 ? 1 : 0);
> +    uint32_t maxdomain =3D cpu_to_be32(spapr->extra_numa_nodes > 1 ? 1 :=
 0);
>      uint32_t maxdomains[] =3D {
>          cpu_to_be32(4),
>          maxdomain,
>          maxdomain,
>          maxdomain,
> -        cpu_to_be32(spapr->gpu_numa_id),
> +        cpu_to_be32(ms->numa_state->num_nodes + spapr->extra_numa_nodes),
>      };
> =20
>      _FDT(rtas =3D fdt_add_subnode(fdt, 0, "rtas"));
> @@ -2824,13 +2824,18 @@ static void spapr_machine_init(MachineState *mach=
ine)
>      /*
>       * NVLink2-connected GPU RAM needs to be placed on a separate NUMA n=
ode.
>       * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() whic=
h is
> -     * called from vPHB reset handler so we initialize the counter here.
> +     * called from vPHB reset handler. We have code to generate an extra=
 numa
> +     * id to place the GPU via 'extra_numa_nodes' and 'current_numa_node=
', which
> +     * are initialized here.
> +     *
>       * If no NUMA is configured from the QEMU side, we start from 1 as G=
PU RAM
>       * must be equally distant from any other node.
> -     * The final value of spapr->gpu_numa_id is going to be written to
> +     *
> +     * The extra NUMA node ids generated for GPU usage will be written to
>       * max-associativity-domains in spapr_build_fdt().
>       */
> -    spapr->gpu_numa_id =3D MAX(1, machine->numa_state->num_nodes);
> +    spapr->current_numa_id =3D 0;
> +    spapr->extra_numa_nodes =3D 0;
> =20
>      if ((!kvm_enabled() || kvmppc_has_cap_mmu_radix()) &&
>          ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICAL_3_0=
0, 0,
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 0a418f1e67..09ac58fd7f 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2492,3 +2492,36 @@ void spapr_pci_switch_vga(bool big_endian)
>                             &big_endian);
>      }
>  }
> +
> +unsigned spapr_pci_get_available_numa_id(Error **errp)
> +{
> +    MachineState *machine =3D MACHINE(qdev_get_machine());
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(machine);
> +    NodeInfo *numa_info =3D machine->numa_state->nodes;
> +    unsigned i, start;
> +
> +    if (machine->numa_state->num_nodes + spapr->extra_numa_nodes >=3D MA=
X_NODES) {
> +        error_setg(errp,
> +                   "Unable to get an extra NUMA node beyond MAX_NODES =
=3D %d",
> +                   MAX_NODES);
> +        return spapr->current_numa_id;
> +    }
> +
> +    if (spapr->extra_numa_nodes =3D=3D 0) {
> +        start =3D 0;
> +    } else {
> +        start =3D spapr->current_numa_id + 1;
> +    }
> +
> +    for (i =3D start; i < MAX_NODES; i++) {
> +        if (!numa_info[i].present) {
> +            spapr->extra_numa_nodes++;
> +            spapr->current_numa_id =3D i;
> +            return i;
> +        }
> +    }

I think I see what you're trying to do, but this logic makes me a bit
nervous.  I guess migration isn't really an issue for the GPUs, but as
a general rule we want the NUMA ids for everything to be the same from
boot to boot (assuming similar command line configuration).

I think that's probably true here, but the rules are complex enough
that it's hard to convince myself there isn't some edge case where
something that doesn't seem relevant could change the numa nodes the
gpus end up with.

> +
> +    error_setg(errp, "Unable to find a valid NUMA id");
> +
> +    return spapr->current_numa_id;
> +}
> diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
> index 76ae77ebc8..611c8a2957 100644
> --- a/hw/ppc/spapr_pci_nvlink2.c
> +++ b/hw/ppc/spapr_pci_nvlink2.c
> @@ -87,9 +87,8 @@ static void spapr_pci_collect_nvgpu(SpaprPhbPciNvGpuCon=
fig *nvgpus,
>                                      PCIDevice *pdev, uint64_t tgt,
>                                      MemoryRegion *mr, Error **errp)
>  {
> -    MachineState *machine =3D MACHINE(qdev_get_machine());
> -    SpaprMachineState *spapr =3D SPAPR_MACHINE(machine);
>      SpaprPhbPciNvGpuSlot *nvslot =3D spapr_nvgpu_get_slot(nvgpus, tgt);
> +    Error *local_err =3D NULL;
> =20
>      if (!nvslot) {
>          error_setg(errp, "Found too many GPUs per vPHB");
> @@ -100,8 +99,11 @@ static void spapr_pci_collect_nvgpu(SpaprPhbPciNvGpuC=
onfig *nvgpus,
> =20
>      nvslot->gpa =3D nvgpus->nv2_ram_current;
>      nvgpus->nv2_ram_current +=3D memory_region_size(mr);
> -    nvslot->numa_id =3D spapr->gpu_numa_id;
> -    ++spapr->gpu_numa_id;
> +
> +    nvslot->numa_id =3D spapr_pci_get_available_numa_id(&local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +    }
>  }
> =20
>  static void spapr_pci_collect_nvnpu(SpaprPhbPciNvGpuConfig *nvgpus,
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 600eb55c34..8d93223a76 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -129,6 +129,8 @@ struct SpaprPhbState {
>  #define SPAPR_PCI_NV2ATSD_WIN_SIZE   (NVGPU_MAX_NUM * NVGPU_MAX_LINKS * \
>                                        64 * KiB)
> =20
> +unsigned spapr_pci_get_available_numa_id(Error **errp);
> +
>  int spapr_dt_phb(SpaprMachineState *spapr, SpaprPhbState *phb,
>                   uint32_t intc_phandle, void *fdt, int *node_offset);
> =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 3134d339e8..739a6a4942 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -227,7 +227,9 @@ struct SpaprMachineState {
>      bool cmd_line_caps[SPAPR_CAP_NUM];
>      SpaprCapabilities def, eff, mig;
> =20
> -    unsigned gpu_numa_id;
> +    unsigned current_numa_id;

The nane "current_numa_id" is a bit unclear.  AFAICT this is used
specifically for the GPU "extra" numa nodes, which isn't obvious from
the name.

> +    unsigned extra_numa_nodes;
> +
>      SpaprTpmProxy *tpm_proxy;
> =20
>      Error *fwnmi_migration_blocker;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HcccYpVZDxQ8hzPO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl893H8ACgkQbDjKyiDZ
s5KaaxAAs1PcKu9OrtuALr48cc3b6BiILUUjaZ8U+YAmhLunlsLvmFZvKEA/0iF7
o9Pp8nkObXbNBRRbkhAN8M/tE69V0HgV9+TFo5MleIKoa5xUfnC/oasYC8/A5F6m
LAJ1hU94HhCjRSHHiHFFsfOshyQHsT5XVundc1SryaXV7yCA5aP93LPkQDNV/d27
0C1Ij87kJi+mof/MvutqrjYvnzzr+54Ndr35HHrqwkMfeSZs0pRX1ue84ErYmh2X
hysKpNIs3N+Iemi6WfPC5RGH8H+cz7aVs+2vEC+NNhW7dlPiuCQI45AjG8Fsbz1h
HCTARKUHj3ibTe2L+k4wzqbtcVZ3JDmxf22jRTQTE2EesetJQbGMYImHyjKdAAaN
tZz+qCEjWVJCd9c7BohkU6GujZarYo6wIUN496KUSpvf98qB6Qn25lSl+2D7SX7a
X82xmC25fAflejt7iQBadp7FYHxUhnl2q+Vqbaes56ZcHls5MKqQ5t2yxlouKggT
uEXOl9zv4ZB8o8hnmVpu599kKYFzDHwBiANjHr1tfSYGyEaI3KR6ur/j5tt0q5PJ
o5xG8AyeFFkUv7vkPyhjDLhYFyuhirHJyf+1j2l6PzhjYosHYdn8js6yf7rmbYvS
xYpQFAOEuQ6lM1KgIGWLPnpOgV47qqPwbm42yu3CTQOf7DRJ9Vc=
=DUMe
-----END PGP SIGNATURE-----

--HcccYpVZDxQ8hzPO--

