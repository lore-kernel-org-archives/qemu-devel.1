Received: from eggs.gnu.org ([2001:4830:134:3::10]:60506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ctsSn-0006mb-3q
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 05:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ctsSm-0005Xf-Ac
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 05:03:21 -0400
Date: Fri, 31 Mar 2017 10:03:09 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170331090309.GB2199@stefanha-x1.localdomain>
References: <1490895797-29094-1-git-send-email-armbru@redhat.com>
	<1490895797-29094-3-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <1490895797-29094-3-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 for-2.9 2/9] char: Fix socket with
 "type": "vsock" address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pbonzini@redhat.com, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2017 at 07:43:10PM +0200, Markus Armbruster wrote:
> Watch this:
>=20
>     $ qemu-system-x86_64 -nodefaults -S -display none -qmp stdio
>     {"QMP": {"version": {"qemu": {"micro": 91, "minor": 8, "major": 2}, "=
package": " (v2.8.0-1195-gf84141e-dirty)"}, "capabilities": []}}
>     { "execute": "qmp_capabilities" }
>     {"return": {}}
>     { "execute": "chardev-add", "arguments": { "id": "chr0", "backend": {=
 "type": "socket", "data": { "addr": { "type": "vsock", "data": { "cid": "C=
ID", "port": "P" }}}}}}
>     Aborted (core dumped)
>=20
> Crashes because SocketAddress_to_str() is blissfully unaware of
> SOCKET_ADDRESS_KIND_VSOCK.  Fix that.  Pick the output format to match
> socket_parse(), just like the existing formats.
>=20
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  chardev/char-socket.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY3htNAAoJEJykq7OBq3PI9dMH/jtjTYX81KoGpsI+d9K9T9NY
KZqQ1C0cneFhmR3mbestKAp7H93CQbdOPzdHPRs2+fdan2jcpoQz08BC+x6Whyml
FRbcyc/AwHngKor1GL92ph7ww+XWMxdyUCTZzfS+ooHRdTdvCt6lmowIcIPeaxWT
8mtEPLsdaEoLquf/UqWBrSRglhnv4h3suzWADmJX9X4ULTdh24eoQZ0XGM1roei/
BPzVHsdfpQdUr3672dgwewWDVt4IO2nR2cdElYrW+5P9QVveRl+78mos5QhK+gsO
yJ834hWnCHe45fSQGTPtInEv1NgxPZLLecHCvOXvHT2eT7BXlO+Ogz1RkpQ13IY=
=rypu
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
