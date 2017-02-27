Received: from eggs.gnu.org ([2001:4830:134:3::10]:49100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciSoZ-0003fG-5c
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 16:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciSoY-00007N-21
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 16:26:39 -0500
References: <cover.1488220970.git.jcody@redhat.com>
	<963f4d61ffcef289b8030bed4be9b9849e2056fe.1488220970.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8cd7a865-83fb-e89b-10e5-b0dc1e6ad66a@redhat.com>
Date: Mon, 27 Feb 2017 15:26:24 -0600
MIME-Version: 1.0
In-Reply-To: <963f4d61ffcef289b8030bed4be9b9849e2056fe.1488220970.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="N6O5PX256Kiwq4C3x5KWBEjswKr6XVPI0"
Subject: Re: [Qemu-devel] [PATCH v2 1/5] block/rbd: don't copy strings in
 qemu_rbd_next_tok()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N6O5PX256Kiwq4C3x5KWBEjswKr6XVPI0
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, berrange@redhat.com
Message-ID: <8cd7a865-83fb-e89b-10e5-b0dc1e6ad66a@redhat.com>
Subject: Re: [PATCH v2 1/5] block/rbd: don't copy strings in
 qemu_rbd_next_tok()
References: <cover.1488220970.git.jcody@redhat.com>
 <963f4d61ffcef289b8030bed4be9b9849e2056fe.1488220970.git.jcody@redhat.com>
In-Reply-To: <963f4d61ffcef289b8030bed4be9b9849e2056fe.1488220970.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 12:58 PM, Jeff Cody wrote:
> This patch is prep work for parsing options for .bdrv_parse_filename,
> and using QDict options.
>=20
> The function qemu_rbd_next_tok() searched for various key/value pairs,
> and copied them into buffers.  This will soon be an unnecessary extra
> step, so we will now return found strings by reference only, and
> offload the responsibility for safely handling/coping these strings to
> the caller.
>=20
> This also cleans up error handling some, as the callers now rely on
> the Error object to determine if there is a parse error.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/rbd.c | 99 +++++++++++++++++++++++++++++++++++++++--------------=
--------
>  1 file changed, 64 insertions(+), 35 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--N6O5PX256Kiwq4C3x5KWBEjswKr6XVPI0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtJmAAAoJEKeha0olJ0NqNIEH/ic32VNav7+K59A5dGeg4rc/
fD4B1HCHrxZS5h5/VgwlIe5sfWIQOR1KhZF2nkyksmPaAiafKuA1UdIXGUaD3qK0
CR5VIhAsDxeG+rMBQIj4Dd+o2tpdazCmBqB+izBFuEgEzOLKpLT4+xmBu/7imdeb
dEZayiJEbY2I+m+J5Cf1VoIfHhIPPBpbh8pWwKRP3zR8iW+xIzMvlWVt6aS7isFY
SGPsVvs5zTC0xdVebc55ffhEg0kRWN1EnjkiTdjVCKlqyVHJ+YnMxQPv3yW3lFnY
0xdroaY+SRE8lCNlUNUfQh1NcPSpXlm3+PARYbyJBTGv0I+ldVr5h+oi2TevoeE=
=IvMu
-----END PGP SIGNATURE-----

--N6O5PX256Kiwq4C3x5KWBEjswKr6XVPI0--
