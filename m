Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA664C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 07:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 995B720673
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 07:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995B720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJurx-00046V-Nf
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 03:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iJupL-0002ay-1v
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 03:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iJupI-0000SF-NB
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 03:31:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38322)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iJupH-0000Ri-FR
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 03:31:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9CC9B18CB8EA;
 Mon, 14 Oct 2019 07:31:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 60F0C10013D9;
 Mon, 14 Oct 2019 07:31:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BD4861138619; Mon, 14 Oct 2019 09:31:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Subject: Re: [PATCH v4 1/8] target/mips: Clean up helper.c
References: <1570991178-5511-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1570991178-5511-2-git-send-email-aleksandar.markovic@rt-rk.com>
Date: Mon, 14 Oct 2019 09:31:27 +0200
In-Reply-To: <1570991178-5511-2-git-send-email-aleksandar.markovic@rt-rk.com>
 (Aleksandar Markovic's message of "Sun, 13 Oct 2019 20:26:11 +0200")
Message-ID: <87a7a36awg.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Mon, 14 Oct 2019 07:31:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: aleksandar.rikalo@rt-rk.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Aleksandar Markovic <aleksandar.markovic@rt-rk.com> writes:

> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Mostly fix errors and warnings reported by 'checkpatch.pl -f'.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/helper.c | 128 +++++++++++++++++++++++++++++++--------------------
>  1 file changed, 78 insertions(+), 50 deletions(-)
>
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index a2b6459..2411a2c 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -39,8 +39,8 @@ enum {
>  #if !defined(CONFIG_USER_ONLY)
>  
>  /* no MMU emulation */
> -int no_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
> -                        target_ulong address, int rw, int access_type)
> +int no_mmu_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,
> +                       target_ulong address, int rw, int access_type)
>  {
>      *physical = address;
>      *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> @@ -48,26 +48,28 @@ int no_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
>  }
>  
>  /* fixed mapping MMU emulation */
> -int fixed_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
> -                           target_ulong address, int rw, int access_type)
> +int fixed_mmu_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,
> +                          target_ulong address, int rw, int access_type)
>  {
>      if (address <= (int32_t)0x7FFFFFFFUL) {
> -        if (!(env->CP0_Status & (1 << CP0St_ERL)))
> +        if (!(env->CP0_Status & (1 << CP0St_ERL))) {
>              *physical = address + 0x40000000UL;
> -        else
> +        } else {
>              *physical = address;
> -    } else if (address <= (int32_t)0xBFFFFFFFUL)
> +        }
> +    } else if (address <= (int32_t)0xBFFFFFFFUL) {
>          *physical = address & 0x1FFFFFFF;
> -    else
> +    } else {
>          *physical = address;
> +    }
>  
>      *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>      return TLBRET_MATCH;
>  }
>  
>  /* MIPS32/MIPS64 R4000-style MMU emulation */
> -int r4k_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
> -                     target_ulong address, int rw, int access_type)
> +int r4k_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,
> +                    target_ulong address, int rw, int access_type)
>  {
>      uint16_t ASID = env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
>      int i;
> @@ -99,8 +101,9 @@ int r4k_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
>              if (rw != MMU_DATA_STORE || (n ? tlb->D1 : tlb->D0)) {
>                  *physical = tlb->PFN[n] | (address & (mask >> 1));
>                  *prot = PAGE_READ;
> -                if (n ? tlb->D1 : tlb->D0)
> +                if (n ? tlb->D1 : tlb->D0) {
>                      *prot |= PAGE_WRITE;
> +                }
>                  if (!(n ? tlb->XI1 : tlb->XI0)) {
>                      *prot |= PAGE_EXEC;
>                  }
> @@ -130,8 +133,11 @@ static int is_seg_am_mapped(unsigned int am, bool eu, int mmu_idx)
>      int32_t adetlb_mask;
>  
>      switch (mmu_idx) {
> -    case 3 /* ERL */:
> -        /* If EU is set, always unmapped */
> +    case 3:
> +        /*
> +         * ERL
> +         * If EU is set, always unmapped
> +         */
>          if (eu) {
>              return 0;
>          }

This changes from the usual way we format switch case comments to an
unusual way.

If you want to pursue this change, please put it in a separate patch,
so this one is really about fixing "errors and warnings reported by
'checkpatch.pl -f'", as your commit message promises.

[...]

