Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EEDC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 06:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A50620843
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 06:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Bx1ufMal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A50620843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49069 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIpDC-00071A-BS
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 02:47:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hIpCE-0006gP-6r
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 02:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hIpCC-00055f-7U
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 02:46:26 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36141 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hIpCB-00054W-1j; Tue, 23 Apr 2019 02:46:24 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44pDVy40Gsz9sDn; Tue, 23 Apr 2019 16:46:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556001978;
	bh=wBHwSlCidEzOIgYG8jkuXyR9lPB/GTiW0dJAYvW5hF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bx1ufMaliwdhstwuRj+Sao78IWlUsli8ViEhN/0OvvyZwk+xG9cqQi2c/OXcQI0Pd
	t2x4/3eSYcZDJpLYGj8EcmiXQStSJm0Znm8Atu62Mwh5W1G7d2P3qLB997XDPr3pv1
	o1AJp+dL+wvwKRe45o8WCff8CQ+oURFRs6aiXKo8=
Date: Tue, 23 Apr 2019 16:45:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190423064536.GD31496@umbus.fritz.box>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591657807.20338.12115795588476734752.stgit@aravinda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Content-Disposition: inline
In-Reply-To: <155591657807.20338.12115795588476734752.stgit@aravinda>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v8 1/6] ppc: spapr: Handle "ibm,
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
Cc: paulus@ozlabs.org, qemu-ppc@nongnu.org, aik@au1.ibm.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423064537.bnapPd48C0p2QcV24w4my7D057FjSLlMTjFBwPK9kwA@z>


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2019 at 12:32:58PM +0530, Aravinda Prasad wrote:
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

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Although I wonder if it needs to be moved later in the series to avoid
advertising the availability of the RTAS calls to the guest before all
the prereq patches are in place to make them work properly.

> ---
>  hw/ppc/spapr.c         |   18 ++++++++++++++
>  hw/ppc/spapr_rtas.c    |   61 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr.h |    9 ++++++-
>  3 files changed, 87 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c56939a..6642cb5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1805,6 +1805,11 @@ static void spapr_machine_reset(void)
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
> @@ -2095,6 +2100,16 @@ static const VMStateDescription vmstate_spapr_dtb =
=3D {
>      },
>  };
> =20
> +static const VMStateDescription vmstate_spapr_machine_check =3D {
> +    .name =3D "spapr_machine_check",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT64(guest_machine_check_addr, SpaprMachineState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription vmstate_spapr =3D {
>      .name =3D "spapr",
>      .version_id =3D 3,
> @@ -2127,6 +2142,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_dtb,
>          &vmstate_spapr_cap_large_decr,
>          &vmstate_spapr_cap_ccf_assist,
> +        &vmstate_spapr_machine_check,
>          NULL
>      }
>  };
> @@ -3068,6 +3084,8 @@ static void spapr_machine_init(MachineState *machin=
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
> index ee24212..c2f3991 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -348,6 +348,39 @@ static void rtas_get_power_level(PowerPCCPU *cpu, Sp=
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
> +    uint64_t rtas_addr =3D spapr_get_rtas_addr();
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
> +    if (!spapr->guest_machine_check_addr) {
> +        /* NMI register not called */
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +    } else {
> +        qemu_cond_signal(&spapr->mc_delivery_cond);
> +        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +    }
> +}
> +
> +
>  static struct rtas_call {
>      const char *name;
>      spapr_rtas_fn fn;
> @@ -466,6 +499,30 @@ void spapr_load_rtas(SpaprMachineState *spapr, void =
*fdt, hwaddr addr)
>      }
>  }
> =20
> +uint64_t spapr_get_rtas_addr(void)
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
> +    }
> +
> +    rtas_addr_prop =3D fdt_get_property(fdt, rtas_node, "linux,rtas-base=
", NULL);
> +    if (!rtas_addr_prop) {
> +        return 0;
> +    }
> +
> +    rtas_addr =3D fdt32_to_cpu(*(uint32_t *)rtas_addr_prop->data);
> +    return (uint64_t)rtas_addr;
> +}
> +
> +
>  static void core_rtas_register_types(void)
>  {
>      spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-character",
> @@ -489,6 +546,10 @@ static void core_rtas_register_types(void)
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
> index 7e32f30..ec6f33e 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -187,6 +187,10 @@ struct SpaprMachineState {
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
> @@ -623,8 +627,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target=
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
> @@ -874,4 +880,5 @@ void spapr_check_pagesize(SpaprMachineState *spapr, h=
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

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAly+tJAACgkQbDjKyiDZ
s5KObg//UUUaiYirXLaGa4fgQtaU93S9+lWgJ4zj2uBTd8OeDIecZ6RqcKutq2Ck
sp+YiX4HnUInE7q7y/kHhoxUVi21WF1M/pDazAzIuzNtTstg/AqrFrq1QlALesqE
M1Qqjbds4In6sDV5mDa/ob0nJjfA68XWIfR8SP3qvia/cp+yBCIpqvCqKF6oUncx
d38x8Zxcu/4sSTV7eQT/NUe4yHhmJrFpKgtSEs6g8KRUEBqZqz9S0js39U6Tysk3
+QGnv6yJKtT4fmJS96f+VjUQKQkXw8SJzxDHgxJLKMIft/YGFc2DnRLJwTawxiLV
wyXWLOtLqM1E6Nh+oAJQ4jjkSZWkJEmoQh7xAoFh7/Q7vz133AdsN2wjQHpZlA3x
Sm0jAj3CZH89TpURLKdNm41OFO0+dedDzbC6SGyq6HdNDHtMZRDHrj6PxulxreeF
sW9g3cJmZGHgMN9xEjGx7SC9Xb5ebu+1WVBzHnm6206X079LJO3i7r5PHZpR1DNw
bY8QpVxbBjscvtq3XtO1GAEmjEeH6Ez5JVFXmTzvIA3R0by1cb7ucUUhpOHHC6dM
eH1dcM2HFoW3ghY6y6SHM9RLurB6+Xq9FVlTeRaNYN8XPR5WthmocpQIKXTXjlRt
ftkh76efWkTqghRZwdXMB5qYoLBtYbxpu3xAeDh1O5W4vOsJ5Ek=
=PZ8Q
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--

