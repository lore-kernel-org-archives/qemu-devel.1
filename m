Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368D2C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 03:34:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0108420726
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 03:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YTANrspp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0108420726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBs8B-0004Ot-5J
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 23:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jBs7M-0003OI-MT
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 23:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jBs7L-0003ql-A4
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 23:33:12 -0400
Received: from ozlabs.org ([203.11.71.1]:52349)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jBs7J-0003a8-TP; Tue, 10 Mar 2020 23:33:11 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48ccwN4Tdpz9sPK; Wed, 11 Mar 2020 14:32:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583897556;
 bh=RhtO+2jk4Ypqd1fTmLdrZeXpN2Yql0sPP06IKvmFfKA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YTANrsppmubX6/7pxi3nYy0/b7bWC0uUWspsrgG8mnD/Yd+aDrPKhGLaFvPTuIZ/6
 h8wEKkLQ86zCAvubdnP99QzAubL0Rk/RW4ghp1E0aFEOw9a5MvoOLPGcEb+2TiMoAy
 vH13yN/W10RTRvkeJNg7y3JXRYeEp1PYMNzvqS8c=
Date: Wed, 11 Mar 2020 14:11:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu v8 1/3] ppc/spapr: Move GPRs setup to one place
Message-ID: <20200311031154.GU660117@umbus.fritz.box>
References: <20200310050733.29805-1-aik@ozlabs.ru>
 <20200310050733.29805-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="O0IT7rLmWuveAsNR"
Content-Disposition: inline
In-Reply-To: <20200310050733.29805-2-aik@ozlabs.ru>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--O0IT7rLmWuveAsNR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2020 at 04:07:31PM +1100, Alexey Kardashevskiy wrote:
> At the moment "pseries" starts in SLOF which only expects the FDT blob
> pointer in r3. As we are going to introduce a OpenFirmware support in
> QEMU, we will be booting OF clients directly and these expect a stack
> pointer in r1, Linux looks at r3/r4 for the initramdisk location
> (although vmlinux can find this from the device tree but zImage from
> distro kernels cannot).
>=20
> This extends spapr_cpu_set_entry_state() to take more registers. This
> should cause no behavioral change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

LGTM independent of the other changes, so applied to ppc-for-5.0.

> ---
> Changes:
> v7:
> * removed r5 as it points to prom entry which is now provided by
> a new firmware in later patches
> ---
>  include/hw/ppc/spapr_cpu_core.h | 4 +++-
>  hw/ppc/spapr.c                  | 2 +-
>  hw/ppc/spapr_cpu_core.c         | 6 +++++-
>  hw/ppc/spapr_rtas.c             | 2 +-
>  4 files changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
> index 1c4cc6559c52..7aed8f555b4f 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -40,7 +40,9 @@ typedef struct SpaprCpuCoreClass {
>  } SpaprCpuCoreClass;
> =20
>  const char *spapr_get_cpu_core_type(const char *cpu_type);
> -void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target=
_ulong r3);
> +void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip,
> +                               target_ulong r1, target_ulong r3,
> +                               target_ulong r4);
> =20
>  typedef struct SpaprCpuState {
>      uint64_t vpa_addr;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2eb0d8f70de6..64bc8b83e91e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1698,7 +1698,7 @@ static void spapr_machine_reset(MachineState *machi=
ne)
>      spapr->fdt_blob =3D fdt;
> =20
>      /* Set up the entry state */
> -    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr=
);
> +    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, 0, fdt_a=
ddr, 0);
>      first_ppc_cpu->env.gpr[5] =3D 0;
> =20
>      spapr->cas_reboot =3D false;
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 36ed3a2b665b..ac1c10942771 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -76,13 +76,17 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
>      spapr_irq_cpu_intc_reset(spapr, cpu);
>  }
> =20
> -void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target=
_ulong r3)
> +void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip,
> +                               target_ulong r1, target_ulong r3,
> +                               target_ulong r4)
>  {
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
>      CPUPPCState *env =3D &cpu->env;
> =20
>      env->nip =3D nip;
> +    env->gpr[1] =3D r1;
>      env->gpr[3] =3D r3;
> +    env->gpr[4] =3D r4;
>      kvmppc_set_reg_ppc_online(cpu, 1);
>      CPU(cpu)->halted =3D 0;
>      /* Enable Power-saving mode Exit Cause exceptions */
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 656fdd221665..fe83b50c6629 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -190,7 +190,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, Spapr=
MachineState *spapr,
>       */
>      newcpu->env.tb_env->tb_offset =3D callcpu->env.tb_env->tb_offset;
> =20
> -    spapr_cpu_set_entry_state(newcpu, start, r3);
> +    spapr_cpu_set_entry_state(newcpu, start, 0, r3, 0);
> =20
>      qemu_cpu_kick(CPU(newcpu));
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--O0IT7rLmWuveAsNR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5oVvcACgkQbDjKyiDZ
s5L83hAA1a4ARseTl8MwUPYt7FCNjyDQ1VYAZJo7sxvCWpOj/zHZCh4mrvEK4/M4
clwkoHgrZyg0T/bBGfNoic90B+TexYkbMID//qPs5GoyLUogexdXtYIFo7YNywEL
cMT7MfTidaTZVGmBHh2EuuvXAky4x9H7+0vn+P5tfxiqZXJ3odGaFvtPE9tvVyL8
nrFPz9931liFJlvN6ZjQLYgtBSIX7SQ22aNe+xyEowOeDumfCT93ctVvicMvAVzp
DYzxAVkitzkyh3a/P2leI6W06XtiMfIpjpHj1gxZlZ6cziYtStgNfmqgLLCkXysU
0NftCSCR10PkL7dqeLYXIXfp9pn91gQp6tNXwTX3AuSD5vtAnfz9KB+poa/NXn43
KV8Td/Z1/gXWOIDTJ0b+BYdN/iAxSh2Bn0SXXF0apzJ2jB6Fsk+1DddBVgzjDc7H
tQbz2e1m+cx0v5V6AJAUuhDjZd9Kx47OIQzYvGkrYGMklR8tQnuP9QZWqfgF5A1d
5YECZchKQ7zNwSseTbsMTxx/eyjcRrQCTOZP9VWB3yfosVHMlZoiOccXE51Yzdb+
u2aJJsRW8ec/HeO/ONVa7jEm19O+QDdYNJ4B4adMmOlw67TkGF6d03IhQQhf/p6/
MzfwyqyRujoIeD8JhJB4J/wTJ0GL+JQfvU5wIBbFjgTs26tr2Bk=
=Fqh1
-----END PGP SIGNATURE-----

--O0IT7rLmWuveAsNR--

