Received: from eggs.gnu.org ([2001:4830:134:3::10]:49723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eI9YI-0008Sg-PN
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 03:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eI9YD-0000gQ-Cf
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 03:41:38 -0500
Date: Fri, 24 Nov 2017 16:41:20 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171124084120.GC3108@lemon>
References: <20171123175747.2309-1-famz@redhat.com>
	<20171124061234.GB14612@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171124061234.GB14612@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 0/1] block: Workaround for the iotests
 errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, 11/24 01:12, Jeff Cody wrote:
> On Fri, Nov 24, 2017 at 01:57:46AM +0800, Fam Zheng wrote:
> > Jeff's block job patch made the latent drain bug visible, and I find this
> > patch, which by itself also makes some sense, can hide it again. :) With it
> > applied we are at least back to the ground where patchew's iotests (make
> > docker-test-block@fedora) can pass.
> > 
> 
> Unfortunately, I am still seeing segfaults and aborts even with this patch.
> For instance, on tests: 097 141 176.

OK, so the graph change during bdrv_parent_drained_begin/end still bits. We'll
need more code to secure it.

Fam
