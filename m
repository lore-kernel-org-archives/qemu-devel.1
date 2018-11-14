Received: from eggs.gnu.org ([2001:4830:134:3::10]:36981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gMw8A-0005Rk-Ai
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:26:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gMw86-0004F5-Ny
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:26:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gMw86-0003zC-Bt
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:26:54 -0500
Date: Wed, 14 Nov 2018 14:26:42 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181114142642.GA3103@stefanha-x1.localdomain>
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20181114123643.24091-1-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.2 00/41] RFC: slirp: make it again a
 standalone project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, rjones@redhat.com, renzo@cs.unibo.it


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 14, 2018 at 04:36:02PM +0400, Marc-Andr=E9 Lureau wrote:
> Hi,
>=20
> Based-on: https://people.debian.org/~sthibault/qemu.git/ slirp branch
>=20
> This series goal is to allow building libslirp as an independent library.
>=20
> While looking at making SLIRP a seperate running process, I thought
> that having an independent library from QEMU would be a first step.
>=20
> There has been some attempts to make slirp a seperate project in the past.
> (https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01092.html)
> Unfortunately, they forked from QEMU and didn't provide enough
> compatibility for QEMU to make use of it (in particular, vmstate
> handling was removed, they lost git history etc). Furthermore, they
> are not maintained as far as I can see.
>=20
> I would propose to make slirp a seperate project, that can initially
> be used by QEMU as a submodule, keeping Makefile.objs until a proper
> shared library with stability guarantees etc is ready..
>=20
> The subproject could created by preserving git tags, and cleaning up the =
code style, this way:
>=20
> git filter-branch --tree-filter "if ls * 1> /dev/null 2>&1; then clang-fo=
rmat -i * /dev/null; fi " -f --subdirectory-filter "slirp" --prune-empty --=
tag-name-filter cat -- --all
> (my clang-format https://gist.github.com/elmarco/cb20c8d92007df0e2fb8a240=
4678ac73)
>=20
> What do you think?

Great idea!

Maybe in the future there will be a tests too.  Right now my impression
is that slirp isn't hardened and suitable for production use cases (i.e.
security).  But with some love (and testing!) I think that could change.

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb7DCiAAoJEJykq7OBq3PI910H/jIYUNIwF7ymetAAOL1NNL7+
55HUJzGNjniZbzu4Kaklc8FhGw1eneiMcT2iim06kKwjDXfCLA8ngahQ7wIlpu8E
2p8Ci2954doB/655eAPgkSMKPHeI76vzZBENY0QAJmBWTxPedPpJU2kO5HmVZITu
qQFt6F06g8PbIfJPSK9EYX+3YqMJ4fdYfoBIo1Betl+zDwIX8DHpX1/kXnqkXCYq
sQjARl7M1s0jn4saVMtTMLkgoeOQ6D9RZ1/ma+O40cyWwgcZUz3C8Sasm6AoYKsK
bnohDPMQnrAI5S/DcsSoY6PJE91efmzf9bxISXEGp8WYCwkErlNt2iY7WZZvs1s=
=o7RO
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
