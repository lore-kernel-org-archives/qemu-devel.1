Received: from eggs.gnu.org ([2001:4830:134:3::10]:36522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp4g5-0006bS-Bq
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp4g0-0003VY-Py
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:37:29 -0400
Date: Tue, 5 Sep 2017 11:37:10 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170905033710.GT22515@lemon.lan>
References: <20170830100605.22694-1-famz@redhat.com>
	<8760d28x40.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8760d28x40.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PATCH] block: Cleanup BMDS in bdrv_close_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org, peterx@redhat.com, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Fri, 09/01 13:41, Juan Quintela wrote:
> Fam Zheng <famz@redhat.com> wrote:
> > This fixes the assertion due to op blockers added by BMDS:
> >
> > block.c:3248: bdrv_delete: Assertion `bdrv_op_blocker_is_empty(bs)' failed.
> >
> > Reproducer: simply start block migration and quit QEMU before it ends.
> >
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> This stub stuff is crazy.
> 
> Fam, you were right (a.k.a. I was wrong).
> 
> Sorry, Juan.

Stefan, will you merge this?

Fam
