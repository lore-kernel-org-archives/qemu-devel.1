Received: from eggs.gnu.org ([2001:4830:134:3::10]:49398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dedKi-0007ma-BD
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dedKh-0000pc-35
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:24:16 -0400
Date: Mon, 7 Aug 2017 09:24:03 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170807082403.GC18259@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-6-vsementsov@virtuozzo.com>
	<20170804161135.GJ14504@redhat.com>
	<b102b503-ff2f-db95-330f-9780ab4aaeb2@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b102b503-ff2f-db95-330f-9780ab4aaeb2@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 05/17] block/nbd-client: get rid of ssize_t
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

On Mon, Aug 07, 2017 at 09:57:30AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> 04.08.2017 19:11, Daniel P. Berrange wrote:
> > On Fri, Aug 04, 2017 at 06:14:28PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > Use int variable for nbd_co_send_request return value (as
> > > nbd_co_send_request returns int).
> > Hmm, nbd_co_send_request() propagates return value of nbd_send_request,
> > which returns ssize_t.
> 
> See patch 04, nbd_send_request fixed in it to return int. It propagates
> return
> value of nbd_write which is int.

That's wrong too - nbd_write() should have been fixed to have ssize_t
as its return type, since its returning the value of a ssize_t variable.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
