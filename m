Received: from eggs.gnu.org ([2001:4830:134:3::10]:42785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dgWqB-0005SG-Fs
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 09:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dgWqA-0002n3-CL
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 09:52:35 -0400
MIME-Version: 1.0
In-Reply-To: <20170812114243.GZ12347@toto>
References: <cover.1502488636.git.alistair.francis@xilinx.com>
	<CAFEAcA_GsfrueJQYbL6dzNBnLwMWHd3fv24CMRczuf_TxYo6NQ@mail.gmail.com>
	<20170812114243.GZ12347@toto>
From: Alistair Francis <alistair23@gmail.com>
Date: Sat, 12 Aug 2017 06:52:02 -0700
Message-ID: <CAKmqyKM3BUg9SKTiHaSRSn3iThJtwBagi64Tn0FvjT74QXzPwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 0/3] Fixup exclusive store logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>

On Sat, Aug 12, 2017 at 4:42 AM, Edgar E. Iglesias
<edgar.iglesias@xilinx.com> wrote:
> On Sat, Aug 12, 2017 at 11:24:30AM +0100, Peter Maydell wrote:
>> On 11 August 2017 at 23:17, Alistair Francis
>> <alistair.francis@xilinx.com> wrote:
>> > I found some issues with the way exclusive store was working. This patch
>> > series seems to fix the test cases that were failing for me.
>> >
>> > The first patch is just a simple adjustment.
>> >
>> > The third patch fixes the main bug I was seeing.
>> >
>> > The second patch is left over from the RFC that seems like it is still a
>> > good idea.
>> >
>> > Changes from RFC:
>> >  - Rewrite the third patch to correctly fix the issue.
>> >
>> > Alistair Francis (3):
>> >   target/arm: Update the memops for exclusive load
>> >   tcg/tcg-op: Expose the tcg_gen_ext_i* functions
>> >   target/arm: Correct exclusive store cmpxchg memop mask
>> >
>> >  target/arm/translate-a64.c | 4 ++--
>> >  tcg/tcg-op.c               | 4 ++--
>> >  tcg/tcg-op.h               | 2 ++
>> >  3 files changed, 6 insertions(+), 4 deletions(-)
>>
>> Is this series (or at least patches 1 and 3) worth putting
>> into 2.10 ?
>
>
> I would vote for including it...

The only reason not to is because this bug has been in QEMU for a
while, so it obviously isn't hit very often. In saying that it is a
pretty big issue (32-bit pair stores are completely broken) which
might become an issue during the 2.10 support window and I don't see
many complications from including the series.

I agree with Edgar, probably worth including.

Thanks,
Alistair

>
> Cheers,
> Edgar
