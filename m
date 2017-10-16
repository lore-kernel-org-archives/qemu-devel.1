Received: from eggs.gnu.org ([2001:4830:134:3::10]:42696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e48dj-0002f4-MF
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e48de-0002Js-Qv
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:53:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e48de-0002IZ-Lc
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:53:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66646267C0
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 16:53:13 +0000 (UTC)
Date: Mon, 16 Oct 2017 17:53:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171016165306.GI2252@work-vm>
References: <20171004104636.7963-1-quintela@redhat.com>
	<20171004104636.7963-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004104636.7963-2-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9 01/12] qapi: Fix grammar in
 x-multifd-page-count descriptions
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
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>

This should just go separately to trivial.

> ---
>  qapi/migration.json | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index f8b365e3f5..d94d6c0e46 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -471,7 +471,7 @@
>  #                     number of sockets used for migration.  The
>  #                     default value is 2 (since 2.11)

I wonder if we need a '.' after the 2 and 16 in this set as well.
(Personally I'm not that fussy).

>  #
> -# @x-multifd-page-count: Number of pages sent together to a thread
> +# @x-multifd-page-count: Number of pages sent together to a thread.
>  #                        The default value is 16 (since 2.11)
>  #
>  # Since: 2.4
> @@ -542,7 +542,7 @@
>  #                     number of sockets used for migration.  The
>  #                     default value is 2 (since 2.11)
>  #
> -# @x-multifd-page-count: Number of pages sent together to a thread
> +# @x-multifd-page-count: Number of pages sent together to a thread.
>  #                        The default value is 16 (since 2.11)
>  #
>  # Since: 2.4
> @@ -638,7 +638,7 @@
>  #                     number of sockets used for migration.
>  #                     The default value is 2 (since 2.11)
>  #
> -# @x-multifd-page-count: Number of pages sent together to a thread
> +# @x-multifd-page-count: Number of pages sent together to a thread.
>  #                        The default value is 16 (since 2.11)
>  #

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  # Since: 2.4
> -- 
> 2.13.5
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
