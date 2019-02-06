Received: from eggs.gnu.org ([209.51.188.92]:42378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1grOAC-0000wn-TX
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:26:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1grOAB-0006A2-83
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:26:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1grOAB-00068T-13
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:26:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 28B78356E5
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 14:21:01 +0000 (UTC)
References: <20190206132331.1694-1-quintela@redhat.com>
	<20190206132331.1694-3-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <3beec7d3-7a57-30be-affb-c68caa713a60@redhat.com>
Date: Wed, 6 Feb 2019 15:20:57 +0100
MIME-Version: 1.0
In-Reply-To: <20190206132331.1694-3-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] multifd: Drop x-multifd-page-count
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 06/02/2019 14:23, Juan Quintela wrote:
> Libvirt don't want to expose (and explain it).  And testing looks like
> 128 is good for all use cases, so just drop it.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hmp.c                 |  7 -------
>  migration/migration.c | 30 ------------------------------
>  migration/migration.h |  1 -
>  migration/ram.c       | 13 ++++++++-----
>  qapi/migration.json   | 13 +------------
>  5 files changed, 9 insertions(+), 55 deletions(-)
> 
...
> diff --git a/migration/migration.c b/migration/migration.c
> index f673486679..65df9b566e 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -81,7 +81,6 @@
>  /* The delay time (in ms) between two COLO checkpoints */
>  #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
>  #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
> -#define DEFAULT_MIGRATE_MULTIFD_PAGE_COUNT 128

Why do you update it in the previous patch to remove it in this one?

Thanks,
Laurent
