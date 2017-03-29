Received: from eggs.gnu.org ([2001:4830:134:3::10]:54852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ctIYL-0008Hk-Ex
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 14:42:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ctIYK-0003o8-Ls
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 14:42:41 -0400
Date: Wed, 29 Mar 2017 19:42:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170329184216.GC18142@stefanha-x1.localdomain>
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-3-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline
In-Reply-To: <1490805920-17029-3-git-send-email-armbru@redhat.com>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pbonzini@redhat.com, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2017 at 06:45:14PM +0200, Markus Armbruster wrote:
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
> ---
>  chardev/char-socket.c | 4 ++++
>  1 file changed, 4 insertions(+)

Thanks for the fix!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY3AAIAAoJEJykq7OBq3PI2zwH/1BpOwEx7E2CRdIocmt/Civi
KRgj+GNiXJ4PXG18ejAodqf/L6VrqQuAt6TDvChLix8pfb0qXmMbpRNI+zxNZpoX
c5KlbPZ3gWalNVVzH2J/6tyamrgjd6kRTI8YjYMB7F3A43AcnTZPdKPR9hnv9mxB
7LhDDrsM+eNCXAkB41AUZb/ucoZijQ5Ymb7qov38n91YFAVcfMH7FWoG7Aw2Gzwg
3+6vM5MyZg98HFZ2t6wpE1LkM0wQYtBX+WVKTfQCN1ZzMbrcKFQ3khvPN+XtdTE1
xcG3Nye6t7Z89kH4OlceinQWewf9e5c0+eARHJiPpDo+/AWuEudJ4bq6KHWoAkg=
=h+9s
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--
