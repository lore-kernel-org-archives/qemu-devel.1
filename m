Received: from eggs.gnu.org ([2001:4830:134:3::10]:46729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e2WKD-0006FH-OW
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 01:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e2WKA-0004ga-NQ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 01:46:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e2WKA-0004ft-Hk
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 01:46:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64CD27F405
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 05:46:25 +0000 (UTC)
Date: Thu, 12 Oct 2017 13:46:21 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171012054621.GB30901@pxdev.xzpeter.org>
References: <20171010181542.24168-1-quintela@redhat.com>
	<20171010181542.24168-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171010181542.24168-2-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/10] migration: Fix migrate_test_apply
 for multifd parameters
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

On Tue, Oct 10, 2017 at 08:15:33PM +0200, Juan Quintela wrote:
> They were missing when introduced on the tree
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 98429dc843..fb62a639d8 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -865,6 +865,12 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>      if (params->has_block_incremental) {
>          dest->block_incremental = params->block_incremental;
>      }

(newline?)

> +    if (params->has_x_multifd_channels) {
> +        dest->x_multifd_channels = params->x_multifd_channels;
> +    }

(newline?)

> +    if (params->has_x_multifd_page_count) {
> +        dest->x_multifd_page_count = params->x_multifd_page_count;
> +    }
>  }
>  
>  static void migrate_params_apply(MigrateSetParameters *params)
> -- 
> 2.13.6
> 

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
