Received: from eggs.gnu.org ([2001:4830:134:3::10]:44332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e0T4Q-00050F-Ml
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e0T4P-0001bh-NA
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:53:42 -0400
Date: Fri, 6 Oct 2017 09:53:35 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171006135335.GA7742@stefanha-x1.localdomain>
References: <CAEfK_45dZvxvBNQpPLo71ZJhrPN5_GJr8uJ2pJZpCaFf0+i3YA@mail.gmail.com>
	<20171006094956.GB4325@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171006094956.GB4325@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] Patch to add helpful tracing output
 for driver authors in NVMe emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Gale <doug16k@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, keith.busch@intel.com, stefanha@redhat.com, qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org, mreitz@redhat.com

On Fri, Oct 06, 2017 at 11:49:56AM +0200, Kevin Wolf wrote:
> Am 06.10.2017 um 01:18 hat Doug Gale geschrieben:
> > I added the tracing output in this patch to assist me in implementing
> > an NVMe driver. It helped tremendously.
> > 
> > From 1d19086cdef8d492929852d582cb41dcc5026f71 Mon Sep 17 00:00:00 2001
> > From: Doug Gale <doug16k@gmail.com>
> > Date: Thu, 5 Oct 2017 19:02:03 -0400
> > Subject: [PATCH] Add tracing output to NVMe emulation to help driver authors.
> > 
> > It is off by default, enable it by uncommenting #define DEBUG_NVME
> > or through CFLAGS
> > 
> > Signed-off-by: Doug Gale <doug16k@gmail.com>
> 
> I think it's generally preferable to use the actual tracing
> infrastructure instead of fprintf. This would allow to enable the trace
> points with the command line options instead of only at compile time and
> also to get machine-readable output if necessary.
> 
> The tracing infrastructure is documented in docs/devel/tracing.txt.

Here is a quick example of enabling trace events whose name starts with
"cpu_":

  $ x86_64-softmmu/qemu-system-x86_64 -trace enable=cpu_\*
  7996@1507297762.170096:cpu_get_apic_base 0x00000000fee00900

The default trace backend prints to QEMU's log (stderr).  This makes it
easy to get at tracing output during development.

In order to add trace events to nvme.c you need to edit
hw/block/trace-events.  I suggest naming them with a "nvme_" prefix.

Stefan
