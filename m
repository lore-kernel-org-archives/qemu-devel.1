Received: from eggs.gnu.org ([2001:4830:134:3::10]:56804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dG18p-0005iV-Tb
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:46:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dG18p-0006DE-AX
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:46:15 -0400
Date: Wed, 31 May 2017 18:46:04 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170531104604.GD6170@lemon.lan>
References: <20170524025235.32190-1-famz@redhat.com>
	<20170531094531.GD15666@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170531094531.GD15666@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 00/16] block: Protect AIO
 context change with perm API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, 05/31 10:45, Stefan Hajnoczi wrote:
> On Wed, May 24, 2017 at 10:52:19AM +0800, Fam Zheng wrote:
> > v3: Move blk_set_aio_context to the front of mirror_start_job to avoid
> >     accessing target without acquiring its aio context. [Stefan]
> >     Use error_free_or_abort in test code. [Stefan]
> 
> Please include my Reviewed-bys from the previous revision.  That way
> they will be included in the commit log and I don't need to look back at
> previous revisions when you send the next revision.

Yes, sorry for forgetting that.

Fam
