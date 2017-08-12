Received: from eggs.gnu.org ([2001:4830:134:3::10]:33358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1dgUpB-0001UM-QS
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 07:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1dgUpA-0004KT-Od
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 07:43:25 -0400
Date: Sat, 12 Aug 2017 13:42:43 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20170812114243.GZ12347@toto>
References: <cover.1502488636.git.alistair.francis@xilinx.com>
	<CAFEAcA_GsfrueJQYbL6dzNBnLwMWHd3fv24CMRczuf_TxYo6NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_GsfrueJQYbL6dzNBnLwMWHd3fv24CMRczuf_TxYo6NQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1 0/3] Fixup exclusive store logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>, "Edgar E.
	Iglesias" <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>

On Sat, Aug 12, 2017 at 11:24:30AM +0100, Peter Maydell wrote:
> On 11 August 2017 at 23:17, Alistair Francis
> <alistair.francis@xilinx.com> wrote:
> > I found some issues with the way exclusive store was working. This patch
> > series seems to fix the test cases that were failing for me.
> >
> > The first patch is just a simple adjustment.
> >
> > The third patch fixes the main bug I was seeing.
> >
> > The second patch is left over from the RFC that seems like it is still a
> > good idea.
> >
> > Changes from RFC:
> >  - Rewrite the third patch to correctly fix the issue.
> >
> > Alistair Francis (3):
> >   target/arm: Update the memops for exclusive load
> >   tcg/tcg-op: Expose the tcg_gen_ext_i* functions
> >   target/arm: Correct exclusive store cmpxchg memop mask
> >
> >  target/arm/translate-a64.c | 4 ++--
> >  tcg/tcg-op.c               | 4 ++--
> >  tcg/tcg-op.h               | 2 ++
> >  3 files changed, 6 insertions(+), 4 deletions(-)
> 
> Is this series (or at least patches 1 and 3) worth putting
> into 2.10 ?


I would vote for including it...

Cheers,
Edgar
