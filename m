Received: from eggs.gnu.org ([2001:4830:134:3::10]:36991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehhrX-0001bO-QH
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 15:23:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehhrU-0003qp-JX
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 15:23:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ehhrU-0003po-9t
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 15:23:04 -0500
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-10-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1ec446ca-a469-7950-bea1-c832cbaf9fa3@redhat.com>
Date: Fri, 2 Feb 2018 14:22:59 -0600
MIME-Version: 1.0
In-Reply-To: <20180202130336.24719-10-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lg4yQgbh53UtEg2LHLEBJAJLlGWkjDThC"
Subject: Re: [Qemu-devel] [PATCH RFC 09/21] qapi: Don't absolutize include
 file name in error messages
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
--lg4yQgbh53UtEg2LHLEBJAJLlGWkjDThC
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <1ec446ca-a469-7950-bea1-c832cbaf9fa3@redhat.com>
Subject: Re: [PATCH RFC 09/21] qapi: Don't absolutize include file name in
 error messages
References: <20180202130336.24719-1-armbru@redhat.com>
 <20180202130336.24719-10-armbru@redhat.com>
In-Reply-To: <20180202130336.24719-10-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 07:03 AM, Markus Armbruster wrote:
> Error messages print absolute filenames of included files even gave a

s/even gave/even when given/

> relative one on the command line:
>=20
>      PYTHONPATH=3Dscripts python -B tests/qapi-schema/test-qapi.py test=
s/qapi-schema/include-cycle.json
>     In file included from tests/qapi-schema/include-cycle.json:1:
>     In file included from /work/armbru/qemu/tests/qapi-schema/include-c=
ycle-b.json:1:
>     /work/armbru/qemu/tests/qapi-schema/include-cycle-c.json:1: Inclusi=
on loop for include-cycle.json
>=20
> Improve this to
>=20
>     In file included from tests/qapi-schema/include-cycle.json:1:
>     In file included from tests/qapi-schema/include-cycle-b.json:1:
>     tests/qapi-schema/include-cycle-c.json:1: Inclusion loop for includ=
e-cycle.json

Nice, and makes developing new qapi tests a little less painful since
it's less modification to qapi-schema/*.err additions.

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi/common.py                | 12 ++++++------
>  tests/qapi-schema/include-no-file.err |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lg4yQgbh53UtEg2LHLEBJAJLlGWkjDThC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0yKMACgkQp6FrSiUn
Q2o7bAgAlffxHHxLQuLH/MiiNgrcJ+CS1AImC687Y/IDs2BCtOjlkwrAUZDIs8Tw
zbGaWf5S5l3PJNT6hwZ3Rwk4ZaMaaf25lkcem6d/ms4m812kd77uoy0Ev2ReaSPU
6s2T+NajpB3n1uhynFtilVO4sI7CLmY5d8ZD1dTt1CpongOloVmh3cDljPectGUA
1vxN4imTRWRJ91PDlgTqj+fbXrkGChVLB/3tlcsMDdndgF9vKGdz+SY2+jf2rDqf
dmg8ZeBjVfJU4DZswJFQTFVhtiWtYDoNzwDt9tARaif+BEyiHxzk4KNjJcJ318k7
3csSRmbdiJCAj+GKh5XATl0PvuUl3w==
=e1+R
-----END PGP SIGNATURE-----

--lg4yQgbh53UtEg2LHLEBJAJLlGWkjDThC--
