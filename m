Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA50C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 02:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E61712240C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 02:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fYwyQB36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61712240C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWtYr-0004Q5-Tj
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 21:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iWtWm-0002y2-0h
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 21:46:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iWtWj-0004Dy-Be
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 21:46:03 -0500
Received: from ozlabs.org ([203.11.71.1]:34895)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iWtWi-0004D4-Bz; Mon, 18 Nov 2019 21:46:01 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47H9Dg2ZT5z9sPf; Tue, 19 Nov 2019 13:45:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574131555;
 bh=YZN0Iu4nZQyT8DXeFV5XydaSs3ISnj/FgOoS4wVdKzU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fYwyQB36i6AKT0+byeGnLd5gvRva+4poKY06bxfdY5in8M3pxKNezNNfaI2YNcoYS
 Ccy2W9fVD+5ULBLLT6hf8ebE6lLrBnNxaZy8s5Udido6ZGZeFqxtN6THd/ECytH/JF
 0wHCSDXvo8zyrywC9rmkiiv49c8QmvtI3Qy+YV4w=
Date: Tue, 19 Nov 2019 13:39:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Ganesh Goudar <ganeshgr@linux.ibm.com>
Subject: Re: [PATCH v17 5/7] ppc: spapr: Handle "ibm,nmi-register" and
 "ibm,nmi-interlock" RTAS calls
Message-ID: <20191119023932.GL5582@umbus.fritz.box>
References: <20191024074307.22821-1-ganeshgr@linux.ibm.com>
 <20191024074307.22821-6-ganeshgr@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KjSGHOmKKB2VUiQn"
Content-Disposition: inline
In-Reply-To: <20191024074307.22821-6-ganeshgr@linux.ibm.com>
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
Cc: arawinda.p@gmail.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 paulus@ozlabs.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--KjSGHOmKKB2VUiQn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 01:13:05PM +0530, Ganesh Goudar wrote:
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
> [Move fwnmi registeration to .apply hook]

s/registeration/registration/

> Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
> Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
> ---
>  hw/ppc/spapr_caps.c    |  9 +++++--
>  hw/ppc/spapr_rtas.c    | 57 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  5 +++-
>  3 files changed, 68 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 976d709210..1675ebd45e 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -509,9 +509,14 @@ static void cap_fwnmi_mce_apply(SpaprMachineState *s=
papr, uint8_t val,
>           * of software injected faults like duplicate SLBs).
>           */
>          warn_report("Firmware Assisted Non-Maskable Interrupts not suppo=
rted in TCG");

This logic still isn't quite right.  To start with the warn_report()
above possible wants to be more weakly worded.  With TCG, FWNMI won't
generally *do* anything, and there are some edge cases where the
behaviour is arguably incorrect.  However there's no reason we can't
make the RTAS calls work basically as expected and in almost all cases
things will behave correctly - at least according to the case where no
fwnmi events are delivered...

> -    } else if (kvm_enabled() && (kvmppc_set_fwnmi() !=3D 0)) {
> -        error_setg(errp,
> +    } else if (kvm_enabled()) {
> +        if (!kvmppc_set_fwnmi()) {
> +            /* Register ibm,nmi-register and ibm,nmi-interlock RTAS call=
s */
> +            spapr_fwnmi_register();

=2E.but here you only register the RTAS calls in the KVM case, which
breaks that.  If there really is a strong reason to do this, then the
warn_report() above should be error_setg() and fail the apply.

> +        } else {
> +            error_setg(errp,
>  "Firmware Assisted Non-Maskable Interrupts not supported by KVM, try cap=
-fwnmi-mce=3Doff");
> +        }
>      }
>  }
> =20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 2c066a372d..0328b1f341 100644
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

Actually, since you explicitly test for the cap being enabled here,
there's no reason not to *always* register this RTAS call.  Also this
test for the feature flag should go first, before delving into the
device tree for the RTAS address.

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
> @@ -503,6 +552,14 @@ hwaddr spapr_get_rtas_addr(void)
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
> index 4afa8d4d09..86f0fc8fdd 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -653,8 +653,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target=
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
> @@ -907,4 +909,5 @@ void spapr_check_pagesize(SpaprMachineState *spapr, h=
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

--KjSGHOmKKB2VUiQn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3TVeEACgkQbDjKyiDZ
s5J3NxAAv5G3N3+eUEeW/YDKtDDhzlEjBxOE5BJ2pWv/4fpOU3pwCLTgdLlr24Yi
eFRANjs331+NSNBPeUS2IKhgEtdzLlqR07gnOJoUASgOot9qKpewAL/0aInNenIp
n66nP8EJQuxqofVpi7PYqj7wD8p068cfpUk77U7qX6ZeIOGpPNfC2/qyj5z7lo+y
Utfh89SVvvJI69kibp9Z/2B77SNSK2cpIkiS/79IIHbV7EPUFyooMutUeWsda287
qsOk7uQ6dkx56KaDz239+ZqT9QrEFoG9zSzDhuTVBS6jXPZ96Tw+4uvrO9l0RIpw
ERoN6VQBjXJfQURPalirIB4mSKDefLNxh3/aja5ZQ6rVYYTbEBalUFyrg/aHsoGn
zzH8M/i3JAgcT2VnX3rfkCUArME0+IOcdLVQHJKBmVoB5TnM0Az8m4d5KhbRDsAL
5PnpcjDIhaBdlW/UPLj0KBvlaIf41j5coD4EfjxXE+yLtTCW/bEHYMhmtfANyJA+
FsKoZfs4ozC9PUjVolROBfvvLbFSNuxOfcMjEBWrQYA3qv/MFmm4BzX37HsuSA2I
KJpRmxeBKwDa7BE2UNdLn+JtSN2K5jcp6x78R4yioUeIQ0LSAJnq1OETBotNN2Ns
x3hTmDB/aaxK6g72P+69H/eaEPLEfGtRi9XtqJstMbqFbGo5RAs=
=TTMR
-----END PGP SIGNATURE-----

--KjSGHOmKKB2VUiQn--

