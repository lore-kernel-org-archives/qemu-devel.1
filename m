Received: from eggs.gnu.org ([209.51.188.92]:42774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvpkW-0007rt-2P
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:42:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvpkV-0003X1-Ds
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:42:48 -0500
References: <20190218161822.3573-1-kwolf@redhat.com>
	<20190218161822.3573-6-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <76f9f9b6-435d-f7c3-f9df-4477a430acbc@redhat.com>
Date: Mon, 18 Feb 2019 14:42:40 -0600
MIME-Version: 1.0
In-Reply-To: <20190218161822.3573-6-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/12] nbd: Move nbd_read_eof() to
 nbd/client.c
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
> The only caller of nbd_read_eof() is nbd_receive_reply(), so it doesn't
> have to live in the header file, but can move next to its caller.
> 
> Also add the missing coroutine_fn to the function and its caller.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/nbd.h |  3 ++-
>  nbd/nbd-internal.h  | 19 -------------------
>  nbd/client.c        | 22 +++++++++++++++++++++-
>  3 files changed, 23 insertions(+), 21 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
