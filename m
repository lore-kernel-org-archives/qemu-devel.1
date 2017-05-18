Received: from eggs.gnu.org ([2001:4830:134:3::10]:37656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dBJwL-0000dx-Mr
	for qemu-devel@nongnu.org; Thu, 18 May 2017 07:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dBJwH-0004yL-Qr
	for qemu-devel@nongnu.org; Thu, 18 May 2017 07:49:57 -0400
Date: Thu, 18 May 2017 12:49:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170518114946.GB2467@work-vm>
References: <20170518103642.27796-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170518103642.27796-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] trivial: Remove unneeded ifndef in memory.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, qemu-trivial@nongnu.org

* Juan Quintela (quintela@redhat.com) wrote:
> All the file is surounded already by #ifndef CONFIG_USER_ONLY.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Ah yes, the patch that added the inner ifndef added it to
every use of exec/hwaddr.h.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/exec/memory.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 99e0f54..6b5b953 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -17,9 +17,7 @@
>  #ifndef CONFIG_USER_ONLY
>  
>  #include "exec/cpu-common.h"
> -#ifndef CONFIG_USER_ONLY
>  #include "exec/hwaddr.h"
> -#endif
>  #include "exec/memattrs.h"
>  #include "exec/ramlist.h"
>  #include "qemu/queue.h"
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
