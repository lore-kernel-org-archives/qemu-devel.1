Received: from eggs.gnu.org ([2001:4830:134:3::10]:56745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDLt1-0008VF-3z
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDLt0-00057E-9U
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:18:55 -0400
Date: Wed, 24 May 2017 10:18:44 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170524021844.GG12279@lemon.lan>
References: <20170419094356.19826-1-famz@redhat.com>
	<20170419094356.19826-7-famz@redhat.com>
	<20170511194100.GI24584@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170511194100.GI24584@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 06/16] backup: Request
 BLK_PERM_AIO_CONTEXT_CHANGE on target
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

On Thu, 05/11 15:41, Stefan Hajnoczi wrote:
> On Wed, Apr 19, 2017 at 05:43:46PM +0800, Fam Zheng wrote:
> > What's done in the source's context change notifier is moving the
> > target's context to follow the new one, so we request this permission
> > here.
> 
> It's true that the backup block job must be able to set target's
> AioContext, but does this change also allow other users to set target's
> AioContext while the backup job is running?  If yes, then we need to
> handle that.

If through job->target, yes, but I don't think there is any user of job->target.
Otherwise, it's not allowed, because the second parameter of blk_new doesn't
have BLK_PERM_AIO_CONTEXT_CHANGE.

So it's okay.

Fam
