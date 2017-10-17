Received: from eggs.gnu.org ([2001:4830:134:3::10]:44584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1e4TLV-0003xR-Mp
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1e4TLU-0000yU-Ss
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:59:53 -0400
Date: Tue, 17 Oct 2017 10:59:40 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Message-ID: <20171017145940.GD3676@codeaurora.org>
References: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
	<1506737310-21880-3-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA_zwAu4Zt0-2Qy9euBzYQgD19EnnoWwa+ZNzidWwkmEcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_zwAu4Zt0-2Qy9euBzYQgD19EnnoWwa+ZNzidWwkmEcA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 02/13] target/arm: Check PMCNTEN for
 whether PMCCNTR is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Oct 17 13:49, Peter Maydell wrote:
> On 30 September 2017 at 03:08, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> > Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> > ---
> >  target/arm/helper.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index 8be78ea..40c9273 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -964,7 +964,7 @@ static inline bool arm_ccnt_enabled(CPUARMState *env)
> >  {
> >      /* This does not support checking PMCCFILTR_EL0 register */
> >
> > -    if (!(env->cp15.c9_pmcr & PMCRE)) {
> > +    if (!(env->cp15.c9_pmcr & PMCRE) || !(env->cp15.c9_pmcnten & (1 << 31))) {
> >          return false;
> >      }
> >
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> I keep replying to your v1 patchset by mistake -- can you use
> the git format-patch options to put make the subject prefix
> be "[PATCH v3]" for the next round in all the patchmails to
> help keep the versions distinct, please?

Yes, and I apologize for the nuisance. Also, thanks - I didn't know
about the `-v, --reroll-count` option and must have gotten distracted
between updating the subject to be 'v2' for the cover letter and the patches.

-Aaron

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
