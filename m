Received: from eggs.gnu.org ([2001:4830:134:3::10]:40709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1gCM4g-0006qL-HL
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 05:55:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1gCM4e-0006o5-Oc
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 05:55:38 -0400
Date: Tue, 16 Oct 2018 05:55:18 -0400
From: Aaron Lindsay <aclindsa@gmail.com>
Message-ID: <20181016095517.GL3671@okra.localdomain>
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-10-aclindsa@gmail.com>
	<4001b651-754e-de03-bfe3-f865bebaed48@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4001b651-754e-de03-bfe3-f865bebaed48@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 09/14] target/arm: Add array for
 supported PMU events, generate PMCEID[01]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Michael Spradling <mspradli@codeaurora.org>, qemu-devel@nongnu.org, Digant Desai <digantd@codeaurora.org>

On Oct 15 14:35, Richard Henderson wrote:
> On 10/10/18 1:37 PM, Aaron Lindsay wrote:
> > +static const pm_event pm_events[] = {
> > +};
> > +#define MAX_EVENT_ID 0x0
> 
> Is this going to be ARRAY_SIZE(pm_events) - 1 in the end?

No, this ends up being a 'sparse' array. It maps the ARM architected PMU
event numbers to their implementations. So, MAX_EVENT_ID ends up being
the maximum architected event number we implement when my later patches
add those.

-Aaron
