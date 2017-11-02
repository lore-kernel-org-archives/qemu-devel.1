Received: from eggs.gnu.org ([2001:4830:134:3::10]:59878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAJXE-0007ok-97
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAJX8-0000U0-G3
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:44:08 -0400
References: <cover.1509550787.git.berto@igalia.com>
	<c7e98781b46f3bbda37cffe526d5082f3e68a425.1509550787.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bdb44140-d0fa-f84e-4622-21c50e4be8b7@redhat.com>
Date: Thu, 2 Nov 2017 18:43:53 +0100
MIME-Version: 1.0
In-Reply-To: <c7e98781b46f3bbda37cffe526d5082f3e68a425.1509550787.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7gHCinIDDP7rU33gckxeUU9A9IDG1jnaR"
Subject: Re: [Qemu-devel] [PATCH 4/4] qcow2: Add iotest for an empty
 refcount table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7gHCinIDDP7rU33gckxeUU9A9IDG1jnaR
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>
Message-ID: <bdb44140-d0fa-f84e-4622-21c50e4be8b7@redhat.com>
Subject: Re: [PATCH 4/4] qcow2: Add iotest for an empty refcount table
References: <cover.1509550787.git.berto@igalia.com>
 <c7e98781b46f3bbda37cffe526d5082f3e68a425.1509550787.git.berto@igalia.com>
In-Reply-To: <c7e98781b46f3bbda37cffe526d5082f3e68a425.1509550787.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-01 16:42, Alberto Garcia wrote:
> This patch adds a simple iotests in which we try to write to an image
> with an empty refcount table (i.e. with all entries set to 0).
>=20
> This scenario was already handled by the existing consistency checks,
> but we add an explicit test case for completeness.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  tests/qemu-iotests/060     | 7 +++++++
>  tests/qemu-iotests/060.out | 6 ++++++
>  2 files changed, 13 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--7gHCinIDDP7rU33gckxeUU9A9IDG1jnaR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAln7WVkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AddQIAJent9mOWF7bHba71uJlS+8lDdFPhfD7
IOwlpnERK2GQCID3dNewgC1Q1tISh+oEZKE0drhNP2I+6DJCQPm+XuSY62pH1MuS
D8Q9Fig6zKTP5sHwzUUyaRRBiR0Fk3lPilZwgXthmNqMdSc2jhojxzCJj8Dgk0Ve
3/LSKlt0hF03qqS7TvrGAEYwo6MLMV3VCgQ3YQWBpczBe5SULswBuzOfYdaC4QIS
rbqtpSsWe+i5Xhasi9JT+Um11rSpncujnurWqFRahMQSKNYRTkVAioRfAVNL83/L
3L+TgH105R7PIO3LTwnhc1aD6bm5OVEJq/6tfxeDtibvIHVREpnRKp8=
=sMG/
-----END PGP SIGNATURE-----

--7gHCinIDDP7rU33gckxeUU9A9IDG1jnaR--
