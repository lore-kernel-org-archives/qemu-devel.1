Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C78C3276D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 02:27:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758E121D56
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 02:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bL04F7Mw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758E121D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inCgG-0003cM-6R
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 21:27:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1inCf4-0002Ab-6a
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 21:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1inCf2-00062E-Ah
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 21:26:02 -0500
Received: from ozlabs.org ([203.11.71.1]:53751)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1inCf0-0005jn-43; Thu, 02 Jan 2020 21:26:00 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47ppfk4QK6z9sRG; Fri,  3 Jan 2020 13:25:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578018350;
 bh=Ef633iE+rJY3SbV1KGTTq0y8s3+uJUhawIxzDSPIx5k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bL04F7Mw9tX3aUQ4QiO0CAGAT7fdF353ENPzu3/wLJrEiPJD9f8A22zhwkSJf9JTc
 V2zrPL6dj8Rc0TXWFB9tIA3gxB7AnWCXiKl2tztEXiKzRInCHAR9RbLoSAdGsw/TuW
 S5yhsjv8lnT2jnh03xur+gRVdT8r1H2T+9SYq6H8=
Date: Fri, 3 Jan 2020 13:19:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Ganesh Goudar <ganeshgr@linux.ibm.com>
Subject: Re: [PATCH v18 5/7] ppc: spapr: Handle "ibm,nmi-register" and
 "ibm,nmi-interlock" RTAS calls
Message-ID: <20200103021959.GR2098@umbus>
References: <20200102075111.25308-1-ganeshgr@linux.ibm.com>
 <20200102075111.25308-6-ganeshgr@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="e7jIye1Ygp5H0AIi"
Content-Disposition: inline
In-Reply-To: <20200102075111.25308-6-ganeshgr@linux.ibm.com>
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


--e7jIye1Ygp5H0AIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2020 at 01:21:09PM +0530, Ganesh Goudar wrote:
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
> [Move fwnmi registration to .apply hook]
> Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
> Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
> ---
>  hw/ppc/spapr_caps.c    |  6 +++++
>  hw/ppc/spapr_rtas.c    | 58 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  7 ++++-
>  3 files changed, 70 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 3001098601..e922419cfb 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -502,6 +502,12 @@ static void cap_fwnmi_mce_apply(SpaprMachineState *s=
papr, uint8_t val,
>      if (!val) {
>          return; /* Disabled by default */
>      }
> +
> +    if (!spapr->fwnmi_calls_registered && !kvmppc_set_fwnmi()) {

So, we definitely need the kvmppc_set_fwnmi() call here.  But in the
case where we *do* have KVM, but the call fails, we should fail the
=2Eapply hook, rather than ignoring it silently.

As we've discussed although TCG behaviour with fwnmi isn't 100%
correct, it's close enough to pass for most purposes - so it's
reasonable to continue if the cap is selected.  But if the cap is
selected and we're running with KVM we *must* enable the capability in
KVM or we're not providing the environment the user requested.

> +        /* Register ibm,nmi-register and ibm,nmi-interlock RTAS calls */
> +        spapr_fwnmi_register();

We discussed registering the hypercalls here, but I thought after that
I suggested just always registering them, and having them bail out
when called if the cap is not set.  I see that you've implemented that
bailout for register, though not for interlock.  I think that's
simpler than registering them here.

> +        spapr->fwnmi_calls_registered =3D true;
> +    }
>  }
> =20
>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 2c066a372d..54b142f35b 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -400,6 +400,56 @@ static void rtas_get_power_level(PowerPCCPU *cpu, Sp=
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
> @@ -503,6 +553,14 @@ hwaddr spapr_get_rtas_addr(void)
>      return (hwaddr)fdt32_to_cpu(*rtas_data);
>  }
> =20
> +void spapr_fwnmi_register(void)
> +{
> +    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register",
> +                        rtas_ibm_nmi_register);
> +    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
> +                        rtas_ibm_nmi_interlock);
> +}
> +
>  static void core_rtas_register_types(void)
>  {
>      spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-character",
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 652a5514e8..a90e677cc3 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -218,6 +218,8 @@ struct SpaprMachineState {
> =20
>      unsigned gpu_numa_id;
>      SpaprTpmProxy *tpm_proxy;
> +
> +    bool fwnmi_calls_registered;
>  };
> =20
>  #define H_SUCCESS         0
> @@ -656,8 +658,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target=
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
> @@ -908,4 +912,5 @@ void spapr_check_pagesize(SpaprMachineState *spapr, h=
waddr pagesize,
> =20
>  void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
>  hwaddr spapr_get_rtas_addr(void);
> +void spapr_fwnmi_register(void);
>  #endif /* HW_SPAPR_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--e7jIye1Ygp5H0AIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4OpMwACgkQbDjKyiDZ
s5JPNQ/+L16eHcqoWpynJx9xQQgRruCsgfQAbsYcktTVtJjl59oAzsDO1QQfnEBR
5E8QGGEXmXylPyL0B1OdlrDB5Xeyx32edMVY6Pi3zGqKYcjSURgLueKOnfQBBB58
8d0hXPic3qL7YVumhUjYU8vd1xIjIN8s3gBN0Vc3jmrK6SJgwJDTaanHB3R5Jb3q
rQ2EGh+X9urQ5XCiM3XIuIqZTYD2iW9hb0o+Yaog8qk5rHuTAWNkh8AZ8nsynwXQ
e8PMExFAtgEEODFfj37nmNZbOm4r7F+rbLUl24//hdtBAkfp6o1T/VK7CVCMqYQF
5q7qt3pa6SzxNkTv1WDQrncliN13KGbjvEzHZykHYwnJjfYdpZKkxBk+WWVAJ/eN
f43OHQ+W79uDqgcmFy3yJhC8OF/egzgtUhmxv6CbKfBvM0LFZXzAMAZ/pFbGtL4d
qpfA/XJ/QEY3cfbcuYe6mu3+XI4aRH8xRc/fW9EOv7EpcbuT7XBLpJHYs65YpFOM
w1JfQCHfzmyq7RC96RZ40063kVB3M5IbIKdE3gJwBxO2Mb31cALZ1IEcNrRM4kl3
vv+o7CRh/QhLdAHcNap/aWDwer5jXA1wjRtMxACcP/4L3izT6Mv1gqb9M14Me1bK
dDYxMwJ3/0Cf3aPDpOQ7OQn1ZQ6AC0aN+WQnmfHyQvEuK8aQxh4=
=vEEH
-----END PGP SIGNATURE-----

--e7jIye1Ygp5H0AIi--

