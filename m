Received: from eggs.gnu.org ([2001:4830:134:3::10]:57633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d6M11-0001h1-Hq
	for qemu-devel@nongnu.org; Thu, 04 May 2017 15:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d6M0y-0006o1-Cx
	for qemu-devel@nongnu.org; Thu, 04 May 2017 15:02:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d6M0y-0006nm-0s
	for qemu-devel@nongnu.org; Thu, 04 May 2017 15:02:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C1B1128D
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 19:02:10 +0000 (UTC)
Date: Thu, 4 May 2017 20:02:04 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170504190203.GA2611@work-vm>
References: <20170425220451.6028-1-quintela@redhat.com>
	<20170425220451.6028-7-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170425220451.6028-7-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/41] migration: Move colo.h to migration/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> There are functions only used by migration code.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  MAINTAINERS                             | 2 +-
>  migration/colo-comm.c                   | 2 +-
>  migration/colo-failover.c               | 2 +-
>  {include/migration => migration}/colo.h | 0
>  migration/migration.c                   | 2 +-
>  migration/ram.c                         | 2 +-
>  6 files changed, 5 insertions(+), 5 deletions(-)
>  rename {include/migration => migration}/colo.h (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cae3b09..3560ba2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1535,7 +1535,7 @@ COLO Framework
>  M: zhanghailiang <zhang.zhanghailiang@huawei.com>
>  S: Maintained
>  F: migration/colo*
> -F: include/migration/colo.h
> +F: migration/colo.h
>  F: include/migration/failover.h
>  F: docs/COLO-FT.txt
>  
> diff --git a/migration/colo-comm.c b/migration/colo-comm.c
> index 3d91798..9b35027 100644
> --- a/migration/colo-comm.c
> +++ b/migration/colo-comm.c
> @@ -13,7 +13,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "migration/migration.h"
> -#include "migration/colo.h"
> +#include "colo.h"
>  #include "trace.h"

Like most of the other 'move foo.h' patches, these don't need
the #include's changing everywhere - so the patch becomes trivial;
so you can then wrap most of these mv's up into fewer patches.

Dave

>  typedef struct {
> diff --git a/migration/colo-failover.c b/migration/colo-failover.c
> index cc229f5..29b8d63 100644
> --- a/migration/colo-failover.c
> +++ b/migration/colo-failover.c
> @@ -11,7 +11,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "migration/colo.h"
> +#include "colo.h"
>  #include "migration/failover.h"
>  #include "qmp-commands.h"
>  #include "qapi/qmp/qerror.h"
> diff --git a/include/migration/colo.h b/migration/colo.h
> similarity index 100%
> rename from include/migration/colo.h
> rename to migration/colo.h
> diff --git a/migration/migration.c b/migration/migration.c
> index dd8c9d5..fe30227 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -38,7 +38,7 @@
>  #include "exec/address-spaces.h"
>  #include "io/channel-buffer.h"
>  #include "io/channel-tls.h"
> -#include "migration/colo.h"
> +#include "colo.h"
>  
>  #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
>  
> diff --git a/migration/ram.c b/migration/ram.c
> index 4e562be..47e66f4 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -44,7 +44,7 @@
>  #include "trace.h"
>  #include "exec/ram_addr.h"
>  #include "qemu/rcu_queue.h"
> -#include "migration/colo.h"
> +#include "colo.h"
>  
>  /***********************************************************/
>  /* ram save/restore */
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
