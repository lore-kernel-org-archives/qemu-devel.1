Received: from eggs.gnu.org ([2001:4830:134:3::10]:49564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehh1X-0003fV-Me
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehh1T-0008DA-FN
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:29:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehh1T-0008Cu-9V
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:29:19 -0500
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-8-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0c256a6b-7c43-02f1-3a2e-610c20327680@redhat.com>
Date: Fri, 2 Feb 2018 13:29:11 -0600
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-8-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SQUTcT7gUI6BU5lH0j6cC1vSFMZJlWhnB"
Subject: Re: [Qemu-devel] [PATCH RFC 07/21] qapi: Move parse_command_line()
 next to its only use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SQUTcT7gUI6BU5lH0j6cC1vSFMZJlWhnB
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <0c256a6b-7c43-02f1-3a2e-610c20327680@redhat.com>
Subject: Re: [PATCH RFC 07/21] qapi: Move parse_command_line() next to its
 only use
References: <20180202130336.24719-1-armbru@redhat.com>
 <20180202130336.24719-8-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-8-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 07:03 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi-gen.py    | 52 ++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  scripts/qapi/common.py | 54 ------------------------------------------=
--------
>  2 files changed, 51 insertions(+), 55 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SQUTcT7gUI6BU5lH0j6cC1vSFMZJlWhnB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0vAgACgkQp6FrSiUn
Q2qdiAf/UDnZ2Sp3jjqIESj2anjj+D1KAQQGe/hHAXeoA2W1ZNexDL4r0CfmJtvy
6GNkWVY4Xwe2QI1BZ6i9Ldij9KngMCUjrr9w8zBY8s/KQg8QnzUbuW3WOK0NzvF1
5tPEd6W0DUHUX+AobNOR1picCIUX51lle9PVnrkRIxZrPVxINWkCGvsQXeQFcAOT
1pSA37ET0nBp3s1XPRAEaG2KUEQV7s7C+fRrc6GTTj2QizcD+LuRsCEP6EbrvTt0
JdJ0w5sl/w2RmmkXLeYfitG4MZ7iApRIuOKJiQAEjaVbyFH6Md+mU/HxBjAZewtK
DfnG0m9UpOXmkGynIVrQTKI6deovfA==
=H0KM
-----END PGP SIGNATURE-----

--SQUTcT7gUI6BU5lH0j6cC1vSFMZJlWhnB--
