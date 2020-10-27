Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86A6C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 02:11:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1820620790
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 02:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mVRKel7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1820620790
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXESi-00053q-UT
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 22:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXEOq-0001QV-Ia; Mon, 26 Oct 2020 22:07:48 -0400
Received: from ozlabs.org ([203.11.71.1]:45867)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXEOo-00026I-Bu; Mon, 26 Oct 2020 22:07:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CKw8D6VClz9sSn; Tue, 27 Oct 2020 13:07:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603764460;
 bh=2ZIqzZVCTGSBj3aLosyzgmUXHhCZdzP8hJyeHmQQtVM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mVRKel7yVDFlryAVdCtoODflSGy66ht7ZrTQKGKwRtJv+4+hXCCJkmW3wrMQgFhy4
 rtPSbdoi+2Ot2RbeFVRXBsCI+UvvtnJPme7KJ8O7L60hm/zO1Quihco5Eb4Lo0ggFU
 zYnIyi3PNOazVqsqmZ7icVNi3AUgA3yMn/QVBvKk=
Date: Tue, 27 Oct 2020 13:07:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: zhaolichang <zhaolichang@huawei.com>
Subject: Re: [PATCH V2 02/14] ppc/: fix some comment spelling errors
Message-ID: <20201027020736.GA351557@yekko.fritz.box>
References: <20201009064449.2336-1-zhaolichang@huawei.com>
 <20201009064449.2336-3-zhaolichang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20201009064449.2336-3-zhaolichang@huawei.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 22:03:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, David Edmondson <david.edmondson@oracle.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 09, 2020 at 02:44:37PM +0800, zhaolichang wrote:
> I found that there are many spelling errors in the comments of qemu/targe=
t/ppc.
> I used spellcheck to check the spelling errors and found some errors in t=
he folder.
>=20
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
> Reviewed-by: David Edmondson <david.edmondson@oracle.com>

Applied to ppc-for-5.2.  Thanks Thomas, for adding me to CC.

> ---
>  target/ppc/cpu.h                | 6 +++---
>  target/ppc/excp_helper.c        | 6 +++---
>  target/ppc/fpu_helper.c         | 2 +-
>  target/ppc/internal.h           | 2 +-
>  target/ppc/kvm.c                | 2 +-
>  target/ppc/machine.c            | 2 +-
>  target/ppc/mmu-hash64.c         | 2 +-
>  target/ppc/mmu_helper.c         | 4 ++--
>  target/ppc/translate_init.c.inc | 2 +-
>  9 files changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 766e9c5c26..ba5ebb13fc 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -615,7 +615,7 @@ enum {
>  #define FPSCR_VXCVI  8  /* Floating-point invalid operation exception (i=
nt)  */
>  #define FPSCR_VE     7  /* Floating-point invalid operation exception en=
able */
>  #define FPSCR_OE     6  /* Floating-point overflow exception enable     =
     */
> -#define FPSCR_UE     5  /* Floating-point undeflow exception enable     =
     */
> +#define FPSCR_UE     5  /* Floating-point underflow exception enable    =
      */
>  #define FPSCR_ZE     4  /* Floating-point zero divide exception enable  =
     */
>  #define FPSCR_XE     3  /* Floating-point inexact exception enable      =
     */
>  #define FPSCR_NI     2  /* Floating-point non-IEEE mode                 =
     */
> @@ -2331,13 +2331,13 @@ enum {
>      /* Internal hardware exception sources */
>      PPC_INTERRUPT_DECR,           /* Decrementer exception              =
  */
>      PPC_INTERRUPT_HDECR,          /* Hypervisor decrementer exception   =
  */
> -    PPC_INTERRUPT_PIT,            /* Programmable inteval timer interrup=
t */
> +    PPC_INTERRUPT_PIT,            /* Programmable interval timer interru=
pt */
>      PPC_INTERRUPT_FIT,            /* Fixed interval timer interrupt     =
  */
>      PPC_INTERRUPT_WDT,            /* Watchdog timer interrupt           =
  */
>      PPC_INTERRUPT_CDOORBELL,      /* Critical doorbell interrupt        =
  */
>      PPC_INTERRUPT_DOORBELL,       /* Doorbell interrupt                 =
  */
>      PPC_INTERRUPT_PERFM,          /* Performance monitor interrupt      =
  */
> -    PPC_INTERRUPT_HMI,            /* Hypervisor Maintainance interrupt  =
  */
> +    PPC_INTERRUPT_HMI,            /* Hypervisor Maintenance interrupt   =
 */
>      PPC_INTERRUPT_HDOORBELL,      /* Hypervisor Doorbell interrupt      =
  */
>      PPC_INTERRUPT_HVIRT,          /* Hypervisor virtualization interrupt=
  */
>  };
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index a988ba15f4..d7411bcc81 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -231,7 +231,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
>      }
> =20
>      /*
> -     * Exception targetting modifiers
> +     * Exception targeting modifiers
>       *
>       * LPES0 is supported on POWER7/8/9
>       * LPES1 is not supported (old iSeries mode)
> @@ -1015,7 +1015,7 @@ static void ppc_hw_interrupt(CPUPPCState *env)
>           * This means we will incorrectly execute past the power managem=
ent
>           * instruction instead of triggering a reset.
>           *
> -         * It generally means a discrepancy between the wakup conditions=
 in the
> +         * It generally means a discrepancy between the wakeup condition=
s in the
>           * processor has_work implementation and the logic in this funct=
ion.
>           */
>          cpu_abort(env_cpu(env),
> @@ -1191,7 +1191,7 @@ void helper_rfi(CPUPPCState *env)
>  void helper_rfid(CPUPPCState *env)
>  {
>      /*
> -     * The architeture defines a number of rules for which bits can
> +     * The architecture defines a number of rules for which bits can
>       * change but in practice, we handle this in hreg_store_msr()
>       * which will be called by do_rfi(), so there is no need to filter
>       * here
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index ae43b08eb5..9b8c8b70b6 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -1804,7 +1804,7 @@ uint32_t helper_efdcmpeq(CPUPPCState *env, uint64_t=
 op1, uint64_t op2)
> =20
> =20
>  /*
> - * VSX_ADD_SUB - VSX floating point add/subract
> + * VSX_ADD_SUB - VSX floating point add/subtract
>   *   name  - instruction mnemonic
>   *   op    - operation (add or sub)
>   *   nels  - number of elements (1, 2 or 4)
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index 15d655b356..b4df127f4a 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -1,5 +1,5 @@
>  /*
> - *  PowerPC interal definitions for qemu.
> + *  PowerPC internal definitions for qemu.
>   *
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index d85ba8ffe0..e85ef2ea9e 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -487,7 +487,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>              /*
>               * KVM-HV has transactional memory on POWER8 also without
>               * the KVM_CAP_PPC_HTM extension, so enable it here
> -             * instead as long as it's availble to userspace on the
> +             * instead as long as it's available to userspace on the
>               * host.
>               */
>              if (qemu_getauxval(AT_HWCAP2) & PPC_FEATURE2_HAS_HTM) {
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 109d071162..f6a24a9c9a 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -337,7 +337,7 @@ static int cpu_post_load(void *opaque, int version_id)
> =20
>      /*
>       * If we're operating in compat mode, we should be ok as long as
> -     * the destination supports the same compatiblity mode.
> +     * the destination supports the same compatibility mode.
>       *
>       * Otherwise, however, we require that the destination has exactly
>       * the same CPU model as the source.
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index c31d21e6a9..977b2d1561 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -883,7 +883,7 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vadd=
r eaddr,
>      /*
>       * Note on LPCR usage: 970 uses HID4, but our special variant of
>       * store_spr copies relevant fields into env->spr[SPR_LPCR].
> -     * Similarily we filter unimplemented bits when storing into LPCR
> +     * Similarly we filter unimplemented bits when storing into LPCR
>       * depending on the MMU version. This code can thus just use the
>       * LPCR "as-is".
>       */
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 8972714775..50aa18a763 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -179,7 +179,7 @@ static inline int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx=
, target_ulong pte0,
>              }
>              /* Compute access rights */
>              access =3D pp_check(ctx->key, pp, ctx->nx);
> -            /* Keep the matching PTE informations */
> +            /* Keep the matching PTE information */
>              ctx->raddr =3D pte1;
>              ctx->prot =3D access;
>              ret =3D check_prot(ctx->prot, rw, type);
> @@ -2176,7 +2176,7 @@ void helper_store_sr(CPUPPCState *env, target_ulong=
 srnum, target_ulong value)
>          env->sr[srnum] =3D value;
>          /*
>           * Invalidating 256MB of virtual memory in 4kB pages is way
> -         * longer than flusing the whole TLB.
> +         * longer than flushing the whole TLB.
>           */
>  #if !defined(FLUSH_ALL_TLBS) && 0
>          {
> diff --git a/target/ppc/translate_init.c.inc b/target/ppc/translate_init.=
c.inc
> index bb66526280..3e0810fd6d 100644
> --- a/target/ppc/translate_init.c.inc
> +++ b/target/ppc/translate_init.c.inc
> @@ -792,7 +792,7 @@ static void gen_spr_generic(CPUPPCState *env)
>                   &spr_read_xer, &spr_write_xer,
>                   &spr_read_xer, &spr_write_xer,
>                   0x00000000);
> -    /* Branch contol */
> +    /* Branch control */
>      spr_register(env, SPR_LR, "LR",
>                   &spr_read_lr, &spr_write_lr,
>                   &spr_read_lr, &spr_write_lr,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+XgOcACgkQbDjKyiDZ
s5KS4g/4zu4J6s7+4e2obz7V1HJyi9XJZ/qgBzlLm10WG9M+nfcW7eN6f+7pVxrw
lRiBxna0AjkdcwLSWhhm836Ig5C9vAIc5uebv0Rab7YPUOneZ6XDLJXNxniJ6342
Ka99zCo3EBDoZfGlpyxwKQSgvfPOgwrEwV9rBWcmrVCOZMGh2DShJapAuPeitPDK
GRwWtxseaf8enRcg8VyLfyEPENAruSklR3sYu+s7sKeeLV6f2O288U+tzYYsJtVG
KXnRgI+NHYZRJqJoIQc8AS4mpGaoKp9F/c+tb+MI0nNLLAFMDsZlStWvaKghvclQ
TQt8CyOIbI7+fVH9g0OQhD10PrWjT2TVjbm7AC0+Cihaynhs7Icty2CZpiFmyBFS
ip9nC820rsvU9XYhwnKS4/7Enbg2Kgk9lALDvPF96/PRVVOjNlyhrFZ9bLS66c91
mDJul1cwxNjo3BRgbnbClaBJLVuHXNc2pvTFt63DkQcMY2IZc7SD6C9o8J001Q1G
CZ+8+OhzJTcQsYBHOUWzZCKf5KjrEOCzJsj9aCvZZKpDts6fXLwLi3U4IR+G1exu
I467gyeuGJrgUXs+kwTDizuxpruuEkrEiqJLdqiZkwzzDqJsj1WBUa8wQ+RtJM5n
DNRMUa9vtbC9tcNudMXk8YkQPhCC/uCT3/46sM3zgDiK1blkwA==
=9D9K
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--

