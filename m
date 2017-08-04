Received: from eggs.gnu.org ([2001:4830:134:3::10]:55831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ddeKP-0006ig-M6
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:15:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ddeKO-00005T-Mj
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:15:53 -0400
Date: Fri, 4 Aug 2017 16:15:44 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170804151544.GF14504@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170804140826.1351-1-berrange@redhat.com>
	<08b23cf1-5fc4-bb97-dad1-75103f3c5d8a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08b23cf1-5fc4-bb97-dad1-75103f3c5d8a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] block: document semanatics of
 bdrv_co_preadv|pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Fri, Aug 04, 2017 at 09:28:54AM -0500, Eric Blake wrote:
> On 08/04/2017 09:08 AM, Daniel P. Berrange wrote:
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> > 
> >  - Clarify that @bytes matches @qiov total size (Kevin)
> > 
> >  include/block/block_int.h | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> 
> [looks like the nongnu.org infrastructure is having heavy load today, so
> mails are getting through more slowly than usual - leads to lots of
> crossed emails, where I'm seeing replies or direct sends sooner than
> list copies]
> 
> > +    /**
> > +     * @offset: position in bytes to write at
> > +     * @bytes: number of bytes to write
> > +     * @qiov: the buffers containing data to write
> > +     * @flags: zero or more of bits allowed by 'supported_write_flags'
> 
> maybe s/of //
> 
> > +     *
> > +     * @offset and @bytes will be a multiple of 'request_alignment',
> > +     * but the length of individual @qiov elements does not have to
> > +     * be a multiple.
> > +     *
> > +     * @bytes will always equal the total size of @qiov, and will be
> > +     * no larger than 'max_transfer'.
> > +     *
> > +     * The buffer in @qiov may point directly to guest memory.
> > +     */
> >      int coroutine_fn (*bdrv_co_pwritev)(BlockDriverState *bs,
> >          uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags);
> 
> Do we make guarantees that the driver callback is never reached if the
> image is currently read-only?  If so, is that a guarantee worth documenting?

bdrv_co_pwritev() returns EPERM if bs->read_only, so it looks like you
are right we have a guarantee we can document

> Reviewed-by: Eric Blake <eblake@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
