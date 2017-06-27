Received: from eggs.gnu.org ([2001:4830:134:3::10]:52366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dPtm2-0006q3-Ua
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:55:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dPsIe-0002pF-Of
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:21:11 -0400
Received: from mail-lf0-x22e.google.com ([2a00:1450:4010:c07::22e]:33046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dPsIe-0002fk-Gv
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:21:08 -0400
Received: by mail-lf0-x22e.google.com with SMTP id m77so19192536lfe.0
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 08:21:06 -0700 (PDT)
Date: Tue, 27 Jun 2017 17:21:04 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170627152104.GK4859@toto>
References: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA9OibH=kz7iTc95YBgHM1WGOdHRYSsudx=OfaBHHZbJrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9OibH=kz7iTc95YBgHM1WGOdHRYSsudx=OfaBHHZbJrg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v1 0/7] MMIO Exec pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, KONRAD =?iso-8859-1?Q?Fr=E9d=E9ric?= <fred.konrad@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On Fri, Jun 23, 2017 at 11:54:52AM +0100, Peter Maydell wrote:
> On 14 June 2017 at 18:45, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> >
> > Hi,
> >
> > Paolo suggested offline that we send a pull request for this series.
> > Here it is, I've run it through my testsuite + tested the LQSPI testcase
> > on Zynq.
> >
> > Cheers,
> > Edgar
> >
> > The following changes since commit 3f0602927b120a480b35dcf58cf6f95435b3ae91:
> >
> >   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170613' into staging (2017-06-13 15:49:07 +0100)
> >
> > are available in the git repository at:
> >
> >   git@github.com:edgarigl/qemu.git tags/edgar/mmio-exec.for-upstream
> >
> > for you to fetch changes up to 63ef40dd6bc6cfdae5fa67ccac1cb11e7a5161b0:
> >
> >   xilinx_spips: allow mmio execution (2017-06-14 17:31:08 +0200)
> >
> > ----------------------------------------------------------------
> > mmio-exec.for-upstream
> >
> > ----------------------------------------------------------------
> > KONRAD Frederic (7):
> >       cputlb: cleanup get_page_addr_code to use VICTIM_TLB_HIT
> >       cputlb: move get_page_addr_code
> >       cputlb: fix the way get_page_addr_code fills the tlb
> >       qdev: add MemoryRegion property
> >       introduce mmio_interface
> >       exec: allow to get a pointer for some mmio memory region
> >       xilinx_spips: allow mmio execution
> 
> Hi Edgar -- since these patches have come via your tree they should
> have your signed-off-by line, not just Fred's. They also seem to
> still have all the V1->V2->V3 revision notes in the commit logs.

OK thanks, I'll fix both things for v2.


> 
> I'd be happier with a reviewed-by: from somebody for the exec:
> patch, if possible...

We must have lost mine. Anyway, I've had another review and it looks
good to me. Of course the more eyes the better...

I'll post a v2 in a moment.

Best regards,
Edgar
