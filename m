Received: from eggs.gnu.org ([2001:4830:134:3::10]:38470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dBMsS-0007xK-LM
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dBMsP-0005px-Ke
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:58:08 -0400
References: <20170518103642.27796-1-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <1bfe7314-0138-cb26-c1dc-dd55b7f01cb1@redhat.com>
Date: Thu, 18 May 2017 16:57:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170518103642.27796-1-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] trivial: Remove unneeded ifndef in memory.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peterx@redhat.com, qemu-trivial@nongnu.org

On 18/05/2017 12:36, Juan Quintela wrote:
> All the file is surounded already by #ifndef CONFIG_USER_ONLY.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
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
> 
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
