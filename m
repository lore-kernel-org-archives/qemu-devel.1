Received: from eggs.gnu.org ([2001:4830:134:3::10]:34297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpB6S-0005Jg-KA
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 07:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpB6R-0005Zb-RS
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 07:33:40 -0400
Date: Mon, 13 Aug 2018 13:33:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180813113331.GE4323@localhost.localdomain>
References: <20180810062647.23211-1-lbloch@janustech.com>
	<20180810062647.23211-6-lbloch@janustech.com>
	<w51sh3m70ca.fsf@maestria.local.igalia.com>
	<1475efc2-86af-48d1-5887-bb8a1a3997a7@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475efc2-86af-48d1-5887-bb8a1a3997a7@janustech.com>
Subject: Re: [Qemu-devel] [PATCH v7 5/9] qcow2: Assign the L2 cache
 relatively to the image size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

Am 11.08.2018 um 21:19 hat Leonid Bloch geschrieben:
> > >   @item refcount-cache-size
> > >   The maximum size of the refcount block cache in bytes
> > > diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
> > > index 87965625d8..e3fb078588 100755
> > > --- a/tests/qemu-iotests/137
> > > +++ b/tests/qemu-iotests/137
> > > @@ -109,7 +109,6 @@ $QEMU_IO \
> > >       -c "reopen -o cache-size=1M,l2-cache-size=64k,refcount-cache-size=64k" \
> > >       -c "reopen -o cache-size=1M,l2-cache-size=2M" \
> > >       -c "reopen -o cache-size=1M,refcount-cache-size=2M" \
> > > -    -c "reopen -o l2-cache-size=256T" \
> > 
> > The "L2 cache size too big" error can still be tested, but you will need
> > to create an image large enough to allow such a big cache.
> > 
> > $ qemu-img create -f qcow2 -o cluster_size=256k hd.qcow2 32P
> > $ $QEMU -drive file=hd.qcow2,l2-cache-entry-size=512,l2-cache-size=1T
> 
> * 32P qcow2 will take 33M - is it OK to create it just for a test?
> * Is it worth to create a special test scenario, with a separate image
> creation, just for that case?

We're creating larger images than that during tests, so I think this is
fine. You don't have to create a new separate test file or anything,
just increase the size of the used test image from 64M to 32P or
whatever is necessary.

Kevin
