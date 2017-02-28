Received: from eggs.gnu.org ([2001:4830:134:3::10]:46329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cipdb-0000Wv-KD
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:48:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cipda-0001HZ-EB
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:48:51 -0500
References: <1488317230-26248-1-git-send-email-armbru@redhat.com>
	<1488317230-26248-4-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3ecd3de0-c390-984d-daa6-0c7e609b9e9f@redhat.com>
Date: Tue, 28 Feb 2017 15:48:40 -0600
MIME-Version: 1.0
In-Reply-To: <1488317230-26248-4-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vl3AhIpNKBwCcl7SFICBdr7TTPb3IU1EN"
Subject: Re: [Qemu-devel] [PATCH v2 03/24] keyval: New keyval_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vl3AhIpNKBwCcl7SFICBdr7TTPb3IU1EN
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com,
 mdroth@linux.vnet.ibm.com
Message-ID: <3ecd3de0-c390-984d-daa6-0c7e609b9e9f@redhat.com>
Subject: Re: [PATCH v2 03/24] keyval: New keyval_parse()
References: <1488317230-26248-1-git-send-email-armbru@redhat.com>
 <1488317230-26248-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1488317230-26248-4-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/28/2017 03:26 PM, Markus Armbruster wrote:
> keyval_parse() parses KEY=3DVALUE,... into a QDict.  Works like
> qemu_opts_parse(), except:
>=20
> * Returns a QDict instead of a QemuOpts (d'oh).
>=20
> * Supports nesting, unlike QemuOpts: a KEY is split into key
>   fragments at '.' (dotted key convention; the block layer does
>   something similar on top of QemuOpts).  The key fragments are QDict
>   keys, and the last one's value is updated to VALUE.
>=20
> * Each key fragment may be up to 127 bytes long.  qemu_opts_parse()
>   limits the entire key to 127 bytes.
>=20
> * Overlong key fragments are rejected.  qemu_opts_parse() silently
>   truncates them.
>=20
> * Empty key fragments are rejected.  qemu_opts_parse() happily
>   accepts empty keys.
>=20
> * It does not store the returned value.  qemu_opts_parse() stores it
>   in the QemuOptsList.
>=20
> * It does not treat parameter "id" specially.  qemu_opts_parse()
>   ignores all but the first "id", and fails when its value isn't
>   id_wellformed(), or duplicate (a QemuOpts with the same ID is
>   already stored).  It also screws up when a value contains ",id=3D".
>=20
> * Implied value is not supported.  qemu_opts_parse() desugars "foo" to
>   "foo=3Don", and "nofoo" to "foo=3Doff".
>=20
> * An implied key's value can't be empty, and can't contain ','.

or '=3D' (but the presence of '=3D' means no implied key, while the prese=
nce
of ',' marks end of the implied key's value).  Not sure it's worth
tweaking this commit message any further.

>=20
> I intend to grow this into a saner replacement for QemuOpts.  It'll
> take time, though.
>=20
> Note: keyval_parse() provides no way to do lists, and its key syntax
> is incompatible with the __RFQDN_ prefix convention for downstream
> extensions, because it blindly splits at '.', even in __RFQDN_.  Both
> issues will be addressed later in the series.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Looks like you addressed all the comments.
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vl3AhIpNKBwCcl7SFICBdr7TTPb3IU1EN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtfA4AAoJEKeha0olJ0NqbeoIAJv7314ayBrVlH/BocCyUrO6
43eP2MFVfTOVQYJYZ+TZww5vPXEmfZLbXWCTy9DICxPgHRDq2rEIpHoMXwNWN6fU
BSLhohOLQLJQFRvCKg4LmahK4SAhBO+toyCv1IxNsAuorqpzuQ7rgOzPIre1EPpP
IDROWl6HWDaCA9q0MKkCIkhpEFj6mDlZt0n/i2WLFfU8AOpTO66B/f96Lt0fVWwI
4Gdy6+gCP0E0tGktmHOeRfxu8aE6iuxvsYBF4ufSv0Iqa28Brmr755DXPB0RgnpT
5j9/T7oCvSsam93jsb8JRg2wBPy+hcPdN0k+O/w2R3b4h/ds6GINbADZXDc2qyc=
=c6Nq
-----END PGP SIGNATURE-----

--vl3AhIpNKBwCcl7SFICBdr7TTPb3IU1EN--
