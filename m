Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAE0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 19:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 730DE20720
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 19:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730DE20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqinP-0002gc-Ns
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 15:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jqimX-0001ji-9h
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 15:52:33 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:43906
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jqimT-00019v-6O
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 15:52:32 -0400
Received: from host86-182-221-233.range86-182.btcentralplus.com
 ([86.182.221.233] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jqimO-0005X1-Mw; Wed, 01 Jul 2020 20:52:29 +0100
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200630112752.31134-1-mark.cave-ayland@ilande.co.uk>
 <20200630112752.31134-3-mark.cave-ayland@ilande.co.uk>
 <3da2bd06-b7fe-5b02-d35a-d57edc1a7989@vivier.eu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
Message-ID: <fcb19340-8ea0-1a5e-65b7-d042c4c08e28@ilande.co.uk>
Date: Wed, 1 Jul 2020 20:52:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3da2bd06-b7fe-5b02-d35a-d57edc1a7989@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.182.221.233
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 2/2] target/m68k: consolidate physical translation
 offset into get_physical_address()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 30/06/2020 22:20, Laurent Vivier wrote:

> Le 30/06/2020 à 13:27, Mark Cave-Ayland a écrit :
>> Since all callers to get_physical_address() now apply the same page offset to
>> the translation result, move the logic into get_physical_address() itself to
>> avoid duplication.
>>
>> Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  target/m68k/helper.c | 18 +++++++-----------
>>  1 file changed, 7 insertions(+), 11 deletions(-)
>>
>> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
>> index 631eab7774..71c2376910 100644
>> --- a/target/m68k/helper.c
>> +++ b/target/m68k/helper.c
>> @@ -643,7 +643,7 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
>>                  /* Transparent Translation Register bit */
>>                  env->mmu.mmusr = M68K_MMU_T_040 | M68K_MMU_R_040;
>>              }
>> -            *physical = address & TARGET_PAGE_MASK;
>> +            *physical = address;
>>              *page_size = TARGET_PAGE_SIZE;
>>              return 0;
>>          }
>> @@ -771,7 +771,8 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
>>      }
>>      *page_size = 1 << page_bits;
>>      page_mask = ~(*page_size - 1);
>> -    *physical = next & page_mask;
>> +    address &= TARGET_PAGE_MASK;
> 
> I don't think you need TARGET_PAGE_MASK here:
> - TARGET_PAGE_MASK is 4096
> - page_mask is either 4096 or 8192

Ah yes, of course - that will get handled fine by the statement below.

>> +    *physical = (next & page_mask) + (address & (*page_size - 1));
>>  
>>      if (access_type & ACCESS_PTEST) {
>>          env->mmu.mmusr |= next & M68K_MMU_SR_MASK_040;
>> @@ -826,8 +827,6 @@ hwaddr m68k_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>>          return -1;
>>      }
>>  
>> -    addr &= TARGET_PAGE_MASK;
>> -    phys_addr += addr & (page_size - 1);
>>      return phys_addr;
>>  }
>>  
>> @@ -891,10 +890,8 @@ bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>>      ret = get_physical_address(&cpu->env, &physical, &prot,
>>                                 address, access_type, &page_size);
>>      if (likely(ret == 0)) {
>> -        address &= TARGET_PAGE_MASK;
>> -        physical += address & (page_size - 1);
>> -        tlb_set_page(cs, address, physical,
>> -                     prot, mmu_idx, TARGET_PAGE_SIZE);
>> +        tlb_set_page(cs, address & TARGET_PAGE_MASK,
>> +                     physical & TARGET_PAGE_MASK, prot, mmu_idx, page_size);
> 
> I had a look to tl_set_page() to see how it manages the entry when the
> addresses are not aligned to page_size, and it calls
> tlb_set_page_with_attrs() where we have a comment:
> 
> /* Add a new TLB entry. At most one entry for a given virtual address
>  * is permitted. Only a single TARGET_PAGE_SIZE region is mapped, the
>  * supplied size is only used by tlb_flush_page.
> ...
> 
> So I think it's correct to use TARGET_PAGE_MASK and page_size.

Indeed, it certainly agrees with the documentation and what the majority of the
callers are doing - I'm just surprised that tlb_set_page_with_attrs() doesn't
assert() if any bits below TARGET_PAGE_MASK are set, rather than masking both vaddr
and paddr itself. But I'm happy with this part anyhow.


ATB,

Mark.

