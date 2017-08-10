Received: from eggs.gnu.org ([2001:4830:134:3::10]:45274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfouX-0003eT-JZ
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfouW-00064n-EC
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:58:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dfouW-00064A-8K
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:58:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F1D8C005751
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 14:58:07 +0000 (UTC)
Date: Thu, 10 Aug 2017 15:57:59 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170810145759.GM12980@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170808162629.32493-4-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 03/19] migration: Add comments to
 channel functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Tue, Aug 08, 2017 at 06:26:13PM +0200, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/channel.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/migration/channel.c b/migration/channel.c
> index edceebd..79b0f8b 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -19,6 +19,14 @@
>  #include "qapi/error.h"
>  #include "io/channel-tls.h"
>  
> +/**
> + * @migration_channel_process_incoming - Create new incoming migration channel
> + *
> + * Notice that TLS is special.  For it we listen in a listener socket,
> + * and then create a new client socket from the TLS library.
> + *
> + * @ioc: Channel to wich we are connecting
> + */

s/wich/which/

>  void migration_channel_process_incoming(QIOChannel *ioc)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -41,6 +49,13 @@ void migration_channel_process_incoming(QIOChannel *ioc)
>  }
>  
>  
> +/**
> + * @migration_channel_connect - Create new outgoing migration channel
> + *
> + * @s: Current migration state
> + * @ioc: Channel to wich we are connecting

s/wich/which/

> + * @hostname: Where we want to connect
> + */
>  void migration_channel_connect(MigrationState *s,
>                                 QIOChannel *ioc,
>                                 const char *hostname)
> -- 
> 2.9.4

With those typos fixed, you can add

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
