Received: from eggs.gnu.org ([2001:4830:134:3::10]:54204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cgV9C-0007KO-5N
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:31:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cgV9B-0008KD-2Q
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:31:50 -0500
Date: Wed, 22 Feb 2017 11:31:39 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170222113139.GJ28937@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170220151921.22842-1-berrange@redhat.com>
	<20170220151921.22842-3-berrange@redhat.com>
	<20170222104606.GF4112@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170222104606.GF4112@noname.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/4] qemu-img: fix --image-opts usage
 with dd command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>

On Wed, Feb 22, 2017 at 11:46:06AM +0100, Kevin Wolf wrote:
> Am 20.02.2017 um 16:19 hat Daniel P. Berrange geschrieben:
> > The --image-opts flag can only be used to affect the parsing
> > of the source image. The target image has to be specified in
> > the traditional style regardless, since it needs to be passed
> > to the bdrv_create() API which does not support the new style
> > opts.
> > 
> > Reviewed-by: Max Reitz <mreitz@redhat.com>
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> 
> Hm. This means that...
> 
> 1. --image-opts never worked for 'qemu-img dd'
> 
> 2. If we ever change bdrv_create() to be more flexible, with this patch
>    we'd be stuck with an inconsistent "filename for target, options for
>    source" interface because we can't change the semantics any more.
> 
> Should we just remove --image-opts from qemu-img dd instead until we can
> provide the real thing?

We're already in that situation wrt bdrv_create() for other commands, so
we need a separate flag to request use of image opts for the target
image. So I don't think we want to special case dd in this respect.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
