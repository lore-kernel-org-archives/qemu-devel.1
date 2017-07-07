Received: from eggs.gnu.org ([2001:4830:134:3::10]:39473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dTOOB-0001mW-6A
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 04:13:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dTOOA-0005YP-5y
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 04:13:23 -0400
Date: Fri, 7 Jul 2017 09:13:05 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170707081305.GA15945@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<20170628120530.31251-26-vsementsov@virtuozzo.com>
	<87r2xs65a5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r2xs65a5.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v22 25/30] qmp: add
 x-debug-block-dirty-bitmap-sha256
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com

On Fri, Jul 07, 2017 at 10:05:22AM +0200, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
> 
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > ---
> >  block/dirty-bitmap.c         |  5 +++++
> >  blockdev.c                   | 25 +++++++++++++++++++++++++
> >  include/block/dirty-bitmap.h |  1 +
> >  include/qemu/hbitmap.h       |  8 ++++++++
> >  qapi/block-core.json         | 27 +++++++++++++++++++++++++++
> >  tests/Makefile.include       |  2 +-
> >  util/hbitmap.c               | 11 +++++++++++
> >  7 files changed, 78 insertions(+), 1 deletion(-)
> [...]
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 5c42cc7790..6ad8585400 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -1644,6 +1644,33 @@
> >    'data': 'BlockDirtyBitmap' }
> >  
> >  ##
> > +# @BlockDirtyBitmapSha256:
> > +#
> > +# SHA256 hash of dirty bitmap data
> > +#
> > +# @sha256: ASCII representation of SHA256 bitmap hash
> 
> Spell it SHA-256, please.  The member name @sha256 can stay.
> 
> SHA-256 is 256 binary bits.  Please specify how they are represented in
> ASCII.  It better be base64 (RFC 4648), because we use that elsewhere.

It is filled later in this patch using qcrypto_hash_digest, so it is just
a hex string representing the hash, not base64. For the latter you can
use qcrypto_hash_base64


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
