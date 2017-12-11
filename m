Received: from eggs.gnu.org ([2001:4830:134:3::10]:49981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eOKQP-0004Wp-7A
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 04:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eOKQK-0000oM-AF
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 04:31:01 -0500
Date: Mon, 11 Dec 2017 17:30:41 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171211093041.GB3350@lemon>
References: <20171208014456.16635-1-famz@redhat.com>
	<20171208095412.GC23880@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171208095412.GC23880@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] qemu-img: Document
 --force-share / -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, kchamart@redhat.com

On Fri, 12/08 09:54, Stefan Hajnoczi wrote:
> On Fri, Dec 08, 2017 at 09:44:56AM +0800, Fam Zheng wrote:
> > +@item --force-share (-U)
> > +
> > +If specified, @code{qemu-img} will open the image with shared permissions,
> > +which makes it less likely to conflict with a running guest's permissions due
> > +to image locking. For example, this can be used to get the image information
> > +(with 'info' subcommand) when the image is used by a running guest. Note that
> > +this could produce inconsistent result because of concurrent metadata changes,
> > +etc.
> 
> The documentation isn't clear on whether read-write is supported or just
> read-only.

block.c will emit an error if used with read-write. I will add a sentence for
that.

Fam
