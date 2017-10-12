Received: from eggs.gnu.org ([2001:4830:134:3::10]:42285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1e2ih2-0002T4-AN
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 14:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1e2ih0-0004ti-Sl
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 14:58:52 -0400
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMTqZA+t77XV3s2aicsbHHbF8h96w=dmWO9VHJkE0Uw8w@mail.gmail.com>
References: <cover.1505929556.git.alistair.francis@xilinx.com>
	<20171008222029.GA29979@toto>
	<CAKmqyKMEbQ3JbqMxeeOTBV92ixRVDfw1wFi57xNKGyF82DSC_Q@mail.gmail.com>
	<20171010144834.GC5553@toto>
	<CAKmqyKMTqZA+t77XV3s2aicsbHHbF8h96w=dmWO9VHJkE0Uw8w@mail.gmail.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 12 Oct 2017 20:58:43 +0200
Message-ID: <CAJy5ezogexkDJzFp-YyvHqFPhJWrKhEZstwaBsN4njTB9qC=mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/8] Add the ZynqMP PMU and IPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>

On Oct 10, 2017 7:59 PM, "Alistair Francis" <alistair.francis@xilinx.com>
wrote:

On Tue, Oct 10, 2017 at 7:48 AM, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
> On Mon, Oct 09, 2017 at 05:12:39PM -0700, Alistair Francis wrote:
>> On Sun, Oct 8, 2017 at 3:20 PM, Edgar E. Iglesias
>> <edgar.iglesias@xilinx.com> wrote:
>> > On Wed, Sep 20, 2017 at 03:01:31PM -0700, Alistair Francis wrote:
>> >>
>> >> This series adds the ZynqMP Power Management Unit (PMU) machine with
basic
>> >> functionality.
>> >>
>> >> The machine only has the
>> >>  - CPU
>> >>  - Memory
>> >>  - Interrupt controller
>> >>  - IPI device
>> >>
>> >> connected, but that is enough to run some of the ROM and firmware
>> >> code on the machine
>> >>
>> >> The series also adds the IPI device and connects it to the ZynqMP ARM
>> >> side and the ZynqMP PMU. These IPI devices don't connect between the
ARM
>> >> and MicroBlaze instances though.
>> >>
>> >> v3:
>> >>  - Add the interrupt controller
>> >>  - Replace some of the error_fatals with errp
>> >>  - Fix the PMU CPU name
>> >
>> > Hi Alistair,
>> >
>> >
>> > Sorry for the super long delay...
>> >
>> > I think this mostly looks good but I was wondering if we really need
>> > to have a board specific (zcu102) PMU?
>>
>> It doesn't have to be board specific. What I wanted though was an SoC
>> and a machine so that maybe one day we could add the PMU SoC to the
>> ARM ZCU102 machine. After that it was hard to think of a name to
>> differentiate the SoC and the machine. Do you have a recommendation on
>> names?
>
>
> Hi Alistair,
>
> Yes, I agree with your approach but I got a little confused by the names.
>
> I think all the stuff that is inside the PMU subsystem architecture-wise
> should have generic PMU names (no ZCU102). I.e the ROM, the RAM, the
IOModule,
> interrupt controller etc.

Ok I can rename them to the ZynqMP PMU (the machine/board) and the
ZynqMP PMU SoC. Does that work?

>
> The IPI block can be outside of the PMU module and be instantiated by the
> board or perhaps better if we could reuse some of the ZynqMP modules
> instantiated by the ZCU102 machine to get a CPU-less PS for the PMU
> to interact with. Or something along those lines.
> How does that sound?>

I'm a little unclear what you mean here.

Thanks,
Alistair

> Best regards,
> Edgar
>


Hi Alistair,

To clarify, if you create a pmu object, try to only put stuff in that
object that belong to the pmu subsystem. The IPI block for example doesn't,
it belongs outside of the pmu object allthough you will want to instate an
ipi instance in the pmu machine.

Hope that helps
Edgar

Sent from my phone
