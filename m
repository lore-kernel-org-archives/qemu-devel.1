Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF40C28CC5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 02:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF782075B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 02:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="o11duXf2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF782075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53008 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYhzu-0005T9-8N
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 22:19:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hYhy9-0004SW-VF
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 22:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hYhy8-00074Z-D2
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 22:17:33 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:35459 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hYhy6-00071b-OR; Wed, 05 Jun 2019 22:17:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45K8SN0PHNz9s9y; Thu,  6 Jun 2019 12:17:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559787444;
	bh=ZpPVNu//noXZEDA078KEd4YEG0EmRdrPFQ3aqhLKjuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o11duXf2AM+nhbUoegCYadpUbsRQzJrtebhbGlm6rEFMdCbIGuLA7Z1YqNh0rwr4p
	prJaQ2cAjU+eQeR4A9StqTFIBM7BK6Arlpn0u6OIh1Rsvz0ZClEpkkr3By64sXZulh
	SV0YarK8EbI44zGx6jUUxs6rr9oC2iF09/igYANY=
Date: Thu, 6 Jun 2019 11:34:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190606013457.GD10319@umbus.fritz.box>
References: <155910829070.13149.5215948335633966328.stgit@aravinda>
	<155910841478.13149.2830700794862210739.stgit@aravinda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
Content-Disposition: inline
In-Reply-To: <155910841478.13149.2830700794862210739.stgit@aravinda>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v9 1/6] ppc: spapr: Handle "ibm,
 nmi-register" and "ibm, nmi-interlock" RTAS calls
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
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, groug@kaod.org, paulus@ozlabs.org,
	qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2019 at 11:10:14AM +0530, Aravinda Prasad wrote:
> This patch adds support in QEMU to handle "ibm,nmi-register"
> and "ibm,nmi-interlock" RTAS calls.
>=20
> The machine check notification address is saved when the
> OS issues "ibm,nmi-register" RTAS call.
>=20
> This patch also handles the case when multiple processors
> experience machine check at or about the same time by
> handling "ibm,nmi-interlock" call. In such cases, as per
> PAPR, subsequent processors serialize waiting for the first
> processor to issue the "ibm,nmi-interlock" call. The second
> processor that also received a machine check error waits
> till the first processor is done reading the error log.
> The first processor issues "ibm,nmi-interlock" call
> when the error log is consumed. This patch implements the
> releasing part of the error-log while subsequent patch
> (which builds error log) handles the locking part.
>=20
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c         |    7 +++++
>  hw/ppc/spapr_rtas.c    |   65 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr.h |    9 ++++++-
>  3 files changed, 80 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e2b33e5..fae28a9 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1808,6 +1808,11 @@ static void spapr_machine_reset(void)
>      first_ppc_cpu->env.gpr[5] =3D 0;
> =20
>      spapr->cas_reboot =3D false;
> +
> +    spapr->guest_machine_check_addr =3D -1;
> +
> +    /* Signal all vCPUs waiting on this condition */
> +    qemu_cond_broadcast(&spapr->mc_delivery_cond);
>  }
> =20
>  static void spapr_create_nvram(SpaprMachineState *spapr)
> @@ -3072,6 +3077,8 @@ static void spapr_machine_init(MachineState *machin=
e)
> =20
>          kvmppc_spapr_enable_inkernel_multitce();
>      }
> +
> +    qemu_cond_init(&spapr->mc_delivery_cond);
>  }
> =20
>  static int spapr_kvm_type(MachineState *machine, const char *vm_type)
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 5bc1a93..e7509cf 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -352,6 +352,38 @@ static void rtas_get_power_level(PowerPCCPU *cpu, Sp=
aprMachineState *spapr,
>      rtas_st(rets, 1, 100);
>  }
> =20
> +static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
> +                                  SpaprMachineState *spapr,
> +                                  uint32_t token, uint32_t nargs,
> +                                  target_ulong args,
> +                                  uint32_t nret, target_ulong rets)
> +{
> +    hwaddr rtas_addr =3D spapr_get_rtas_addr();
> +
> +    if (!rtas_addr) {
> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> +        return;
> +    }
> +
> +    spapr->guest_machine_check_addr =3D rtas_ld(args, 1);
> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +}
> +
> +static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
> +                                   SpaprMachineState *spapr,
> +                                   uint32_t token, uint32_t nargs,
> +                                   target_ulong args,
> +                                   uint32_t nret, target_ulong rets)
> +{
> +    if (spapr->guest_machine_check_addr =3D=3D -1) {
> +        /* NMI register not called */
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +    } else {
> +        qemu_cond_signal(&spapr->mc_delivery_cond);
> +        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +    }
> +}
> +
>  static struct rtas_call {
>      const char *name;
>      spapr_rtas_fn fn;
> @@ -470,6 +502,35 @@ void spapr_load_rtas(SpaprMachineState *spapr, void =
*fdt, hwaddr addr)
>      }
>  }
> =20
> +hwaddr spapr_get_rtas_addr(void)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    int rtas_node;
> +    const struct fdt_property *rtas_addr_prop;
> +    void *fdt =3D spapr->fdt_blob;
> +    uint32_t rtas_addr;
> +
> +    /* fetch rtas addr from fdt */
> +    rtas_node =3D fdt_path_offset(fdt, "/rtas");
> +    if (rtas_node =3D=3D 0) {
> +        return 0;

This is incorrect, a return code < 0 indicates an error which you
should check for.  A return code of 0 indicates the root node, which
could only happen if libfdt was badly buggy.

> +    }
> +
> +    rtas_addr_prop =3D fdt_get_property(fdt, rtas_node, "linux,rtas-base=
", NULL);

fdt_get_property is generally only needed for certain edge cases.
fdt_getprop() is a better option.

> +    if (!rtas_addr_prop) {
> +        return 0;
> +    }
> +
> +    /*
> +     * We assume that the OS called RTAS instantiate-rtas, but some other
> +     * OS might call RTAS instantiate-rtas-64 instead. This fine as of n=
ow
> +     * as SLOF only supports 32-bit variant.
> +     */
> +    rtas_addr =3D fdt32_to_cpu(*(uint32_t *)rtas_addr_prop->data);
> +    return (hwaddr)rtas_addr;
> +}
> +
> +
>  static void core_rtas_register_types(void)
>  {
>      spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-character",
> @@ -493,6 +554,10 @@ static void core_rtas_register_types(void)
>                          rtas_set_power_level);
>      spapr_rtas_register(RTAS_GET_POWER_LEVEL, "get-power-level",
>                          rtas_get_power_level);
> +    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register",
> +                        rtas_ibm_nmi_register);
> +    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
> +                        rtas_ibm_nmi_interlock);
>  }
> =20
>  type_init(core_rtas_register_types)
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 4f5becf..9dc5e30 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -188,6 +188,10 @@ struct SpaprMachineState {
>       * occurs during the unplug process. */
>      QTAILQ_HEAD(, SpaprDimmState) pending_dimm_unplugs;
> =20
> +    /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" calls=
 */
> +    target_ulong guest_machine_check_addr;
> +    QemuCond mc_delivery_cond;
> +
>      /*< public >*/
>      char *kvm_type;
>      char *host_model;
> @@ -624,8 +628,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target=
_ulong opcode,
>  #define RTAS_IBM_CREATE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x27)
>  #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
>  #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
> +#define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2A)
> +#define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2B)
> =20
> -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2A)
> +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2C)
> =20
>  /* RTAS ibm,get-system-parameter token values */
>  #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
> @@ -876,4 +882,5 @@ void spapr_check_pagesize(SpaprMachineState *spapr, h=
waddr pagesize,
>  #define SPAPR_OV5_XIVE_BOTH     0x80 /* Only to advertise on the platfor=
m */
> =20
>  void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
> +uint64_t spapr_get_rtas_addr(void);
>  #endif /* HW_SPAPR_H */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlz4bb4ACgkQbDjKyiDZ
s5Km7Q//XxltU1Y6Qrt2Q+wQEMlJ8zWgJGZG78vZAguoCwQsvxe3JAQ7sXKSTwVY
14SPpL0XYz1e+T8AShCRkYxfqr60YyJXDIzLWJOrv540Ma/o6WBxSyqXsBWUA8n9
O+C/6Dzh7ZuNgDMY7xiba4lDcoWeMug5lT5EDBNLSFXk4USijWVP8Ke2vb6iCbxx
B4davIsmEP4yG/8N5hQ4SPDKLvti5QObyTTfUQkWOT3nIFfMhYs2XS/gAIzwLni5
KwTv61Nl9PwnXlEfylA+UZLFqOa9M5nkvL4BgfTly2JF7yXTrrxLVL+H6uuuyrVW
YNmyRAMqIi87PmjcTgnlKVgFC8oDXznMhrasns8vZ+BdkLH1eAGkB+E3AMOH/J47
WQ9HJPdbbeOOYN3VNXpV8WpqWh6X5OqCGhRPF7uLhKyoG4RvIEEHKJto9llPYOSx
hhgzhfXU4DbdLZZgC8Yndfw6kzEnofbHvfKCoCHlP+wxynfBqdycSk3nqGp2z4fO
tSAR3fMmzO3qU3TqVHOi+mrBStc+UzPsAHYs400cOOMbMaVYoWb7yngU5KXU0RMq
4bYvrk9a4maZ3eEgeNLDJjFKh/+PyEyPbFeAPnxy4yvFZN/5SMkBgGf3y525yCT6
mAhOVK5e7EYWdSbHmVeL4JLE+2ZPfGcaikVUylJZhB0yAjyl3nw=
=Wyu5
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--

