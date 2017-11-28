Received: from eggs.gnu.org ([2001:4830:134:3::10]:38041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eJiG0-0005Qx-Og
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:57:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eJiFw-0003Qc-U1
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:57:12 -0500
Date: Tue, 28 Nov 2017 10:56:47 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171128155647.GA25110@localhost.localdomain>
References: <20171128154350.21504-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171128154350.21504-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 0/4] Fix qemu-iotests failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

On Tue, Nov 28, 2017 at 04:43:46PM +0100, Kevin Wolf wrote:
> This reverts the recent fix for the case of qemu-iotests 200 (block job
> completion races when using a separate I/O thread) that only fixed a
> symptom and caused many regressions, and replaces it with a new
> solution that hopefully attacks the right root cause.
> 
> The series also contains a bonus fix for a bug that was uncovered by the
> different timing with the patches that are reverted here.
> 
> Kevin Wolf (4):
>   Revert "coroutine: abort if we try to schedule or enter a pending
>     coroutine"
>   Revert "blockjob: do not allow coroutine double entry or
>     entry-after-completion"
>   coroutine: Cancel aio_co_schedule() on direct entry
>   block: Expect graph changes in bdrv_parent_drained_begin/end
> 
>  include/block/blockjob_int.h |  3 +--
>  include/qemu/coroutine_int.h | 14 ++++----------
>  block/io.c                   |  8 ++++----
>  blockjob.c                   |  7 ++-----
>  util/async.c                 | 26 +++++++++++++-------------
>  util/qemu-coroutine-sleep.c  | 12 ------------
>  util/qemu-coroutine.c        | 31 +++++++++++++++++--------------
>  7 files changed, 41 insertions(+), 60 deletions(-)
> 
> -- 
> 2.13.6
>

Tested-by: Jeff Cody <jcody@redhat.com>
