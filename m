Received: from eggs.gnu.org ([209.51.188.92]:45364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvpvR-0004Qc-Ai
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvpvQ-0003P8-KY
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:54:05 -0500
References: <20190218161822.3573-1-kwolf@redhat.com>
	<20190218161822.3573-10-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b2b21f26-a553-4427-648c-c0a9db5fd3ab@redhat.com>
Date: Mon, 18 Feb 2019 14:53:58 -0600
MIME-Version: 1.0
In-Reply-To: <20190218161822.3573-10-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/12] block: Fix AioContext switch for
 drained node
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
> When a drained node changes its AioContext, we need to move its
> aio_disable_external() to the new context, too.
> 
> Without this fix, drain_end will try to reenable the new context, which
> has never been disabled, so an assertion failure is triggered.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
