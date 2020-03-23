Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70B4C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 14:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA7EF2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 14:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7EF2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGOW9-00071Q-Uw
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 10:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jGOVQ-0006AG-3P
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jGOVO-0005Ks-PW
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:56:44 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:37211)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jGOVJ-0005G6-2A; Mon, 23 Mar 2020 10:56:37 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M2w8Y-1jFHVE1bpc-003JGd; Mon, 23 Mar 2020 15:56:00 +0100
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200321144110.5010-1-philmd@redhat.com>
 <1c711740-6166-c730-ef67-d07511add1e6@vivier.eu>
 <262f8318-1590-1c48-f4de-a6482fdc3071@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH-for-5.0 v2 00/11] misc: Trivial static code analyzer fixes
Message-ID: <10431e44-880a-cbec-c35e-1d425064c40b@vivier.eu>
Date: Mon, 23 Mar 2020 15:55:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <262f8318-1590-1c48-f4de-a6482fdc3071@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:40GVz+W7NkMzKf2pJ241KL1TxtHoQ5690PSyBkrakagaTgBUHuz
 QTHo7AelNkaeH1lBR1sgV/90kM5n02tWQF/zhpnvhJWtmg269OfP1hVyYK+ubjg6wMKdjvu
 ihpJ558ivNf1wl9Qfei+D/8b0Jf6tyAmzh83Bp94cKgciKGDIl6oE20wdJmB/903iCxEL1k
 5guRTUeaXqAtqe+PGWe2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q4CMWtGpBYY=:wbi/4/B1kLULezcHy9u35V
 UaSHd/xsWA23K/iBEbXYY7MZbVmjTFZC1t+RCwNjrJfVs9N9CoQyStqUv6pQaNGBYxS++Gy/L
 8ZCq+7U+2riCJzVtT0yT5O871SZFq3oJh0PAQIKW934SvMTv2qS8TGKU3n5Gn2xuUzZlT95wE
 BUOU4NKE55TeuQxpzrIkSfn0TzwNgOrfvdNGXcJ06TtUcHARpFmYehdCZMKsyAZrwXMwSusiI
 26T8N7JEf+H+LKYBgxrA97V1n4F6lf+2jzFNA2jt5DOdJPZSwov7AuzeF/RaKHKJuBFqFBEWU
 APi7KttBVhnLHb+RhRLCzLK/xEq6LFB6sVPeUAJp6jo/ONMV2kcLDrYD+5TdzOhgcaSwrX5By
 P1bcjbCca2PQNPdF5BBWhUIDbE9YKChmdalKCp/1D8V0KxG3AL2tqWncjfiI9KFyfk1e+9OiM
 Ob/ImnV95ZEP2d3YWwA80hPD1v8SGgJ3CdW5FCOdbPF8is0CvW62fZywbVegw+nra3q/cc/8Y
 fxx1hbGcBH7Hu6X8402ysOgjAth1XzGwJgMxpFGRG6B/q08FAMX8iQHcCnkVFS/Dt9iStpSjp
 tpn6pbMQ2J/IYO8J4XT2kjnnnG1+zogA1uo16m9xTsIu3XnqWsgO7wx4XGPqXoGhlnozMcJv+
 R02/RPHzieBGslOoPVU1MlJNcPiWE55kzaK/qaW+icnxFinRjL7En72SqfpdDf3ybFg8n2zuk
 PWa0LBAKzgBkzKfM/pDypDVF3M/f21GYHgopie0mndRXpo4eJNnPOLG5u1/RZLUKBNOAaYXNe
 5eM0hm3Gw1Zt0P1SyfS895/3yImRjPSW2CL37QbKlFNG8x89MWJOgLcvnDcEmkntBnLf7LV
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Max Reitz <mreitz@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 23/03/2020 à 15:45, Philippe Mathieu-Daudé a écrit :
> On 3/23/20 3:32 PM, Laurent Vivier wrote:
>> Le 21/03/2020 à 15:40, Philippe Mathieu-Daudé a écrit :
>>> Fix trivial warnings reported by the Clang static code analyzer.
>>>
>>> Since v1:
>>> - Addressed Markus/Zoltan/Aleksandar review comments
>>>
>>> Philippe Mathieu-Daudé (11):
>>>    block: Avoid dead assignment
>>>    blockdev: Remove dead assignment
>>>    hw/i2c/pm_smbus: Remove dead assignment
>>>    hw/input/adb-kbd: Remove dead assignment
>>>    hw/ide/sii3112: Remove dead assignment
>>>    hw/isa/i82378: Remove dead assignment
>>>    hw/gpio/aspeed_gpio: Remove dead assignment
>>>    hw/timer/exynos4210_mct: Remove dead assignments
>>>    hw/timer/stm32f2xx_timer: Remove dead assignment
>>>    hw/timer/pxa2xx_timer: Add assertion to silent static analyzer
>>> warning
>>>    hw/scsi/esp-pci: Remove dead assignment
>>>
>>>   block.c                    | 2 +-
>>>   blockdev.c                 | 2 +-
>>>   hw/gpio/aspeed_gpio.c      | 2 +-
>>>   hw/i2c/pm_smbus.c          | 1 -
>>>   hw/ide/sii3112.c           | 5 +++--
>>>   hw/input/adb-kbd.c         | 6 +-----
>>>   hw/isa/i82378.c            | 8 ++++----
>>>   hw/scsi/esp-pci.c          | 1 -
>>>   hw/timer/exynos4210_mct.c  | 3 ---
>>>   hw/timer/pxa2xx_timer.c    | 1 +
>>>   hw/timer/stm32f2xx_timer.c | 1 -
>>>   11 files changed, 12 insertions(+), 20 deletions(-)
>>>
>>
>> I think your series covers cases already covered by:
>>
>> [PATCH v3 00/12] redundant code: Fix warnings reported by Clang static
>> code analyzer
>> https://patchew.org/QEMU/20200302130715.29440-1-kuhn.ch
> 
> Unfortunately [for me...] I don't have v3 in my INBOX... *sigh*
> This was 3 weeks ago. *sigh*.
> 
> I can see the series in the archives:
> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg00219.html
> But I can't find the outcome, was it queued in the trivial tree?
> Any idea when this will be merged in the master tree?

Some patches are already merged via trivial (1, 2 (should go by SCSI
queue) 3, 5, 6, 7, 9, 11 (by USB queue), 12).

But others needed R-b tags or new version. I didn't check which of your
patches are already covered by this series.

I'm sorry to not have checked your series earlier...

Thanks,
Laurent


