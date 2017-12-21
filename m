Received: from eggs.gnu.org ([2001:4830:134:3::10]:55375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRruz-0002ud-GS
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 22:53:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRruw-0001D6-Vp
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 22:53:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eRruw-0001CR-PQ
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 22:53:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E29BF477
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 03:53:09 +0000 (UTC)
Date: Thu, 21 Dec 2017 05:53:05 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171221055215-mutt-send-email-mst@kernel.org>
References: <20171219181129.24189-1-maxime.coquelin@redhat.com>
	<20171220160741.GE12566@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171220160741.GE12566@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH 0/3] Vhost: no more leak QEMU virtual
 addresses to user backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, qemu-devel@nongnu.org, mlureau@redhat.com

On Wed, Dec 20, 2017 at 04:07:41PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 19, 2017 at 07:11:26PM +0100, Maxime Coquelin wrote:
> > Before this series, QEMU process virtual addresses are sent to the
> > user backend as user addresses.
> > 
> > Passing these virtual addresses aren't useful, as the backend doesn't
> > direct access to QEMU address space.
> > 
> > It does make sense however for kernel backend, which can access QEMU
> > address space.
> > 
> > This series introduce a new enum set by the backend stating whether it
> > prefers using QEMU Virtual addresses or Guest physical addresses as
> > User address, and make vhost-user backend to use Guest physical
> > addresses.
> > 
> > Maxime Coquelin (3):
> >   vhost-user: rename VhostUserMemory userspace_addr field to user_addr
> >   vhost: introduce backend's user address type
> >   vhost-user: no more leak QEMU virtual addresses to user backend
> > 
> >  hw/virtio/vhost-backend.c         |  1 +
> >  hw/virtio/vhost-user.c            |  6 ++++--
> >  hw/virtio/vhost.c                 | 16 ++++++++++++----
> >  include/hw/virtio/vhost-backend.h |  6 ++++++
> >  4 files changed, 23 insertions(+), 6 deletions(-)
> > 
> > -- 
> > 2.14.3
> > 
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

This makes make check fail. Any idea why?
