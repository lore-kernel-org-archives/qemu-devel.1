Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE1CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 04:28:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87AE2067C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 04:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ESglLctx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87AE2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8cBN-0004iE-0E
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 00:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8cAd-0003ZH-3v; Thu, 20 Aug 2020 00:27:23 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:52149 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8cAZ-0002Gb-L2; Thu, 20 Aug 2020 00:27:22 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BXBSf6KjDz9sR4; Thu, 20 Aug 2020 14:27:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597897634;
 bh=9/twLOjQrUiK89FPBhoQBIyjvve6cTt6S92k3oWuMnw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ESglLctxT+LGArKEm9kke2AksrLYur3M3cadW2wHNglF+qTzXkWfEvy2FPOMnpuHd
 cAF8QTA0mgJpMjQFebeSZBDJD7mLrpu8WVicJPhIAYs4JVhvhuR1ST4nz9oTh4oP6I
 wt9tZyrhEGYyrq9vKmtC3A9AGxKb1VEE4VMJS0g0=
Date: Thu, 20 Aug 2020 14:26:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 08/10] spapr: introduce
 SpaprMachineClass::numa_assoc_domains
Message-ID: <20200820042600.GO271315@yekko.fritz.box>
References: <20200814205424.543857-1-danielhb413@gmail.com>
 <20200814205424.543857-9-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="S0GG+JvAI2G0KxBG"
Content-Disposition: inline
In-Reply-To: <20200814205424.543857-9-danielhb413@gmail.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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


--S0GG+JvAI2G0KxBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2020 at 05:54:22PM -0300, Daniel Henrique Barboza wrote:
> We can't use the input from machine->numa_state->nodes directly
> in the pSeries machine because PAPR does not work with raw distance
> values, like ACPI SLIT does. We need to determine common
> associativity domains, based on similar performance/distance of the
> resources, and set these domains in the associativy array that goes
> to the FDT of each resource.
>=20
> To ease the translation between regular ACPI NUMA distance info
> to our PAPR dialect, let's create a matrix called numa_assoc_domains
> in the SpaprMachineClass. This matrix will be initiated during
> machine init, where  we will read NUMA information from user input,
> apply a heuristic to determine the associativity domains for each node,
> then populate numa_assoc_domains accordingly.
>=20
> The changes are mostly centered in the spapr_set_associativity()
> helper that will use the values of numa_assoc_domains instead of
> using 0x0, with spapr_dt_dynamic_reconfiguration_memory() and
> h_home_node_associativity() being the exceptions.
>=20
> To keep the changes under control, we'll plug in the matrix usage
> in the existing code first. The actual heuristic to determine
> the associativity domains for each NUMA node will come in a follow-up
> patch.
>=20
> Note that the matrix is initiated with zeros, meaning that there is
> no guest changes implemented in this patch. We'll keep these
> changes from legacy NUMA guests by not initiating the matrix
> in these cases.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

IIUC, what this is basically doing is that instead of doing the
translation from qemu's internal NUMA representation to PAPRs at the
point(s) we emit the PAPR information, we're moving it to persistent
data we calculate for each (qemu) numa node then just copy out when we
emit the information?

That could be a reasonable idea, and indeed the rest of the series
might be easier to understand if this change were earlier in the
series.  In particular it means we might be able localise all the
hacks for calculating the right vectors depending on machine
version/options into one place.

A couple of nits, though:

> ---
>  hw/ppc/spapr.c                | 46 +++++++++++++++++++++++------------
>  hw/ppc/spapr_hcall.c          | 13 ++++++++--
>  hw/ppc/spapr_nvdimm.c         | 13 +++++-----
>  hw/ppc/spapr_pci.c            |  3 ++-
>  include/hw/ppc/spapr.h        |  7 +++++-
>  include/hw/ppc/spapr_nvdimm.h |  5 ++--
>  6 files changed, 59 insertions(+), 28 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b80a6f6936..4f50ab21ee 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -201,8 +201,13 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int off=
set, PowerPCCPU *cpu,
>      return ret;
>  }
> =20
> -void spapr_set_associativity(uint32_t *assoc, int node_id, int cpu_index)
> +void spapr_set_associativity(uint32_t *assoc, int node_id, int cpu_index,
> +                             MachineState *machine)
>  {
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
> +    uint8_t assoc_domain1 =3D smc->numa_assoc_domains[node_id][0];
> +    uint8_t assoc_domain2 =3D smc->numa_assoc_domains[node_id][1];
> +    uint8_t assoc_domain3 =3D smc->numa_assoc_domains[node_id][2];
>      uint8_t assoc_size =3D 0x4;
> =20
>      if (cpu_index >=3D 0) {
> @@ -211,17 +216,18 @@ void spapr_set_associativity(uint32_t *assoc, int n=
ode_id, int cpu_index)
>      }
> =20
>      assoc[0] =3D cpu_to_be32(assoc_size);
> -    assoc[1] =3D cpu_to_be32(0x0);
> -    assoc[2] =3D cpu_to_be32(0x0);
> -    assoc[3] =3D cpu_to_be32(0x0);
> +    assoc[1] =3D cpu_to_be32(assoc_domain1);
> +    assoc[2] =3D cpu_to_be32(assoc_domain2);
> +    assoc[3] =3D cpu_to_be32(assoc_domain3);
>      assoc[4] =3D cpu_to_be32(node_id);

So spapr_set_associativity() is already a slightly dangerous function,
because the required buffer space for 'assoc' varies in a non-obvious
way depending on if cpu_index is >=3D 0.  I didn't comment on that when
it was introduced, because it's not really any worse than what it
replaced.

But with this change, I think we can do better.  I'd suggest storing
the full PAPR associativity vector for each qemu numa node verbatim,
so it can just be copied straight into the device tree without
interpretation.  Then the helper can actually do the property set, and
we don't need magically sized locals any more.

Obviously there will need to be some more handling for the extra layer
we add on cpu assoc vectors.  We could store a vector for each vcpu as
well, or just have a hack to adjust these (fdt_appendprop() might be
useful).

>  }
> =20
> -static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cp=
u)
> +static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cp=
u,
> +                                   MachineState *machine)
>  {
>      int index =3D spapr_get_vcpu_id(cpu);
>      uint32_t associativity[6];
> -    spapr_set_associativity(associativity, cpu->node_id, index);
> +    spapr_set_associativity(associativity, cpu->node_id, index, machine);
> =20
>      /* Advertise NUMA via ibm,associativity */
>      return fdt_setprop(fdt, offset, "ibm,associativity", associativity,
> @@ -335,14 +341,14 @@ static void add_str(GString *s, const gchar *s1)
>  }
> =20
>  static int spapr_dt_memory_node(void *fdt, int nodeid, hwaddr start,
> -                                hwaddr size)
> +                                hwaddr size, MachineState *machine)
>  {
>      uint32_t associativity[5];
>      char mem_name[32];
>      uint64_t mem_reg_property[2];
>      int off;
> =20
> -    spapr_set_associativity(associativity, nodeid, -1);
> +    spapr_set_associativity(associativity, nodeid, -1, machine);
> =20
>      mem_reg_property[0] =3D cpu_to_be64(start);
>      mem_reg_property[1] =3D cpu_to_be64(size);
> @@ -574,6 +580,7 @@ static int spapr_dt_dynamic_reconfiguration_memory(Sp=
aprMachineState *spapr,
>                                                     void *fdt)
>  {
>      MachineState *machine =3D MACHINE(spapr);
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
>      int nb_numa_nodes =3D machine->numa_state->num_nodes;
>      int ret, i, offset;
>      uint64_t lmb_size =3D SPAPR_MEMORY_BLOCK_SIZE;
> @@ -628,12 +635,17 @@ static int spapr_dt_dynamic_reconfiguration_memory(=
SpaprMachineState *spapr,
>      int_buf[1] =3D cpu_to_be32(4); /* Number of entries per associativit=
y list */
>      cur_index +=3D 2;
>      for (i =3D 0; i < nr_nodes; i++) {
> +        uint8_t assoc_domain1 =3D smc->numa_assoc_domains[i][0];
> +        uint8_t assoc_domain2 =3D smc->numa_assoc_domains[i][1];
> +        uint8_t assoc_domain3 =3D smc->numa_assoc_domains[i][2];
> +
>          uint32_t associativity[] =3D {
> -            cpu_to_be32(0x0),
> -            cpu_to_be32(0x0),
> -            cpu_to_be32(0x0),
> +            cpu_to_be32(assoc_domain1),
> +            cpu_to_be32(assoc_domain2),
> +            cpu_to_be32(assoc_domain3),
>              cpu_to_be32(i)

So again, I suggest this be copiedas a blob from a stored vector for
the node, rather than a mix of stored info and locally calculated info
(the final 'i').

>          };
> +
>          memcpy(cur_index, associativity, sizeof(associativity));
>          cur_index +=3D 4;
>      }
> @@ -667,7 +679,7 @@ static int spapr_dt_memory(SpaprMachineState *spapr, =
void *fdt)
>          if (!mem_start) {
>              /* spapr_machine_init() checks for rma_size <=3D node0_size
>               * already */
> -            spapr_dt_memory_node(fdt, i, 0, spapr->rma_size);
> +            spapr_dt_memory_node(fdt, i, 0, spapr->rma_size, machine);
>              mem_start +=3D spapr->rma_size;
>              node_size -=3D spapr->rma_size;
>          }
> @@ -679,7 +691,7 @@ static int spapr_dt_memory(SpaprMachineState *spapr, =
void *fdt)
>                  sizetmp =3D 1ULL << ctzl(mem_start);
>              }
> =20
> -            spapr_dt_memory_node(fdt, i, mem_start, sizetmp);
> +            spapr_dt_memory_node(fdt, i, mem_start, sizetmp, machine);
>              node_size -=3D sizetmp;
>              mem_start +=3D sizetmp;
>          }
> @@ -809,7 +821,7 @@ static void spapr_dt_cpu(CPUState *cs, void *fdt, int=
 offset,
>                        pft_size_prop, sizeof(pft_size_prop))));
> =20
>      if (ms->numa_state->num_nodes > 1) {
> -        _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cpu));
> +        _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cpu, ms));
>      }
> =20
>      _FDT(spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt));
> @@ -1335,7 +1347,7 @@ void *spapr_build_fdt(SpaprMachineState *spapr, boo=
l reset, size_t space)
> =20
>      /* NVDIMM devices */
>      if (mc->nvdimm_supported) {
> -        spapr_dt_persistent_memory(fdt);
> +        spapr_dt_persistent_memory(fdt, machine);
>      }
> =20
>      return fdt;
> @@ -3453,6 +3465,7 @@ static void spapr_nmi(NMIState *n, int cpu_index, E=
rror **errp)
>  int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
>                            void *fdt, int *fdt_start_offset, Error **errp)
>  {
> +    MachineState *machine =3D MACHINE(spapr);
>      uint64_t addr;
>      uint32_t node;
> =20
> @@ -3460,7 +3473,8 @@ int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachi=
neState *spapr,
>      node =3D object_property_get_uint(OBJECT(drc->dev), PC_DIMM_NODE_PRO=
P,
>                                      &error_abort);
>      *fdt_start_offset =3D spapr_dt_memory_node(fdt, node, addr,
> -                                             SPAPR_MEMORY_BLOCK_SIZE);
> +                                             SPAPR_MEMORY_BLOCK_SIZE,
> +                                             machine);
>      return 0;
>  }
> =20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index c1d01228c6..6e94e513cf 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1878,10 +1878,15 @@ static target_ulong h_home_node_associativity(Pow=
erPCCPU *cpu,
>                                                target_ulong opcode,
>                                                target_ulong *args)
>  {
> +    MachineState *machine =3D MACHINE(spapr);
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
>      target_ulong flags =3D args[0];
>      target_ulong procno =3D args[1];
>      PowerPCCPU *tcpu;
>      int idx;
> +    uint8_t assoc_domain1;
> +    uint8_t assoc_domain2;
> +    uint8_t assoc_domain3;
> =20
>      /* only support procno from H_REGISTER_VPA */
>      if (flags !=3D 0x1) {
> @@ -1893,13 +1898,17 @@ static target_ulong h_home_node_associativity(Pow=
erPCCPU *cpu,
>          return H_P2;
>      }
> =20
> +    assoc_domain1 =3D smc->numa_assoc_domains[tcpu->node_id][0];
> +    assoc_domain2 =3D smc->numa_assoc_domains[tcpu->node_id][1];
> +    assoc_domain3 =3D smc->numa_assoc_domains[tcpu->node_id][2];
> +
>      /* sequence is the same as in the "ibm,associativity" property */
> =20
>      idx =3D 0;
>  #define ASSOCIATIVITY(a, b) (((uint64_t)(a) << 32) | \
>                               ((uint64_t)(b) & 0xffffffff))
> -    args[idx++] =3D ASSOCIATIVITY(0, 0);
> -    args[idx++] =3D ASSOCIATIVITY(0, tcpu->node_id);
> +    args[idx++] =3D ASSOCIATIVITY(assoc_domain1, assoc_domain2);
> +    args[idx++] =3D ASSOCIATIVITY(assoc_domain3, tcpu->node_id);
>      args[idx++] =3D ASSOCIATIVITY(procno, -1);
>      for ( ; idx < 6; idx++) {
>          args[idx] =3D -1;
> diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
> index bd109bfc00..7f1f088c39 100644
> --- a/hw/ppc/spapr_nvdimm.c
> +++ b/hw/ppc/spapr_nvdimm.c
> @@ -87,8 +87,9 @@ int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineS=
tate *spapr,
>                             void *fdt, int *fdt_start_offset, Error **err=
p)
>  {
>      NVDIMMDevice *nvdimm =3D NVDIMM(drc->dev);
> +    MachineState *machine =3D MACHINE(spapr);
> =20
> -    *fdt_start_offset =3D spapr_dt_nvdimm(fdt, 0, nvdimm);
> +    *fdt_start_offset =3D spapr_dt_nvdimm(fdt, 0, nvdimm, machine);
> =20
>      return 0;
>  }
> @@ -104,8 +105,8 @@ void spapr_create_nvdimm_dr_connectors(SpaprMachineSt=
ate *spapr)
>  }
> =20
> =20
> -int spapr_dt_nvdimm(void *fdt, int parent_offset,
> -                           NVDIMMDevice *nvdimm)
> +int spapr_dt_nvdimm(void *fdt, int parent_offset, NVDIMMDevice *nvdimm,
> +                    MachineState *machine)
>  {
>      int child_offset;
>      char *buf;
> @@ -120,7 +121,7 @@ int spapr_dt_nvdimm(void *fdt, int parent_offset,
>      uint64_t size =3D object_property_get_int(OBJECT(nvdimm), PC_DIMM_SI=
ZE_PROP,
>                                              NULL);
> =20
> -    spapr_set_associativity(associativity, node, -1);
> +    spapr_set_associativity(associativity, node, -1, machine);
> =20
>      drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM, slot);
>      g_assert(drc);
> @@ -159,7 +160,7 @@ int spapr_dt_nvdimm(void *fdt, int parent_offset,
>      return child_offset;
>  }
> =20
> -void spapr_dt_persistent_memory(void *fdt)
> +void spapr_dt_persistent_memory(void *fdt, MachineState *machine)
>  {
>      int offset =3D fdt_subnode_offset(fdt, 0, "persistent-memory");
>      GSList *iter, *nvdimms =3D nvdimm_get_device_list();
> @@ -177,7 +178,7 @@ void spapr_dt_persistent_memory(void *fdt)
>      for (iter =3D nvdimms; iter; iter =3D iter->next) {
>          NVDIMMDevice *nvdimm =3D iter->data;
> =20
> -        spapr_dt_nvdimm(fdt, offset, nvdimm);
> +        spapr_dt_nvdimm(fdt, offset, nvdimm, machine);
>      }
>      g_slist_free(nvdimms);
> =20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index c02ace226c..4d9ef63f3e 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2355,7 +2355,8 @@ int spapr_dt_phb(SpaprMachineState *spapr, SpaprPhb=
State *phb,
> =20
>      /* Advertise NUMA via ibm,associativity */
>      if (phb->numa_node !=3D -1) {
> -        spapr_set_associativity(associativity, phb->numa_node, -1);
> +        MachineState *machine =3D MACHINE(spapr);
> +        spapr_set_associativity(associativity, phb->numa_node, -1, machi=
ne);
>          _FDT(fdt_setprop(fdt, bus_off, "ibm,associativity", associativit=
y,
>                           sizeof(associativity)));
>      }
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index cd158bf95a..1f9700ac19 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -104,6 +104,9 @@ typedef enum {
> =20
>  #define FDT_MAX_SIZE                    0x100000
> =20
> +/* Taken from Linux kernel arch/powerpc/mm/numa.h */
> +#define MAX_DISTANCE_REF_POINTS         4
> +
>  typedef struct SpaprCapabilities SpaprCapabilities;
>  struct SpaprCapabilities {
>      uint8_t caps[SPAPR_CAP_NUM];
> @@ -131,6 +134,7 @@ struct SpaprMachineClass {
>      hwaddr rma_limit;          /* clamp the RMA to this size */
>      bool pre_5_1_assoc_refpoints;
>      bool pre_5_2_numa_associativity;
> +    uint8_t numa_assoc_domains[MAX_NODES][MAX_DISTANCE_REF_POINTS-1];
> =20
>      void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
>                            uint64_t *buid, hwaddr *pio,=20
> @@ -863,7 +867,8 @@ int spapr_phb_dt_populate(SpaprDrc *drc, SpaprMachine=
State *spapr,
> =20
>  void spapr_rtc_read(SpaprRtcState *rtc, struct tm *tm, uint32_t *ns);
>  int spapr_rtc_import_offset(SpaprRtcState *rtc, int64_t legacy_offset);
> -void spapr_set_associativity(uint32_t *assoc, int node_id, int cpu_index=
);
> +void spapr_set_associativity(uint32_t *assoc, int node_id, int cpu_index,
> +                             MachineState *machine);
> =20
>  #define TYPE_SPAPR_RNG "spapr-rng"
> =20
> diff --git a/include/hw/ppc/spapr_nvdimm.h b/include/hw/ppc/spapr_nvdimm.h
> index b3330cc485..be30773c7d 100644
> --- a/include/hw/ppc/spapr_nvdimm.h
> +++ b/include/hw/ppc/spapr_nvdimm.h
> @@ -27,8 +27,9 @@ QEMU_BUILD_BUG_ON(SPAPR_MINIMUM_SCM_BLOCK_SIZE % SPAPR_=
MEMORY_BLOCK_SIZE);
> =20
>  int spapr_pmem_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
>                             void *fdt, int *fdt_start_offset, Error **err=
p);
> -int spapr_dt_nvdimm(void *fdt, int parent_offset, NVDIMMDevice *nvdimm);
> -void spapr_dt_persistent_memory(void *fdt);
> +int spapr_dt_nvdimm(void *fdt, int parent_offset, NVDIMMDevice *nvdimm,
> +                    MachineState *machine);
> +void spapr_dt_persistent_memory(void *fdt, MachineState *machine);
>  void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm, uint64_t size,
>                                  Error **errp);
>  void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--S0GG+JvAI2G0KxBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl89+1YACgkQbDjKyiDZ
s5LCOA/6Ap+InqJ+vm0a7pNeSRBdx9+SK7RbvHBdAwVIUuaqyK187N0+Qa46hY/Q
5/f/5qJFC79cm9DfJXXlQ9+Ik/0qppQfAWDu9jqC4/zMYA1guJZNVovXuQIH3PDQ
gbcJF2UGXQ8xb0eV/fzXUBdVsgN6Pnk8VFoFtZ8wTvLtqKTvuSxCbaYnQH9gKBnz
7pHxAAqFTjjjGqv7NeuSgbyJfjG67tUaTQg+jRSNxiTuCrW1vFNoYlWeNJRsv9AK
gmF2o85vqTkcGAhVtb2RN6CxiZ+zqEEBrpAZc3o3DX7qt9ZbNHHatNjuLSScahX+
tYoICP+t3l8y6nUAWgozTOc2xFBKWh3XTs2Pfs6V/oQtGJOnBaWJq6dJFS7g0YW+
joIUDMVdCByHeAMeyf4hSKFcvQnTVQwunZFugiXNpOV7VdQo6kcHwhze75A+Tmam
jozhZGWNkdkhZ27szg2+PzXlx0EQQVnziFqk++jx5XgSRD6gfdIe8nY25qtowrBC
SOe2NX6cDOpUO2RfdxCLOb0T4NLmbrEVSWBXUAUklerI2C7f4rhRK9xw/6ghLNXV
xH8yendYB0YIJQLVZugqyY1HuaG3zVeHI3DNcKtnq8A0y/+YGmTyJlAaev1CDeCR
d/GL51AyCHdFF1K9q86tvuNFJbVbUzvhit0kPacX7tx25feH3x0=
=JTVm
-----END PGP SIGNATURE-----

--S0GG+JvAI2G0KxBG--

