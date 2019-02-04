Received: from eggs.gnu.org ([209.51.188.92]:55800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqg2M-0003Lr-QO
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqg2L-0005cU-MZ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:19:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqg2L-0005Zd-Ee
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:19:53 -0500
Date: Mon, 4 Feb 2019 10:19:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204101130-mutt-send-email-mst@kernel.org>
References: <20190204142638.27021-1-mst@redhat.com>
	<20190204142638.27021-16-mst@redhat.com>
	<20190204150748.GP1905@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190204150748.GP1905@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 15/25] contrib: compile vhost-user-blk tool
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Changpeng Liu <changpeng.liu@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

Hmm I do think we want to build the contrib tools,
otherwise they bitrot too quickly, witness follow-up
patches that fix the compilation.

And I think we need tests that actually use them.

However I agree adding them to tools and installing
is probably rushing things, e.g. there's no
manpage even.

Changpeng Liu could you post a patch that moves this
away from tools, so it builds but isn't installed?
If it's tricky I think I will revert this one for now ..


On Mon, Feb 04, 2019 at 03:07:48PM +0000, Daniel P. Berrang=E9 wrote:
>=20
> No explanation of /why/ we want to build this by default ?
>=20
> The source header calls it a demo application and it has no man
> page.
>=20
> Given this IMHO we should *not* be building & installing it by
> default, as doing so defacto turns it into a user tool we have
> to support.
>=20
>=20
> On Mon, Feb 04, 2019 at 09:43:48AM -0500, Michael S. Tsirkin wrote:
> > From: Changpeng Liu <changpeng.liu@intel.com>
> >=20
> > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  configure | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/configure b/configure
> > index 31cf6f584d..5c619d4e03 100755
> > --- a/configure
> > +++ b/configure
> > @@ -5831,6 +5831,9 @@ if test "$want_tools" =3D "yes" ; then
> >    if [ "$posix" =3D "yes" ] && [ "$curl" =3D "yes" ]; then
> >      tools=3D"elf2dmp $tools"
> >    fi
> > +  if [ "$linux" =3D "yes" ]; then
> > +    tools=3D"vhost-user-blk\$(EXESUF) $tools"
> > +  fi
> >  fi
> >  if test "$softmmu" =3D yes ; then
> >    if test "$linux" =3D yes; then
> > --=20
> > MST
> >=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
