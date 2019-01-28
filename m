Received: from eggs.gnu.org ([209.51.188.92]:56658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1goAfC-00041D-MB
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1goAfA-0002ZO-II
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:25:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1goAfA-0002XB-7M
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:25:36 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DBE54DF86A
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 17:25:33 +0000 (UTC)
Date: Mon, 28 Jan 2019 17:25:15 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190128172514.GD2585@work-vm>
References: <20190128170321.16936-1-dgilbert@redhat.com>
	<20190128121142-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128121142-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 0/9] Network announce changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, berrange@redhat.com

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Mon, Jan 28, 2019 at 05:03:12PM +0000, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Hi,
> >   This is a reworking of a few sets of patches from 2017
> > that were put together by myself, Germano and Vlad that make
> > the network announce system more flexible.
> > 
> >   Firstly, it's parameterised, so that you can change the number
> > of packets and the gap between them; the number can be set to 0
> > to disable announce completely.
> > 
> >   Secondly, you can force an announce by a qmp or hmp command at
> > any time.  This is useful if you need the guest to do an announce
> > for a different reason; for example if the management layer
> > has just juggled some bonding configuration around.
> > 
> >   The packet creation and timing also moves to net/ from migration/
> > 
> >   The previous set was:
> >      https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg05594.html
> > 
> > Dave
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Who's applying this? Jason?

That would seem most appropriate.

Dave

> 
> > Dr. David Alan Gilbert (9):
> >   net: Introduce announce timer
> >   migration: Add announce parameters
> >   virtio-net: Switch to using announce timer
> >   migration: Switch to using announce timer
> >   net: Add a network device specific self-announcement ability
> >   virtio-net: Allow qemu_announce_self to trigger virtio announcements
> >   qmp: Add announce-self command
> >   hmp: Add hmp_announce_self
> >   tests: Add a test for qemu self announcments
> > 
> >  hmp-commands.hx                |  14 ++++
> >  hmp.c                          |  33 ++++++++
> >  hmp.h                          |   1 +
> >  hw/net/trace-events            |   8 ++
> >  hw/net/virtio-net.c            |  69 ++++++++++++----
> >  include/hw/virtio/virtio-net.h |   4 +-
> >  include/migration/misc.h       |  12 +--
> >  include/net/announce.h         |  41 ++++++++++
> >  include/net/net.h              |   2 +
> >  include/qemu/typedefs.h        |   2 +
> >  include/sysemu/sysemu.h        |   2 -
> >  migration/migration.c          | 103 +++++++++++++++++++++++-
> >  migration/migration.h          |   4 +
> >  migration/savevm.c             |  72 +----------------
> >  migration/trace-events         |   1 -
> >  net/Makefile.objs              |   1 +
> >  net/announce.c                 | 141 +++++++++++++++++++++++++++++++++
> >  net/trace-events               |   4 +
> >  qapi/migration.json            |  56 ++++++++++++-
> >  qapi/net.json                  |  43 ++++++++++
> >  tests/Makefile.include         |   2 +
> >  tests/test-announce-self.c     |  83 +++++++++++++++++++
> >  tests/test-hmp.c               |   1 +
> >  23 files changed, 595 insertions(+), 104 deletions(-)
> >  create mode 100644 include/net/announce.h
> >  create mode 100644 net/announce.c
> >  create mode 100644 tests/test-announce-self.c
> > 
> > -- 
> > 2.20.1
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
