Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4CAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC7720663
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC7720663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqECz-0007T2-Go
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 07:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jqECO-0006sk-9H
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 07:13:12 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:40994
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jqECM-00084S-3H
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 07:13:12 -0400
Received: from host86-182-221-235.range86-182.btcentralplus.com
 ([86.182.221.235] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jqECN-0008T6-3h; Tue, 30 Jun 2020 12:13:12 +0100
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200630061036.7526-1-mark.cave-ayland@ilande.co.uk>
 <20200630061036.7526-3-mark.cave-ayland@ilande.co.uk>
 <747ff000-aa47-5f9d-a953-0c503c6be78a@vivier.eu>
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
Message-ID: <39da231d-82fd-1b2b-7fce-fb65d43c91a2@ilande.co.uk>
Date: Tue, 30 Jun 2020 12:13:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <747ff000-aa47-5f9d-a953-0c503c6be78a@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.182.221.235
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 2/2] target/m68k: consolidate physical translation
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

On 30/06/2020 08:23, Laurent Vivier wrote:

> Le 30/06/2020 à 08:10, Mark Cave-Ayland a écrit :
>> Since all callers to get_physical_address() now apply the same page offset to
>> the translation result, move the logic into get_physical_address() itself to
>> avoid duplication.
>>
>> Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  target/m68k/helper.c | 12 +++---------
>>  1 file changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
>> index 631eab7774..ddd8a2667e 100644
>> --- a/target/m68k/helper.c
>> +++ b/target/m68k/helper.c
>> @@ -771,7 +771,8 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
>>      }
>>      *page_size = 1 << page_bits;
>>      page_mask = ~(*page_size - 1);
>> -    *physical = next & page_mask;
>> +    address &= TARGET_PAGE_MASK;
>> +    *physical = (next & page_mask) + (address & (*page_size - 1));
> 
> You didn't update the Transparent Translation Register part.

Ooops yes - looks like TARGET_PAGE_MASK needs to be removed from the TTR part.

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
>> @@ -891,10 +890,7 @@ bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>>      ret = get_physical_address(&cpu->env, &physical, &prot,
>>                                 address, access_type, &page_size);
>>      if (likely(ret == 0)) {
>> -        address &= TARGET_PAGE_MASK;
>> -        physical += address & (page_size - 1);
>> -        tlb_set_page(cs, address, physical,
>> -                     prot, mmu_idx, TARGET_PAGE_SIZE);
>> +        tlb_set_page(cs, address, physical, prot, mmu_idx, page_size);
> 
> but now we use "address" which is not the exact virtual address but the
> virtual address of the page. According to the name, tlb_set_page(), and
> the other users in QEMU, it should be:
> 
> 
>  tlb_set_page(cs, address & TARGET_PAGE_MASK,
>                   physical & TARGET_PAGE_MASK, prot, mmu_idx,
>                   page_size);

The tlb_set_page() contract seems a bit confusing, since tlb_set_page_with_attrs()
applies TARGET_PAGE_MASK regardless, but I agree that it's clearer this way.

I also spotted that this needs to be done for the tlb_set_page() call in the ptest
helper, so I'll go ahead and make these changes. Assuming all looks good I will send
along v3 shortly.


ATB,

Mark.

