Received: from eggs.gnu.org ([209.51.188.92]:49188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj87I-0008Cj-Hm
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 14:41:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj87H-0003K8-Pd
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 14:41:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gj87H-0003Jr-HB
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 14:41:47 -0500
References: <20190114090324.16176-1-mhines@scalecomputing.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <95f3ade6-5a10-5ebf-7f8e-91fc40fd45bc@redhat.com>
Date: Mon, 14 Jan 2019 13:41:45 -0600
MIME-Version: 1.0
In-Reply-To: <20190114090324.16176-1-mhines@scalecomputing.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XCxofIXptMMI6PVHYY5pZWyE6xmSrYYch"
Subject: Re: [Qemu-devel] [PATCH] QGA: Fix guest-get-fsinfo PCI address
 collection in Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mhines@scalecomputing.com, qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XCxofIXptMMI6PVHYY5pZWyE6xmSrYYch
From: Eric Blake <eblake@redhat.com>
To: mhines@scalecomputing.com, qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <95f3ade6-5a10-5ebf-7f8e-91fc40fd45bc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] QGA: Fix guest-get-fsinfo PCI address
 collection in Windows
References: <20190114090324.16176-1-mhines@scalecomputing.com>
In-Reply-To: <20190114090324.16176-1-mhines@scalecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/14/19 3:03 AM, mhines@scalecomputing.com wrote:
> From: Matt Hines <mhines@scalecomputing.com>
>=20
> Signed-off-by: Matt Hines <mhines@scalecomputing.com>

The title says what (a fix), but no description of that fix or a "why"
in the commit body.

> ---
>  configure            |   2 +-
>  qga/commands-win32.c | 295 +++++++++++++++++++++++++++++++++----------=
--------
>  qga/qapi-schema.json |   3 +-
>  3 files changed, 197 insertions(+), 103 deletions(-)

> +++ b/qga/qapi-schema.json
> @@ -836,6 +836,7 @@
>  # @unit: unit id
>  # @serial: serial number (since: 3.1)
>  # @dev: device node (POSIX) or device UNC (Windows) (since: 3.1)
> +# @number: device slot index (Windows)

Adding a member is more than just a fix.  Also, this is missing a
'(since 4.0)' tag.

>  #
>  # Since: 2.2
>  ##
> @@ -843,7 +844,7 @@
>    'data': {'pci-controller': 'GuestPCIAddress',
>             'bus-type': 'GuestDiskBusType',
>             'bus': 'int', 'target': 'int', 'unit': 'int',
> -           '*serial': 'str', '*dev': 'str'} }
> +           '*serial': 'str', '*dev': 'str', 'number':'int'} }
> =20
>  ##
>  # @GuestFilesystemInfo:
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--XCxofIXptMMI6PVHYY5pZWyE6xmSrYYch
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw85fkACgkQp6FrSiUn
Q2p4VQf9GcJ2YIX5Tmz4yYV4eidjhGXfZiBHBfVe6BeVBDuF92YVt0r1FTLx58Op
iO57ggMwENcpwiR0YoxQDDYmkGpKEYY24lpHS4MXBAESUGqyytmh5djcUrwexy8o
ce/g1nLarfVJ2AQ9HKnkj4XSo6GkxkTl2nlKspW9Q/YYHL3mkK0GuQeY7GZrzG4X
hXz4+U1xEnIieWtmYv0Pkgx3dLo6fpSFTiaAAmpPBpq/LTMtMmR9iMZmmfPjCg1e
g2vXYkAWxpwSEBMbew2RQW7q9HCBnNoM9s/FNzBZLSzR6bt76XyR9M6b/deXZEbh
8J5O+RZ+d8WpCHjBqw/DddQAvQ44Mg==
=VR3X
-----END PGP SIGNATURE-----

--XCxofIXptMMI6PVHYY5pZWyE6xmSrYYch--
