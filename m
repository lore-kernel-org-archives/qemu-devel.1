Received: from eggs.gnu.org ([2001:4830:134:3::10]:52665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXrWQ-0006EG-S9
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXrWM-0006VT-SO
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:08:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dXrWM-0006Uy-MC
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:08:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C1A02272CB
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 16:08:17 +0000 (UTC)
Date: Wed, 19 Jul 2017 17:08:11 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170719160811.GP30084@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-4-quintela@redhat.com>
	<20170719154208.GD3500@work-vm> <20170719154345.GM30084@redhat.com>
	<20170719160418.GG3500@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170719160418.GG3500@work-vm>
Subject: Re: [Qemu-devel] [PATCH v5 03/17] qio: Create new
 qio_channel_{readv, writev}_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

On Wed, Jul 19, 2017 at 05:04:19PM +0100, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrange (berrange@redhat.com) wrote:
> > On Wed, Jul 19, 2017 at 04:42:09PM +0100, Dr. David Alan Gilbert wrote:
> > > * Juan Quintela (quintela@redhat.com) wrote:
> > > > The functions waits until it is able to write the full iov.
> > > 
> > > When is it safe to call these - I see qio_channel_wait does it's
> > > own g_main_loop - so I guess they're intended to be called from their
> > > own process?
> > > 
> > > What causes these to exit if the migration fails for some other
> > > (non-file) related reason?
> > 
> > It'll exit if the other end closes the socket, or if the local QEMU
> > does a qio_channel_close() on it.  I don't know if this patch series
> > uses either of those options tough.
> 
> How do you safely cope with calling close on a socket that's currently
> being waited on/might be reading?  In the cancel case we use shutdown()
> to force exits with out actually closing.

You can use qio_channel_shutdown() instead if that's desired

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
