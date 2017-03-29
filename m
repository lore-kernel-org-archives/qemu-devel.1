Received: from eggs.gnu.org ([2001:4830:134:3::10]:33413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctIoy-0004MC-1A
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 14:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctIox-0006NQ-33
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 14:59:52 -0400
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-3-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2208f4c6-2010-777c-f064-0579e950a041@redhat.com>
Date: Wed, 29 Mar 2017 20:59:36 +0200
MIME-Version: 1.0
In-Reply-To: <1490805920-17029-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nCLh5393wXsxPtbj8q4MtPlwGlXcFiLLp"
Subject: Re: [Qemu-devel] [for-2.9 2/8] char: Fix socket with "type":
 "vsock" address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nCLh5393wXsxPtbj8q4MtPlwGlXcFiLLp
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com,
 pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Message-ID: <2208f4c6-2010-777c-f064-0579e950a041@redhat.com>
Subject: Re: [for-2.9 2/8] char: Fix socket with "type": "vsock" address
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
 <1490805920-17029-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1490805920-17029-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.03.2017 18:45, Markus Armbruster wrote:
> Watch this:
>=20
>     $ qemu-system-x86_64 -nodefaults -S -display none -qmp stdio
>     {"QMP": {"version": {"qemu": {"micro": 91, "minor": 8, "major": 2},=
 "package": " (v2.8.0-1195-gf84141e-dirty)"}, "capabilities": []}}
>     { "execute": "qmp_capabilities" }
>     {"return": {}}
>     { "execute": "chardev-add", "arguments": { "id": "chr0", "backend":=
 { "type": "socket", "data": { "addr": { "type": "vsock", "data": { "cid"=
: "CID", "port": "P" }}}}}}
>     Aborted (core dumped)
>=20
> Crashes because SocketAddress_to_str() is blissfully unaware of
> SOCKET_ADDRESS_KIND_VSOCK.  Fix that.  Pick the output format to match
> socket_parse(), just like the existing formats.
>=20
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  chardev/char-socket.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--nCLh5393wXsxPtbj8q4MtPlwGlXcFiLLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljcBBgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AcCgH/j3SA1xVBxAoIRGSVKcol0HduE8PQ26R
KQO7OWzI5N/RuxlqwZxMTt2CRxx7gWaw5/MW0deZDq+IrZlVjIcHTW9yrJ7Sj9QJ
BWDCdpGXFBCWhf0oy6pY+IrfFgdz8CwKp9wh99bStkMzUKRbxXiusXNd8lXzy5sq
4Pent8A2CcFIvskMi+35Uy6QEKWKXDaRqm3FIZFTClB+t31hb0xS+1RvN6+Q4xVP
8lyhbkRjGJs+FxW/RoMXdiYBJwZXBPuD6qsgUp6JUQm9tys+5KmU+FDXLAhQU22g
wog1o3U1Kgq6XuB3LUA2v25MnOR6R0NX9sPvFMxjA63++0Z5KzZOqbM=
=l1H1
-----END PGP SIGNATURE-----

--nCLh5393wXsxPtbj8q4MtPlwGlXcFiLLp--
