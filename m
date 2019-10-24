Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB89CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:46:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 613AC21872
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613AC21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNi83-0007hL-Bx
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNhaJ-0006aS-FL
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNhaI-0008TV-2S
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:11:43 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:60977)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNhaH-0008Sy-PF; Thu, 24 Oct 2019 14:11:42 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N5mOZ-1hv9FK1EFf-017F3I; Thu, 24 Oct 2019 20:11:37 +0200
Subject: Re: [PATCH 3/3] qemu-timer: reuse MIN macro in qemu_timeout_ns_to_ms
To: Eric Blake <eblake@redhat.com>, Frediano Ziglio <fziglio@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20191023122652.2999-1-fziglio@redhat.com>
 <20191023122652.2999-3-fziglio@redhat.com>
 <ac0dbd04-c594-0904-020c-ab6384153997@vivier.eu>
 <45775e9d-5d7d-74b4-8eee-1813b080c2da@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d9bf8d20-a873-57ec-3cc4-542c72016463@vivier.eu>
Date: Thu, 24 Oct 2019 20:11:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <45775e9d-5d7d-74b4-8eee-1813b080c2da@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Io65x8KOSpNhKJQfe0EV/jvbAueGShzHdDd8ROILf2MwE99pjWn
 V/rnGL2flHK6l+NRaZWXGUADAdlGha3JVN44onLRco5jTZgEQfOHoqghuq6FpjCs27Dvagm
 9dpSbuA0s4yyzfSwyAzxsyJzccI+jtPp52B68qp2JePGHgTqwUSOMGTfmybqM8YVRU1H00Y
 nty82DnwpzQ3OfW/ZxmOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ved6pVf0YTo=:B9gM8tPp7C+tLJt3WoeBb0
 lQ+Ma1M+sneFgZmNBO83es5DMY9yYz0P+AzYdopb7Ygig5CcuNIJUseRaA5FCBXU2xG/kFe6l
 H/Ednkw54gq0fncxAxl/N/ojE6OFlXO3lU0YMlXGWrYk+Drz9mOxOqiPBKAZ8qf/OfFcgXdUm
 fJ26hROHG9PWf0NOKD/nNdYMaObz1sgIrU3ID7dNeM1Tt4E9E78QlUCocOMc3uakpSiLuVbrn
 CSY5BFystLlb0xc7/esG5iU19OtHWybm5oMNc++TNo7cdbDX8m4QyIyTb2FabHsD6INEpYfoG
 AHeD5fFJl0JKm4/crxwudOekxD5YMGZjJw4aTll58pT95Sc+LsLJuZ/+kY/ZhIRfKJ0vvEn+V
 QaWcyAJQlA94Je9MMIbADjjelb/Sc7nrHdN2ugkqPWVrEhsPmhsHp3aF2TKm9EQsxa0BDcanU
 sGe++JlTw42omgkFLMbfUQDssAPl0nU04qjLwQQB0ZapxV+niEMp3IcbdHXVKgeZIswVkspRW
 HM1tQ+F5RBxNXPchouBAf01e1rs/ps+cyApJc2LfxkZZWwXBaYujKS1BATNx4hzcHizcQw3W9
 sDhpi8WeB3H4VkKfohXO0MopTafNlcr+fxy6NJyueJ8PTLLMDdhthCAHIDD3qnqmUuayQWY2C
 uAR2AUY16mftqfwuVhXT6y9FIwzinYnZjnClRsF+pfGoTCy1fANSlb4+s4aUTF7rXTyk3zf/6
 JM8A6NCcmCYubudR4OHOjfOHG1FxOZ1V1rL/opeA3kFF3cMSEYHEmMt4eh9/+QNklqDMU49me
 4I7UINIOT+GtuncI1lSSLySVonL0J1Zhds7ORC3M40UVLmdNVoNmaVzvNGfNXhPZefXLJoT6K
 dnEYo9Dr+lX0Xq2BuArS+tcoK9uA+AOCwyG+fu0xI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.133
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 24/10/2019 à 20:03, Eric Blake a écrit :
> On 10/24/19 12:31 PM, Laurent Vivier wrote:
>> Le 23/10/2019 à 14:26, Frediano Ziglio a écrit :
>>> Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
>>> ---
>>>   util/qemu-timer.c | 6 +-----
>>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>>
> 
>>>
>>
>> Applied to my trivial-patches branch.
>>
>> I've updated the patch to remove the two useless casts.
>>
>> Eric, if you want to add your R-b, I can add it to the queued patch.
> 
> I don't see it queued on https://github.com/vivier/qemu/branches yet,

Sorry, forgot to push it.

> but if removing the two casts is the only difference from the original:
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

Added and pushed (branch trivial-patches), you can check.

Thanks,
Laurent

