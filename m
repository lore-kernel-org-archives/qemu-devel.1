Received: from eggs.gnu.org ([2001:4830:134:3::10]:36247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fkpF6-00037l-RZ
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fkpF2-0004wL-On
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:24:36 -0400
Date: Wed, 1 Aug 2018 13:24:23 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA-FitsqU3kQJTFGSFgOh6Zsf2Zy2fO3OTnL5c+Tzi5pog@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.1808011300070.7488@zero.eik.bme.hu>
References: <20180801035357.7804-1-david@gibson.dropbear.id.au>
	<CAFEAcA-FitsqU3kQJTFGSFgOh6Zsf2Zy2fO3OTnL5c+Tzi5pog@mail.gmail.com>
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
> On 1 August 2018 at 04:53, David Gibson <david@gibson.dropbear.id.au> wrote:
>> The following changes since commit f7502360397d291be04bc040e9f96c92ff2d8030:
>>
>>   Update version for v3.0.0-rc3 release (2018-07-31 19:30:17 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/dgibson/qemu.git tags/ppc-for-3.0-20180801
>>
>> for you to fetch changes up to 6484ab3dffadc79020a71376010f517d60b81b83:
>>
>>   sam460ex: Fix PCI interrupts with multiple devices (2018-08-01 11:01:38 +1000)
>>
>> ----------------------------------------------------------------
>> ppc patch queue for 2018-08-01
>>
>> Here are a final couple of fixes for the 3.0 release.
>
> So, we've just put out rc3, which in an ideal world is our
> final release candidate for 3.0. Are these bugs regressions from
> 2.12 ?

I don't know about the macio one but the sam460ex PCI interrupts were 
broken in 2.12 too. However it's a fix for a device only used in sam460ex 
which is now fixed by this patch so including it is not high risk for 
breaking anything else than sam460ex which is known to be not finished yet 
so I would not worry too much. But which is better? Releasing 3.0 with a 
known bug or including this fix without an rc4? In case of machines that 
are in QEMU for a long time, widely used and other infrastructure is 
dependent upon it's good to have strict rules to avoid regressions but for 
the newly added sam460ex which is really only expected to be first usable 
in 3.0 and not many people depend on it yet delaying a fix for a known 
problem until December just to follow a rule looks counterproductive. So I 
would say it's OK to include this fix but skip rc4 and if it makes 
sam460ex worse than it is now then at worst we would have a broken 3.0 
that will need to be fixed in next release. But we have a good chance to 
release a better 3.0 as opposed to not include the fix and release a known 
broken 3.0 that surely will have to be fixed in next release. (This fix 
may improve sound and network support so it would be good to have it in 
3.0. A lot of potential users can only use release and rc versions because 
they can't build QEMU from source so they will only get this fix in next 
release otherwise.)

But if it's not possible to have this in 3.0 without rc4 and there won't 
be other changes needing an rc4 we can live with this not getting in 3.0 
but due to the above it might delay this for the general public by a few 
months.

Regards,
BALATON Zoltan
