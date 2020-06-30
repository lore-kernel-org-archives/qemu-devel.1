Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2039EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 07:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E561E20759
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 07:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E561E20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqAcP-0001gL-6q
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 03:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jqAbh-0000jd-9L
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 03:23:05 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:45091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jqAbf-00042d-AD
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 03:23:04 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Msqpq-1iwxWX1Ipk-00tCkm; Tue, 30 Jun 2020 09:23:01 +0200
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20200630061036.7526-1-mark.cave-ayland@ilande.co.uk>
 <20200630061036.7526-3-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2 2/2] target/m68k: consolidate physical translation
 offset into get_physical_address()
Message-ID: <747ff000-aa47-5f9d-a953-0c503c6be78a@vivier.eu>
Date: Tue, 30 Jun 2020 09:23:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630061036.7526-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vShNWArpKtSb86i/0jbHg1/hyTmY+XzE2w7NR57U1AnS8K0i5nK
 Te5FDUALEU9ef8AQq64cg2pfo3rj8fq2DxZ7nsTAaCEK7AFOt31NKgrh8jgU87uSpHkOD2t
 Hids5NVcYT0dq5P3fwiQzW4wfD7EcV5fqLie8FvTRgOt+H91tktpmBshs00f4VwJnVtO/Ym
 S4LW4Tlyz1jptn8KmtByw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kt6xUYuBo0U=:TogFFQDlRAnNGitq+I3bZE
 CulKXlfAp7Eav+vCO0MIagIex9/+BOY12SeHsnxk3Jg085qDQTNciOkQ9ORcDG77gQIEiW28M
 2RUbQVppTnDqr0BT+S7HL7rmFyUBWVLCMyrxLjDg0z0jZ0TZTOdcRaK8XubKQx/SmgV/Jsxfy
 xmrbOuUtsW3mNy+F3DYGO9MQDpwE9goTMgxAX6925wl1+00sMSqQVMIFDbpi5kN+w6NQKu2+q
 FlBMq2eBxq01HVkL3VBk4iRzhd+nb1iTH3SAxiTO1QwWNyWqkxnve/ujK/P47jFns94ocAFcD
 uSO/HdoD48Pe5GLM1XTe00BYgHrlWEIwp2eUQ0l7wvOXYetBfnthKDQ7sZfWb+rHtL89E757t
 FaARzO8MDVzugRYcBDw9laVZr/RCSVItEa0BqDJ49b/mU7264BeedL6rQTxLTHTqrgCAFwsZ0
 NyQQMfLGsc/pqalljvMlbqk2UFNBQlDyOU4UQ5Nub9qhuT7msee4+BxLgeAbetp6kZZFzY/TG
 VszJ/exXJ/zvd9jzzcPhetsk4xvjjlbFDDz2Ixh913a7iPYvbsKqCKn5ctg4TwL/5/7jN0enZ
 0URUty3K2Qrst/r60cVOd4sNon9RLoPuZG1bqycCpxclv81T8Z3tjGVINFD2gItBzk90ikaEz
 Mj/mhWHRpLllLtuDp4gZTU4B+OobNsxeAJhdHALaRxlAIltLiENwqlMgECOC/trH0jAkIqFlL
 d97lJuuLxzMe5Y9MqVY7eupe3oFkoBLOZ0qdhPHfF6rSXg5hFSMfp40R2ZdUlBtIqs3DorNg9
 kCKUJOzLwV6yNeGbnfUSSV2h+KVj4Ax1Bn5RSMRQ7Xxmq0uSgBJXjvxmuwbVLTgl1DdWbJ3
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:23:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 30/06/2020 à 08:10, Mark Cave-Ayland a écrit :
> Since all callers to get_physical_address() now apply the same page offset to
> the translation result, move the logic into get_physical_address() itself to
> avoid duplication.
> 
> Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/m68k/helper.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 631eab7774..ddd8a2667e 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -771,7 +771,8 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
>      }
>      *page_size = 1 << page_bits;
>      page_mask = ~(*page_size - 1);
> -    *physical = next & page_mask;
> +    address &= TARGET_PAGE_MASK;
> +    *physical = (next & page_mask) + (address & (*page_size - 1));

You didn't update the Transparent Translation Register part.

>  
>      if (access_type & ACCESS_PTEST) {
>          env->mmu.mmusr |= next & M68K_MMU_SR_MASK_040;
> @@ -826,8 +827,6 @@ hwaddr m68k_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>          return -1;
>      }
>  
> -    addr &= TARGET_PAGE_MASK;
> -    phys_addr += addr & (page_size - 1);
>      return phys_addr;
>  }
>  
> @@ -891,10 +890,7 @@ bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>      ret = get_physical_address(&cpu->env, &physical, &prot,
>                                 address, access_type, &page_size);
>      if (likely(ret == 0)) {
> -        address &= TARGET_PAGE_MASK;
> -        physical += address & (page_size - 1);
> -        tlb_set_page(cs, address, physical,
> -                     prot, mmu_idx, TARGET_PAGE_SIZE);
> +        tlb_set_page(cs, address, physical, prot, mmu_idx, page_size);

but now we use "address" which is not the exact virtual address but the
virtual address of the page. According to the name, tlb_set_page(), and
the other users in QEMU, it should be:


 tlb_set_page(cs, address & TARGET_PAGE_MASK,
                  physical & TARGET_PAGE_MASK, prot, mmu_idx,
                  page_size);

Thanks,
Laurent

