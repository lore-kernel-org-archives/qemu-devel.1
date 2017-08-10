Received: from eggs.gnu.org ([2001:4830:134:3::10]:45560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfovF-0003zr-GI
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfovD-0006fm-JF
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:58:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dfovD-0006fE-Cn
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:58:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3FA579783A
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 14:58:50 +0000 (UTC)
Date: Thu, 10 Aug 2017 15:58:43 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170810145843.GN12980@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-5-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170808162629.32493-5-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 04/19] migration: Create
 migration_has_all_channels
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

On Tue, Aug 08, 2017 at 06:26:14PM +0200, Juan Quintela wrote:
> This functions allows us to decide when to close the listener socket.
> For now, we only need one connection.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c | 11 +++++++++++
>  migration/migration.h |  2 ++
>  migration/socket.c    | 10 +++++++---
>  3 files changed, 20 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
