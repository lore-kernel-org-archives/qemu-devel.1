Received: from eggs.gnu.org ([2001:4830:134:3::10]:48437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfn9j-00043l-F8
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:33:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfn9i-0006Nm-CA
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:33:27 -0500
Date: Mon, 20 Feb 2017 12:33:14 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170220123314.GL15874@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170203120254.15062-1-berrange@redhat.com>
	<20170203120254.15062-4-berrange@redhat.com>
	<5c7df424-d78e-650f-3045-c87fd645b611@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c7df424-d78e-650f-3045-c87fd645b611@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] qemu-img: add support for
 conv=nocreat, notrunc args to dd command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>

On Fri, Feb 03, 2017 at 10:44:46PM +0100, Max Reitz wrote:
> On 03.02.2017 13:02, Daniel P. Berrange wrote:
> > The -n arg to the convert command allows use of a pre-existing image,
> > rather than creating a new image. This adds equivalent functionality
> > to the dd command using the 'conv' arg. If 'conv=nocreat' is used,
> > then it will assume the image already exists. The existing image
> > will be truncated to match the required output size. 'conv=notrunc'
> > cna be used to preserve the existing image size.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  qemu-img-cmds.hx |   4 +-
> >  qemu-img.c       | 137 +++++++++++++++++++++++++++++++++++++++++--------------
> >  qemu-img.texi    |  10 +++-
> >  3 files changed, 115 insertions(+), 36 deletions(-)
> 
> Quite frankly I don't like this patch very much. It's not bad in itself,
> but I don't like the idea of giving qemu-img dd new features until it's
> an interface for qemu-img convert. Everything that we add now encourages
> new users to use it and will make the conversion a bit more difficult.
> 
> As long as qemu-img convert gets a --target-image-opts, I don't think we
> need all of this functionality in qemu-img dd.
> 
> Anyway, I won't block/NACK this patch, so resuming review.

I'm going to drop this patch and focus on just fixing qemu-img convert
for now. We can re-visit 'dd' at a later date, once it is clear what
will happen to it wrt refactoring to run above 'convert'.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
