Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6ECC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:36:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 902F820692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902F820692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipBVw-0008CH-GD
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 08:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ipBUz-000780-Jt
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:35:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ipBUx-0004Zf-2g
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:35:48 -0500
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:52538)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ipBUw-0004WL-QF
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:35:47 -0500
Received: from player789.ha.ovh.net (unknown [10.109.146.166])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 5F0AF1BEA6B
 for <qemu-devel@nongnu.org>; Wed,  8 Jan 2020 14:35:42 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id 9A16EE055679;
 Wed,  8 Jan 2020 13:35:31 +0000 (UTC)
Date: Wed, 8 Jan 2020 14:35:30 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 02/10] ppc: Remove stub of PPC970 HID4 implementation
Message-ID: <20200108143530.4b176973@bahia.lan>
In-Reply-To: <20200107044827.471355-3-david@gibson.dropbear.id.au>
References: <20200107044827.471355-1-david@gibson.dropbear.id.au>
 <20200107044827.471355-3-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15757532148474419686
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehkedgheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeekledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.172.75
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
Cc: lvivier@redhat.com, aik@ozlabs.ru,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 paulus@ozlabs.org, qemu-ppc@nongnu.org, clg@kaod.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  7 Jan 2020 15:48:19 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> The PowerPC 970 CPU was a cut-down POWER4, which had hypervisor capability.
> However, it can be (and often was) strapped into "Apple mode", where the
> hypervisor capabilities were disabled (essentially putting it always in
> hypervisor mode).
> 
> That's actually the only mode of the 970 we support in qemu, and we're
> unlikely to change that any time soon.  However, we do have a partial
> implementation of the 970's HID4 register which affects things only
> relevant for hypervisor mode.
> 

FWIW, it is currently _possible_ to boot an RHEL 6.1 guest with a 970mp
CPU under TCG (newer guests like RHEL 7.5 don't work because the kernel
seems to have instructions not supported on 970). Of course this no longer
works with this patch, but I guess we don't really care for such an old
setup, do we ?

> That stub is also really ugly, since it attempts to duplicate the effects
> of HID4 by re-encoding it into the LPCR register used in newer CPUs, but
> in a really confusing way.
> 
> Just get rid of it.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Just one cosmetic nit I hadn't spotted before...

>  target/ppc/mmu-hash64.c         | 28 +---------------------------
>  target/ppc/translate_init.inc.c | 17 ++++++-----------
>  2 files changed, 7 insertions(+), 38 deletions(-)
> 
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index da8966ccf5..a881876647 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -1091,33 +1091,6 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
>  
>      /* Filter out bits */
>      switch (env->mmu_model) {
> -    case POWERPC_MMU_64B: /* 970 */
> -        if (val & 0x40) {
> -            lpcr |= LPCR_LPES0;
> -        }
> -        if (val & 0x8000000000000000ull) {
> -            lpcr |= LPCR_LPES1;
> -        }
> -        if (val & 0x20) {
> -            lpcr |= (0x4ull << LPCR_RMLS_SHIFT);
> -        }
> -        if (val & 0x4000000000000000ull) {
> -            lpcr |= (0x2ull << LPCR_RMLS_SHIFT);
> -        }
> -        if (val & 0x2000000000000000ull) {
> -            lpcr |= (0x1ull << LPCR_RMLS_SHIFT);
> -        }
> -        env->spr[SPR_RMOR] = ((lpcr >> 41) & 0xffffull) << 26;
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
>      case POWERPC_MMU_2_03: /* P5p */
>          lpcr = val & (LPCR_RMLS | LPCR_ILE |
>                        LPCR_LPES0 | LPCR_LPES1 |
> @@ -1154,6 +1127,7 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
>          }
>          break;
>      default:
> +        g_assert_not_reached();
>          ;

... remove the line with the semi-colon ?
 
>      }
>      env->spr[SPR_LPCR] = lpcr;
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
> index d33d65dff7..436d0d5a51 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -7884,25 +7884,20 @@ static void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn)
>  {
>      gen_helper_store_lpcr(cpu_env, cpu_gpr[gprn]);
>  }
> -
> -static void spr_write_970_hid4(DisasContext *ctx, int sprn, int gprn)
> -{
> -#if defined(TARGET_PPC64)
> -    spr_write_generic(ctx, sprn, gprn);
> -    gen_helper_store_lpcr(cpu_env, cpu_gpr[gprn]);
> -#endif
> -}
> -
>  #endif /* !defined(CONFIG_USER_ONLY) */
>  
>  static void gen_spr_970_lpar(CPUPPCState *env)
>  {
>  #if !defined(CONFIG_USER_ONLY)
>      /* Logical partitionning */
> -    /* PPC970: HID4 is effectively the LPCR */
> +    /* PPC970: HID4 covers things later controlled by the LPCR and
> +     * RMOR in later CPUs, but with a different encoding.  We only
> +     * support the 970 in "Apple mode" which has all hypervisor
> +     * facilities disabled by strapping, so we can basically just
> +     * ignore it */
>      spr_register(env, SPR_970_HID4, "HID4",
>                   SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_970_hid4,
> +                 &spr_read_generic, &spr_write_generic,
>                   0x00000000);
>  #endif
>  }


