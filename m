Received: from eggs.gnu.org ([2001:4830:134:3::10]:45224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1gCOkV-0007kE-Oj
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1gCOkP-0001qB-AO
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:46:59 -0400
Date: Tue, 16 Oct 2018 08:46:49 -0400
From: Aaron Lindsay <aclindsa@gmail.com>
Message-ID: <20181016124648.GN3671@okra.localdomain>
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<CAFEAcA9cACQa7A8VUdfuSk-FcmFeHu+4x5m7HDE1A-+LYcwvXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9cACQa7A8VUdfuSk-FcmFeHu+4x5m7HDE1A-+LYcwvXA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 00/14] More fully implement ARM PMUv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Oct 16 13:01, Peter Maydell wrote:
> On 10 October 2018 at 21:37, Aaron Lindsay <aclindsa@gmail.com> wrote:
> > The ARM PMU implementation currently contains a basic cycle counter, but
> > it is often useful to gather counts of other events, filter them based
> > on execution mode, and/or be notified on counter overflow. These patches
> > flesh out the implementations of various PMU registers including
> > PM[X]EVCNTR and PM[X]EVTYPER, add a struct definition to represent
> > arbitrary counter types, implement mode filtering, send interrupts on
> > counter overflow, and add instruction, cycle, and software increment
> > events.
> >
> > Since v5 [1] I have:
> > * Taken a first pass at addressing migration
> > * Restructured the list of supported events, and ensured they're all
> >   initialized
> > * Fixed aliasing for PMOVSSET
> > * Added ARM_CP_IO for PMINTENCLR and PMINTENCLR_EL1
> > * Addressed a few non-code issues (comment style, patch staging,
> >   spelling, etc.)
> >
> > [1] - https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg06830.html
> >
> > Aaron Lindsay (14):
> >   target/arm: Mark PMINTENCLR and PMINTENCLR_EL1 accesses as possibly
> >     doing IO
> >   target/arm: Mask PMOVSR writes based on supported counters
> 
> Hi; Richard has reviewed most of this series and suggested some
> changes (thanks!); I'll just take these first two patches into
> target-arm.next, since they're simple fixes that have been reviewed.

Thanks, Peter and Richard!

Is anyone willing to take a glance at the final patch in this series,
"target/arm: Send interrupts on PMU counter overflow", before my next
iteration? I'm particularly interested in a review of the approach I
took for detecting overflow.

-Aaron
