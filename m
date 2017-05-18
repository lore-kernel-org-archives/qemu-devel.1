Received: from eggs.gnu.org ([2001:4830:134:3::10]:44910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBKD9-0000TY-OK
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBKD6-00036S-Hv
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:07:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dBKD6-000366-Bx
	for qemu-devel@nongnu.org; Thu, 18 May 2017 08:07:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C99680C0B
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 12:07:15 +0000 (UTC)
Date: Thu, 18 May 2017 20:07:10 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170518120710.GE24085@pxdev.xzpeter.org>
References: <20170517154756.22079-1-quintela@redhat.com>
	<20170517154756.22079-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170517154756.22079-4-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/9] migration: Export qemu-file-channel.c
 functions in its own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Wed, May 17, 2017 at 05:47:50PM +0200, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/migration/migration.h |  1 +
>  include/migration/qemu-file.h |  4 ----
>  migration/channel.c           |  1 +
>  migration/colo.c              |  1 +
>  migration/migration.c         |  1 +
>  migration/qemu-file-channel.c |  1 +
>  migration/qemu-file-channel.h | 21 +++++++++++++++++++++
>  migration/rdma.c              |  1 +
>  migration/savevm.c            |  1 +
>  tests/test-vmstate.c          |  1 +
>  10 files changed, 29 insertions(+), 4 deletions(-)
>  create mode 100644 migration/qemu-file-channel.h
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index e831259..8280df1 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -19,6 +19,7 @@
>  #include "qemu/thread.h"
>  #include "qemu/notify.h"
>  #include "migration/vmstate.h"
> +#include "io/channel.h"

Could I ask why we add this line here? I thought one of the main goals
of this series is removing things from migration.h...

>  #include "qapi-types.h"
>  #include "exec/cpu-common.h"
>  #include "qemu/coroutine_int.h"

Thanks,

-- 
Peter Xu
