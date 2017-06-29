Received: from eggs.gnu.org ([2001:4830:134:3::10]:33166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dQUYW-0001P9-Rr
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dQUYR-00088E-T5
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:12:04 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dQUYR-000878-N0
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:11:59 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OSA0028PURVX850@mailout1.w1.samsung.com> for
	qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:11:55 +0100 (BST)
Date: Thu, 29 Jun 2017 11:11:52 +0300
From: Alexey <a.perevalov@samsung.com>
Message-id: <20170629081152.GA11185@aperevalov-ubuntu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
In-reply-to: <20170629032802.GD32268@pxdev.xzpeter.org>
References: <1498654172-26570-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170628125232eucas1p1af5a7b0d734c7af25a20981e25812ee2@eucas1p1.samsung.com>
	<1498654172-26570-4-git-send-email-a.perevalov@samsung.com>
	<20170629032802.GD32268@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH v6 3/3] migration: add bitmap for received
 page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: i.maximets@samsung.com, qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com

On Thu, Jun 29, 2017 at 11:28:02AM +0800, Peter Xu wrote:
> On Wed, Jun 28, 2017 at 08:49:32AM -0400, Alexey Perevalov wrote:
> 
> [...]
> 
> > @@ -2324,8 +2352,14 @@ static int ram_load_setup(QEMUFile *f, void *opaque)
> 
> [1]
> 
> >  
> >  static int ram_load_cleanup(void *opaque)
> >  {
> > +    RAMBlock *rb;
> >      xbzrle_load_cleanup();
> >      compress_threads_load_cleanup();
> > +
> > +    RAMBLOCK_FOREACH(rb) {
> > +        g_free(rb->receivedmap);
> > +        rb->receivedmap = NULL;
> > +    }
> >      return 0;
> >  }
> 
> Can we put init into ram_load_setup()? (I don't have the codes, but I
> see this function above at [1], I suppose it'll be called on dest side
> before migration really starts?)
> 
> Sorry for my harshness, but this just looks weird. I am not asking
> that we _must_ put it somewhere outside RAM codes, but at least I
> think they should be paired. If you cleanup the bitmap in RAM code,
> why not you init it in RAM code as well? Did I miss anything again?
> 
no looks like it missed by me, I have to admit I didn't fully review
Juan's patches, right now I checked forth version of his patch set,
I had got to participate in Juan's patch set discussion.
> -- 
> Peter Xu
> 

-- 

BR
Alexey
