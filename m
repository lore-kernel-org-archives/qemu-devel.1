Received: from eggs.gnu.org ([2001:4830:134:3::10]:40487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwQ8J-0003tG-7H
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:56:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwQ8E-00088D-Vu
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:56:59 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dwQ8E-000872-QE
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:56:54 -0400
Received: by mail-wm0-x244.google.com with SMTP id m127so6721134wmm.0
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 02:56:54 -0700 (PDT)
Date: Mon, 25 Sep 2017 10:56:51 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170925095651.GG14140@stefanha-x1.localdomain>
References: <1506321449-24013-1-git-send-email-peterx@redhat.com>
	<1506321449-24013-4-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506321449-24013-4-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] iothread: export iothread_stop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Sep 25, 2017 at 02:37:28PM +0800, Peter Xu wrote:
> So that internal iothread users can explicitly stop one iothread without
> destroying it.
> 
> Since at it, fix iothread_stop() to allow it to be called multiple
> times.  Before this patch we may call iothread_stop() more than once on
> single iothread, while that may not be correct since qemu_thread_join()
> is not allowed to run twice.  From manual of pthread_join():
> 
>   Joining with a thread that has previously been joined results in
>   undefined behavior.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/sysemu/iothread.h |  1 +
>  iothread.c                | 24 ++++++++++++++++--------
>  2 files changed, 17 insertions(+), 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
