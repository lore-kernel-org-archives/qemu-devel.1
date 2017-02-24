Received: from eggs.gnu.org ([2001:4830:134:3::10]:57068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1chMmj-0007Bf-51
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 15:48:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1chMmd-0003fB-Ja
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 15:48:13 -0500
Date: Fri, 24 Feb 2017 21:48:05 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA9m8Yjwjn_B5aBZmWVwXXVj7-BQ1_d76ED4bg3cAWw=bw@mail.gmail.com>
Message-ID: <alpine.BSF.2.20.1702242138290.76443@zero.eik.bme.hu>
References: <cover.1487522123.git.balaton@eik.bme.hu>
	<8936f97ffdf6fe9a71a300113019bfdba0ecef23.1487522123.git.balaton@eik.bme.hu>
	<CAFEAcA9m8Yjwjn_B5aBZmWVwXXVj7-BQ1_d76ED4bg3cAWw=bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH 09/10] sm501: Add some more missing
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On Fri, 24 Feb 2017, Peter Maydell wrote:
> On 19 February 2017 at 16:35, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> Write only to allow clients to initialise these without failing
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> What's the point in write-only register values?

U-boot writes this register during setting up the device and without this 
it would abort QEMU.

> What does the real hardware do here?

This register contains bits to set up FIFO parameters and memory 
priorities which we are not emulating so these can be ignored here but 
the hardware would change parameters according the value written.

> If the registers are writes-ignored, there's no need to store
> the data written into the state struct; if the registers are
> reads-as-written then implement them that way.

I'm not sure what you get on real hardware but it's documented to be R/W 
(except reserved bits that are masked which are always 0). Why is it not 
implemented as read-as-written or what do you mean by that?
