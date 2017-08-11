Received: from eggs.gnu.org ([2001:4830:134:3::10]:56380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dg4As-0007OW-SH
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dg4Ar-0002zg-RS
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:16:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dg4Ar-0002zM-L7
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:16:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B22975214B
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 07:16:00 +0000 (UTC)
Date: Fri, 11 Aug 2017 15:15:56 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170811071556.GK26015@pxdev.xzpeter.org>
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-8-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170808162629.32493-8-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 07/19] migration: Create
 x-multifd-threads parameter
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

On Tue, Aug 08, 2017 at 06:26:17PM +0200, Juan Quintela wrote:

[...]

> diff --git a/qapi-schema.json b/qapi-schema.json
> index 521e15c..3fe1a64 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -918,6 +918,7 @@
>  #
>  # @return-path: If enabled, migration will use the return path even
>  #               for precopy. (since 2.10)
> +#

(maybe this empty line belongs to previous patch?)

>  # @x-multifd: Use more than one fd for migration (since 2.11)
>  #
>  # Since: 1.2
> @@ -1043,13 +1044,19 @@
>  # 	migrated and the destination must already have access to the
>  # 	same backing chain as was used on the source.  (since 2.10)
>  #
> +# @x-multifd-threads: Number of threads used to migrate data in
> +#                     parallel. This is the same number that the
> +#                     number of sockets used for migration.
> +#                     The default value is 2 (since 2.11)
> +#
>  # Since: 2.4
>  ##
>  { 'enum': 'MigrationParameter',
>    'data': ['compress-level', 'compress-threads', 'decompress-threads',
>             'cpu-throttle-initial', 'cpu-throttle-increment',
>             'tls-creds', 'tls-hostname', 'max-bandwidth',
> -           'downtime-limit', 'x-checkpoint-delay', 'block-incremental' ] }
> +           'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
> +           'x-multifd-threads'] }

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
