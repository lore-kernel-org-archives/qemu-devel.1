Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580CEC2D0FA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 10:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CB120575
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 10:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BFrIpfJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CB120575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYoLO-0005Cx-61
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 06:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jYoKi-00043R-Du; Wed, 13 May 2020 06:09:48 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36467 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jYoKf-0007HJ-Om; Wed, 13 May 2020 06:09:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49MVlK6QNtz9sSW; Wed, 13 May 2020 20:09:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1589364573;
 bh=ycRgYu/A8+K8wasjeVvJsGvRyawu+F1RnpdIZE8PkgA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BFrIpfJAEVhpw8ls1WyMOSYQ9XlIOO0rTRHQsanU74FINFoDBMFPzK88b5y+n9Oaz
 /qwcHWhYGgmEViTZyAkIOovIBcauc9GM/eijEXW1/f8i3lqnw2M8jI57dAmCpYpUIv
 dB/W6ynfw1dq9gKyJ8+GlNh0ULiTPyBS2PZlchtY=
Date: Wed, 13 May 2020 15:56:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] ppc/pnv: Add definitions for interrupts occurring in
 power-saving mode
Message-ID: <20200513055654.GA2183@umbus.fritz.box>
References: <20200511085822.65319-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ca0/yK2c6QcOc1Rp"
Content-Disposition: inline
In-Reply-To: <20200511085822.65319-1-clg@kaod.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 06:09:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Ca0/yK2c6QcOc1Rp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2020 at 10:58:22AM +0200, C=E9dric Le Goater wrote:
> If an interrupt occurred when the thread was in power-saving mode,
> bits [42:45] of SRR1 indicate the exception that caused exit from
> power-saving mode.
>=20
> bits [46:47] of SRR1 indicate the power-saving mode in which the
> thread was when the interrupt occured.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-5.1.

> ---
>  target/ppc/cpu.h         | 21 +++++++++++++++++++++
>  hw/ppc/pnv.c             |  8 ++++----
>  target/ppc/excp_helper.c | 16 ++++++++--------
>  3 files changed, 33 insertions(+), 12 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index df5c30160da8..9648623677d2 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -476,6 +476,27 @@ typedef struct ppc_v3_pate_t {
>  #define SRR1_PROTFAULT           DSISR_PROTFAULT
>  #define SRR1_IAMR                DSISR_AMR
> =20
> +/* SRR1[42:45] wakeup fields for System Reset Interrupt */
> +
> +#define SRR1_WAKEMASK           0x003c0000 /* reason for wakeup */
> +
> +#define SRR1_WAKEHMI            0x00280000 /* Hypervisor maintenance */
> +#define SRR1_WAKEHVI            0x00240000 /* Hypervisor Virt. Interrupt=
 (P9) */
> +#define SRR1_WAKEEE             0x00200000 /* External interrupt */
> +#define SRR1_WAKEDEC            0x00180000 /* Decrementer interrupt */
> +#define SRR1_WAKEDBELL          0x00140000 /* Privileged doorbell */
> +#define SRR1_WAKERESET          0x00100000 /* System reset */
> +#define SRR1_WAKEHDBELL         0x000c0000 /* Hypervisor doorbell */
> +#define SRR1_WAKESCOM           0x00080000 /* SCOM not in power-saving m=
ode */
> +
> +/* SRR1[46:47] power-saving exit mode */
> +
> +#define SRR1_WAKESTATE          0x00030000 /* Powersave exit mask */
> +
> +#define SRR1_WS_HVLOSS          0x00030000 /* HV resources not maintaine=
d */
> +#define SRR1_WS_GPRLOSS         0x00020000 /* GPRs not maintained */
> +#define SRR1_WS_NOLOSS          0x00010000 /* All resources maintained */
> +
>  /* Facility Status and Control (FSCR) bits */
>  #define FSCR_EBB        (63 - 56) /* Event-Based Branch Facility */
>  #define FSCR_TAR        (63 - 55) /* Target Address Register */
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 1b4748ce6dc3..182b62565022 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1986,15 +1986,15 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, r=
un_on_cpu_data arg)
> =20
>      cpu_synchronize_state(cs);
>      ppc_cpu_do_system_reset(cs);
> -    if (env->spr[SPR_SRR1] & PPC_BITMASK(46, 47)) {
> +    if (env->spr[SPR_SRR1] & SRR1_WAKESTATE) {
>          /*
>  	 * Power-save wakeups, as indicated by non-zero SRR1[46:47] put the
>  	 * wakeup reason in SRR1[42:45], system reset is indicated with 0b0100
>  	 * (PPC_BIT(43)).
>  	 */
> -        if (!(env->spr[SPR_SRR1] & PPC_BIT(43))) {
> +        if (!(env->spr[SPR_SRR1] & SRR1_WAKERESET)) {
>              warn_report("ppc_cpu_do_system_reset does not set system res=
et wakeup reason");
> -            env->spr[SPR_SRR1] |=3D PPC_BIT(43);
> +            env->spr[SPR_SRR1] |=3D SRR1_WAKERESET;
>          }
>      } else {
>          /*
> @@ -2004,7 +2004,7 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run=
_on_cpu_data arg)
>  	 * another CPU requesting a NMI IPI) system reset exception should be
>  	 * 0b0010 (PPC_BIT(44)).
>           */
> -        env->spr[SPR_SRR1] |=3D PPC_BIT(44);
> +        env->spr[SPR_SRR1] |=3D SRR1_WAKESCOM;
>      }
>  }
> =20
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 14d39029825a..a988ba15f4f7 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -101,7 +101,7 @@ static int powerpc_reset_wakeup(CPUState *cs, CPUPPCS=
tate *env, int excp,
>      env->resume_as_sreset =3D false;
> =20
>      /* Pretend to be returning from doze always as we don't lose state */
> -    *msr |=3D (0x1ull << (63 - 47));
> +    *msr |=3D SRR1_WS_NOLOSS;
> =20
>      /* Machine checks are sent normally */
>      if (excp =3D=3D POWERPC_EXCP_MCHECK) {
> @@ -109,25 +109,25 @@ static int powerpc_reset_wakeup(CPUState *cs, CPUPP=
CState *env, int excp,
>      }
>      switch (excp) {
>      case POWERPC_EXCP_RESET:
> -        *msr |=3D 0x4ull << (63 - 45);
> +        *msr |=3D SRR1_WAKERESET;
>          break;
>      case POWERPC_EXCP_EXTERNAL:
> -        *msr |=3D 0x8ull << (63 - 45);
> +        *msr |=3D SRR1_WAKEEE;
>          break;
>      case POWERPC_EXCP_DECR:
> -        *msr |=3D 0x6ull << (63 - 45);
> +        *msr |=3D SRR1_WAKEDEC;
>          break;
>      case POWERPC_EXCP_SDOOR:
> -        *msr |=3D 0x5ull << (63 - 45);
> +        *msr |=3D SRR1_WAKEDBELL;
>          break;
>      case POWERPC_EXCP_SDOOR_HV:
> -        *msr |=3D 0x3ull << (63 - 45);
> +        *msr |=3D SRR1_WAKEHDBELL;
>          break;
>      case POWERPC_EXCP_HV_MAINT:
> -        *msr |=3D 0xaull << (63 - 45);
> +        *msr |=3D SRR1_WAKEHMI;
>          break;
>      case POWERPC_EXCP_HVIRT:
> -        *msr |=3D 0x9ull << (63 - 45);
> +        *msr |=3D SRR1_WAKEHVI;
>          break;
>      default:
>          cpu_abort(cs, "Unsupported exception %d in Power Save mode\n",

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ca0/yK2c6QcOc1Rp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl67jCYACgkQbDjKyiDZ
s5I/ABAAnv6ngEa8ony483FIEcMaJEHmbkGVfzynxy30ktmXjrPuA5/bVYIwS17n
lLnc6XPh+mlr1tmRMnXYwHq3D1oBV3mRnSW2tSVWCnLirM6PD+tQSh0IvjqqpTJs
kcvjLdPHWZRAc+vQ5/7B0/qIB+aEnh5b9QKtKDB/WbGxXOuZn7tZD5BJMTflBu6E
5UKReb0xVacqrQdJCTnNJjuZQL9q1DdThPtAnbmx+duaMiwsKz47JVbz3oCctU4R
Zc8/MyWJYnqzdql+OP41Ijy54qUOvSvAzrDb+kZZAEmrVH1FDvpkqFE9YBhKyagK
5SltSPqCLDE1oK7nNSILqmAGjbgA+9gjNTU0BoOQdmcBzonOMEcUyoNYxMfZih9+
tJzKLkXHvI+H/uKAmgNOrRqBJevakksOqG/1h/HtBjWael8ezCEBoPp8ch0bwh2L
3F9Fnej6wgF6FidgXOKVr4UXF4L6cQwr/0H0ZOUrVdRXnaCbz7fzbSsAf9AvvxOs
li6y8exVQVe38hfd0AHjBGXniGeMgR4Z2Q94AFe6EZiDjiTPxE+J5zyVu5CmCuzB
mWP17FcUJyxKatZWpgaR2eH7zGJP6QB+By16Yvx/T7O21guz72cKA3fl9Fk8I2U9
KVajP4I9FQgHZRY8yC1bBwEgLUYNLUQ63naliBG/YwXDlld12ss=
=ZcDS
-----END PGP SIGNATURE-----

--Ca0/yK2c6QcOc1Rp--

