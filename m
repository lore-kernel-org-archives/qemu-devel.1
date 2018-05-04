Received: from eggs.gnu.org ([2001:4830:134:3::10]:37513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEc4o-0002tM-HH
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEc4l-0000Wp-FU
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:52:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEc4l-0000WK-9F
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:52:47 -0400
Date: Fri, 4 May 2018 17:52:39 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180504174256-mutt-send-email-mst@kernel.org>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-28-git-send-email-mst@redhat.com>
	<20180504092924.GE29999@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180504092924.GE29999@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org

On Fri, May 04, 2018 at 10:29:24AM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, May 03, 2018 at 10:51:05PM +0300, Michael S. Tsirkin wrote:
> > This way it is easier to find using standard rules.
> >=20
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/replication.h | 1 +
> >  1 file changed, 1 insertion(+)
> >  create mode 100644 include/replication.h
> >=20
> > diff --git a/include/replication.h b/include/replication.h
> > new file mode 100644
> > index 0000000..2f40e8e
> > --- /dev/null
> > +++ b/include/replication.h
> > @@ -0,0 +1 @@
> > +#include_next "../replication.h"
>=20
> I think this is really crazy. If we want the headers to be accessible
> via the include/ directory, lets move them to the include/ directory,
> not create wrappers that point back to the source directory.
>=20
> Regards,
> Daniel

True. I did that initially. However I think maintainers should do this
otherwise this amounts to moving internal headers to include/ wholesale.

At least this patch will stop proliferation of new headers in source
directories.

And with these patches external headers in source directory are
easy to identify.

> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
