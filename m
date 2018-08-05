Received: from eggs.gnu.org ([2001:4830:134:3::10]:40684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fmL7V-0001Od-Qf
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 11:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fmL7Q-00085d-U2
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 11:39:01 -0400
Date: Sun, 5 Aug 2018 17:38:47 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA-=c7O+h3c-gQ=31q0oyLzJhDNmEBzv4X2Yp_TBfYhC-w@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.1808051732420.22072@zero.eik.bme.hu>
References: <20180801035357.7804-1-david@gibson.dropbear.id.au>
	<CAFEAcA-FitsqU3kQJTFGSFgOh6Zsf2Zy2fO3OTnL5c+Tzi5pog@mail.gmail.com>
	<alpine.BSF.2.21.1808011300070.7488@zero.eik.bme.hu>
	<CAFEAcA-=c7O+h3c-gQ=31q0oyLzJhDNmEBzv4X2Yp_TBfYhC-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 0/2] ppc-for-3.0 queue 20180801
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>

On Wed, 1 Aug 2018, Peter Maydell wrote:
> On 1 August 2018 at 12:24, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> On Wed, 1 Aug 2018, Peter Maydell wrote:
>>> So, we've just put out rc3, which in an ideal world is our
>>> final release candidate for 3.0. Are these bugs regressions from
>>> 2.12 ?
>>
>>
>> I don't know about the macio one but the sam460ex PCI interrupts were broken
>> in 2.12 too. However it's a fix for a device only used in sam460ex which is
>> now fixed by this patch so including it is not high risk for breaking
>> anything else than sam460ex which is known to be not finished yet so I would
>> not worry too much. But which is better? Releasing 3.0 with a known bug or
>> including this fix without an rc4?
>
> The problem with continuing to delay 3.0 while we have known bugs
> is that bugs generally come in at an even rate, so we *always*
> have known bugs, and so "we found another bug, let's delay 3.0
> again to put in a fix for it" is a recipe for never doing a release.
> That's why we gradually wind up the bar for "should this go in",
> from "any bug" to "regressions" to "really really serious showstopper
> regressions".
>
> We never do a final release without a last rc (it is too risky),
> so that is not an option.

Now that it looks like we'll have an rc4 due to other fixes can these be 
included as well despite not being regressions? These may not have been 
serious enough to fix when we wouldn't have rc4 otherwise but holding on 
to broken implementation just because they were also broken in the 
previous release does not make sense if we'll have another rc anyway.

Regards,
BALATON Zoltan
