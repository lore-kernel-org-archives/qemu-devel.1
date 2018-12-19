Received: from eggs.gnu.org ([2001:4830:134:3::10]:57247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1gZepp-0000zq-Jc
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 11:36:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1gZepm-0007L1-H5
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 11:36:37 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <remy.noel@blade-group.com>)
	id 1gZepm-0007KV-9f
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 11:36:34 -0500
Received: by mail-wm1-x344.google.com with SMTP id m1so6719837wml.2
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 08:36:34 -0800 (PST)
References: <20181217164847.24411-1-remy.noel@blade-group.com>
	<20181218141401.GF18767@stefanha-x1.localdomain>
From: Remy NOEL <remy.noel@blade-group.com>
Message-ID: <ab3c2d76-0dd1-1147-2194-5078a568d074@blade-group.com>
Date: Wed, 19 Dec 2018 17:36:53 +0100
MIME-Version: 1.0
In-Reply-To: <20181218141401.GF18767@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [QEMU-devel][PATCH v3] aio-posix: Fix concurrent
 aio_poll/set_fd_handler.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Weil <sw@weilnetz.de>, "open list:Block I/O path" <qemu-block@nongnu.org>

On 12/18/18 3:14 PM, Stefan Hajnoczi wrote:

> Please include a changelog in future patches.  For example:
>
> v3:
>   * Don't drop revents when a handler is modified [Stefan]
>
> That way reviewers know what to look for and which issues you have
> addressed.
Sorry, wasn't sure i had to do this in single commit patches without 
cover letter.
> Thanks!  The worst case I can now imagine is if an fd is handled twice
> due to a concurrent aio_set_fd_handler() call, but spurious
> ->io_read()/->io_write() should not cause problems.

Concurrent aio_set_fd_handlers should not be possible (not on the same 
AioContext at least) since we lock ctx->list_lock.

Remy
