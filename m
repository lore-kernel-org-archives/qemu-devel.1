Received: from eggs.gnu.org ([2001:4830:134:3::10]:55795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0PGo-0001ov-BR
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0PGk-0007Yy-GZ
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:50:14 -0400
Date: Fri, 6 Oct 2017 11:49:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171006094956.GB4325@localhost.localdomain>
References: <CAEfK_45dZvxvBNQpPLo71ZJhrPN5_GJr8uJ2pJZpCaFf0+i3YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEfK_45dZvxvBNQpPLo71ZJhrPN5_GJr8uJ2pJZpCaFf0+i3YA@mail.gmail.com>
Subject: Re: [Qemu-devel] Patch to add helpful tracing output for driver
 authors in NVMe emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Gale <doug16k@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org, keith.busch@intel.com, mreitz@redhat.com, stefanha@redhat.com

Am 06.10.2017 um 01:18 hat Doug Gale geschrieben:
> I added the tracing output in this patch to assist me in implementing
> an NVMe driver. It helped tremendously.
> 
> From 1d19086cdef8d492929852d582cb41dcc5026f71 Mon Sep 17 00:00:00 2001
> From: Doug Gale <doug16k@gmail.com>
> Date: Thu, 5 Oct 2017 19:02:03 -0400
> Subject: [PATCH] Add tracing output to NVMe emulation to help driver authors.
> 
> It is off by default, enable it by uncommenting #define DEBUG_NVME
> or through CFLAGS
> 
> Signed-off-by: Doug Gale <doug16k@gmail.com>

I think it's generally preferable to use the actual tracing
infrastructure instead of fprintf. This would allow to enable the trace
points with the command line options instead of only at compile time and
also to get machine-readable output if necessary.

The tracing infrastructure is documented in docs/devel/tracing.txt.

Kevin
