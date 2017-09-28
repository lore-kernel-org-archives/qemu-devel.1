Received: from eggs.gnu.org ([2001:4830:134:3::10]:46258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dxW3f-0000nX-QZ
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 06:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dxW3b-0003Te-Ej
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 06:28:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dxW3b-0003TI-8N
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 06:28:39 -0400
Date: Thu, 28 Sep 2017 11:28:31 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170928102831.GC12157@stefanha-x1.localdomain>
References: <20170928025958.1420-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170928025958.1420-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/5] iothread: allow to create internal
 iothreads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Manos Pitsidianakis <el13635@mail.ntua.gr>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Sep 28, 2017 at 10:59:53AM +0800, Peter Xu wrote:
> v4:
> - fix comment in patch 1 [Fam, Stefan]
> - add one more patch from Stefan to fix the aio glib warning
> 
> v3:
> - pick up r-bs (one missing for Fam's on last patch)
> - fix patch 1 to create isolated internal container
> 
> v2:
> - add one patch to provide object_get_internal_root() [Daniel]
> - patch 2: use the new object_get_internal_root()
> - patch 3: fix commit message, "reentrant" is wrongly used by me. it
>   should be "called multiple times"; move iothread->ctx check into
>   iothread_stop() [Fam]
> - patch 4: add one paragraph in commit message, mention about the glib
>   issue. [Fam]
> 
> When trying to support monitor OOB (out-of-band) commands, I found
> that the monitor IO thread I did looks just like iothread.  It would
> be best if I can use iothread directly.  However it seems that it was
> mostly used by "-object iothread" before but not friendly to internal
> usages.  This series tries to export essential functions to do it.
> 
> Also, I think patch 2 also fixes a bug in iothread_stop().
> 
> Please review. Thanks.
> 
> Peter Xu (4):
>   qom: provide root container for internal objs
>   iothread: provide helpers for internal use
>   iothread: export iothread_stop()
>   iothread: delay the context release to finalize
> 
> Stefan Hajnoczi (1):
>   aio: fix assert when remove poll during destroy
> 
>  include/qom/object.h      | 11 +++++++++++
>  include/sysemu/iothread.h |  9 +++++++++
>  iothread.c                | 46 ++++++++++++++++++++++++++++++++++++----------
>  qom/object.c              | 11 +++++++++++
>  util/aio-posix.c          |  9 ++++++++-
>  5 files changed, 75 insertions(+), 11 deletions(-)
> 
> -- 
> 2.13.5
> 

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan
