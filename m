Received: from eggs.gnu.org ([2001:4830:134:3::10]:56837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dLnrb-0006LB-BS
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dLnra-0002iU-EG
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:48:23 -0400
Date: Fri, 16 Jun 2017 10:48:09 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170616094809.GC25765@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170615195209.17720-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170615195209.17720-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] nbd: fix NBD over TLS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org

On Thu, Jun 15, 2017 at 09:52:09PM +0200, Paolo Bonzini wrote:
> When attaching the NBD QIOChannel to an AioContext, the TLS channel should
> be used, not the underlying socket channel.  This is because, trivially,
> the TLS channel will be the one that we read/write to and thus the one
> that will get the qio_channel_yield() call.
> 
> Fixes: ff82911cd3f69f028f2537825c9720ff78bc3f19
> Cc: qemu-stable@nongnu.org
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/nbd-client.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Tested-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
