Received: from eggs.gnu.org ([2001:4830:134:3::10]:52696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1cdkyg-0005te-E1
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:49:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1cdkyf-0000EI-Dz
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:49:38 -0500
Date: Tue, 14 Feb 2017 16:49:21 -0500
From: Aaron Lindsay <alindsay@codeaurora.org>
Message-ID: <20170214214921.GA7958@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [RFC] Pointers for implementing AArch64 PMU
 instruction counter?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Wei Huang <wei@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, cov@codeaurora.org

I am interested in implementing an instruction counter to augment the
ongoing (mostly cycle-counter) PMU work on AArch64. The icount
infrastructure seems like the logical source for the instruction counts,
but I have a couple of implementation-related questions:

1. It looks like cpu_get_icount_raw() can serve as a good source for
directly reading the current instruction count. Does it seem reasonable
to only enable the instruction counter in the PMU when icount is enabled
and are there any caveats I've missed with using icount for this
purpose?

2. Triggering interrupts on overflow seems like it will take more work.
Does it seem reasonable to add a QEMU_CLOCK_VIRTUAL for the PMU so that
tcg_get_icount_limit() will overflow at the appropriate time for the PMU
if an instruction counter overflow interrupt is set? TBH, I'm not sure
how well this would work since the timer code mostly seems to deal with
time (as you might expect), keeping the icount values somewhat hidden
away.

Thanks for any feedback!

-Aaron

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
