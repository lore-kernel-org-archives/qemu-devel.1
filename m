Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411CDC4320D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 01:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EE0D214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 01:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="l4lM9uDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE0D214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCwJo-0007O9-P5
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 21:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iCwHb-0005TX-B5
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 21:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iCwHZ-0003Hj-9l
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 21:39:54 -0400
Received: from ozlabs.org ([203.11.71.1]:52845)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iCwHY-0003HD-Bs; Tue, 24 Sep 2019 21:39:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46dLMm68BJz9sNx; Wed, 25 Sep 2019 11:39:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569375588;
 bh=6ucTAQTlosytJwaQeHMBqAi8zJTOK6PAHLrDKDIpGdI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l4lM9uDkcWCZjsbfDafc6nFoCUiC5CqnYmOBbPY4vv8Z8rWZjwX2xwhPrOpg3D0ia
 ewwTiWezDVS6ByJ8/Dz00Le/xkRpSWhfVegIka5QaVfKjhr+tcuVIxWZYl44JnFnIi
 +wvg0oQkLxmY/4VQv3N34EvhjrVwLHbE//OQoKNA=
Date: Wed, 25 Sep 2019 11:33:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Subject: Re: [PATCH v14 5/7] ppc: spapr: Handle "ibm, nmi-register" and "ibm, 
 nmi-interlock" RTAS calls
Message-ID: <20190925013355.GH17405@umbus>
References: <156879398718.18368.17640174821710157715.stgit@aravinda>
 <156879436343.18368.8562371485748853742.stgit@aravinda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JI+G0+mN8WmwPnOn"
Content-Disposition: inline
In-Reply-To: <156879436343.18368.8562371485748853742.stgit@aravinda>
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--JI+G0+mN8WmwPnOn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 01:42:43PM +0530, Aravinda Prasad wrote:
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
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c         |    9 ++++++++
>  hw/ppc/spapr_rtas.c    |   57 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr.h |    5 +++-
>  3 files changed, 70 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9f2e5d2..6992b32 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2941,6 +2941,15 @@ static void spapr_machine_init(MachineState *machi=
ne)
> =20
>          /* Resize rtas blob to accommodate error log */
>          spapr->rtas_size =3D RTAS_ERROR_LOG_MAX;
> +
> +        /* Set fwnmi capability in KVM */
> +        if (kvmppc_set_fwnmi() < 0) {
> +            error_report("Could not enable FWNMI capability");
> +            exit(1);
> +        }
> +
> +        /* Register ibm,nmi-register and ibm,nmi-interlock RTAS calls */
> +        spapr_fwnmi_register();

This setup only needs to happen if CAP_MCE_FWNMI is turned on, so it
makes more sense in the .apply hooks for that rather than general
machine_init, I think.

>      }
> =20
>      spapr->rtas_blob =3D g_malloc(spapr->rtas_size);
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index d8fb8a8..b569538 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -400,6 +400,55 @@ static void rtas_get_power_level(PowerPCCPU *cpu, Sp=
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
> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) =3D=3D SPAPR_CAP_OFF) {
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
> @@ -544,6 +593,14 @@ hwaddr spapr_get_rtas_addr(void)
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
> index ffefde7..dada821 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -655,8 +655,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target=
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
> @@ -908,4 +910,5 @@ void spapr_check_pagesize(SpaprMachineState *spapr, h=
waddr pagesize,
> =20
>  void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
>  hwaddr spapr_get_rtas_addr(void);
> +void spapr_fwnmi_register(void);
>  #endif /* HW_SPAPR_H */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JI+G0+mN8WmwPnOn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2KxAIACgkQbDjKyiDZ
s5LjZQ//WpAuT3nTWV3Shj5QAwpLURln4sjsUqpXPT8pLfQBCX8XVqvhlp5sykJu
klBdiECYlq/8eEGLa5AnxQdz30ebuTOlCtYTa3VSmxCKblo4KB+eA6rv749b6Sca
hinKluk2xf4KgCJVvCVFYDktqvTC2nySypTR5XinsPHpKUQwYc46HyudeWsDeqvS
Gz7Uuiak+YzST6Uv0JL9fCqJ2Y3ijEZ64C2QKdVLQxAKo9nrnmKWxCZ43ppaP1XX
BZrDf0yiPdLG2ci3Pn0Tnv4iRopS3gx6Jocp0oWnlUwzDDI389+t8oRO0ic9GalG
KYFY+IAwLFPMlDJmvN36P68DDAKXrLQu3lcs3M8sBNHHP3SsknN3Olgnlk3YHR1+
6gtnv9Ub6rB/K1v0DEnFPmFFYyFRdOjZHJgBuOlcSS4bmhj/9xX6kKo9C4HstBP8
xrCP4VS/6B1qyyvmO67f8ATNT2nTYWx0sg+ibcxg2nFyHF+ejj0gsr1t5zLXhGSz
AQcP7QHl7A4keEXJPoMa6GMixaRnFRR/4ananB0jv4ubjTm1ZERO4gDZzPem1K9U
lwAxmSTq+f9p52iKVeIrmWLi9NK3zN9ug/71edpymT4oh1JeIyku8AHoUQqjoAc+
ah5QRWFtNNmTmYPLhDdzoEmQ2KDZY12sJ5TcEnjSI8JzTJUoAQ0=
=vjTz
-----END PGP SIGNATURE-----

--JI+G0+mN8WmwPnOn--

