Received: from eggs.gnu.org ([2001:4830:134:3::10]:43955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1gCREg-00032l-2M
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1gCREf-0004ET-7q
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:26:17 -0400
Date: Tue, 16 Oct 2018 11:26:09 -0400
From: Aaron Lindsay <aclindsa@gmail.com>
Message-ID: <20181016152608.GQ3671@okra.localdomain>
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-7-aclindsa@gmail.com>
	<b58c1b9d-f3d7-198e-e31e-d276effc42a9@linaro.org>
	<20181016122542.GM3671@okra.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016122542.GM3671@okra.localdomain>
Subject: Re: [Qemu-devel] [PATCH v6 06/14] target/arm: Filter cycle counter
 based on PMCCFILTR_EL0
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

On Oct 16 08:25, Aaron Lindsay wrote:
> On Oct 15 13:51, Richard Henderson wrote:
> > On 10/10/18 1:37 PM, Aaron Lindsay wrote:
> > > --- a/target/arm/machine.c
> > > +++ b/target/arm/machine.c
> > > @@ -584,7 +584,7 @@ static int cpu_pre_save(void *opaque)
> > >  {
> > >      ARMCPU *cpu = opaque;
> > >  
> > > -    pmccntr_op_start(&cpu->env);
> > > +    pmu_op_start(&cpu->env);
> > 
> > Does it make sense to move this patch earlier so that these hooks are modified
> > once?  No big deal if not.

I took another look at this, and I think it makes sense to move the
pmccntr_op -> pmu_op changes into "target/arm: Reorganize PMCCNTR
accesses", independent of the filtering changes.

-Aaron
