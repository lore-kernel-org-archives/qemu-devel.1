Received: from eggs.gnu.org ([2001:4830:134:3::10]:33092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eteV3-0007Bd-3y
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 14:13:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eteV2-00038m-6r
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 14:13:17 -0500
References: <20180307185946.29366-1-kwolf@redhat.com>
	<20180307185946.29366-4-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0f8a9c23-319e-56f1-6ffb-9def2e256af9@redhat.com>
Date: Wed, 7 Mar 2018 20:13:08 +0100
MIME-Version: 1.0
In-Reply-To: <20180307185946.29366-4-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YL3NIQLTVFpgifYgp5gMVWK6PJIU0OYlq"
Subject: Re: [Qemu-devel] [PATCH v4 03/37] qcow2: Rename qcow2_co_create2()
 to qcow2_co_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YL3NIQLTVFpgifYgp5gMVWK6PJIU0OYlq
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <0f8a9c23-319e-56f1-6ffb-9def2e256af9@redhat.com>
Subject: Re: [PATCH v4 03/37] qcow2: Rename qcow2_co_create2() to
 qcow2_co_create()
References: <20180307185946.29366-1-kwolf@redhat.com>
 <20180307185946.29366-4-kwolf@redhat.com>
In-Reply-To: <20180307185946.29366-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-07 19:59, Kevin Wolf wrote:
> The functions originally known as qcow2_create() and qcow2_create2()
> are now called qcow2_co_create_opts() and qcow2_co_create(), which
> matches the names of the BlockDriver callbacks that they will implement=

> at the end of this patch series.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--YL3NIQLTVFpgifYgp5gMVWK6PJIU0OYlq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqgOcQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9As8oIAITTXD2Pz9N8d0yNZkPOez2ZVfwGbQKN
leFr8wsatbTJT/miT+Zs1t8FprA+IDD25n56wY93ZRjGdVl1/F3v3miga/YmAgKW
MsCslLsgCjToWbg7HtDjgeElUUs/iWPvWCU9YdX0sNCkkHdW7lABAAElCIfE1LjO
Ubatkju5E87n1HHZTIsY+NGql84C06G0gXBOOxwUvOcZDoNPePM2vYU7nWNu9b2P
nEAM+iZSkjKpDrN8d6yZRoZyL2XaUaWa3v5T+lrs6UsdErhjjydflA8Im4N5TGQV
FJa4fA5QkBwhCysNZOTM4zPSSSYA5lB49uon5dLMB4Zrv7ExYxD0Nm4=
=rmHF
-----END PGP SIGNATURE-----

--YL3NIQLTVFpgifYgp5gMVWK6PJIU0OYlq--
