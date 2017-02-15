Received: from eggs.gnu.org ([2001:4830:134:3::10]:39860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ce153-0000kO-QZ
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:01:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ce150-0007bl-OK
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:01:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ce150-0007af-IU
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:01:14 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F05F9C0CA
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 15:01:14 +0000 (UTC)
Date: Wed, 15 Feb 2017 15:01:07 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170215150107.GG24672@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
	<1485207141-1941-10-git-send-email-quintela@redhat.com>
	<20170213173520.GK12387@redhat.com> <20170215144614.GA2410@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170215144614.GA2410@work-vm>
Subject: Re: [Qemu-devel] [PATCH 09/17] migration: Start of multiple fd work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

On Wed, Feb 15, 2017 at 02:46:15PM +0000, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrange (berrange@redhat.com) wrote:
> > On Mon, Jan 23, 2017 at 10:32:13PM +0100, Juan Quintela wrote:
> > > We create new channels for each new thread created. We only send through
> > > them a character to be sure that we are creating the channels in the
> > > right order.
> > > 
> > > Note: Reference count/freeing of channels is not done
> > > 
> > > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > > ---
> > >  include/migration/migration.h |  6 +++++
> > >  migration/ram.c               | 45 +++++++++++++++++++++++++++++++++-
> > >  migration/socket.c            | 56 +++++++++++++++++++++++++++++++++++++++++--
> > 
> > BTW, right now libvirt never uses QEMU's tcp: protocol - it does everything
> > with the fd: protocol.  So either we need multi-fd support for fd: protocol,
> > or libvirt needs to switch to use tcp:
> 
> I thought using fd was safer than tcp: because of the race when something else
> could listen on the proposed port on the incoming side between the point of libvirt
> picking the port number and qemu starting.

Hmm, good point.

> > In fact, having said that, we're going to have to switch to use  the tcp:
> > protocol anyway in order to support TLS, so this is just another good
> > reason for the switch.
> 
> I thought you had a way of allowing fd to work for TLS?

Oh yes, I forgot that I made that work :-)

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
