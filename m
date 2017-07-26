Received: from eggs.gnu.org ([2001:4830:134:3::10]:34905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1daIxC-0005Px-L8
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1daIxB-0001lt-Ld
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:50:06 -0400
Date: Wed, 26 Jul 2017 10:49:51 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170726094951.GC28914@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170721034730.25612-1-crosa@redhat.com>
	<20170721034730.25612-4-crosa@redhat.com>
	<ddf57b6c-42b2-0ec1-7d53-71d5266727fe@linux.vnet.ibm.com>
	<20170725154546.GR23343@stefanha-x1.localdomain>
	<20170725154854.GS26394@redhat.com>
	<7343a904-6f31-b8b1-c721-267c66e4cb75@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7343a904-6f31-b8b1-c721-267c66e4cb75@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/3] qemu-iotests: require
 CONFIG_LINUX_AIO for test 087
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jing Liu <liujbjl@linux.vnet.ibm.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed, Jul 26, 2017 at 04:55:39PM +0800, Jing Liu wrote:
>=20
>=20
> On 2017/7/25 =E4=B8=8B=E5=8D=8811:48, Daniel P. Berrange wrote:
> > On Tue, Jul 25, 2017 at 04:45:46PM +0100, Stefan Hajnoczi wrote:
> > > On Mon, Jul 24, 2017 at 02:44:13PM +0800, Jing Liu wrote:
> > > > On 2017/7/21 =E4=B8=8A=E5=8D=8811:47, Cleber Rosa wrote:
> > > > > One of the "sub-"tests of test 087 requires CONFIG_LINUX_AIO.
> > > > >=20
> > > > > As a PoC/RFC, this goes the easy route and skips the test as a =
whole
> > > > > when that feature is missing.  Other approaches include splitti=
ng
> > > > > the test and adding extra filtering.
> > > > >=20
> > > > > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > > > > ---
> > > > >    tests/qemu-iotests/087 | 1 +
> > > > >    1 file changed, 1 insertion(+)
> > > > >=20
> > > > > diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
> > > > > index f8e4903..a2fb7de 100755
> > > > > --- a/tests/qemu-iotests/087
> > > > > +++ b/tests/qemu-iotests/087
> > > > > @@ -34,6 +34,7 @@ status=3D1	# failure is the default!
> > > > >    _supported_fmt qcow2
> > > > >    _supported_proto file
> > > > >    _supported_os Linux
> > > > > +_require_feature CONFIG_LINUX_AIO
> > > > I tested that CONFIG_NETTLE_KDF is also a necessary for 087.
> > > >=20
> > > > +_require_feature CONFIG_NETTLE_KDF
> > > Are you sure?  Looks like either nettle or gcrypt is needed:
> > Correct, it works with either.
> Ah, because I just found out nettle which related to KDF.
> why can not find out gcrypt.h in qemu?
> How to compile config_gcrypt_kdf into qemu?

QEMU picks either nettle or libgcrypt automatically, dependant on which
of these gnutls is linked to.

You can force override this via  --disable-nettle --enable-gcrypt
(or vica-verca), for sake of testing, but you shouldn't do that
for production builds.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
