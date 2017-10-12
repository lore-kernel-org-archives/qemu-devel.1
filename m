Received: from eggs.gnu.org ([2001:4830:134:3::10]:49887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e2WT5-0000aD-Pc
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 01:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e2WT2-00013f-Hp
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 01:55:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e2WT2-00012w-CJ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 01:55:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ECA6E13A4E
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 05:55:34 +0000 (UTC)
Date: Thu, 12 Oct 2017 13:55:26 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171012055526.GE30901@pxdev.xzpeter.org>
References: <20171010181542.24168-1-quintela@redhat.com>
	<20171010181542.24168-6-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171010181542.24168-6-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/10] migration: Make cache_init() take an
 error parameter
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

On Tue, Oct 10, 2017 at 08:15:37PM +0200, Juan Quintela wrote:

[...]

> diff --git a/migration/page_cache.h b/migration/page_cache.h
> index 931868b857..4596496416 100644
> --- a/migration/page_cache.h
> +++ b/migration/page_cache.h
> @@ -24,12 +24,11 @@ typedef struct PageCache PageCache;
>   *
>   * Returns new allocated cache or NULL on error
>   *
> - * @cache pointer to the PageCache struct
> - * @num_pages: cache maximal number of cached pages
> + * @cache_size: cache size in byets
                                 ^^^^^
(typo)

>   * @page_size: cache page size
> + * @errp: set *errp if the check failed, with reason
>   */
> -PageCache *cache_init(size_t num_pages, size_t page_size);
> -
> +PageCache *cache_init(int64_t cache_size, size_t page_size, Error **errp);

Besides:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
