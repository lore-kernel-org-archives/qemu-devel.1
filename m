Received: from eggs.gnu.org ([2001:4830:134:3::10]:40507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cjXEy-0002Fj-N2
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 15:22:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cjXEv-0007cD-5q
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 15:22:20 -0500
Date: Thu, 2 Mar 2017 21:22:15 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA_kzNEfkg56CFE=x-GqQTV-fpXjGXxvwoPoZS1HNVTnww@mail.gmail.com>
Message-ID: <alpine.BSF.2.20.1703022121300.83701@zero.eik.bme.hu>
References: <cover.1488068248.git.balaton@eik.bme.hu>
	<db1b69270ca4d2335e6fb2455ee56552373757fc.1488068248.git.balaton@eik.bme.hu>
	<CAFEAcA_kzNEfkg56CFE=x-GqQTV-fpXjGXxvwoPoZS1HNVTnww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2 12/14] sm501: Implement reading 2D
 engine registers
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

On Thu, 2 Mar 2017, Peter Maydell wrote:
> On 25 February 2017 at 21:47, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> Clients normally only write to these registers, nothing is known to
>> ever read them but they are documented as read/write so allow clients
>> to also read the values.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/display/sm501.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 57 insertions(+)
>
> Oh, the read code is in a separate patch? Please put all the handling
> for a particular register in the same patch. If you think the
> resulting patch is too long you can split it into several patches
> each of which handles a group of registers if you like (but it
> probably isn't necessary).

So is it OK to squash this in the previous patch adding write and make the 
two a single patch?

>
> thanks
> -- PMM
>
>
