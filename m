Received: from eggs.gnu.org ([2001:4830:134:3::10]:44559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1f6hz3-0001GO-2l
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 15:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1f6hz2-0003D2-56
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 15:34:13 -0400
Date: Thu, 12 Apr 2018 15:34:02 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Message-ID: <20180412193402.GL24561@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA8G-WD2U4+NUzWYk_gwM51-mmDNj6o9CeeAjW+USSW=uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8G-WD2U4+NUzWYk_gwM51-mmDNj6o9CeeAjW+USSW=uw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/22] More fully implement ARM PMUv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Apr 12 18:32, Peter Maydell wrote:
> On 16 March 2018 at 20:30, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> > The ARM PMU implementation currently contains a basic cycle counter, but it is
> > often useful to gather counts of other events and filter them based on
> > execution mode. These patches flesh out the implementations of various PMU
> > registers including PM[X]EVCNTR and PM[X]EVTYPER, add a struct definition to
> > represent arbitrary counter types, implement mode filtering, and add
> > instruction, cycle, and software increment events.
> 
> Hi; sorry it's taken me a while to get to this (I've been focusing
> on for-2.12 work). I've now reviewed most of the patches in this
> set. My suggestion is that you fix the stuff I've commented on
> and send out a v4, and then I can take some of the patches from
> the start of that into target-arm.next, and I'll review the tail
> end of the set then.

Thanks for the review! I'll see if I can get a v4 out late this week or
early next.

I'll make a note of this when I send it out, but one thing to look out
for in the next version is that I had to reorganize a few things to make
the interrupt-on-overflow functionality work better. I think the changes
are fairly minor and limited to the later patches, with the possible
exception of using two variables per counter (because you have to know
what the previous counter value was in addition to the current value to
know if you've overflowed since your last check).

-Aaron

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
