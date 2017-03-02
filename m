Received: from eggs.gnu.org ([2001:4830:134:3::10]:34468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjYTl-0004TU-Tb
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:41:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjYTi-0001CY-QF
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:41:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjYTi-0001Bx-HH
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:41:38 -0500
References: <20170302213650.86211-1-ben@skyportsystems.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <24c55319-20af-fbe2-366b-e3bda17f6f94@redhat.com>
Date: Thu, 2 Mar 2017 15:41:33 -0600
MIME-Version: 1.0
In-Reply-To: <20170302213650.86211-1-ben@skyportsystems.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PNTBgUdDUmhQgWhm9R3uR5VNHVgkHTO6x"
Subject: Re: [Qemu-devel] [PATCH] Bugfix: Handle error if VM Generation ID
 device not present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mst@redhat.com, armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, lersek@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PNTBgUdDUmhQgWhm9R3uR5VNHVgkHTO6x
From: Eric Blake <eblake@redhat.com>
To: ben@skyportsystems.com, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mst@redhat.com, armbru@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, imammedo@redhat.com,
 lersek@redhat.com
Message-ID: <24c55319-20af-fbe2-366b-e3bda17f6f94@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Bugfix: Handle error if VM Generation ID
 device not present
References: <20170302213650.86211-1-ben@skyportsystems.com>
In-Reply-To: <20170302213650.86211-1-ben@skyportsystems.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/02/2017 03:36 PM, ben@skyportsystems.com wrote:
> From: Ben Warren <ben@skyportsystems.com>
>=20
> This was crashing due to NULL-pointer dereference
>=20
> QMP Test case:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> (QEMU) query-vm-generation-id
> {"error": {"class": "GenericError", "desc": "VM Generation ID device no=
t
> found"}}
>=20
> HMP Test case:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> virsh # qemu-monitor-command --hmp 3 info vm-generation-id
> VM Generation ID device not found
>=20
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> ---
>  hmp.c             | 4 +++-
>  hw/acpi/vmgenid.c | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

However, hw/acpi/vmgenid.c is not part of the tree yet, so it may be
better to just respin the pull request to incorporate this into the
problematic patch that introduced the problem, rather than needing a
followup patch.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--PNTBgUdDUmhQgWhm9R3uR5VNHVgkHTO6x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuJGNAAoJEKeha0olJ0Nq3CQH/RZgnBKGuy1euKhpsb5taAR1
zMUF4Wpd5zSxloMVSw4sXsIRnnnTby3wxPNF4lQDcqSZFbmf3sYcdfeRb7zK1LLc
NQmV0/umH2RC0F1VqZuXLtLzFmzBT1PSZev0+2uMfC7jshf5Cm0O11oqf/n1bwKS
VnoUlMjMbQ2vsOfhJP3hle4nMgUEJ7ajg8J0kmjGNpf3bkPyKwN1VvOhHxSHhM1N
uJH5L33igkL+6tTSJCe4HnqnuAcuSChFJTK9dfOHqfSd4PFJhdbNlp9VOKlDcMLa
wq88FiNU0frmC30dCVXHU+AY7h3I9X33+OlOL+klB8baHNRh4NHPU71pXZURibo=
=qN8/
-----END PGP SIGNATURE-----

--PNTBgUdDUmhQgWhm9R3uR5VNHVgkHTO6x--
