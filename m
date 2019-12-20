Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96294C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:55:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67CD82067C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CD82067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiHoB-0000OT-JS
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 07:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iiHnY-0007jd-Vg
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:54:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iiHnX-0007wK-JN
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:54:28 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:51899)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iiHnU-0007cC-Kl; Fri, 20 Dec 2019 07:54:24 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N17cq-1hgsYm0cgc-012cP8; Fri, 20 Dec 2019 13:54:06 +0100
Subject: Re: [PATCH 00/10] Fixes for DP8393X SONIC device emulation
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Finn Thain <fthain@telegraphics.com.au>
References: <cover.1576286757.git.fthain@telegraphics.com.au>
 <CAL1e-=jN-8zEnCvxq4actoBcrjBviqfxBjGCTT7mBxmSPhiF3w@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <067319c3-b426-bb83-56da-6612180d35c5@vivier.eu>
Date: Fri, 20 Dec 2019 13:54:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jN-8zEnCvxq4actoBcrjBviqfxBjGCTT7mBxmSPhiF3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3jfa/m6aXSLcDqvy1abycLC7i52MkYF8xOgUfRhjaz2K3KNpj1E
 L6JW35ryDbV3+9o4XC/LsPeDEDf9UvVsXcbzJTnmM6SAL6nBP9+emw4PuYZzzZz0+jmXNO6
 6mTJoGX9Llst6ObVrxfRTNJuHB6O5MCUamV2A1nU6yoEYF6BvP2KVhE/iREIcmNPzTzm72e
 dLn4ZtJVOVtjAYqXgiRnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q4Pn7WGEE6M=:HAUt5jTVXk/c5koSP9C37Z
 Q7IlOsriQYXv687aIXROwDPTpCxLTp5/4nWlBGm5Uv7blVxu/wdzVkXAu42Q5yFrrjc6fLghB
 8vMsbCHM0x0ALsSS0GrXtg2EKJY4mN0+9kY30EIwR+68O9sa6PDxnUwAQaqYLj4hFarSH5Tzc
 +1E97hPa3vY920LY84A+l2xp9Qpv1HRf/SkE5uAE9UCe7B4jwSUdpuRamdzqPngLopfHnYdk9
 syZKHmPnJ4fe++qnmJovNVfQ4WCGj23fF7fTAMEGyyrCidy8sds8wGSwxbCBscCnLrqLU3xmn
 HTa3ODAmHiiyx0ZejnIgntLSitO3YX4Qw6zsy7xQrldkSdMt/Lk6PA6ccp4NivFIdDdyHtQw5
 eCtvC4HimW6jx/RIeIWOFdJVTzrJU48HyT69yWE/bCBkvH635Kq1qL6h77mUFCw5x9gZIEDEA
 p/tzPbOteUIAmBClOZduR6zKirpidlx78eEvMPaCLdf2+4VQwSqCm2ftuUA7P7OJUtSORMExs
 ZUOXtV1dQ8yjQjTz2Djne/fxdjzWoUFiyln1E8EDB6m+BiDfUCL0BikJXhk+rH3fTf7e+BE7f
 7gSjFO7qMDhDiuXxwDrsdRVeuUcZVDdHmdPJ2FmeqZ5KHg3962dNbsEn3HanW6aGPgnHelR30
 gmZPqP55QfXKOM6UgcI7S2SYhS1KP3wJdZf66NvMHTAHDaun/uYrZBXVuQ+dq/AKnhbYk6L9a
 6SFHHuyRjud2IyOw1JgNjG/XEqSp87hrhJSMtye+QbdcEFiAZwckpR9IlRoLglwP62pAZCrCO
 jWJc+V8Wk38VtOfy++bKonYQ+0c82lIhYx9C0XbopSFhBk7kdhY+4PdZPxu1xJGjEDzM4fwb/
 PrH8p0k00q4cOwVJYS/bSztLNG63G2UozECpYuBJM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.75
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
Cc: Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Herve Poussineau <hpoussin@reactos.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 20/12/2019 à 12:38, Aleksandar Markovic a écrit :
> On Sat, Dec 14, 2019 at 2:29 AM Finn Thain <fthain@telegraphics.com.au> wrote:
>>
>> Hi All,
>>
>> There is a bug in the DP8393X emulation that can stop packet reception.
>>
>> Whilst debugging that issue I found that the receiver algorithm differs
>> from the one described in the National Semiconductor datasheet.
>>
> 
> Finn, could you please provide the link to the exact datasheet that
> you used for reference, so that we are on the same page while looking
> at your code?

According to his comments ,"National Semiconductor DP83932C" and
sections seem to be the same, I think the datasheet is:

https://www.eit.lth.se/fileadmin/eit/courses/datablad/Periphery/Communication/DP83932C.pdf

Thanks,
Laurent

