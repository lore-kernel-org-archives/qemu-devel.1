Received: from eggs.gnu.org ([2001:4830:134:3::10]:35563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d0qrp-0007a4-23
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d0qro-0002lD-78
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:46:01 -0400
Date: Wed, 19 Apr 2017 16:45:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170419144546.GE5826@noname.redhat.com>
References: <1492104214-29994-1-git-send-email-kwolf@redhat.com>
	<1492104214-29994-3-git-send-email-kwolf@redhat.com>
	<c8d62cd3-73fc-4461-a3f1-c050908e9bec@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
In-Reply-To: <c8d62cd3-73fc-4461-a3f1-c050908e9bec@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] qemu-iotests: Filter HMP readline
 escape characters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 13.04.2017 um 19:38 hat Eric Blake geschrieben:
> On 04/13/2017 12:23 PM, Kevin Wolf wrote:
> > The only thing the escape characters achieve is making the reference
> > output unreadable and lines that are potentially so long that git
> > doesn't want to put them into an email any more. Let's filter them out.
>=20
> Hear! Hear!
>=20
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  tests/qemu-iotests/028.out       | 2 +-
> >  tests/qemu-iotests/130.out       | 4 ++--
> >  tests/qemu-iotests/common.filter | 7 +++++++
> >  tests/qemu-iotests/common.qemu   | 4 ++--
> >  4 files changed, 12 insertions(+), 5 deletions(-)
>=20
> Yay!  But I think you're incomplete:
>=20
> What about 051, 068, 142, and 145?

I only converted the cases that use common.qemu, so they failed after
my change. The other test cases you found are running qemu manually and
didn't apply the filter yet, so they wouldn't fail.

For v2, I'll add the new filter to them and change the reference output
accordingly.

> (found by:
>  git grep -l $'\e' tests/qemu-iotests/*.out
> using bash as the shell)
>=20
>=20
> > +++ b/tests/qemu-iotests/common.filter
> > @@ -86,6 +86,13 @@ _filter_qmp()
> >          -e '    QMP_VERSION'
> >  }
> > =20
> > +# readline makes HMP command strings so long that git complains
> > +_filter_hmp()
> > +{
> > +    sed -e 's/(qemu).*\o33\[D/(qemu) /g' \
>=20
> \oNN is a GNU sed-ism, as far as I can tell.  Is it portable to our
> BSD/MacOS builds?

I'll use your bash version in v2.

Kevin

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY93gaAAoJEH8JsnLIjy/Ws14P/20Sc5ydUOtgb5DCmTyYCIGq
Lll1PadPqAv9PPxqBfE7pNEgOK1rTCe8lhjAPCxN+74reMC2HnDHJygw7Dpb/S0Y
t1ENnYVGMwyXK7dhgKU8iUPf9xnEhxrRXeg4NIhXOVACh5UzDefGQvtToHlXQXoq
ncPvb6j7/VCs2R7ApNh/YLjyzJa9+LXg95Q1BEPz8zd0XKBYwLCMzb8/TrKD0Ack
to1ENfJaGs7BICWVijQQ3TSB4RHS59weFKTot5gVsnvyRBprZIypGsw8zuyWrHwP
1w/qZWTAPWt9jUOsAZ07UAYDYyYCVNOYoaSP9TxcraYl9IaLjCwYVfqzdKjxzL6u
hfbQjhkZYeBHmu5S4xwLRSY097kaqIYtQCDXvulwn8JkaGm5tylel4GHduAu1Dt/
VPhLESWYBerRtuTSZ/GQiOEqZP87oIH2u4vQ9+SSvw1KjnELRqBX9pt+kjk+neiS
E4IbYgFo8hqAS/AzcKzgYdsD3UBu8CAZIyqJxUm5cKPHnGOKxsTugwyRYw1PK6L8
9shj5LVKY2SygOJra8VDnc9lCvoVNtVvMgSVxjT2x/whOxnVCnXi3i7+6STGdE3l
f6wUIl80gaEvMkySZ2wTVj2MURMP3qoAX20HMoDc77OgURwaSqjeAwXqzV4nrtxR
c56t8pnE935vgN3oWAun
=WRnt
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
