Received: from eggs.gnu.org ([2001:4830:134:3::10]:41931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dT4BZ-0006Mk-J2
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dT4BY-00058x-DL
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:39:01 -0400
Date: Thu, 6 Jul 2017 12:38:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170706103849.GA5975@noname.redhat.com>
References: <20170705210842.960-1-eblake@redhat.com>
	<20170705210842.960-5-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170705210842.960-5-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 04/21] stream: Drop reached_end for
 stream_complete()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 05.07.2017 um 23:08 hat Eric Blake geschrieben:
> stream_complete() skips the work of rewriting the backing file if
> the job was cancelled, if data->reached_end is false, or if there
> was an error detected (non-zero data->ret) during the streaming.
> But note that in stream_run(), data->reached_end is only set if the
> loop ran to completion, and data->ret is only 0 in two cases:
> either the loop ran to completion (possibly by cancellation, but
> stream_complete checks for that), or we took an early goto out
> because there is no bs->backing.  Thus, we can preserve the same
> semantics without the use of reached_end, by merely checking for
> bs->backing (and logically, if there was no backing file, streaming
> is a no-op, so there is no backing file to rewrite).
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
