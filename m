Received: from eggs.gnu.org ([2001:4830:134:3::10]:43941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1degl6-0007ty-Rs
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1degl1-0004RM-RX
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:03:44 -0400
Date: Mon, 7 Aug 2017 13:03:22 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170807120322.GH18259@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-5-vsementsov@virtuozzo.com>
	<20170807082320.GB18259@redhat.com>
	<d3446922-b464-020a-bde5-c925b29db991@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d3446922-b464-020a-bde5-c925b29db991@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 04/17] nbd/client: fix nbd_send_request to
 return int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, pbonzini@redhat.com

On Mon, Aug 07, 2017 at 11:57:12AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> 07.08.2017 11:23, Daniel P. Berrange wrote:
> > On Fri, Aug 04, 2017 at 06:14:27PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > Fix nbd_send_request to return int, as it returns a return value
> > > of nbd_write (which is int), and the only user of nbd_send_request's
> > > return value (nbd_co_send_request) consider it as int too.
> > The real problem here is the return value of nbd_write() - it should be
> > a ssize_t, not an int, since it is propagating the return value of
> > nbd_rwv() which is ssize_t.
> 
> It was changed in f5d406fe86bb (sent in May)
> The discussion actually was started half a year ago:
> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00825.html

Actually I misread the code.  nbd_rwv() is returning 0 on success, not
the number of bytes, so int is in fact ok


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
