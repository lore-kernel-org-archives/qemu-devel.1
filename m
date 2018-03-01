Received: from eggs.gnu.org ([2001:4830:134:3::10]:52487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1erLkH-0003QD-3s
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:47:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1erLkD-0006Zy-5j
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:47:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45864 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1erLkD-0006Zp-11
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:47:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45A0587ABA
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 10:47:21 +0000 (UTC)
Date: Thu, 1 Mar 2018 10:47:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180301104717.GB14643@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180301084438.13594-6-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 05/15] qio: refactor net listener source
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Mar 01, 2018 at 04:44:28PM +0800, Peter Xu wrote:
> Three functions are abstracted from the old code:
> 
> - qio_net_listener_source_add(): create one source for listener
> - qio_net_listener_sources_clear(): unset existing net lister sources
> - qio_net_listener_sources_update(): setup all sources for listener
> 
> Use them where possible.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  io/net-listener.c | 82 +++++++++++++++++++++++++++----------------------------
>  1 file changed, 41 insertions(+), 41 deletions(-)

This patch can be dropped since nothing else in the series now
depends on it.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
