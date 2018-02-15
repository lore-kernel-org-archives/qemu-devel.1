Received: from eggs.gnu.org ([2001:4830:134:3::10]:34731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1emG11-0008Ro-Np
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1emG0x-0007fG-AC
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:39:43 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47032 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1emG0x-0007eo-3p
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:39:39 -0500
Date: Thu, 15 Feb 2018 09:39:22 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180215093922.GF23321@stefanha-x1.localdomain>
References: <20180213173429.19501-1-stefanha@redhat.com>
	<20180214004820.GA15103@lemon.usersys.redhat.com>
	<20180214132508.GA7545@stefanha-x1.localdomain>
	<CAK1Eb9kbSCzwrGzXA4Tp0N-F_82vD0tzz2V_QiYLG+AUoqYYfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3oCie2+XPXTnK5a5"
Content-Disposition: inline
In-Reply-To: <CAK1Eb9kbSCzwrGzXA4Tp0N-F_82vD0tzz2V_QiYLG+AUoqYYfg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>


--3oCie2+XPXTnK5a5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2018 at 09:58:27PM +0800, Fam Zheng wrote:
> On Wed, Feb 14, 2018 at 9:25 PM, Stefan Hajnoczi <stefanha@redhat.com> wr=
ote:
> > On Wed, Feb 14, 2018 at 08:48:20AM +0800, Fam Zheng wrote:
> >> On Tue, 02/13 17:34, Stefan Hajnoczi wrote:
> >> > The following changes since commit fb68096da3d35e64c88cd610c1fa42766=
c58e92a:
> >> >
> >> >   Revert "tests: use memfd in vhost-user-test" (2018-02-13 09:51:52 =
+0000)
> >> >
> >> > are available in the Git repository at:
> >> >
> >> >   git://github.com/stefanha/qemu.git tags/block-pull-request
> >> >
> >> > for you to fetch changes up to 64b01feca991e5b19a5d750ef77cdca92b68b=
dbb:
> >> >
> >> >   misc: fix spelling (2018-02-13 15:38:17 +0000)
> >>
> >> Did you mean "PULL" in the subject?
> >
> > git-publish is just obeying your profile settings:
> >
> > +[gitpublishprofile "default"]
> > +base =3D master
> > +prefix =3D PATCH
> >  ^---- :)
> >
> > I used PULL myself in the past but am happy with using whatever we
> > decide the standard should be.
> >
> > Shall we remove prefix from the profiles (it defaults to "PATCH" for
> > regular patches and "PULL" for pull requests)?
>=20
> Yes, this is a bug. In my ~/.gitconfig I had "prefix =3D PATCH ..." for
> all other qemu-* profiles but not the main one, "qemu". When I wrote
> the patch I didn't realize it is so for a reason, and "fixed" it!

Please resend your series once this email thread has run its course.

I am dropping it from the pull request because I'd like to merge the
other fixes in this pull request as soon as possible.

Stefan

--3oCie2+XPXTnK5a5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJahVVKAAoJEJykq7OBq3PIJNMH/3PTNAQ7JT1oTcBC/aaBnfiB
cSZ+4N34WsJ+M0UhUTPIdSxkyaXgAC8XxhyiFEzWuaw13KHsi1BMtHU5VCLsbQNg
4u4oKSolMsJhLGgOhQZI7VK8VCX4nSrrSjI+QjpA5DgYsmqCCncl7y5PDU/+nRK/
WUkhUykvNIpkeHaftfxZwSyrMMvA/uJsQTjzd9LlHB1lPQ9PY4f2UeJ+MF4E5EhG
wb+bRaJQ6iZy2IQaSvz41lyAzqDcaZx3PNFhtQBHZBnoF9Sw45HL83TdfHOHb06P
DDMdfsgFLmFWA8jtcepGc3eyaFDKvdKCiBO/fYaY2AE7s0MvI0IrRoyk4aZ0lgE=
=3FdU
-----END PGP SIGNATURE-----

--3oCie2+XPXTnK5a5--
