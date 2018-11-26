Received: from eggs.gnu.org ([2001:4830:134:3::10]:35352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gRJfH-0005mL-AW
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:23:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gRJfE-0000sr-JE
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:23:15 -0500
References: <20181126160513.26369-1-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3fed5e03-7240-3c91-84b5-107b6ada1f88@redhat.com>
Date: Mon, 26 Nov 2018 17:17:58 +0100
MIME-Version: 1.0
In-Reply-To: <20181126160513.26369-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AMwfVQ3Vbb5VCjDPAG7ei4biHQIz2WYIl"
Subject: Re: [Qemu-devel] [PATCH for-3.1 v3 0/2] block: Fix crash on
 migration with explicit child nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AMwfVQ3Vbb5VCjDPAG7ei4biHQIz2WYIl
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <3fed5e03-7240-3c91-84b5-107b6ada1f88@redhat.com>
Subject: Re: [PATCH for-3.1 v3 0/2] block: Fix crash on migration with
 explicit child nodes
References: <20181126160513.26369-1-kwolf@redhat.com>
In-Reply-To: <20181126160513.26369-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.11.18 17:05, Kevin Wolf wrote:
> v3:
> - Checking whether there are still active parents only really works wit=
h
>   a single pass, so that's what we do now [Max]
> - Test case polishing [Max]
>=20
> v2:
> - Cover children that were created after their parents [Max]
>=20
> Kevin Wolf (2):
>   block: Don't inactivate children before parents
>   iotests: Test migration with -blockdev
>=20
>  block.c                    |  84 +++++++++++++++----------
>  tests/qemu-iotests/234     | 121 +++++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/234.out |  30 +++++++++
>  tests/qemu-iotests/group   |   1 +
>  4 files changed, 205 insertions(+), 31 deletions(-)
>  create mode 100755 tests/qemu-iotests/234
>  create mode 100644 tests/qemu-iotests/234.out

Reviewed-by: Max Reitz <mreitz@redhat.com>


--AMwfVQ3Vbb5VCjDPAG7ei4biHQIz2WYIl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlv8HLYACgkQ9AfbAGHV
z0Av0Qf/a6377t3tgrgSgU2+PjNuCpj/PMNFEu9M4SmuU59u4Zzkcm6ZExmIvNP/
P41HYd8VAO63d6ktBlHkC06AuKLKFkdhCq+CYnm04nn0mNZ2ujmq9EgRwSIgbbj9
frel4AQsAsSctM8d5xxqfzQbDEienIA0Tw+8Za64kiwnqF1S/fDzOMgFcUJdzxoh
Vz7qra0CEM8DoIuZvdzMV1j1RQQk5EMDCTkiT58DZBxwpz+CWo4Zpoo3rcAqI0Dl
r6vKlm8ephyzfgeI8v9edOTCaMAbwvCPSqUF2BAo6M5Tu5wA6gnWrzbiz4yb3+lP
x7m0mqjKsM4t4zja5JYTqTrFw0LSXg==
=k4eM
-----END PGP SIGNATURE-----

--AMwfVQ3Vbb5VCjDPAG7ei4biHQIz2WYIl--
