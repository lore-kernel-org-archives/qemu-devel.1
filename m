Received: from eggs.gnu.org ([2001:4830:134:3::10]:38780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehL2A-0000dm-TW
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:01:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehL16-0000tW-VH
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:00:34 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<39c501933ab5eda5c439d082d182f0b1f571eba0.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <648ecd44-ce57-dd32-e26c-09f89bb86c58@redhat.com>
Date: Thu, 1 Feb 2018 20:50:17 +0100
MIME-Version: 1.0
In-Reply-To: <39c501933ab5eda5c439d082d182f0b1f571eba0.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="y8wux93EEVJQbsI6z2nCt47v6QreuX7J0"
Subject: Re: [Qemu-devel] [PATCH v3 35/39] qcow2: Rename l2_table in
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--y8wux93EEVJQbsI6z2nCt47v6QreuX7J0
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <648ecd44-ce57-dd32-e26c-09f89bb86c58@redhat.com>
Subject: Re: [PATCH v3 35/39] qcow2: Rename l2_table in count_cow_clusters()
References: <cover.1516978645.git.berto@igalia.com>
 <39c501933ab5eda5c439d082d182f0b1f571eba0.1516978645.git.berto@igalia.com>
In-Reply-To: <39c501933ab5eda5c439d082d182f0b1f571eba0.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 16:00, Alberto Garcia wrote:
> This function doesn't need any changes to support L2 slices, but since
> it's now dealing with slices intead of full tables, the l2_table
> variable is renamed for clarity.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cluster.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--y8wux93EEVJQbsI6z2nCt47v6QreuX7J0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpzb3kSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AQ3kH+wULEdFD6z0X3cY5tHVzJGRR4Yq/UcDL
h6YHT9JLUPFJY2f6H58CJAgAWOL82O3fn0EFw1ZEU/SM/ujtb/LTgB7nkXPy0v44
yDky1ZIBKkZn7UTsS0QwNurz5Q7wyGDH9OphFTSBsIqtO6CfJczxxGmoHk0/Znsc
BwSJl7+Zd0QYgEONnueDz0hvz6M7vciJU9HfIfzJDAxZdeAVtA9ECjmIt4smohd3
NLBoIsqnmoDqYDCJHnsaZ+7dlOgKTz7JFXearce66RPbqXbaVjF3JbSQjbVvvh85
L7nCG3PgiYkmqcUZOLlI0/MSgYZxhPIx3eQntoPmOj/qJkU3cTVw71E=
=lpGN
-----END PGP SIGNATURE-----

--y8wux93EEVJQbsI6z2nCt47v6QreuX7J0--
