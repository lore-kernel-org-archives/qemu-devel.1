Received: from eggs.gnu.org ([2001:4830:134:3::10]:41268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dgBHI-0008Rd-K7
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dgBHF-0005oL-J1
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:51:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dgBHF-0005o6-CZ
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:51:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3729425B99
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 14:51:04 +0000 (UTC)
Date: Fri, 11 Aug 2017 15:50:56 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170811145056.GN2554@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170808162629.32493-2-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 01/19] migration: Create
 migration_ioc_process_incoming()
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

On Tue, Aug 08, 2017 at 06:26:11PM +0200, Juan Quintela wrote:
> We pass the ioc instead of the fd.  This will allow us to have more
> than one channel open.  We also make sure that we set the
> from_src_file sooner, so we don't need to pass it as a parameter.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/channel.c   |  3 +--
>  migration/migration.c | 25 ++++++++++++++++++++-----
>  migration/migration.h |  2 ++
>  3 files changed, 23 insertions(+), 7 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
