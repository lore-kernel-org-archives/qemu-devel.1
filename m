Received: from eggs.gnu.org ([2001:4830:134:3::10]:54801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suratiamol@gmail.com>) id 1fUyrI-0000sB-7A
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suratiamol@gmail.com>) id 1fUyrE-0003HS-4q
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:26:32 -0400
From: Amol Surati <suratiamol@gmail.com>
Date: Mon, 18 Jun 2018 23:54:53 +0530
Message-ID: <20180618182451.GA3610@arch>
References: <20180617183515.3982-1-suratiamol@gmail.com>
	<20180617183515.3982-2-suratiamol@gmail.com>
	<20180618180254.GA2441@arch>
	<7b876b98-527d-f158-441b-5004b6bcd3a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b876b98-527d-f158-441b-5004b6bcd3a9@redhat.com>
Subject: Re: [Qemu-devel] [RFC 1/1] ide: bug #1777315: io_buffer_size and
 sg.size can represent partial sector sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Amol Surati <suratiamol@gmail.com>, qemu-devel@nongnu.org, "open list:IDE" <qemu-block@nongnu.org>

On Mon, Jun 18, 2018 at 02:13:52PM -0400, John Snow wrote:
> 
> On 06/18/2018 02:02 PM, Amol Surati wrote:
> > On Mon, Jun 18, 2018 at 12:05:15AM +0530, Amol Surati wrote:
> >> This patch fixes the assumption that io_buffer_size is always a perfect
> >> multiple of the sector size. The assumption is the cause of the firing
> >> of 'assert(n * 512 == s->sg.size);'.
> >>
> >> Signed-off-by: Amol Surati <suratiamol@gmail.com>
> >> ---
> > 
> > The repository https://github.com/asurati/1777315 contains a module for
> > QEMU's 8086:7010 ATA controller, which exercises the code path
> > described in [RFC 0/1] of this series.
> > 
> > Loading the module reproduces the bug. Tested on the latest master
> > branch.
> > 
> > Steps:
. . .
. . .

> Are you the original reporter as well?

I am not the original reporter.

> I'm looking at the patch and the reproducer now, thanks.
> 
> --js



-Amol
