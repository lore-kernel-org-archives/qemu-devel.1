Received: from eggs.gnu.org ([2001:4830:134:3::10]:57029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1dHsEU-0007zR-9Z
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1dHsER-0007xD-6a
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:39:46 -0400
In-Reply-To: <20170605005534.GX13397@umbus.fritz.box>
References: <201706021132.v52BWx1t027533@linux03a.ddci.com>
	<20170605005534.GX13397@umbus.fritz.box>
MIME-Version: 1.0
From: alarson@ddci.com
Message-ID: <OF8290D871.96947387-ON86258136.004AB4CA-86258136.004B0887@ddci.com>
Date: Mon, 5 Jun 2017 08:39:37 -0500
Content-Type: text/plain; charset="US-ASCII"
Subject: Re: [Qemu-devel] [PATCH] target-ppc: Fix openpic timer read
 register offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

David Gibson <david@gibson.dropbear.id.au> wrote on 06/04/2017 07:55:34 
PM:

> From: David Gibson <david@gibson.dropbear.id.au>
> To: Aaron Larson <alarson@ddci.com>
> Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
> Date: 06/04/2017 07:55 PM
> Subject: Re: [PATCH] target-ppc: Fix openpic timer read register offset
> 
> On Fri, Jun 02, 2017 at 04:32:59AM -0700, Aaron Larson wrote:
> > 
> > openpic_tmr_read() is incorrectly computing register offset of the
> > TCCR, TBCR, TVPR, and TDR registers when accessing the open pic timer
> > registers.  ...
> 
> Applied to ppc-for-2.10.  It looks saner than the existing code, but I
> don't know openpic well enough to really review it; so I'm trusting
> you on that.

Thanks David, I'll have an updated timer patch out later today for the
timer that actually times.  I'm reasonably sure the resulting code is
correct because we have the same binary working on real hardware and
on QEMU.
