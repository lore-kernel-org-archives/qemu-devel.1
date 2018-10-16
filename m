Received: from eggs.gnu.org ([2001:4830:134:3::10]:54213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCO2j-00009O-H1
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCO2h-0005c5-9e
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:01:45 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCO2f-0005Zr-A9
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:01:43 -0400
Received: by mail-ot1-x341.google.com with SMTP id l58so22217266otd.6
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 05:01:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181010203735.27918-1-aclindsa@gmail.com>
References: <20181010203735.27918-1-aclindsa@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 13:01:18 +0100
Message-ID: <CAFEAcA9cACQa7A8VUdfuSk-FcmFeHu+4x5m7HDE1A-+LYcwvXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 00/14] More fully implement ARM PMUv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aclindsa@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 10 October 2018 at 21:37, Aaron Lindsay <aclindsa@gmail.com> wrote:
> The ARM PMU implementation currently contains a basic cycle counter, but
> it is often useful to gather counts of other events, filter them based
> on execution mode, and/or be notified on counter overflow. These patches
> flesh out the implementations of various PMU registers including
> PM[X]EVCNTR and PM[X]EVTYPER, add a struct definition to represent
> arbitrary counter types, implement mode filtering, send interrupts on
> counter overflow, and add instruction, cycle, and software increment
> events.
>
> Since v5 [1] I have:
> * Taken a first pass at addressing migration
> * Restructured the list of supported events, and ensured they're all
>   initialized
> * Fixed aliasing for PMOVSSET
> * Added ARM_CP_IO for PMINTENCLR and PMINTENCLR_EL1
> * Addressed a few non-code issues (comment style, patch staging,
>   spelling, etc.)
>
> [1] - https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg06830.html
>
> Aaron Lindsay (14):
>   target/arm: Mark PMINTENCLR and PMINTENCLR_EL1 accesses as possibly
>     doing IO
>   target/arm: Mask PMOVSR writes based on supported counters

Hi; Richard has reviewed most of this series and suggested some
changes (thanks!); I'll just take these first two patches into
target-arm.next, since they're simple fixes that have been reviewed.

thanks
-- PMM
