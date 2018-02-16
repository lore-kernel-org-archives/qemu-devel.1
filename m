Received: from eggs.gnu.org ([2001:4830:134:3::10]:40731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emjh9-0004ll-OE
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:21:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emjh5-00049Q-P8
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:21:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49104 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1emjh5-00049C-KE
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:21:07 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B12EEAEB1
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 17:20:57 +0000 (UTC)
References: <20180216165015.30715-1-stefanha@redhat.com>
	<20180216165015.30715-2-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <46f7890d-5104-102e-97ea-82919408a201@redhat.com>
Date: Fri, 16 Feb 2018 11:20:49 -0600
MIME-Version: 1.0
In-Reply-To: <20180216165015.30715-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/5] aio: rename
 aio_context_in_iothread() to in_aio_context_home_thread()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

On 02/16/2018 10:50 AM, Stefan Hajnoczi wrote:
> The name aio_context_in_iothread() is misleading because it also return

s/return/returns/

> true when called on the main AioContext from the main loop thread, which
> is not an IOThread.
> 
> This patch renames it to in_aio_context_home_thread() and expands the
> doc comment to make the semantics clearer.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   include/block/aio.h   | 7 +++++--
>   include/block/block.h | 2 +-
>   2 files changed, 6 insertions(+), 3 deletions(-)
> 

>   /**
> + * in_aio_context_home_thread:
>    * @ctx: the aio context
>    *
> - * Return whether we are running in the I/O thread that manages @ctx.
> + * Return whether we are running in the thread that normally runs @ctx.  Note
> + * that acquiring/releasing ctx does not affect the outcome, each AioContext
> + * still only has a one home thread that is responsible for running it.

s/a one/one/

Typo fixes are trivial, so

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
