Received: from eggs.gnu.org ([2001:4830:134:3::10]:37148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eJiCm-0002fb-8m
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:53:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eJiCi-0002AC-Di
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:53:52 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171128145327.17248-1-berto@igalia.com>
References: <20171128145327.17248-1-berto@igalia.com>
Date: Tue, 28 Nov 2017 16:53:45 +0100
Message-ID: <w51bmjm762e.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.11] blockjob: Remove the job from the
 list earlier in block_job_unref()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>

On Tue 28 Nov 2017 03:53:27 PM CET, Alberto Garcia wrote:
> When destroying a block job in block_job_unref() we should remove it
> from the job list before calling block_job_remove_all_bdrv().
>
> This is because removing the BDSs can trigger an aio_poll() and wake
> up other jobs that might attempt to use the block job list. If that
> happens the job we're currently destroying should not be in that list
> anymore.
> ---
>  blockjob.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I forgot this

Signed-off-by: Alberto Garcia <berto@igalia.com>

Berto
