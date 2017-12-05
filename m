Received: from eggs.gnu.org ([2001:4830:134:3::10]:33982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eMF4o-0000Pt-TP
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:24:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eMF4j-0007NQ-CD
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:24:06 -0500
Date: Tue, 5 Dec 2017 16:23:51 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171205152351.GB4096@localhost.localdomain>
References: <20171205145424.24598-1-kwolf@redhat.com>
	<20171205145424.24598-2-kwolf@redhat.com>
	<a7c90b68-3b82-0fbb-332a-d2831fb97a74@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <a7c90b68-3b82-0fbb-332a-d2831fb97a74@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] block: Make bdrv_drain_invoke()
 recursive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 05.12.2017 um 16:15 hat Eric Blake geschrieben:
> On 12/05/2017 08:54 AM, Kevin Wolf wrote:
> > This change separates bdrv_drain_invoke(), which calls the BlockDriver
> > drain callbacks, from bdrv_drain_recurse(). Instead, the function
> > performs its own recursion now.
> >=20
> > One reason for this is that bdrv_drain_recurse() can be called multiple
> > times bdrv_drain_recurse(),
>=20
> Doesn't read right.  Should the second instance be changed to 'by
> itself', or is the correct meaning something else?

This should be "by bdrv_drain_all_begin()". Thanks!

Kevin

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaJroHAAoJEH8JsnLIjy/WK3IP/3RBXv8H4eg5Ff9ebl/mfSAn
fzs1/SyIIzlfd7GRJJom+sdGn31Ij6HDZDgpOZooPcSVdP0KxjDk4fFayG9saRlB
nrSSuWlsi6veAZKbTE8X7VEB2QW23s5QsZb96T0NdtOQEGLpHG7N8Q3LgWpVj6QH
/49kAsZiLGsQB7kku0ppo3zd2SKfND1YC7ezEPBeIxDYdyjPxoXbGm1czoNN8FWK
mbRbeYbcxBEJV1GZcbokCYRnmAuwnEZ6NSlPc9yDgY4LebD1zsCHGTPKXJ6xzGQj
jnHxehhoam7XmWGeBVCS/N6JjfnIvMiRUPpoahvLarRz3G+ysMwTZfMd1c+8MjDe
AIwBJXMZ6lw4fXpfsYjYu3ngdCbPkbIDkxEt+SfhWTQhCMm7LcxhxmetuYdAE9gJ
abEwN8n7hnoiqXbV3F6a8pl67o9Sk5u/QwXPYDliXeTZqdVj+6wRVeFRfgFtAe7O
1mL5jwnFo5JAvEzdgCiv+x45rrgjR8weq+fzBpZpo8Eobb2TnHI9NmVgRD/jGVUA
jViHZOB375/UM1xDrjpSWdaDUj+Vig8okd9+zvg88jj6NhpWytB5s8GP4zW7hB0I
5duYf8OI0at0ZBN8p63j0ooiaTtNNG/TYxRZkOPmkiUoHuUIclx38Fgj8FD93DzL
16GXrTqhgIUjBI6KdHpE
=kCjO
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
