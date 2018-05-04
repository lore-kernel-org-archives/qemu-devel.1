Received: from eggs.gnu.org ([2001:4830:134:3::10]:39573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fEcG0-0006fl-QJ
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fEcFv-0003KL-3R
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:04:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50988 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fEcFu-0003Hd-Vt
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:04:19 -0400
Date: Fri, 4 May 2018 16:04:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180504150407.GS29999@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-28-git-send-email-mst@redhat.com>
	<20180504092924.GE29999@redhat.com>
	<20180504174256-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180504174256-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 27/67] replication: add include directory
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org

On Fri, May 04, 2018 at 05:52:39PM +0300, Michael S. Tsirkin wrote:
> On Fri, May 04, 2018 at 10:29:24AM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Thu, May 03, 2018 at 10:51:05PM +0300, Michael S. Tsirkin wrote:
> > > This way it is easier to find using standard rules.
> > >=20
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  include/replication.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > >  create mode 100644 include/replication.h
> > >=20
> > > diff --git a/include/replication.h b/include/replication.h
> > > new file mode 100644
> > > index 0000000..2f40e8e
> > > --- /dev/null
> > > +++ b/include/replication.h
> > > @@ -0,0 +1 @@
> > > +#include_next "../replication.h"
> >=20
> > I think this is really crazy. If we want the headers to be accessible
> > via the include/ directory, lets move them to the include/ directory,
> > not create wrappers that point back to the source directory.
> >=20
> > Regards,
> > Daniel
>=20
> True. I did that initially. However I think maintainers should do this
> otherwise this amounts to moving internal headers to include/ wholesale=
.

Your change amounts the very same thing IMHO. A #include will find the
"internal" header via include/... If the header is currently used from
outside its source dir, then it is defacto not an internal header any
more, so we should just move it.  If some subset of the header is
internal, the maintainer can decide to separate the internal vs shared
bits later if desired.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
