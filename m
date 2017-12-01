Received: from eggs.gnu.org ([2001:4830:134:3::10]:45105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKq30-0007ZX-J7
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:28:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKq2z-0001BX-Cs
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:28:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eKq2z-0001BM-6G
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:28:25 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4090BC04AC43
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 18:28:24 +0000 (UTC)
References: <20171201125750.1372-1-quintela@redhat.com>
	<20171201125750.1372-2-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3e95592d-4846-bb91-961d-03ca10e3ae18@redhat.com>
Date: Fri, 1 Dec 2017 12:28:20 -0600
MIME-Version: 1.0
In-Reply-To: <20171201125750.1372-2-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] migration: Create tcp_port parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 12/01/2017 06:57 AM, Juan Quintela wrote:
> It will be used to store the uri tcp_port parameter.  This is the only
> parameter than can change and we can need to be able to connect to it.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> --
> 

> @@ -2422,6 +2430,8 @@ static Property migration_properties[] = {
>       DEFINE_PROP_SIZE("xbzrle-cache-size", MigrationState,
>                         parameters.xbzrle_cache_size,
>                         DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE),
> +    DEFINE_PROP_UINT16("x-tcp-port", MigrationState,
> +                       parameters.tcp_port, 0),

Why is this one experimental when others are not,

>   
>       /* Migration capabilities */
>       DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 4cd3d13158..e2a1d86216 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -488,6 +488,9 @@
>   #                     and a power of 2
>   #                     (Since 2.11)
>   #
> +# @tcp-port: Only used for tcp, to know what is the real port

s/what is the real port/what the real port is/

> +#                     (Since 2.12)
> +#

Especially since it is not experimental here?

> @@ -564,6 +567,10 @@
>   #                     needs to be a multiple of the target page size
>   #                     and a power of 2
>   #                     (Since 2.11)
> +#
> +# @tcp-port: Only used for tcp, to know what is the real port

same wording tweak

> +#                     (Since 2.12)
> +#
>   # Since: 2.4
>   ##
>   # TODO either fuse back into MigrationParameters, or make
> @@ -582,7 +589,8 @@
>               '*block-incremental': 'bool',
>               '*x-multifd-channels': 'int',
>               '*x-multifd-page-count': 'int',
> -            '*xbzrle-cache-size': 'size' } }
> +            '*xbzrle-cache-size': 'size' ,

the space before comma looks unusual (although it's harmless)

> +            '*tcp-port': 'uint16'} }


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
