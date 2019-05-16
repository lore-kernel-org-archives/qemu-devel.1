Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD57C04E53
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 01:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 971D520881
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 01:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jGGXY7B6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971D520881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46857 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR5Uf-0000G7-Tt
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 21:47:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hR5RA-00068T-TI
	for qemu-devel@nongnu.org; Wed, 15 May 2019 21:44:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hR5GM-0008Vk-9m
	for qemu-devel@nongnu.org; Wed, 15 May 2019 21:32:53 -0400
Received: from ozlabs.org ([203.11.71.1]:53871)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hR5GK-0008DD-R9; Wed, 15 May 2019 21:32:50 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 454DSL63Tvz9sMr; Thu, 16 May 2019 11:32:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557970354;
	bh=4tsaiar3aKnK3jE8X+7yg8nzv0Eb+oJbtXWhUjbQAxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jGGXY7B6alb/r7nVEXNbgA0jZ7qtQReDpDB6Ipc6ggnz9L4RXUimQ29wa/zziJQqb
	TYaE5RpgB8c9m+afl0Qsmnhw8LJxf5ncPnjc0EvNWljkTtfWpVXDkxJJNMJVjDI22L
	VZn4y2hIxTw2oVkRnUhqTwNNKlXwhOPpihXiUo78=
Date: Thu, 16 May 2019 11:26:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190516012650.GB3207@umbus.fritz.box>
References: <20190516005744.24366-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <20190516005744.24366-1-sjitindarsingh@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Set PSSCR_EC on cpu halt to
 prevent spurious wakeup
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2019 at 10:57:44AM +1000, Suraj Jitindar Singh wrote:
> The processor stop status and control register (PSSCR) is used to
> control the power saving facilities of the thread. The exit criterion
> bit (EC) is used to specify whether the thread should be woken by any
> interrupt (EC =3D=3D 0) or only an interrupt enabled in the LPCR to wake =
the
> thread (EC =3D=3D 1).
>=20
> The rtas facilities start-cpu and self-stop are used to transition a
> vcpu between the stopped and running states. When a vcpu is stopped it
> may only be started again by the start-cpu rtas call.
>=20
> Currently a vcpu in the stopped state will start again whenever an
> interrupt comes along due to PSSCR_EC being cleared, and while this is
> architecturally correct for a hardware thread, a vcpu is expected to
> only be woken by calling start-cpu. This means when performing a reboot
> on a tcg machine that the secondary threads will restart while the
> primary is still in slof, this is unsupported and causes call traces
> like:
>=20
> SLOF ********************************************************************=
**
> QEMU Starting
>  Build Date =3D Jan 14 2019 18:00:39
>  FW Version =3D git-a5b428e1c1eae703
>  Press "s" to enter Open Firmware.
>=20
> qemu: fatal: Trying to deliver HV exception (MSR) 70 with no HV support
>=20
> NIP 6d61676963313230   LR 000000003dbe0308 CTR 6d61676963313233 XER 00000=
00000000000 CPU#1
> MSR 0000000000000000 HID0 0000000000000000  HF 0000000000000000 iidx 3 di=
dx 3
> TB 00000026 115746031956 DECR 18446744073326238463
> GPR00 000000003dbe0308 000000003e669fe0 000000003dc10700 0000000000000003
> GPR04 000000003dc62198 000000003dc62178 000000003dc0ea48 0000000000000030
> GPR08 000000003dc621a8 0000000000000018 000000003e466008 000000003dc50700
> GPR12 c00000000093a4e0 c00000003ffff300 c00000003e533f90 0000000000000000
> GPR16 0000000000000000 0000000000000000 000000003e466010 000000003dc0b040
> GPR20 0000000000008000 000000000000f003 0000000000000006 000000003e66a050
> GPR24 000000003dc06400 000000003dc0ae70 0000000000000003 000000000000f001
> GPR28 000000003e66a060 ffffffffffffffff 6d61676963313233 0000000000000028
> CR 28000222  [ E  L  -  -  -  E  E  E  ]             RES ffffffffffffffff
> FPR00 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> FPR04 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> FPR08 0000000000000000 0000000000000000 0000000000000000 00000000311825e0
> FPR12 00000000311825e0 0000000000000000 0000000000000000 0000000000000000
> FPR16 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> FPR20 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> FPR24 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> FPR28 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> FPSCR 0000000000000000
>  SRR0 000000003dbe06b0  SRR1 0000000000080000    PVR 00000000004e1200 VRS=
AVE 0000000000000000
> SPRG0 000000003dbe0308 SPRG1 000000003e669fe0  SPRG2 00000000000000d8  SP=
RG3 000000003dbe0308
> SPRG4 0000000000000000 SPRG5 0000000000000000  SPRG6 0000000000000000  SP=
RG7 0000000000000000
> HSRR0 6d61676963313230 HSRR1 0000000000000000
>  CFAR 000000003dbe3e64
>  LPCR 0000000004020008
>  PTCR 0000000000000000   DAR 0000000000000000  DSISR 0000000000000000
> Aborted (core dumped)
>=20
> To fix this, set the PSSCR_EC bit when a vcpu is stopped to disable it
> from coming back online until the start-cpu rtas call is made.
>=20
> Fixes: 21c0d66a9c99 ("target/ppc: Fix support for "STOP light" states on =
POWER9")
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Applied, thanks.

> ---
>  hw/ppc/spapr_cpu_core.c | 2 ++
>  hw/ppc/spapr_rtas.c     | 6 +++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index f04e06cdf6..5621fb9a3d 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -58,9 +58,11 @@ static void spapr_cpu_reset(void *opaque)
>       *
>       * Disable Power-saving mode Exit Cause exceptions for the CPU, so
>       * we don't get spurious wakups before an RTAS start-cpu call.
> +     * For the same reason, set PSSCR_EC.
>       */
>      lpcr &=3D ~(LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV | pcc->lpcr_=
pm);
>      lpcr |=3D LPCR_LPES0 | LPCR_LPES1;
> +    env->spr[SPR_PSSCR] |=3D PSSCR_EC;
> =20
>      /* Set RMLS to the max (ie, 16G) */
>      lpcr &=3D ~LPCR_RMLS;
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index ee24212765..5bc1a93271 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -177,6 +177,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, Spapr=
MachineState *spapr,
>          } else {
>              lpcr &=3D ~(LPCR_UPRT | LPCR_GTSE | LPCR_HR);
>          }
> +        env->spr[SPR_PSSCR] &=3D ~PSSCR_EC;
>      }
>      ppc_store_lpcr(newcpu, lpcr);
> =20
> @@ -205,8 +206,11 @@ static void rtas_stop_self(PowerPCCPU *cpu, SpaprMac=
hineState *spapr,
> =20
>      /* Disable Power-saving mode Exit Cause exceptions for the CPU.
>       * This could deliver an interrupt on a dying CPU and crash the
> -     * guest */
> +     * guest.
> +     * For the same reason, set PSSCR_EC.
> +     */
>      ppc_store_lpcr(cpu, env->spr[SPR_LPCR] & ~pcc->lpcr_pm);
> +    env->spr[SPR_PSSCR] |=3D PSSCR_EC;
>      cs->halted =3D 1;
>      kvmppc_set_reg_ppc_online(cpu, 0);
>      qemu_cpu_kick(cs);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzcvFoACgkQbDjKyiDZ
s5JHiA//RVforLBseuDOFb8kTtPMqhPCadLqpPAlmyEiCou4pctMwWBbSAyVUXxy
EBjL5mMbuRWkI1ZqeF0/W7a8DZ6UPtJ1qLpx0gR15wPN1ta7wOFfCz0mpgzCr6Kq
geohkCTLYzQ9FpXVF4CW0GL78uOg2UL2N4V/BIJwg7m/wgL1zUEoFaXELeD8UMlL
pmDdJ9Ob7hEe+nM8AZEOqvymjZgTkxYF7yloE2Kcfpwzv4m/2zobzidnLH0P9zwh
KkdQsHgDddegvAHW++MdiZYvoSqGrmyBtD445sXsofVp3QYDOpS2VUFL7E06MJ3O
dWOENkGAkVr1AS7bcNVReSd3+II+GbxCVn3P3B7trkBncpmcguY0ry+HXWN+RdEs
amPJf8QDNR5zXDaez3WK3X3i+KaWeD02rfYK2G0wLm9fWeKa3ZB7ae14seccGwP7
ledsfhcenc9hjqfeXv7qvU9ZbrCe4bu//Oc/0aHBIrcjq1PcvPc45SKp7UBZQ3n+
NqxoMhec7rX9DYKeJlXny1y5Zxdq6ikiq3flCI57rTt/R9Oxj06TEa5rME+NeIB0
BLQoqV0kKV3htzW/GqvAoSLaEy/p7Hf2NhjOUPhqgq+LUTfEhh5TEohWE6QpTHNb
G/SAIh8PUUuOOE2a/bKtwbD8tWt4Y07zqamHnyA7Z9UAULv4vVc=
=cjMG
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--

