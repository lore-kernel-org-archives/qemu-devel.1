Received: from eggs.gnu.org ([2001:4830:134:3::10]:54625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuHha-0006kg-2r
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 09:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuHhZ-0001RC-9L
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 09:37:06 -0400
References: <20180823222249.13518-1-jsnow@redhat.com>
	<20180823222249.13518-8-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <35e51256-ac63-7149-1097-0d6a5d480108@redhat.com>
Date: Mon, 27 Aug 2018 15:36:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180823222249.13518-8-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pPcsm6aNAQqavFfzffSCBpLyMtgEyqXSv"
Subject: Re: [Qemu-devel] [PATCH v2 07/13] tests/blockjob: replace Blockjob
 with Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pPcsm6aNAQqavFfzffSCBpLyMtgEyqXSv
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com,
 Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <35e51256-ac63-7149-1097-0d6a5d480108@redhat.com>
Subject: Re: [PATCH v2 07/13] tests/blockjob: replace Blockjob with Job
References: <20180823222249.13518-1-jsnow@redhat.com>
 <20180823222249.13518-8-jsnow@redhat.com>
In-Reply-To: <20180823222249.13518-8-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-24 00:22, John Snow wrote:
> These tests don't actually test blockjobs anymore, they test
> generic Job lifetimes. Change the types accordingly.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/test-blockjob.c | 98 ++++++++++++++++++++++++++-----------------=
--------
>  1 file changed, 50 insertions(+), 48 deletions(-)

So, uh, it's just a test-job now, basically...  Well, apart from the
BlockBackends created to test the ID error paths.

Reviewed-by: Max Reitz <mreitz@redhat.com>


--pPcsm6aNAQqavFfzffSCBpLyMtgEyqXSv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluD/nIACgkQ9AfbAGHV
z0CUXgf/RhWmRUm5Zwq6ssdWTwWyXUViJpaM4S8uJEnC4p4HOpJR8qWl5HuDeax1
JPiho0XagNv78VKHEexAeE7fRZ4KnIcC8k/zd/OUZaXi7qGAz630fc71SjOiYbMx
1Lw2lCtNV0av2cTNPrpmdmCCFrJcQYEbmkNqPtAHjuIfvVpwHiyxlCJXL0NSYkw4
cUumDHPZT+Z1UtfFCEAR4xK+beHIG5Mk9fQqKpMsRas4ElfgfpoNS9wZHnyHO/+q
wCu4uRyeEcAMtL9vIu9rW+RzEcPzAK+TdUqFOJhlljOsbLeOlsM6BEQcgdaPK3EC
avrVNSWzcctQjLqTYwgEVqeqjiXvvg==
=e16g
-----END PGP SIGNATURE-----

--pPcsm6aNAQqavFfzffSCBpLyMtgEyqXSv--
