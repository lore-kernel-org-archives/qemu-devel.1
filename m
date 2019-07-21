Return-Path: <SRS0=xsRN=VS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E93C76191
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 19:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AE2A2084C
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 19:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE2A2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpHu8-0000hZ-I0
	for qemu-devel@archiver.kernel.org; Sun, 21 Jul 2019 15:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33636)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hpHtr-00088H-7r
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 15:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hpHtp-00030O-TQ
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 15:53:39 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:35556
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hpHtp-0002FF-NU
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 15:53:37 -0400
Received: from host86-130-37-205.range86-130.btcentralplus.com
 ([86.130.37.205] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hpHqX-0007Hw-GW; Sun, 21 Jul 2019 20:50:15 +0100
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <a5f7f8854af046c18c6342035662a193@tpw09926dag18e.domain1.systemhost.net>
 <1563343829014.86755@bt.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Openpgp: preference=signencrypt
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <321de4be-d5fd-7ccc-3a37-fd9cd494f564@ilande.co.uk>
Date: Sun, 21 Jul 2019 20:50:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563343829014.86755@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.205
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: No (on mail.default.ilande.uk0.bigv.io); Unknown failure
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: Re: [Qemu-devel] [PATCH 4/4] target/sparc: sun4u Invert Endian TTE
 bit
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
Cc: pbonzini@redhat.com, atar4qemu@gmail.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/07/2019 07:10, tony.nguyen@bt.com wrote:

> This bit configures endianness of PCI MMIO devices. It is used by
> Solaris and OpenBSD sunhme drivers.
> 
> Tested working on OpenBSD.
> 
> Unfortunately Solaris 10 had a unrelated keyboard issue blocking
> testing... another inch towards Solaris 10 on SPARC64 =)
> 
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  target/sparc/cpu.h        |  2 ++
>  target/sparc/mmu_helper.c | 41 +++++++++++++++++++++++++++------------
>  2 files changed, 31 insertions(+), 12 deletions(-)
> 
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index 8ed2250cd0..77e8e07194 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -277,6 +277,7 @@ enum {
>  
>  #define TTE_VALID_BIT       (1ULL << 63)
>  #define TTE_NFO_BIT         (1ULL << 60)
> +#define TTE_IE_BIT          (1ULL << 59)
>  #define TTE_USED_BIT        (1ULL << 41)
>  #define TTE_LOCKED_BIT      (1ULL <<  6)
>  #define TTE_SIDEEFFECT_BIT  (1ULL <<  3)
> @@ -293,6 +294,7 @@ enum {
>  
>  #define TTE_IS_VALID(tte)   ((tte) & TTE_VALID_BIT)
>  #define TTE_IS_NFO(tte)     ((tte) & TTE_NFO_BIT)
> +#define TTE_IS_IE(tte)      ((tte) & TTE_IE_BIT)
>  #define TTE_IS_USED(tte)    ((tte) & TTE_USED_BIT)
>  #define TTE_IS_LOCKED(tte)  ((tte) & TTE_LOCKED_BIT)
>  #define TTE_IS_SIDEEFFECT(tte) ((tte) & TTE_SIDEEFFECT_BIT)
> diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
> index cbd1e91179..f7b97d1e46 100644
> --- a/target/sparc/mmu_helper.c
> +++ b/target/sparc/mmu_helper.c
> @@ -492,7 +492,8 @@ static inline int ultrasparc_tag_match(SparcTLBEntry *tlb,
>  
>  static int get_physical_address_data(CPUSPARCState *env,
>                                       hwaddr *physical, int *prot,
> -                                     target_ulong address, int rw, int mmu_idx)
> +                                     MemTxAttrs *attrs, target_ulong address,
> +                                     int rw, int mmu_idx)
>  {
>      CPUState *cs = env_cpu(env);
>      unsigned int i;
> @@ -536,6 +537,10 @@ static int get_physical_address_data(CPUSPARCState *env,
>          if (ultrasparc_tag_match(&env->dtlb[i], address, context, physical)) {
>              int do_fault = 0;
>  
> +            if (TTE_IS_IE(env->dtlb[i].tte)) {
> +                attrs->byte_swap = true;
> +            }
> +
>              /* access ok? */
>              /* multiple bits in SFSR.FT may be set on TT_DFAULT */
>              if (TTE_IS_PRIV(env->dtlb[i].tte) && is_user) {
> @@ -686,7 +691,7 @@ static int get_physical_address_code(CPUSPARCState *env,
>  }
>  
>  static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
> -                                int *prot, int *access_index,
> +                                int *prot, MemTxAttrs *attrs,
>                                  target_ulong address, int rw, int mmu_idx,
>                                  target_ulong *page_size)
>  {
> @@ -716,11 +721,12 @@ static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
>      }
>  
>      if (rw == 2) {
> +        *attrs = MEMTXATTRS_UNSPECIFIED;
>          return get_physical_address_code(env, physical, prot, address,
>                                           mmu_idx);
>      } else {
> -        return get_physical_address_data(env, physical, prot, address, rw,
> -                                         mmu_idx);
> +        return get_physical_address_data(env, physical, prot, attrs, address,
> +                                         rw, mmu_idx);
>      }
>  }
>  
> @@ -734,10 +740,11 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>      target_ulong vaddr;
>      hwaddr paddr;
>      target_ulong page_size;
> -    int error_code = 0, prot, access_index;
> +    MemTxAttrs attrs = {> +    int error_code = 0, prot;
>  
>      address &= TARGET_PAGE_MASK;
> -    error_code = get_physical_address(env, &paddr, &prot, &access_index,
> +    error_code = get_physical_address(env, &paddr, &prot, &attrs,
>                                        address, access_type,
>                                        mmu_idx, &page_size);
>      if (likely(error_code == 0)) {
> @@ -747,7 +754,8 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                                     env->dmmu.mmu_primary_context,
>                                     env->dmmu.mmu_secondary_context);
>  
> -        tlb_set_page(cs, vaddr, paddr, prot, mmu_idx, page_size);
> +        tlb_set_page_with_attrs(cs, vaddr, paddr, attrs, prot, mmu_idx,
> +                                page_size);
>          return true;
>      }
>      if (probe) {
> @@ -789,7 +797,7 @@ void dump_mmu(CPUSPARCState *env)
>              }
>              if (TTE_IS_VALID(env->dtlb[i].tte)) {
>                  qemu_printf("[%02u] VA: %" PRIx64 ", PA: %llx"
> -                            ", %s, %s, %s, %s, ctx %" PRId64 " %s\n",
> +                            ", %s, %s, %s, %s, ie %s, ctx %" PRId64 " %s\n",
>                              i,
>                              env->dtlb[i].tag & (uint64_t)~0x1fffULL,
>                              TTE_PA(env->dtlb[i].tte),
> @@ -798,6 +806,8 @@ void dump_mmu(CPUSPARCState *env)
>                              TTE_IS_W_OK(env->dtlb[i].tte) ? "RW" : "RO",
>                              TTE_IS_LOCKED(env->dtlb[i].tte) ?
>                              "locked" : "unlocked",
> +                            TTE_IS_IE(env->dtlb[i].tte) ?
> +                            "yes" : "no",
>                              env->dtlb[i].tag & (uint64_t)0x1fffULL,
>                              TTE_IS_GLOBAL(env->dtlb[i].tte) ?
>                              "global" : "local");
> @@ -848,13 +858,20 @@ static int cpu_sparc_get_phys_page(CPUSPARCState *env, hwaddr *phys,
>                                     target_ulong addr, int rw, int mmu_idx)
>  {
>      target_ulong page_size;
> -    int prot, access_index;
> +    int prot;
>  
> -    return get_physical_address(env, phys, &prot, &access_index, addr, rw,
> -                                mmu_idx, &page_size);
> +#ifdef TARGET_SPARC64
> +    MemTxAttrs attrs = {};
> +    return get_physical_address(env, phys, &prot, &attrs,
> +                                addr, rw, mmu_idx, &page_size);
> +#else
> +    int access_index;
> +    return get_physical_address(env, phys, &prot, &access_index,
> +                                addr, rw, mmu_idx, &page_size);
> +#endif /* TARGET_SPARC64 */
>  }
>  
> -#if defined(TARGET_SPARC64)
> +#ifdef TARGET_SPARC64
>  hwaddr cpu_get_phys_page_nofault(CPUSPARCState *env, target_ulong addr,
>                                             int mmu_idx)
>  {

This feels like it's making things more complicated: why don't you just set
MemTxAttrs to {} in sparc_cpu_tlb_fill() and cpu_sparc_get_phys_page() and then push
the extra parameter all the way down to get_physical_address_code() and
get_physical_address_data()? AFAICT we are deliberately clearing the attributes by
default which is why we shouldn't need to use MEMTXATTRS_UNSPECIFIED.

I wonder if adding the MemTxAddrs parameters and converting tlb_set_page() to
tlb_set_page_with_attrs() for both 32-bit and 64-bit SPARCs should be a separate
commit, before the final commit that adds the support for the endian swap?

BTW many thanks for working on this - I have the patchset a quick test and I was able
to boot my OpenBSD test image and successfully use the network card :)


ATB,

Mark.

