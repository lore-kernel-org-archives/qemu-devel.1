Received: from eggs.gnu.org ([2001:4830:134:3::10]:48178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cddIo-00053E-9b
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cddIj-0003bO-CO
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:37:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cddIj-0003af-6F
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:37:49 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54D377FB60
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 13:37:49 +0000 (UTC)
Date: Tue, 14 Feb 2017 21:37:45 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170214133745.GA12294@lemon.lan>
References: <20170213135235.12274-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170213135235.12274-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 00/18] aio_context_acquire/release
 pushdown, part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Mon, 02/13 14:52, Paolo Bonzini wrote:
> Same as v3 except for tests/Makefile.include and trace-events rebase.
> 
> The next part is CoMutex thread-safety, which is relatively
> small (6 patches).
> 
> Paolo
> 
> Paolo Bonzini (18):
>   block: move AioContext, QEMUTimer, main-loop to libqemuutil
>   aio: introduce aio_co_schedule and aio_co_wake
>   block-backend: allow blk_prw from coroutine context
>   test-thread-pool: use generic AioContext infrastructure
>   io: add methods to set I/O handlers on AioContext
>   io: make qio_channel_yield aware of AioContexts
>   nbd: convert to use qio_channel_yield
>   coroutine-lock: reschedule coroutine on the AioContext it was running on
>   blkdebug: reschedule coroutine on the AioContext it is running on
>   qed: introduce qed_aio_start_io and qed_aio_next_io_cb
>   aio: push aio_context_acquire/release down to dispatching
>   block: explicitly acquire aiocontext in timers that need it
>   block: explicitly acquire aiocontext in callbacks that need it
>   block: explicitly acquire aiocontext in bottom halves that need it
>   block: explicitly acquire aiocontext in aio callbacks that need it
>   aio-posix: partially inline aio_dispatch into aio_poll
>   async: remove unnecessary inc/dec pairs
>   block: document fields protected by AioContext lock

Reviewed-by: Fam Zheng <famz@redhat.com>
