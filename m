Received: from eggs.gnu.org ([2001:4830:134:3::10]:33516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1edisL-0008Hf-Cw
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:39:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1edisK-0000ij-Bi
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:39:29 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<9848848136be0af6e4c2c7a51effd88fbd8e6126.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7b8c87e6-04eb-840b-de82-7072b805b1c2@redhat.com>
Date: Mon, 22 Jan 2018 14:39:18 -0600
MIME-Version: 1.0
In-Reply-To: <9848848136be0af6e4c2c7a51effd88fbd8e6126.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="psayIZYGbKSSURUnhWtf4hGscFDAqygDp"
Subject: Re: [Qemu-devel] [PATCH v2 30/32] qcow2: Rename l2_table in
 count_cow_clusters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--psayIZYGbKSSURUnhWtf4hGscFDAqygDp
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <7b8c87e6-04eb-840b-de82-7072b805b1c2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 30/32] qcow2: Rename l2_table in
 count_cow_clusters()
References: <cover.1513342045.git.berto@igalia.com>
 <9848848136be0af6e4c2c7a51effd88fbd8e6126.1513342045.git.berto@igalia.com>
In-Reply-To: <9848848136be0af6e4c2c7a51effd88fbd8e6126.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> This function doesn't need any changes to support L2 slices, but since
> it's now dealing with slices intead of full tables, the l2_table
> variable is renamed for clarity.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--psayIZYGbKSSURUnhWtf4hGscFDAqygDp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpmS/YACgkQp6FrSiUn
Q2rpvwf7BG9rBLiyLsXzdssCIKemTg3wl2LnAC5gu1GUk0fq7SUSstzQYbCOvaW0
gxrkYHByutB1m5IsY5pHcUfo0ROORxq/EEuSv17KcflnPHA2dv0RIIgnClcDfezn
YQ+raYOuEKYeHxVsCmxQfVqQ1bfztKxjkOCU57CcJfJSqUUyygbF1wAJU0QZtML/
OWUnluhsdlq3lb+oaJ6bUpWshhunQ7P5OP1BuG+LOXZArScWKMOnSL4mEPwegCsj
8WWDeziSaLZnICFtBZDD8tGhve7fR5I38oGuT50bDUjLUw42qn4M7sb9miQwsy66
JQiWl5RXsdXmUW0FheLapKD7417hVQ==
=ViWG
-----END PGP SIGNATURE-----

--psayIZYGbKSSURUnhWtf4hGscFDAqygDp--
