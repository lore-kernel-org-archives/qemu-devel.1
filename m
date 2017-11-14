Received: from eggs.gnu.org ([2001:4830:134:3::10]:36739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEd9w-0002Rq-SA
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:29:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEd9w-0004aG-2G
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:29:56 -0500
References: <cover.1510059970.git.jcody@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <aac559b2-36bd-05af-68b2-1e92cbc068f9@redhat.com>
Date: Tue, 14 Nov 2017 16:29:43 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1510059970.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="N85cxSvf8BhMX1xAEPGU9QNUOluxeAEsK"
Subject: Re: [Qemu-devel] [PATCH v4 0/4] Don't write headers if BDS is
 INACTIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, aik@ozlabs.ru, den@openvz.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N85cxSvf8BhMX1xAEPGU9QNUOluxeAEsK
From: Max Reitz <mreitz@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, aik@ozlabs.ru, den@openvz.org,
 stefanha@redhat.com
Message-ID: <aac559b2-36bd-05af-68b2-1e92cbc068f9@redhat.com>
Subject: Re: [PATCH v4 0/4] Don't write headers if BDS is INACTIVE
References: <cover.1510059970.git.jcody@redhat.com>
In-Reply-To: <cover.1510059970.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-07 14:10, Jeff Cody wrote:
> Changes from v3->v4:
>=20
> Patch 3: Add migrate_del_blocker and error_free (Thanks Stefan)

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--N85cxSvf8BhMX1xAEPGU9QNUOluxeAEsK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloLC+cSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AYq0IAIJLCqJzzX4DBNOoHjzzKkHO4N0ZsrBn
OnomyFPp37qoyib8pTaGbluVVwxUIyLciKPamnMFbWe8J0DbKGdSwT+LwzkBomYd
qxeq89tKpxbBMlaGO72dL6Y7BRE9rOyVqJib/AGTW2QjeJu0FhgvFqHkOiWDc9Qm
8rzTrHiRnvnSg6FK5mJeMCMqdQyuh0y8YC/jV+eeytKN7o1WCoSF8qqIsDbJ951Z
GW+aWlXcMaBqBsmQW69eK4+EzrsYTLXYTDZkSoPI/eCwQdQ7egKhpKv2x/Ynqimo
K5u8igqrcrIaPURFfjTGFeYM5xF5G+R++t1ryXgLaz8pequxQqYGuBg=
=n896
-----END PGP SIGNATURE-----

--N85cxSvf8BhMX1xAEPGU9QNUOluxeAEsK--
