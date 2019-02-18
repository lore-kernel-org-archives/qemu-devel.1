Received: from eggs.gnu.org ([209.51.188.92]:44984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvptf-0003Ws-21
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:52:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvpte-0002bz-Bm
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:52:15 -0500
References: <20190218161822.3573-1-kwolf@redhat.com>
	<20190218161822.3573-9-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <05748c04-36b1-add4-a78d-f26e1708cf95@redhat.com>
Date: Mon, 18 Feb 2019 14:52:07 -0600
MIME-Version: 1.0
In-Reply-To: <20190218161822.3573-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/12] block: Don't poll in
 bdrv_set_aio_context()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, stefanha@redhat.com, berrange@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On 2/18/19 10:18 AM, Kevin Wolf wrote:
> The explicit aio_poll() call in bdrv_set_aio_context() was added in
> commit c2b6428d388 as a workaround for bdrv_drain() failing to achieve
> to actually quiesce everything (specifically the NBD client code to
> switch AioContext).
> 
> Now that the NBD client has been fixed to complete this operation during
> bdrv_drain(), we don't need the workaround any more.
> 
> It was wrong anyway: aio_poll() must always be run in the home thread of
> the AioContext.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
