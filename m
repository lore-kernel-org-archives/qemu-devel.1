Received: from eggs.gnu.org ([2001:4830:134:3::10]:55394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6cs0-0005Mz-Pu
	for qemu-devel@nongnu.org; Fri, 05 May 2017 09:02:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6crx-0000BP-PU
	for qemu-devel@nongnu.org; Fri, 05 May 2017 09:02:04 -0400
Date: Fri, 5 May 2017 14:01:57 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170505130157.GD11350@stefanha-x1.localdomain>
References: <20170420120058.28404-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Content-Disposition: inline
In-Reply-To: <20170420120058.28404-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for 2.10 00/17] Block layer
 thread safety, part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2017 at 02:00:41PM +0200, Paolo Bonzini wrote:
> This series uses mutexes or atomic operations around core block layer
> operations.  The remaining parts include:
>=20
> - drivers, though most of them are already thread safe (part 2, 8 patches,
>   depends on Kevin's conversion of QED to coroutines)
>=20
> - block jobs, before-write notifiers, the write threshold mechanism,
>   snapshots, replication, key management (part 3, 16 patches)
>=20
> - devices (virtio-blk/virtio-scsi, part 4, 5 patches)
>=20
> Once these four parts are done the AioContext lock can be removed
> together with all temporary workarounds that have accumulated.

I like the direction these changes are heading in.

Avoiding low-level tricks and custom primitives would be nice until
there is performance data justifying them because they are
time-consuming to review, increase complexity, and are likely to be
misused by others.

Stefan

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZDHfFAAoJEJykq7OBq3PIMgkH/RBcOtvDl8ySFHzQtSILKqMm
zpV0qOYb7YddvE/myhG1zjeGwYgfEeBxPzBwtfyhErc09QZisC9XDTvnPWswM4dH
IEJL46WMi4Hdb5mxN0JiomXbVfZcLbMHo8GkWdqzRwa34U8tK6TI780AfElMjjB8
zha7KCfi7RL7Hrn0PjPZ5yHHd4pc2MacoauHFrG+Dd8C4MDuu3bEb8wfIFFEgmKa
Z2bba7IWBN+iaHvLTMa9fdyC+XHtDiJ+9NcR49uX4fqrT1+bN5+ffQGbXJ6GX988
8zl+jjfHOk1gAYiaIP/5+iF2mbyl1SXi2e375toSDXJQvmjMrQfvBM5GrDx3aZ8=
=Ugm9
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
