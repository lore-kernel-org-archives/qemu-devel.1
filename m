Received: from eggs.gnu.org ([209.51.188.92]:41235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvpbg-0006N7-RB
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:33:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gvpbf-0006us-R5
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:33:40 -0500
References: <20190218161822.3573-1-kwolf@redhat.com>
	<20190218161822.3573-5-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b1db9d0d-0f64-4655-c30d-54fda1d8aa70@redhat.com>
Date: Mon, 18 Feb 2019 14:33:27 -0600
MIME-Version: 1.0
In-Reply-To: <20190218161822.3573-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/12] io: Make qio_channel_yield()
 interruptible
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
> Similar to how qemu_co_sleep_ns() allows to be preempted by an external

allows preemption from an external

> coroutine entry, allow reentering qio_channel_yield() early.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/io/channel.h |  9 ++++++---
>  io/channel.c         | 10 ++++++++++
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
