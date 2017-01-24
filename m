Received: from eggs.gnu.org ([2001:4830:134:3::10]:58992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW0XE-0006o2-Cn
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:49:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW0XA-0005jW-6Z
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:49:16 -0500
Date: Tue, 24 Jan 2017 12:49:01 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170124124901.GN14563@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-16-berrange@redhat.com>
	<a8323336-51b4-21a6-8113-6b80d85d58f7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8323336-51b4-21a6-8113-6b80d85d58f7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 15/15] block: remove all encryption
 handling APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

On Sat, Jan 21, 2017 at 08:22:53PM +0100, Max Reitz wrote:
> On 03.01.2017 19:28, Daniel P. Berrange wrote:
> > Now that all encryption keys must be provided upfront via
> > the QCryptoSecret API and associated block driver properties
> > there is no need for any explicit encryption handling APIs
> > in the block layer. Encryption can be handled transparently
> > within the block driver. We only retain an API for querying
> > whether an image is encrypted or not, since that is a
> > potentially useful piece of metadata to report to the user.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  block.c                   | 77 +----------------------------------------------
> >  block/crypto.c            |  1 -
> >  block/qapi.c              |  2 +-
> >  block/qcow.c              |  1 -
> >  block/qcow2.c             |  1 -
> >  blockdev.c                | 37 ++---------------------
> >  include/block/block.h     |  3 --
> >  include/block/block_int.h |  1 -
> >  include/qapi/error.h      |  1 -
> >  qapi/common.json          |  5 +--
> >  10 files changed, 5 insertions(+), 124 deletions(-)
> 
> It would probably make sense to replace the description of
> BlockDeviceInfo's @encryption_key_missing in qapi/block-core.json by
> "Deprecated; always false".

Oh yes, that makes sense.


> > +    error_setg_errno(errp, -ENOSYS,
> > +                     "Setting block passwords directly is no longer supported");
> 
> A plain error_setg() without _errno should be sufficient.

Will change it.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
