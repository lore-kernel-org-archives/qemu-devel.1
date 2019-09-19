Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CE7C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8006521928
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8006521928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAuzV-0006j4-AC
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 07:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iAuxu-00055K-KP
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iAuuj-000601-TG
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:47:58 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:41645)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iAuuj-0005zi-Ku; Thu, 19 Sep 2019 07:47:57 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mqal4-1hp2Q4196W-00mcJJ; Thu, 19 Sep 2019 13:47:44 +0200
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20190914145155.19360-1-chewi@gentoo.org>
 <457c3a3c-d1b3-9f73-e156-24add1347e07@vivier.eu>
 <20190919083708.mwqjq6qzyemqlxpq@sirius.home.kraxel.org>
 <8dad2ef4-87ed-27ca-da22-a9ef4fa87cde@vivier.eu>
 <20190919110120.l7s4hvpqmcgqofhi@sirius.home.kraxel.org>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b9537aee-21dd-df30-b74e-b923a992318b@vivier.eu>
Date: Thu, 19 Sep 2019 13:47:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919110120.l7s4hvpqmcgqofhi@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JruVSBsBHMkMYs7h0E7lLhAYUxRK+rPAafj85999Hl7p2l6MDOZ
 5hRpJJH4+LGLzTPYhtnaRSzFZLCkQKKCEGdBb7Ca5Wd5E+8bI06NJGMaATR7JzJF4JABmp+
 edXZs6diifyW2JP9lp+NYy9gxdMaVmvPS+rV7nq/CFrwqxLQp838QHOSNFRlvhACCu9Xrvy
 ebwvko/OXwhAJG/G8XOUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7AnoYb9VvJI=:HnY4FaoJ3ImtcYbfbIP3gl
 56QGso7DD+k8q5DVA8SWaNsb5bYIwhIsarjsy2PGFAsGKH4tXGGxBQ40T5iO18QPhn+y13kyR
 pD7rjgx3BiQ+6T6FY48xDnY0aAyFVpBD4Z4MoO50f/hobUlSIeSkQxsSbu/LRPjWZid2eQGWl
 9g7oNtKWx5C1bjyG7tVh3KkZzluB6/qe1THtOpmQA8D3eFJS+lKp/MRBiFdnn3cgc7344mf/Y
 ++zYgVLyg5onZKOOwmoHD8kO91oV4NHXrsQprRFJtxgW2L0YOvLINABvASa0pmZmpsNTz6d/S
 JVWRYlxY1tXDzK9kQiNY6FYfGl4gX1Ro+lkLkJg0Q9LEO1Cx6Gc7DgQsgTXG7RVuU8TDTCcDs
 SBEm5YxVIr/iPJYdhop3ad9GMAc/47a18LBYg9gn3nZiGPbE0SGCtme+aGAZBbhqUe1m2afrZ
 7ZZbkqrinzP1Z5A/6/nD/2XqKv/lzq2Y/jUZ/OU2MDJAjPOfUzb1a0PfaVedeb1G56GA2StHW
 vQnxA8FZKgQwdsCCZ7EwC7iThGgR12Ga9Gr/HOyWA9t8S2pSFv28CNKmL3CqpHXCHtiBNps/H
 AkRUAoxWoBuGCIq0cOsejqmcCAQYmXlC/WOOdh1NO/maK8s42y1yPrFiurJF8g/rLkwfBkz1z
 fN/USojjpR/pkAn0ZTqwMkpDCYLe5/AhqV+7af6jPvE9FsXueY1YuWkWxcw2obxGj5r5QB2bF
 oW9RxsNPJamZRmbk4WfW2GPqlHa9Mfa6fI1oWUTmEwut6BC5aetYQu2uDUTvK46pStXRdrDBm
 fllCrb2bd4Y73fuELAbVID9cRcPojXimZaP5HzOtJiRcVK+QUEJKSVL5N0IM98mEttxQjgiW2
 vFWiAiTlI0CZaQYGbEnBHalBTJ8NmP+luIlNs68fY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] configure: Add xkbcommon
 configure options
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
Cc: qemu-trivial@nongnu.org, James Le Cuirot <chewi@gentoo.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 19/09/2019 à 13:01, Gerd Hoffmann a écrit :
> On Thu, Sep 19, 2019 at 12:16:43PM +0200, Laurent Vivier wrote:
>> Le 19/09/2019 à 10:37, Gerd Hoffmann a écrit :
>>> On Mon, Sep 16, 2019 at 10:15:15AM +0200, Laurent Vivier wrote:
>>>> Le 14/09/2019 à 16:51, James Le Cuirot a écrit :
>>>>> This dependency is currently "automagic", which is bad for distributions.
>>>>>
>>>>> Signed-off-by: James Le Cuirot <chewi@gentoo.org>
>>>>> ---
>>>>>  configure | 5 +++++
>>>>>  1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/configure b/configure
>>>>> index 30aad233d1..30544f52e6 100755
>>>>> --- a/configure
>>>>> +++ b/configure
>>>>> @@ -1521,6 +1521,10 @@ for opt do
>>>>>    ;;
>>>>>    --disable-libpmem) libpmem=no
>>>>>    ;;
>>>>> +  --enable-xkbcommon) xkbcommon=yes
>>>>> +  ;;
>>>>> +  --disable-xkbcommon) xkbcommon=no
>>>>> +  ;;
>>>>>    *)
>>>>>        echo "ERROR: unknown option $opt"
>>>>>        echo "Try '$0 --help' for more information"
>>>>> @@ -1804,6 +1808,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>>>>>    capstone        capstone disassembler support
>>>>>    debug-mutex     mutex debugging support
>>>>>    libpmem         libpmem support
>>>>> +  xkbcommon       xkbcommon support
>>>>>  
>>>>>  NOTE: The object files are built at the place where configure is launched
>>>>>  EOF
>>>>>
>>>>
>>>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>>>>
>>>> cc: Gerd Hoffmann <kraxel@redhat.com>
>>>
>>> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>>>
>>
>> Gerd,
>>
>> do you take this through your ui branch or should I take through the
>> trivial patches branch?
> 
> Trivial branch is fine (have not picked this up b/c I saw qemu-trivial
> on cc).

Applied to my trivial-patches branch.

Thanks,
Laurent

