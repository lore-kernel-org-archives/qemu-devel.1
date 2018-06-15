Received: from eggs.gnu.org ([2001:4830:134:3::10]:35806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTrIC-0006W2-6H
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTrIB-0000HH-5N
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:09:40 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:44487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTrIB-0000H4-0E
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:09:39 -0400
Received: by mail-oi0-x243.google.com with SMTP id c128-v6so9244070oig.11
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 09:09:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8ioVZuB61XWQKKRyGAJxn1gge4fjbrQuK21-drh6y81Q@mail.gmail.com>
References: <20180604152941.20374-1-peter.maydell@linaro.org>
	<20180604152941.20374-9-peter.maydell@linaro.org>
	<64ff124d-fe34-75eb-e9e6-7c419827ee3c@redhat.com>
	<CAFEAcA8ioVZuB61XWQKKRyGAJxn1gge4fjbrQuK21-drh6y81Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 17:09:18 +0100
Message-ID: <CAFEAcA-keXSuHBN9HVem0yoG5bySo01DH1GtbzNcRjsFcLPU_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 08/13] hw/misc/tz_mpc.c: Honour the
 BLK_LUT settings in translate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On 15 June 2018 at 17:07, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 15 June 2018 at 08:31, Auger Eric <eric.auger@redhat.com> wrote:
>> Hi Peter,
>>
>> On 06/04/2018 05:29 PM, Peter Maydell wrote:
>>> The final part of the Memory Protection Controller we need to
>>> implement is actually using the BLK_LUT data programmed by the
>>> guest to determine whether to block the transaction or not.
>>>
>>> Since this means we now change transaction mappings when
>>> the guest writes to BLK_LUT, we must also call the IOMMU
>>> notifiers at that point.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
>>> +        if (newlut & (1 << i)) {
>> Add a comment saying the block is configured as non-secure?

...actually, how about instead having a new variable
   bool block_is_ns = newlut & (1 << i);

and then here and in the later if() having "if (block_is_ns)" ?
I think that clarifies without needing a comment.

thanks
-- PMM
