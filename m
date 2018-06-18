Received: from eggs.gnu.org ([2001:4830:134:3::10]:52254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fUor3-0006mh-La
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 03:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fUor2-0006wg-WE
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 03:45:37 -0400
References: <20180604152941.20374-1-peter.maydell@linaro.org>
	<20180604152941.20374-9-peter.maydell@linaro.org>
	<64ff124d-fe34-75eb-e9e6-7c419827ee3c@redhat.com>
	<CAFEAcA8ioVZuB61XWQKKRyGAJxn1gge4fjbrQuK21-drh6y81Q@mail.gmail.com>
	<CAFEAcA-keXSuHBN9HVem0yoG5bySo01DH1GtbzNcRjsFcLPU_g@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <81c9d91c-516f-78f2-6684-3edda6a40348@redhat.com>
Date: Mon, 18 Jun 2018 09:45:26 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-keXSuHBN9HVem0yoG5bySo01DH1GtbzNcRjsFcLPU_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "patches@linaro.org" <patches@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

Hi Peter,
On 06/15/2018 06:09 PM, Peter Maydell wrote:
> On 15 June 2018 at 17:07, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 15 June 2018 at 08:31, Auger Eric <eric.auger@redhat.com> wrote:
>>> Hi Peter,
>>>
>>> On 06/04/2018 05:29 PM, Peter Maydell wrote:
>>>> The final part of the Memory Protection Controller we need to
>>>> implement is actually using the BLK_LUT data programmed by the
>>>> guest to determine whether to block the transaction or not.
>>>>
>>>> Since this means we now change transaction mappings when
>>>> the guest writes to BLK_LUT, we must also call the IOMMU
>>>> notifiers at that point.
>>>>
>>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>
>>>> +        if (newlut & (1 << i)) {
>>> Add a comment saying the block is configured as non-secure?
> 
> ...actually, how about instead having a new variable
>    bool block_is_ns = newlut & (1 << i);
> 
> and then here and in the later if() having "if (block_is_ns)" ?
> I think that clarifies without needing a comment.
yes, looks good to me

Thanks

Eric
> 
> thanks
> -- PMM
> 
