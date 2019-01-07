Received: from eggs.gnu.org ([209.51.188.92]:52781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1ggaCm-0005Lx-9e
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 14:04:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1ggaCk-0006Gj-En
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 14:04:56 -0500
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:44318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <remy.noel@blade-group.com>)
	id 1ggaCi-0005wF-6g
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 14:04:54 -0500
Received: by mail-ed1-x542.google.com with SMTP id y56so1902368edd.11
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 11:04:38 -0800 (PST)
From: remy.noel@blade-group.com
Date: Mon, 7 Jan 2019 20:04:58 +0100
Message-ID: <20190107190458.5zz4dx36zuuzrc6f@gmail.com>
References: <20181220152030.28035-1-remy.noel@blade-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181220152030.28035-1-remy.noel@blade-group.com>
Subject: Re: [Qemu-devel] [QEMU-devel][PATCH v4 0/2] Fix concurrent
 aio_poll/set_fd_handler.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: remy.noel@blade-group.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Weil <sw@weilnetz.de>

On Thu, Dec 20, 2018 at 04:20:28PM +0100, Remy Noel wrote:
>From: Remy Noel <remy.noel@blade-group.com>
>
>It is possible for an io_poll/read/write callback to be concurrently executed along
>with an aio_set_fd_handlers. This can cause all sorts of problems, like
>a NULL callback or a bad opaque pointer.
>
>V2:
>    * Do not use RCU anymore as it inccurs a performance loss
>V3:
>    * Don't drop revents when a handler is modified [Stefan]
>V4:
>    * Unregister fd from ctx epoll when removing fd_handler [Paolo]
>
>Remy Noel (2):
>  aio-posix: Unregister fd from ctx epoll when removing fd_handler.
>  aio-posix: Fix concurrent aio_poll/set_fd_handler.
>
> util/aio-posix.c | 90 +++++++++++++++++++++++++++++-------------------
> util/aio-win32.c | 67 ++++++++++++++++-------------------
> 2 files changed, 84 insertions(+), 73 deletions(-)
>
>-- 
>2.19.2
>
ping.

Does it needs anything for getting queued ?

Thanks.

Remy.
