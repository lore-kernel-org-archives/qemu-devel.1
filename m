Received: from eggs.gnu.org ([2001:4830:134:3::10]:45645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwPLs-0007Jd-MT
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwPLr-0006eZ-Lw
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:34:40 -0400
Date: Fri, 7 Apr 2017 16:34:24 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170407083424.GG4618@lemon>
References: <20170406142527.25835-1-famz@redhat.com>
	<20170406142527.25835-6-famz@redhat.com>
	<20170406162053.GL4341@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170406162053.GL4341@noname.redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 5/5] coroutine: Explicitly specify
 AioContext when creating coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Ed Swierk <eswierk@skyportsystems.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 04/06 18:20, Kevin Wolf wrote:
> For example, another case where this happens is that block jobs follow
> their nodes if the AioContext changes and even implement
> .attached_aio_context callbacks when they need to drag additional nodes
> into the new context. With your change, the job coroutine would remember
> the old coroutine and move back to the old context in some cases!

You are right, in v2 I'll store the co->ctx at enter time explicitly. This way a
context change on a BDS will also move the block job's co.

Fam
