Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C370C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 283272076C
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283272076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpzvX-00058k-EA
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 15:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jpznu-0007bX-4o
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 15:50:58 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:33259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jpznr-00069x-5b
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 15:50:57 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MXHBo-1jJX7N2RCw-00YmPQ; Mon, 29 Jun 2020 21:50:51 +0200
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20200629162636.6648-1-mark.cave-ayland@ilande.co.uk>
 <853eebf0-f8a7-c7dc-bcbd-a491016a2e7a@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] target/m68k: fix physical address translation in
 m68k_cpu_get_phys_page_debug()
Message-ID: <4f5461f2-d251-df16-00ad-63668fe6aa31@vivier.eu>
Date: Mon, 29 Jun 2020 21:50:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <853eebf0-f8a7-c7dc-bcbd-a491016a2e7a@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vQI1/N9NJ3HSnUh79VTMT9Um614p8VaZjnI1wKfLa6/fFo2xU9u
 d5yHeqD9fjlmH0+UM94EI8dQ3aU2BTbKgcHhhjBubPHd5ILGK5yFtNhWGaA/Q6OLMyQPJG/
 ZIDW5WYPu9Cuu/oRNZYHfL83jwOt0gS1WWpygHYqfOOuuaFOgTKp4HowJ8P0Dt6jOC/4IYX
 hOOj4KNXYk+SEffgjbyvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0xiVenTGiBs=:4fCBzToLYxjGQ4SU7fdkqe
 9y/AixHFcZo25uGI8UjOg8IC6IKBs6nXdEMZPK8aShXhRmYTBOhJ9Hc/mbRY32MtgZZMMyfqZ
 LX4ESSNvqDCY822gLin0TlLDdZyNBhDzPxkyqgonzm0waEYAu4M0wvL13kW8Zd5AMvqBfGdS1
 1e+lgiGyeZOOHWltfYjSFs+K29IYISba+GgvEFKLN4CRvu//2+FEQg/p6SnsTgsHQnKvEHzmH
 nPC1LgoPA8+GoKgA2cxqaxcDzVVnVYEcDv+m8ewUPbqmWQfQi8EftixbWBZIEi3D2eBk+vJcG
 K2xz8JPmzxW+N2z9EmHp6U0PyDA8rtPMu5/aNS4BrUD1gGorwuUBCrWfKAfYmEdGkw6N1ESFW
 TXQZwdGZddDBhH/gFKtkVYBcmuOBifV3D9eDsjX+vC8jyEJCUCw8zVcKwU3VLPS+TAlc11Hrc
 uhVwBSDcz2mkJpjVQ+IF2EA0I9+qwRYVQKabnwXMH2I3/7aEzE3TLx+zi1J/JqHwi1QkO49fo
 QTAOYI+DzfKtcDW9dG4obqr6zJo6+MJhxqxy9ZyuRI7iz346C3PlwOkDDprXB4/eoJqLznjLz
 I63rqvj6+3m3LzMmCe2y69UAmOB7WOqCRUlwVs4P3JItT6wwjqd5PJ8HlOcTlSVCJOGXxECqw
 8VvwQfuhvhuN0BK6iExQNIS0e0cGev1Nf6E9ZflfGpg6uWhExWfVsT03BcutpFCnIkv/NXp3y
 pIwqq/fYTyVWy50frgVBgnfFB5s7MP0TFqkLXL8jG5ARgII1j99ff0PMqWX0Rbrn8ENVm2FSk
 fqC/4CHHoK/u9QoaPHqvpuvlqNaVexX+NwnWD5qdzkU3kj+/nc=
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 15:50:53
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

Le 29/06/2020 à 19:56, Philippe Mathieu-Daudé a écrit :
> On 6/29/20 6:26 PM, Mark Cave-Ayland wrote:
>> The result of the get_physical_address() function should be combined with the
>> offset of the original page access before being returned. Otherwise the
>> m68k_cpu_get_phys_page_debug() function can round to the wrong page causing
>> incorrect lookups in gdbstub and various "Disassembler disagrees with
>> translator over instruction decoding" warnings to appear at translation time.
>>
>> Fixes: 88b2fef6c3 ("target/m68k: add MC68040 MMU")
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  target/m68k/helper.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
>> index 79b0b10ea9..631eab7774 100644
>> --- a/target/m68k/helper.c
>> +++ b/target/m68k/helper.c
>> @@ -820,10 +820,14 @@ hwaddr m68k_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>>      if (env->sr & SR_S) {
>>          access_type |= ACCESS_SUPER;
>>      }
>> +
>>      if (get_physical_address(env, &phys_addr, &prot,
>>                               addr, access_type, &page_size) != 0) {
>>          return -1;
>>      }
>> +
>> +    addr &= TARGET_PAGE_MASK;
>> +    phys_addr += addr & (page_size - 1);
> 
> Correct but all the callers do the same, maybe this can somehow
> be moved to the callee? Anyway:

I agree.

Anyway:
Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent

