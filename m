Received: from eggs.gnu.org ([209.51.188.92]:59687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkUuR-00049Y-H7
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:14:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkUuQ-0003Ok-KU
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:14:11 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkUuQ-0003NE-DE
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:14:10 -0500
Received: by mail-oi1-x243.google.com with SMTP id y23so9055564oia.4
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:14:09 -0800 (PST)
MIME-Version: 1.0
References: <20181211151945.29137-1-aaron@os.amperecomputing.com>
In-Reply-To: <20181211151945.29137-1-aaron@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:13:58 +0000
Message-ID: <CAFEAcA8Kvx9ATDgj5mOqcJGQf_T-Sw0ut5N6w3CBs9pBA4d1_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v10 00/14] More fully implement ARM PMUv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Tue, 11 Dec 2018 at 15:20, Aaron Lindsay
<aaron@os.amperecomputing.com> wrote:
>
> The ARM PMU implementation currently contains a basic cycle counter, but
> it is often useful to gather counts of other events, filter them based
> on execution mode, and/or be notified on counter overflow. These patches
> flesh out the implementations of various PMU registers including
> PM[X]EVCNTR and PM[X]EVTYPER, add a struct definition to represent
> arbitrary counter types, implement mode filtering, send interrupts on
> counter overflow, and add instruction, cycle, and software increment
> events.
>
> Since v9 [1] I have made the following changes:
> * Added a clarifying comment about how the PMU timer's migration is
>   handled
> * Added a check against implementing PMCEID[23] if ID_DFR0.PerfMon ==
>   0xf
> * Added TRACEFILT to the ID_DFR0 field definitions
>
> [1] - https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg00805.html
>

Richard has made some comments on patch 14; since 1-13 have
all been reviewed now I'm going to apply those to target-arm.next.

thanks
-- PMM
