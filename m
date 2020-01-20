Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235B7C33CAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 00:51:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3833206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 00:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GcxeoP87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3833206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itLHU-0001SA-JA
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 19:51:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1itLFW-0007wj-7V
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 19:49:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1itLFU-00036F-7y
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 19:49:01 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:53409 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1itLFT-00031Q-5k; Sun, 19 Jan 2020 19:49:00 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 481Cj25YSvz9sRK; Mon, 20 Jan 2020 11:48:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579481334;
 bh=LO+bZG2UG3ygBITNX5k7YAXmumGnbEy16Io0j3fCH80=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GcxeoP87B288LOVI0FbUb4yx7ZuKf79xgM0GyfDamjypbr3zCubQDxwNOeOUlmJu3
 KMuiDvVen6VQqVrnrzY+zvIw46HUUhGOiAGwqDDEzPGyHXV83drEpkTw739RyRPi0P
 yPVhizYh6oONgC5BQMAZ/vLRHYz6O2cWCTZ0sNHc=
Date: Mon, 20 Jan 2020 11:46:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Ganesh Goudar <ganeshgr@linux.ibm.com>
Subject: Re: [PATCH v20 5/7] ppc: spapr: Handle "ibm,nmi-register" and
 "ibm,nmi-interlock" RTAS calls
Message-ID: <20200120004633.GI54439@umbus>
References: <20200117093855.19074-1-ganeshgr@linux.ibm.com>
 <20200117093855.19074-6-ganeshgr@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="K511Q2pAJ3dpTMb/"
Content-Disposition: inline
In-Reply-To: <20200117093855.19074-6-ganeshgr@linux.ibm.com>
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>, aik@ozlabs.ru,
 qemu-devel@nongnu.org, groug@kaod.org, paulus@ozlabs.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--K511Q2pAJ3dpTMb/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2020 at 03:08:53PM +0530, Ganesh Goudar wrote:
> From: Aravinda Prasad <arawinda.p@gmail.com>
>=20
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
> when the error log is consumed.
>=20
> Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
> [Register fwnmi RTAS calls in core_rtas_register_types()
>  where other RTAS calls are registered]
> Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
> ---
>  hw/ppc/spapr_caps.c    |  7 +++++
>  hw/ppc/spapr_rtas.c    | 59 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  4 ++-
>  3 files changed, 69 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 3001098601..c43498da49 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -502,6 +502,13 @@ static void cap_fwnmi_mce_apply(SpaprMachineState *s=
papr, uint8_t val,
>      if (!val) {
>          return; /* Disabled by default */
>      }
> +
> +    if (kvm_enabled()) {
> +        if (kvmppc_set_fwnmi() < 0) {
> +            error_report("Could not enable fwnmi capability");
> +            exit(1);

We have uniform failure handling for the cap_apply functions so you
shouldn't roll your own.  Simply error_setg() on the supplied errp,
and the generic caps code will handle exiting out.

Also, I think you should explicitly mention KVM in this message, to
make it clear that's where the problem is occurring.  From the user's
point of view they've just *set* the spapr fwnmi capability so this
won't help them figure out why it isn't working.

Also, weren't you going to report a (non fatal) warning in the TCG
case, since TCG FWNMI behaviour doesn't precisely match true FWNMI
behaviour (though in a way that probably won't matter in practice).

> +        }
> +    }
>  }
> =20
>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 2c066a372d..3f162d82f5 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -400,6 +400,61 @@ static void rtas_get_power_level(PowerPCCPU *cpu, Sp=
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
> +    hwaddr rtas_addr;
> +
> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) =3D=3D SPAPR_CAP_OFF) {
> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> +        return;
> +    }
> +
> +    rtas_addr =3D spapr_get_rtas_addr();
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
> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) =3D=3D SPAPR_CAP_OFF) {
> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> +        return;
> +    }
> +
> +    if (spapr->guest_machine_check_addr =3D=3D -1) {
> +        /* NMI register not called */
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +        return;
> +    }
> +
> +    if (spapr->mc_status !=3D cpu->vcpu_id) {
> +        /* The vCPU that hit the NMI should invoke "ibm,nmi-interlock" */
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +        return;
> +    }
> +
> +    /*
> +     * vCPU issuing "ibm,nmi-interlock" is done with NMI handling,
> +     * hence unset mc_status.
> +     */
> +    spapr->mc_status =3D -1;
> +    qemu_cond_signal(&spapr->mc_delivery_cond);
> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> +}
> +
>  static struct rtas_call {
>      const char *name;
>      spapr_rtas_fn fn;
> @@ -528,6 +583,10 @@ static void core_rtas_register_types(void)
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
> index 652a5514e8..f6f82d88aa 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -656,8 +656,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target=
_ulong opcode,
>  #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
>  #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
>  #define RTAS_IBM_SUSPEND_ME                     (RTAS_TOKEN_BASE + 0x2A)
> +#define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2B)
> +#define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2C)
> =20
> -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2B)
> +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2D)
> =20
>  /* RTAS ibm,get-system-parameter token values */
>  #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--K511Q2pAJ3dpTMb/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4k+GkACgkQbDjKyiDZ
s5KJ9hAAp79nTEHkuJ8KC4FepvpOQBCP7i5QeQquI3lEmG+zmR8zpbBjV+t+Dm81
MeWlWuULoZiGcQ8buZ+TCFXuwAG1xnYN6uiM3uXtPNqFFezz0vp9+s9wfYMGZlYI
taR2DpL227oy4xoZdY9sJaL/wrmiNKm0dwG25ffc8h7cCzMcFyL6+u35ia26UTvo
WLirSF6j4r13Ip3aRzvRQRD3mQv53JOzHv3LjNCh/Iah6ejfwct5LKPdo6j5K/XX
OZICBWiPNXuG558n3sRBOz4ka1RSAWk4ci/ebg1kNECf0LSxERwpgqTwcdzIw6Up
Dav7BqGKEAxo8CZuUuEh4vreu6ESFTxtf0fSlYkt3OceGrHYC+Ipx8XAprZv6CaF
dV17f1ji9UOT0elAtIRjKEklqILhP3DqW72KQ7Qkt3pW97tgeeyEuf0HsD1AWmoh
rd7FnkfNcZE0sMdQAONd8iHyXRKHJSwI1JDlCO7w3V9KclEvr9mdXYMIwHxO4UgF
fTOtplTkcgNqiccttJI4daBdQUaFPTyUvZ+ooUYqH6LY5FLSF3dB+WNNEJd7YmfW
A+3Jh1300LVo3s9gk8Giz5FRaMGmO+olUjFiTprRVxfn2/4BDQyP2jOB+xNiTcUY
lKbI3B9DW3DeVBC4faO7O/c6Ar1OiBnRULCjX3zEMNxK17rzv0s=
=eO+/
-----END PGP SIGNATURE-----

--K511Q2pAJ3dpTMb/--

