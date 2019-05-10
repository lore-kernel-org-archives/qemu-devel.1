Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D001C04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:00:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B722182B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="C3vI51j6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B722182B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35876 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOvmF-0002fF-Hm
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 23:00:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOvjK-0000Um-CD
	for qemu-devel@nongnu.org; Thu, 09 May 2019 22:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOvjJ-0001A4-0l
	for qemu-devel@nongnu.org; Thu, 09 May 2019 22:57:50 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48619 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hOvjH-000172-Dy; Thu, 09 May 2019 22:57:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 450ZdL10ynz9sD4; Fri, 10 May 2019 12:57:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557457062;
	bh=C5Mo6UoVGX0PMn65WZ+a+4nOq8cCWHotBN3VvPl5K/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3vI51j6jOopqc72nffyr1gFvhDJAoVeGHrYSbAT7aTAds8Qw1MW3PxFMwXe76Vwn
	UXuoRujAQTgUD7Pwaw8venSuJBK6kqQrJtrSzgQXtjhHT9FzwTcxwL+fusXdLxxouW
	6FMYP1jyIkUHxBK9wLJO2G4u94EfOi4yK+/zfiKo=
Date: Fri, 10 May 2019 11:39:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190510013929.GX7073@umbus.fritz.box>
References: <20190509222631.14271-1-richard.henderson@linaro.org>
	<20190509222631.14271-17-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BtNCO5h84ExDStzY"
Content-Disposition: inline
In-Reply-To: <20190509222631.14271-17-richard.henderson@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v3 16/27] target/ppc: Convert to
 CPUClass::tlb_fill
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--BtNCO5h84ExDStzY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2019 at 03:26:20PM -0700, Richard Henderson wrote:
> Cc: qemu-ppc@nongnu.org
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/cpu.h                |  7 +++----
>  target/ppc/mmu_helper.c         | 22 +++++++++++++---------
>  target/ppc/translate_init.inc.c |  5 ++---
>  target/ppc/user_only_helper.c   | 14 ++++++++------
>  4 files changed, 26 insertions(+), 22 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 5e7cf54b2f..d7f23ad5e0 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1311,10 +1311,9 @@ void ppc_translate_init(void);
>   * is returned if the signal was handled by the virtual CPU.
>   */
>  int cpu_ppc_signal_handler(int host_signum, void *pinfo, void *puc);
> -#if defined(CONFIG_USER_ONLY)
> -int ppc_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int=
 rw,
> -                             int mmu_idx);
> -#endif
> +bool ppc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                      MMUAccessType access_type, int mmu_idx,
> +                      bool probe, uintptr_t retaddr);
> =20
>  #if !defined(CONFIG_USER_ONLY)
>  void ppc_store_sdr1(CPUPPCState *env, target_ulong value);
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 1dbc9acb75..afcca50530 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -3057,15 +3057,9 @@ void helper_check_tlb_flush_global(CPUPPCState *en=
v)
> =20
>  /***********************************************************************=
******/
> =20
> -/*
> - * try to fill the TLB and return an exception if error. If retaddr is
> - * NULL, it means that the function was called in C code (i.e. not
> - * from generated code or from helper.c)
> - *
> - * XXX: fix it to restore all registers
> - */
> -void tlb_fill(CPUState *cs, target_ulong addr, int size,
> -              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
> +bool ppc_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
> +                      MMUAccessType access_type, int mmu_idx,
> +                      bool probe, uintptr_t retaddr)
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cs);
> @@ -3078,7 +3072,17 @@ void tlb_fill(CPUState *cs, target_ulong addr, int=
 size,
>          ret =3D cpu_ppc_handle_mmu_fault(env, addr, access_type, mmu_idx=
);
>      }
>      if (unlikely(ret !=3D 0)) {
> +        if (probe) {
> +            return false;
> +        }
>          raise_exception_err_ra(env, cs->exception_index, env->error_code,
>                                 retaddr);
>      }
> +    return true;
> +}
> +
> +void tlb_fill(CPUState *cs, target_ulong addr, int size,
> +              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
> +{
> +    ppc_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retadd=
r);
>  }
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 0394a9ddad..3f847de36c 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -10592,9 +10592,8 @@ static void ppc_cpu_class_init(ObjectClass *oc, v=
oid *data)
>      cc->gdb_read_register =3D ppc_cpu_gdb_read_register;
>      cc->gdb_write_register =3D ppc_cpu_gdb_write_register;
>      cc->do_unaligned_access =3D ppc_cpu_do_unaligned_access;
> -#ifdef CONFIG_USER_ONLY
> -    cc->handle_mmu_fault =3D ppc_cpu_handle_mmu_fault;
> -#else
> +    cc->tlb_fill =3D ppc_cpu_tlb_fill;
> +#ifndef CONFIG_USER_ONLY
>      cc->get_phys_page_debug =3D ppc_cpu_get_phys_page_debug;
>      cc->vmsd =3D &vmstate_ppc_cpu;
>  #endif
> diff --git a/target/ppc/user_only_helper.c b/target/ppc/user_only_helper.c
> index 2f1477f102..683c03390d 100644
> --- a/target/ppc/user_only_helper.c
> +++ b/target/ppc/user_only_helper.c
> @@ -20,21 +20,24 @@
> =20
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> +#include "exec/exec-all.h"
> =20
> -int ppc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int =
rw,
> -                             int mmu_idx)
> +
> +bool ppc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                      MMUAccessType access_type, int mmu_idx,
> +                      bool probe, uintptr_t retaddr)
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      CPUPPCState *env =3D &cpu->env;
>      int exception, error_code;
> =20
> -    if (rw =3D=3D 2) {
> +    if (access_type =3D=3D MMU_INST_FETCH) {
>          exception =3D POWERPC_EXCP_ISI;
>          error_code =3D 0x40000000;
>      } else {
>          exception =3D POWERPC_EXCP_DSI;
>          error_code =3D 0x40000000;
> -        if (rw) {
> +        if (access_type =3D=3D MMU_DATA_STORE) {
>              error_code |=3D 0x02000000;
>          }
>          env->spr[SPR_DAR] =3D address;
> @@ -42,6 +45,5 @@ int ppc_cpu_handle_mmu_fault(CPUState *cs, vaddr addres=
s, int size, int rw,
>      }
>      cs->exception_index =3D exception;
>      env->error_code =3D error_code;
> -
> -    return 1;
> +    cpu_loop_exit_restore(cs, retaddr);
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BtNCO5h84ExDStzY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzU1k8ACgkQbDjKyiDZ
s5LkZw/9GF4kwBitjfNGlolmWOVAO3LLMVLUGlYtuW6iDsZNh3Mw9FVxAL7ZBQw9
Tp17ALIXv5G8/KZvBcGyLZaisDZ3v51XozV3SZVREl3+aoZU9jc1DRShj+f8RuBZ
lcYbQOjaf/X4fHGXTf17/eJ0Dfschy2DMXeYrZ88a2zgOhLCNnfqNw7//joIVfzu
TinQWm9VNZC7krAFuLT3GDqyhfWJWWSQ3GoaI7of3a9BGDG6K0PeOKEaJ2/WPJPp
W8lazYylNRtNRl8FNBistYnps6LfJMHSZbjkrhqV+8C4/GUCRoZxUO3jiwscvYzB
iaGdnbk79af8vLumsOSCCxcpwqGaQOvi+rrGV8xQvlndzOVyO4cCsy39zJDBb2m6
UiUnWYMGMScao/WeIhKcd7zW4ZQ9b4J3Z1EyNRjM3Ja7l1K/8t3HLKvA5r6nu12x
eCvdhA+9/3dhD+yeHWE0MVUYPZfoKObLGOeIhBFoG3oMIBQ3wT1OIMcjEekDCzcH
OJcJPUSrc6q5E+uGjumSATaZquwjyy0LDMaFPNGjdJBwlZrIv50Y0pCxWrEMP6Vb
GvYycerQBXpl6jtq45BtDu8+yRt6XbPztb0+ysmXNR759lZZJ4fm+s8WBtqZrUEi
WGrWbUYoQyd5GhQw6Z57frvcXDeLO59+P9l9hVpmt4avCJNN0b8=
=U5FD
-----END PGP SIGNATURE-----

--BtNCO5h84ExDStzY--

