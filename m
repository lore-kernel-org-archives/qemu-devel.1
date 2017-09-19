Received: from eggs.gnu.org ([2001:4830:134:3::10]:59858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1duAO8-0004Si-BG
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 00:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1duAO7-0004va-H2
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 00:44:00 -0400
Date: Tue, 19 Sep 2017 11:43:46 +0700
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20170919044346.GA32572@toto>
References: <1498830302-19274-1-git-send-email-edgar.iglesias@gmail.com>
	<1498830302-19274-3-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA-dssYnbZjuWTjBta1aK3iL3pyRKh5Qs4hFh=bPONgnTA@mail.gmail.com>
	<20170711100334.GA25504@toto>
	<CAFEAcA_XTrkAN1ATpp6DLZqGh4aL1gECzQGyubJmoGjtw_pPbA@mail.gmail.com>
	<20170711103859.GC25504@toto>
	<CAFEAcA9wn_ozBCHBZqxqARB5eD4wX1snyGfM0JW1Yk103CTytQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9wn_ozBCHBZqxqARB5eD4wX1snyGfM0JW1Yk103CTytQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/2] target-arm: Extend PAR format
 determination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-arm <qemu-arm@nongnu.org>

On Mon, Sep 18, 2017 at 04:50:23PM +0100, Peter Maydell wrote:
> On 11 July 2017 at 11:38, Edgar E. Iglesias <edgar.iglesias@xilinx.com> wrote:
> > Another way could also be to have get_phys_addr() fill in generic
> > fields in the FaultInfo struct and then have a faultinfo_to_fsr
> > mapping function to populate FSR/PAR. Do you see any issues with that?
> 
> Edgar, did you ever have a go at implementing this?

Hi Peter,

No, I haven't looked at it yet.
I'm a bit behind on everything here so I probably won't get a chance
to look at it soonish...



> I'm currently running into a similar issue with M profile,
> where at the moment we stuff the information about what
> kind of fault the MPU generates into a v7PMSA format
> FSR value and reinterpret it into M profile exception
> types and fault status register bits later. This works
> OK, but for v8M we want to start reporting kinds of fault
> (like SecureFault) that don't have equivalents in v7PMSA
> at all, and maybe it would be better to clean this up rather
> than assigning arbitrary bogus fsr values for internal use...

I see, yes that sounds like a similar issue.
If you'd like to take over this, that'd be great :-)

Cheers,
Edgar
