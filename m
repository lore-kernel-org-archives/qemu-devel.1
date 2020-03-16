Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A84C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 23:12:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E403C20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 23:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="RXJiF4EI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E403C20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDyuh-0008Pq-3c
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 19:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jDys6-0004c4-Ji
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 19:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jDys5-00040o-1l
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 19:10:10 -0400
Received: from ozlabs.org ([203.11.71.1]:52725)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jDys3-0003VF-Q3; Mon, 16 Mar 2020 19:10:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hBpj080Jz9sRR; Tue, 17 Mar 2020 10:10:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584400205;
 bh=tFwaLF6KqT/GTJ1cW9sHDcbkLpguWm+pKPdq9WHCGC8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RXJiF4EIdSxmMdPf3DEWOXkO98ByPCN4aOX5CBIDOR30UWBI2SbryTKHk6FyQu7xc
 zFYRYIqagNkpQrZl2xI9zcgSGF21Q+XdKyR8Zg+A4iknHheQ2uzRd2KJKq8sxAC8g8
 xTjgwb/6F6aVRBzoXh+haGlJMTghZjRX9h4jDALE=
Date: Tue, 17 Mar 2020 09:47:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 3/8] ppc/spapr: Add FWNMI System Reset state
Message-ID: <20200316224718.GC20264@umbus.fritz.box>
References: <20200316142613.121089-1-npiggin@gmail.com>
 <20200316142613.121089-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Content-Disposition: inline
In-Reply-To: <20200316142613.121089-4-npiggin@gmail.com>
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2020 at 12:26:08AM +1000, Nicholas Piggin wrote:
> The FWNMI option must deliver system reset interrupts to their
> registered address, and there are a few constraints on the handler
> addresses specified in PAPR. Add the system reset address state and
> checks.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to ppc-for-5.0, thanks.

> ---
>  hw/ppc/spapr.c         |  2 ++
>  hw/ppc/spapr_rtas.c    | 14 +++++++++++++-
>  include/hw/ppc/spapr.h |  3 ++-
>  3 files changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b03b26370d..5f93c49706 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1704,6 +1704,7 @@ static void spapr_machine_reset(MachineState *machi=
ne)
> =20
>      spapr->cas_reboot =3D false;
> =20
> +    spapr->fwnmi_system_reset_addr =3D -1;
>      spapr->fwnmi_machine_check_addr =3D -1;
>      spapr->fwnmi_machine_check_interlock =3D -1;
> =20
> @@ -2023,6 +2024,7 @@ static const VMStateDescription vmstate_spapr_fwnmi=
 =3D {
>      .needed =3D spapr_fwnmi_needed,
>      .pre_save =3D spapr_fwnmi_pre_save,
>      .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT64(fwnmi_system_reset_addr, SpaprMachineState),
>          VMSTATE_UINT64(fwnmi_machine_check_addr, SpaprMachineState),
>          VMSTATE_INT32(fwnmi_machine_check_interlock, SpaprMachineState),
>          VMSTATE_END_OF_LIST()
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 0b8c481593..521e6b0b72 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -414,6 +414,7 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>                                    uint32_t nret, target_ulong rets)
>  {
>      hwaddr rtas_addr;
> +    target_ulong sreset_addr, mce_addr;
> =20
>      if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI) =3D=3D SPAPR_CAP_OFF) {
>          rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> @@ -426,7 +427,18 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>          return;
>      }
> =20
> -    spapr->fwnmi_machine_check_addr =3D rtas_ld(args, 1);
> +    sreset_addr =3D rtas_ld(args, 0);
> +    mce_addr =3D rtas_ld(args, 1);
> +
> +    /* PAPR requires these are in the first 32M of memory and within RMA=
 */
> +    if (sreset_addr >=3D 32 * MiB || sreset_addr >=3D spapr->rma_size ||
> +           mce_addr >=3D 32 * MiB ||    mce_addr >=3D spapr->rma_size) {
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +        return;
> +    }
> +
> +    spapr->fwnmi_system_reset_addr =3D sreset_addr;
> +    spapr->fwnmi_machine_check_addr =3D mce_addr;
> =20
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 64b83402cb..42d64a0368 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -194,9 +194,10 @@ struct SpaprMachineState {
> =20
>      /* State related to FWNMI option */
> =20
> -    /* Machine Check Notification Routine address
> +    /* System Reset and Machine Check Notification Routine addresses
>       * registered by "ibm,nmi-register" RTAS call.
>       */
> +    target_ulong fwnmi_system_reset_addr;
>      target_ulong fwnmi_machine_check_addr;
> =20
>      /* Machine Check FWNMI synchronization, fwnmi_machine_check_interloc=
k is

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5wAfYACgkQbDjKyiDZ
s5LvGQ//eOSo/L61ikqnM4qiBcFrx0zki55of5qjT8os/4PGyzk0bBxsK9o+CWn7
JRUTfeCI/0JQ21rL9YbKodR6oRJ98ElRb79A11cuHZZ9IqoBN2Sr6EDcueEPEjG4
sNOJFHuorsARQ7Z+0G3OrW6+PxfRia6ECESjN0yU3IrCgba0i9otwlw3rBOG1Tpa
Aw/YX0gwCRN8rlOPSdk6l/8/1V8zvUMtzHBtqUQaTTa8wbS8hQg9QthzXYAzNrYr
R5YXnzLosfTV/xG7hLQZ11h2jgFaj0jCIqgvFzmHRQZpn/dhgGDflcs5G/VLH3yy
TzLQ6NOyoMp2Sp0HClLBRJ1XAA6GcjbLgbng8pRxzHj2rqSaDHVBiyLL91/5MZaS
4ErAVAMo0qMLQfLRLqMPrcceCgWP/kqmc1SHLj3kkGsM4LpcU+rBOD0QYWP3P5Tp
rTjZw29ohcGiHFlgNgkAK/uI6sv605KIa3C2jCpTiP0YNTR4T509jD2JBDneizE/
5wwusYvm0KvGoKU1hgjVlK5G8EZW/KD5bmArZ18jX0hEWLqBhEmDnYYbYRnVJ1O3
fm6INXjc3m7ICydbzNabEmv9KMYxTHTFKjYT4HipF3ucleZRwchgYPRoe9RoKCBn
xxvkUgx4XhJYuDnoFVouGdFIsdDymryBImbSGmosKFGFb3hVDnw=
=m5Qe
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--

