Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE275C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 05:10:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C59206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 05:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lL0exfsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C59206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd5Nd-0005vY-U7
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 01:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jd5LK-000323-5k; Mon, 25 May 2020 01:08:06 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:41457 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jd5LH-00047e-If; Mon, 25 May 2020 01:08:05 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49VlTk58ZVz9sSg; Mon, 25 May 2020 15:07:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590383274;
 bh=a59gNMUkuQ8rm2u4zCsZZZGR8hWK7rCC7hL6cMglZzc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lL0exfsicWUR+6hPeNGrP1RwCDr1LwkQJ/h8jl3SLknSawiLDG1EvFqop6abcu0HN
 X6jATrgyNYRrGVgoP//by9TN2l95WcFS/p3J6ATOM2EFgloPcYUMwjGL4fl5JGMD0z
 F6yfGcfG7MBX/3+YH8HmwVXK4IqFmCWPZEBIMCq4=
Date: Mon, 25 May 2020 15:05:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Reza Arbab <arbab@linux.ibm.com>
Subject: Re: [PATCH v3] spapr: Add a new level of NUMA for GPUs
Message-ID: <20200525050550.GA23110@umbus.fritz.box>
References: <1590177213-4513-1-git-send-email-arbab@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <1590177213-4513-1-git-send-email-arbab@linux.ibm.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Daniel Henrique Barboza <danielhb@linux.ibm.com>,
 Leonardo Augusto Guimaraes Garcia <lagarcia@linux.ibm.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2020 at 02:53:33PM -0500, Reza Arbab wrote:
> NUMA nodes corresponding to GPU memory currently have the same
> affinity/distance as normal memory nodes. Add a third NUMA associativity
> reference point enabling us to give GPU nodes more distance.
>=20
> This is guest visible information, which shouldn't change under a
> running guest across migration between different qemu versions, so make
> the change effective only in new (pseries > 5.0) machine types.
>=20
> Before, `numactl -H` output in a guest with 4 GPUs (nodes 2-5):
>=20
> node distances:
> node   0   1   2   3   4   5
>   0:  10  40  40  40  40  40
>   1:  40  10  40  40  40  40
>   2:  40  40  10  40  40  40
>   3:  40  40  40  10  40  40
>   4:  40  40  40  40  10  40
>   5:  40  40  40  40  40  10
>=20
> After:
>=20
> node distances:
> node   0   1   2   3   4   5
>   0:  10  40  80  80  80  80
>   1:  40  10  80  80  80  80
>   2:  80  80  10  80  80  80
>   3:  80  80  80  10  80  80
>   4:  80  80  80  80  10  80
>   5:  80  80  80  80  80  10
>=20
> These are the same distances as on the host, mirroring the change made
> to host firmware in skiboot commit f845a648b8cb ("numa/associativity:
> Add a new level of NUMA for GPU's").
>=20
> Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
> ---
> v3:
> * Squash into one patch
> * Add PHB compat property
> ---
>  hw/ppc/spapr.c              | 21 +++++++++++++++++++--
>  hw/ppc/spapr_pci.c          |  2 ++
>  hw/ppc/spapr_pci_nvlink2.c  |  7 ++++++-
>  include/hw/pci-host/spapr.h |  1 +
>  include/hw/ppc/spapr.h      |  1 +
>  5 files changed, 29 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c18eab0a2305..7c304b6c389d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -889,10 +889,16 @@ static int spapr_dt_rng(void *fdt)
>  static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>  {
>      MachineState *ms =3D MACHINE(spapr);
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(ms);
>      int rtas;
>      GString *hypertas =3D g_string_sized_new(256);
>      GString *qemu_hypertas =3D g_string_sized_new(256);
> -    uint32_t refpoints[] =3D { cpu_to_be32(0x4), cpu_to_be32(0x4) };
> +    uint32_t refpoints[] =3D {
> +        cpu_to_be32(0x4),
> +        cpu_to_be32(0x4),
> +        cpu_to_be32(0x2),
> +    };
> +    uint32_t nr_refpoints =3D 3;
>      uint64_t max_device_addr =3D MACHINE(spapr)->device_memory->base +
>          memory_region_size(&MACHINE(spapr)->device_memory->mr);
>      uint32_t lrdr_capacity[] =3D {
> @@ -944,8 +950,12 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, =
void *fdt)
>                       qemu_hypertas->str, qemu_hypertas->len));
>      g_string_free(qemu_hypertas, TRUE);
> =20
> +    if (smc->pre_5_1_assoc_refpoints) {
> +        nr_refpoints =3D 2;
> +    }
> +
>      _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-points",
> -                     refpoints, sizeof(refpoints)));
> +                     refpoints, nr_refpoints * sizeof(refpoints[0])));
> =20
>      _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
>                       maxdomains, sizeof(maxdomains)));
> @@ -4607,8 +4617,15 @@ DEFINE_SPAPR_MACHINE(5_1, "5.1", true);
>   */
>  static void spapr_machine_5_0_class_options(MachineClass *mc)
>  {
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> +    static GlobalProperty compat[] =3D {
> +        { TYPE_SPAPR_PCI_HOST_BRIDGE, "pre-5.1-associativity", "on" },
> +    };
> +
>      spapr_machine_5_1_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
> +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> +    smc->pre_5_1_assoc_refpoints =3D true;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(5_0, "5.0", false);
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 61b84a392d65..bcdf1a25ae8b 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2092,6 +2092,8 @@ static Property spapr_phb_properties[] =3D {
>                       pcie_ecs, true),
>      DEFINE_PROP_UINT64("gpa", SpaprPhbState, nv2_gpa_win_addr, 0),
>      DEFINE_PROP_UINT64("atsd", SpaprPhbState, nv2_atsd_win_addr, 0),
> +    DEFINE_PROP_BOOL("pre-5.1-associativity", SpaprPhbState,
> +                     pre_5_1_assoc, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
> index 8332d5694e46..3394ac425eee 100644
> --- a/hw/ppc/spapr_pci_nvlink2.c
> +++ b/hw/ppc/spapr_pci_nvlink2.c
> @@ -362,7 +362,7 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *s=
phb, void *fdt)
>          uint32_t associativity[] =3D {
>              cpu_to_be32(0x4),
>              SPAPR_GPU_NUMA_ID,
> -            SPAPR_GPU_NUMA_ID,
> +            cpu_to_be32(nvslot->numa_id),
>              SPAPR_GPU_NUMA_ID,
>              cpu_to_be32(nvslot->numa_id)


This doesn't look quite right.  In the new case we'll get {
GPU_NUMA_ID, nvslot->numa_id, GPU_NUMA_ID, nvslot->numa_id }.

>          };
> @@ -374,6 +374,11 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *=
sphb, void *fdt)
>          _FDT(off);
>          _FDT((fdt_setprop_string(fdt, off, "device_type", "memory")));
>          _FDT((fdt_setprop(fdt, off, "reg", mem_reg, sizeof(mem_reg))));
> +
> +        if (sphb->pre_5_1_assoc) {
> +            associativity[2] =3D SPAPR_GPU_NUMA_ID;
> +        }
> +
>          _FDT((fdt_setprop(fdt, off, "ibm,associativity", associativity,
>                            sizeof(associativity))));
> =20
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 8877ff51fbf7..600eb55c3488 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -94,6 +94,7 @@ struct SpaprPhbState {
>      hwaddr nv2_gpa_win_addr;
>      hwaddr nv2_atsd_win_addr;
>      SpaprPhbPciNvGpuConfig *nvgpus;
> +    bool pre_5_1_assoc;
>  };
> =20
>  #define SPAPR_PCI_MEM_WIN_BUS_OFFSET 0x80000000ULL
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index e579eaf28c05..8316d9eea405 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -129,6 +129,7 @@ struct SpaprMachineClass {
>      bool linux_pci_probe;
>      bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
>      hwaddr rma_limit;          /* clamp the RMA to this size */
> +    bool pre_5_1_assoc_refpoints;
> =20
>      void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
>                            uint64_t *buid, hwaddr *pio,=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7LUisACgkQbDjKyiDZ
s5KSug//b7QbWvThprrXqWylKy/+Ee1KJzay2G/wKwTkLfCSSc7NqXp1x2WQj79c
KzdR0Qx3I0jbTNlm3We37B0q+nq2mwnNJ5EWb55zVwRkESwdPFpDMs4Z/BOcuURV
DLSk7e5qBDB7hz+4+IHQiAUN/Uvd9eabLN6ewrt4+xigr3TQdm3uI5jPCbklhja6
f8j+0mzByCCxyzp/U/oYecE+fvXwQ9PF3p/IwF8Ylvrv0Px/QtycMzB2sEfJgPgY
/4ALN2CdVQb+PWFBibpfMzt3hv79Vs2g2NGokFRE/n0NwGNhxqoYFvQw7yR72uLU
Vq+cxN4PYbSkp0b5pcjhqtduNW2mWYIc5U1aJnQRjT94STjtlfG6jfbJd0PgUcZb
2anv/HOx/Hjuh6z8cLhJ4AXrGZg25KniowrvWUzRV36MNFLI4TdOcYhNWhEDws/u
P5nYRxUNknEiEHEZw5vblE1+V2oRn65t+E+PObTgMOM/ok2gE+leKg/l67P2jmxQ
KplkXUptCUfMohtbx9NNKFlKI0c6a8Q+OTZI3M4RrRpt4MRA6XM9KBCX0GgtyPkI
Q83yKROU2cdjzTaY+ZP68RkwvTcLNuKRX17Cm3VP7NMAmN6O9i/7bjdoE+GULO/P
TMqHr2ekQyfH97Q0ViGV+pxfUljVwqLjGsEGdJA3S454+/sl+Nk=
=8XvF
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--

