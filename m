Received: from eggs.gnu.org ([2001:4830:134:3::10]:41033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ci4Pr-0007GN-Gu
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 14:23:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ci4Po-0003th-Da
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 14:23:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1ci4Po-0003td-7Y
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 14:23:28 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E20561BAB
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 19:23:28 +0000 (UTC)
References: <20170224182844.32452-1-dgilbert@redhat.com>
	<20170224182844.32452-5-dgilbert@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <94c1bdab-4222-3b03-4a9a-4d02d054eef9@redhat.com>
Date: Sun, 26 Feb 2017 20:23:24 +0100
MIME-Version: 1.0
In-Reply-To: <20170224182844.32452-5-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 04/16] exec: ram_block_discard_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com
Cc: aarcange@redhat.com

On 24/02/2017 19:28, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Create ram_block_discard_range in exec.c to replace
> postcopy_ram_discard_range and most of ram_discard_range.
> 
> Those two routines are a bit of a weird combination, and
> ram_discard_range is about to get more complex for hugepages.
> It's OS dependent code (so shouldn't be in migration/ram.c) but
> it needs quite a bit of the innards of RAMBlock so doesn't belong in
> the os*.c.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> ---
>  exec.c                           | 54 ++++++++++++++++++++++++++++++++++++++++
>  include/exec/cpu-common.h        |  1 +
>  include/migration/postcopy-ram.h |  7 ------
>  migration/postcopy-ram.c         | 30 +---------------------
>  migration/ram.c                  | 24 +++---------------
>  migration/trace-events           |  2 +-
>  6 files changed, 60 insertions(+), 58 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 865a1e8..ddbc314 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -45,6 +45,7 @@
>  #include "exec/address-spaces.h"
>  #include "sysemu/xen-mapcache.h"
>  #include "trace-root.h"
> +
>  #endif

It seems a blank line has "migrated" here from PATCH v2 11/16. ;)

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
