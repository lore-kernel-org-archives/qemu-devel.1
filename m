Received: from eggs.gnu.org ([2001:4830:134:3::10]:34865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dB5tX-0001qT-I2
	for qemu-devel@nongnu.org; Wed, 17 May 2017 16:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dB5tW-0001yN-VM
	for qemu-devel@nongnu.org; Wed, 17 May 2017 16:50:07 -0400
Date: Wed, 17 May 2017 16:49:56 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1734615914.8716277.1495054196354.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170517170941.25850-1-stefanha@redhat.com>
References: <20170517170941.25850-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] block: fix 'savevm' hang with -object
 iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org



----- Original Message -----
> From: "Stefan Hajnoczi" <stefanha@redhat.com>
> To: qemu-devel@nongnu.org
> Cc: "Kevin Wolf" <kwolf@redhat.com>, "Paolo Bonzini" <pbonzini@redhat.com>, "Fam Zheng" <famz@redhat.com>, "Stefan
> Hajnoczi" <stefanha@redhat.com>, qemu-block@nongnu.org
> Sent: Wednesday, May 17, 2017 7:09:38 PM
> Subject: [Qemu-devel] [PATCH 0/3] block: fix 'savevm' hang with -object iothread
> 
> The 'savevm' command hangs when -object iothread is used.  See patches for
> details, but basically the vmstate read/write code didn't conform to the
> latest block layer locking rules.

Thanks for the fixes.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

> Stefan Hajnoczi (3):
>   block: count bdrv_co_rw_vmstate() requests
>   block: use BDRV_POLL_WHILE() in bdrv_rw_vmstate()
>   migration: avoid recursive AioContext locking in save_vmstate()
> 
>  block/io.c         | 21 +++++++++++++--------
>  migration/savevm.c | 12 +++++++++++-
>  2 files changed, 24 insertions(+), 9 deletions(-)
> 
> --
> 2.9.3
> 
> 
> 
