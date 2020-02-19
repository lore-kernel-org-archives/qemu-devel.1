Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDD2C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 11:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE539206E2
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 11:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE539206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4NO4-00021j-1V
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 06:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j4NNI-0001bJ-61
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:18:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j4NNG-0007jt-6k
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:18:39 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:16573)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j4NNF-0007h2-AX; Wed, 19 Feb 2020 06:18:38 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 2DFEB747DFE;
 Wed, 19 Feb 2020 12:18:35 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 01160747DFA; Wed, 19 Feb 2020 12:18:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F3226747DF8;
 Wed, 19 Feb 2020 12:18:34 +0100 (CET)
Date: Wed, 19 Feb 2020 12:18:34 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 02/12] ppc: Remove stub of PPC970 HID4
 implementation
In-Reply-To: <20200219005414.15635-3-david@gibson.dropbear.id.au>
Message-ID: <alpine.BSF.2.22.395.2002191214090.74530@zero.eik.bme.hu>
References: <20200219005414.15635-1-david@gibson.dropbear.id.au>
 <20200219005414.15635-3-david@gibson.dropbear.id.au>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1890943101-1582111114=:74530"
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: lvivier@redhat.com, groug@kaod.org, qemu-devel@nongnu.org, paulus@samba.org,
 clg@kaod.org, qemu-ppc@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1890943101-1582111114=:74530
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Feb 2020, David Gibson wrote:
> The PowerPC 970 CPU was a cut-down POWER4, which had hypervisor capabil=
ity.
> However, it can be (and often was) strapped into "Apple mode", where th=
e
> hypervisor capabilities were disabled (essentially putting it always in
> hypervisor mode).
>
> That's actually the only mode of the 970 we support in qemu, and we're
> unlikely to change that any time soon.  However, we do have a partial
> implementation of the 970's HID4 register which affects things only
> relevant for hypervisor mode.
>
> That stub is also really ugly, since it attempts to duplicate the effec=
ts
> of HID4 by re-encoding it into the LPCR register used in newer CPUs, bu=
t
> in a really confusing way.
>
> Just get rid of it.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
> target/ppc/mmu-hash64.c         | 28 +---------------------------
> target/ppc/translate_init.inc.c | 17 ++++++-----------
> 2 files changed, 7 insertions(+), 38 deletions(-)
>
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index da8966ccf5..a881876647 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -1091,33 +1091,6 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulon=
g val)
>
>     /* Filter out bits */
>     switch (env->mmu_model) {
> -    case POWERPC_MMU_64B: /* 970 */
> -        if (val & 0x40) {
> -            lpcr |=3D LPCR_LPES0;
> -        }
> -        if (val & 0x8000000000000000ull) {
> -            lpcr |=3D LPCR_LPES1;
> -        }
> -        if (val & 0x20) {
> -            lpcr |=3D (0x4ull << LPCR_RMLS_SHIFT);
> -        }
> -        if (val & 0x4000000000000000ull) {
> -            lpcr |=3D (0x2ull << LPCR_RMLS_SHIFT);
> -        }
> -        if (val & 0x2000000000000000ull) {
> -            lpcr |=3D (0x1ull << LPCR_RMLS_SHIFT);
> -        }
> -        env->spr[SPR_RMOR] =3D ((lpcr >> 41) & 0xffffull) << 26;
> -
> -        /*
> -         * XXX We could also write LPID from HID4 here
> -         * but since we don't tag any translation on it
> -         * it doesn't actually matter
> -         *
> -         * XXX For proper emulation of 970 we also need
> -         * to dig HRMOR out of HID5
> -         */
> -        break;
>     case POWERPC_MMU_2_03: /* P5p */
>         lpcr =3D val & (LPCR_RMLS | LPCR_ILE |
>                       LPCR_LPES0 | LPCR_LPES1 |
> @@ -1154,6 +1127,7 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong=
 val)
>         }
>         break;
>     default:
> +        g_assert_not_reached();
>         ;

Is this empty statement (lone semicolon) still needed now that you've=20
added something to this case? Thought it was only there to be able to add=
=20
a label to it so it could be removed now. (Does this count as a double ;=20
that a recent patch was trying to fix?)

Regards,
BALATON Zoltan

>     }
>     env->spr[SPR_LPCR] =3D lpcr;
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_ini=
t.inc.c
> index a0d0eaabf2..d7d4f012b8 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -7895,25 +7895,20 @@ static void spr_write_lpcr(DisasContext *ctx, i=
nt sprn, int gprn)
> {
>     gen_helper_store_lpcr(cpu_env, cpu_gpr[gprn]);
> }
> -
> -static void spr_write_970_hid4(DisasContext *ctx, int sprn, int gprn)
> -{
> -#if defined(TARGET_PPC64)
> -    spr_write_generic(ctx, sprn, gprn);
> -    gen_helper_store_lpcr(cpu_env, cpu_gpr[gprn]);
> -#endif
> -}
> -
> #endif /* !defined(CONFIG_USER_ONLY) */
>
> static void gen_spr_970_lpar(CPUPPCState *env)
> {
> #if !defined(CONFIG_USER_ONLY)
>     /* Logical partitionning */
> -    /* PPC970: HID4 is effectively the LPCR */
> +    /* PPC970: HID4 covers things later controlled by the LPCR and
> +     * RMOR in later CPUs, but with a different encoding.  We only
> +     * support the 970 in "Apple mode" which has all hypervisor
> +     * facilities disabled by strapping, so we can basically just
> +     * ignore it */
>     spr_register(env, SPR_970_HID4, "HID4",
>                  SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_970_hid4,
> +                 &spr_read_generic, &spr_write_generic,
>                  0x00000000);
> #endif
> }
>
--3866299591-1890943101-1582111114=:74530--

