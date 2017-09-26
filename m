Received: from eggs.gnu.org ([2001:4830:134:3::10]:46313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwlW3-00017X-0K
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 04:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwlVz-0004CZ-T6
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 04:46:55 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dwlVz-0004CM-MY
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 04:46:51 -0400
Received: by mail-wr0-x243.google.com with SMTP id g50so1896288wra.3
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 01:46:51 -0700 (PDT)
Date: Tue, 26 Sep 2017 09:46:49 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170926084649.GD16834@stefanha-x1.localdomain>
References: <1506401532-25274-1-git-send-email-peterx@redhat.com>
	<1506401532-25274-3-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506401532-25274-3-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/4] iothread: provide helpers for
 internal use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Tue, Sep 26, 2017 at 12:52:10PM +0800, Peter Xu wrote:
> IOThread is a general framework that contains IO loop environment and a
> real thread behind.  It's also good to be used internally inside qemu.
> Provide some helpers for it to create iothreads to be used internally.
> 
> Put all the internal used iothreads into the internal object container.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/sysemu/iothread.h |  8 ++++++++
>  iothread.c                | 16 ++++++++++++++++
>  2 files changed, 24 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
