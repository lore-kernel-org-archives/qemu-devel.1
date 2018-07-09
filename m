Received: from eggs.gnu.org ([2001:4830:134:3::10]:44178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fcYBl-0001qK-Eu
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fcYBk-0002Fc-Hf
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:34:57 -0400
References: <20180702210721.4847-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4b4af548-d1d6-eca8-226c-3769758c7c92@redhat.com>
Date: Mon, 9 Jul 2018 17:34:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180702210721.4847-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mW2yo54Eo4dokBLbTHyHaWZYsCz5ZBfzK"
Subject: Re: [Qemu-devel] [PATCH 0/2] vmdk: Fix possible segfault with
 non-VMDK backing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mW2yo54Eo4dokBLbTHyHaWZYsCz5ZBfzK
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <famz@redhat.com>
Message-ID: <4b4af548-d1d6-eca8-226c-3769758c7c92@redhat.com>
Subject: Re: [PATCH 0/2] vmdk: Fix possible segfault with non-VMDK backing
References: <20180702210721.4847-1-mreitz@redhat.com>
In-Reply-To: <20180702210721.4847-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-07-02 23:07, Max Reitz wrote:
> The VMDK driver assumes that its backing file is always a VMDK file,
> too, because it verifies that when creating the overlay.  However, that=

> verification means nothing at runtime, and consequently you can assign
> non-VMDK backing files to a VMDK node.  This then breaks because the
> driver accesses the backing node as a VMDK node to read its supposed CI=
D
> to compare it with the overlay's parentCID entry -- which usually fails=
,
> either in a benign way (we read from a garbage offset, and then we read=

> garbage or get a read error straight away), or we get a segfault
> (because the backing node does not have a respective file child).
>=20
> Anyway, we just shouldn't do it and instead check whether the backing
> file is a VMDK node before treating it like one.
>=20
>=20
> (This fixes
>  http://lists.nongnu.org/archive/html/qemu-block/2018-06/msg01268.html)=

>=20
>=20
> Max Reitz (2):
>   vmdk: Fix possible segfault with non-VMDK backing
>   iotests: Add VMDK backing file correlation test
>=20
>  block/vmdk.c               |   6 ++
>  tests/qemu-iotests/225     | 132 +++++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/225.out |  24 +++++++
>  tests/qemu-iotests/group   |   1 +
>  4 files changed, 163 insertions(+)
>  create mode 100755 tests/qemu-iotests/225
>  create mode 100644 tests/qemu-iotests/225.out

Applied to my block branch.

Max


--mW2yo54Eo4dokBLbTHyHaWZYsCz5ZBfzK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltDgJUACgkQ9AfbAGHV
z0ABkAf/fHtHxrmg44EA8/Qsu5cj5M/uM7yDUF7k6/P86qKWyXbjYH2A/wNLpt9s
dpQvv0MbeRjXdDl8nK207H69geZvRWkU45fZizM1te712mNDn1XWtQttbuYPcwfk
yl3ScRQQIowc+h5DRyXFypKxHog5jB51sAW79yfIzrPibXnhWY5ZVXDiLg6wpoyH
jN9AM6x1pJn+lEICI9wpPHL0WnKynnx5WQ15HRAOPm+bgYYV+VnDEeCCPjE8zd7B
bMiPJgUWLBIxKjhN6u3YWk4EtvF+KYk318EtqldfmhyfJbZWukJEuc+PdRs3YYB9
YXxTv+RBl34rpQgupXbSiaB+M94ubg==
=O9O+
-----END PGP SIGNATURE-----

--mW2yo54Eo4dokBLbTHyHaWZYsCz5ZBfzK--
