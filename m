Received: from eggs.gnu.org ([2001:4830:134:3::10]:39634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnpJ0-0003lQ-VH
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnpJ0-0004Iw-4r
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:28:14 -0400
Date: Tue, 14 Mar 2017 17:28:04 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170314162804.GO3952@noname.str.redhat.com>
References: <20170314161205.19415-1-famz@redhat.com>
	<66715588-a25e-3028-d008-8fd285edb755@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
In-Reply-To: <66715588-a25e-3028-d008-8fd285edb755@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] file-posix: Don't leak fd in
 hdev_get_max_segments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 14.03.2017 um 17:20 hat Eric Blake geschrieben:
> On 03/14/2017 11:12 AM, Fam Zheng wrote:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  block/file-posix.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index c4c0663..d670be3 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -703,6 +703,9 @@ static int hdev_get_max_segments(const struct stat =
*st)
> >      }
> > =20
> >  out:
> > +    if (fd !=3D -1) {
> > +        close(fd);
> > +    }
>=20
> Mails crossed - I see I asked about this in reply to v1 after you
> already sent v2 minutes earlier.
>=20
> I still think it might be nice to mention a commit id that you are
> fixing (one of my reply-to-self on your v1), but either way,
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

I added a sentence to the commit message: "This fixes a leaked fd
introduced in commit 9103f1ce." Sounds good?

Kevin

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYyBoUAAoJEH8JsnLIjy/W0CsP/2fPUiRDPjAd09GBvbK1Bxz+
0Kxem6Q3NwFQ5a/US+lxztWm6/8Q/Pel1kbZ4o5n8nespGUOiBLX633aYMqz1SPa
as2lvG5AjgMZc+yuJx8VXzLAZhegiHH9BHXPLSPsy/z3IK3Um8ZH/tqw8xbPtAwl
omUyfWES2dYAuLKMMLTZZZ8xTmWZePJ9081ymPQ1Y3EK5XAxqmVhxvoBr7qz+nUT
osoz1Uu83wSh95IZHBrHesvakFSC5to22c0KO0KSjNXUDfmuFLXLFXrP+4GEzJbL
nFZIN2STcuI2ykvxilza6ANwBcydObVmmgZIj2svP440V0LKfd1En16wpXnjsLAa
ejaq3w1Mm7FvgnXg6SE/nd9BEfI3OQzhGfxeWDl5j06WHLTJY32Dbc/4ZkT5Iydb
lq255wTq5VWsUWkcJzb95ofyC9az6nMdS/a8gqzg2H15cz2kDPFv0F+yGNOkte52
Z+XxoTKBv24L2LyKfHRO3XGFLQY/JfMQ+Q72U6XgeXEea9yBDhuIZSsx7j8FTrxI
Z4loWmWAbJXn2bQ63PhspDQvyD915w/snSW+/HBpL9IfSL9orOM7wpRnD4+ZALR7
BfJna2nsHo82e3+RU07i1QHB//y8Y3FiWzJtxhZGkSCxWTjZFXkEenLaSX4muNDk
ni2RGzCy++5Yc4brP6Zi
=fWt5
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
