Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C25DC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:48:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6068F214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6068F214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izdmI-0006I0-HO
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 04:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1izdka-0004qf-LM
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:47:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1izdkR-0005QO-Qz
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:47:03 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:46301)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1izdkM-00055n-6K; Thu, 06 Feb 2020 04:46:54 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N4yJ8-1jiV6j3gkm-010tiB; Thu, 06 Feb 2020 10:46:50 +0100
Subject: Re: [EXTERNAL] Re: [PATCH] MAINTAINERS: update Leif Lindholm's address
To: Leif Lindholm <leif@nuviainc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200116174226.4780-1-leif@nuviainc.com>
 <a2fc8a4f-0b56-7868-0e52-51c2abfd97f7@redhat.com>
 <20200117131801.GI15141@bivouac.eciton.net>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4ba5872b-f5b2-4c9e-e326-bba6ebb5e58d@vivier.eu>
Date: Thu, 6 Feb 2020 10:46:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200117131801.GI15141@bivouac.eciton.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:h1eBbslxj2PhRSy86s1GVveEKLHK36Vhg8hp3pPfWMyNh382zMJ
 /KxL6QEOJBx5ClWmBWeygU22QRcGkmetioQq7fAY09ygdIjc1vBIbOn3Vh+6iiwm7rF5fwT
 6aVdSROen7OjrV+++ZHXQWnYiRALaGgMf4HCYbFmftmVJViBCXHCZloyP+RU3q4eBSP67/u
 7mE3376IW/sqRkUqGhq4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q1Vlo0iHVXw=:KOYeNj4vEueQSX39OBLFgk
 0nSmVJNSEPJ3gi65Orp4iOQQJA5HKu9PS8bsT53uxvy9uTfJCWRuMfnfGpkShjbssE16BkVWh
 5bVmsFMGAQVc12UCGnX9tFmuhKVJjflgkVui0OV35BFMnGWZyveQe/n/Mz5N9CMWTxrG1HnQ6
 PulUBLdFQBCUIxt/kiCMtqKleUnf3QZroswOm2YFZcIv1x1oju2CFw2V8wn7RP/Lv46NUtC6i
 lguXdExa7JwEtIyUUog/v2P60El13xO0Y29Un6tYhejo+p2/JA3Pz4jqCzkUq4/+lmdH0QtAd
 UnnX0qOCnxOyyLsx8ZqfwLb92pjwcc7wqPJ6kuSN7yLl4q4YV2ZdOyTme21kyNr9/W6S/Itls
 f9sLfbpCdpd1TFfJva/+2NYs5RcBt5XpDtIlCD7bJMZ+2pkSMAe1jO/14uzZEakGXiCnmzj0z
 XmyKVCkg0zGX69TA8iFx2p2zb1oj2hf32S6W3BaS0EbD0aKx8rHBe08FHUFI62CxlrQpWoOMA
 mJiaAUZtm1HRZ60BlWovyXWkkaGRcMlMcSgJuXqfIAUB2Ua9HeejFu/cCAl9W4C21QLBAqgrh
 MBiWWJa14gpuABL97k73aL8K9yzv3lL5M4MiyyTGVQbAQihHtiPFMqW5+H5lbWPNzr7bCRbZp
 1gtjK9oHdSM8cthUICYVg8jmaSW86AnZlBVlF2HsGctdn/wRZ3xr4ET/wq8N+SE6KxMCuCpzr
 igjinDu9oraUTM+5JKaiuLz+anPnOzTO3/8yqx7n3THepEojARoJOW9z/ACq8cJ++zNLavwYl
 JJBZcDPSg3dlAtvk2cn7H8BNSnO5mAuoWPpDzCyXnTEOVV7xzPqmoPdXs2sz+fLL36ku5F0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org,
 Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 17/01/2020 à 14:18, Leif Lindholm a écrit :
> On Thu, Jan 16, 2020 at 19:25:52 +0100, Philippe Mathieu-Daudé wrote:
>> On 1/16/20 6:42 PM, Leif Lindholm wrote:
>>> Update address to reflect new employer.
>>>
>>> Signed-off-by: Leif Lindholm <leif@nuviainc.com>
>>> ---
>>>   MAINTAINERS | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 483edfbc0b..3c8653f26f 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -735,7 +735,7 @@ F: include/hw/ssi/imx_spi.h
>>>   SBSA-REF
>>>   M: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
>>>   M: Peter Maydell <peter.maydell@linaro.org>
>>> -R: Leif Lindholm <leif.lindholm@linaro.org>
>>> +R: Leif Lindholm <leif@nuviainc.com>
>>>   L: qemu-arm@nongnu.org
>>>   S: Maintained
>>>   F: hw/arm/sbsa-ref.c
>>>
>>
>> You might want to add yourself a .mailmap entry too:
>>
>> -- >8 --
>> diff --git a/.mailmap b/.mailmap
>> index 3816e4effe..a521c17b44 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -44,6 +44,7 @@ Aleksandar Markovic <amarkovic@wavecomp.com>
>> <aleksandar.markovic@imgtec.com>
>>  Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com> <arikalo@wavecomp.com>
>>  Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori
>> <aliguori@us.ibm.com>
>>  James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
>> +Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
>>  Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
>>  Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
>>  Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
>> ---
> 
> If that use of .mailmap is common for QEMU, that sounds like a good
> idea. And the comment for that section of the file indeed suggests so,
> so thanks!
> 
>>
>> If you ack this snippet maybe a maintainer is willing to amend it to your
>> patch :)
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Acked-by: Leif Lindholm <leif@nuviainc.com>
> (The other guy agrees.)
> 

Applied to my trivial-patches branch, including .mailmap changes.

Thanks,
Laurent

