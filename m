Received: from eggs.gnu.org ([2001:4830:134:3::10]:53062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fyQ05-0006Qx-0q
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 19:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fyPzz-0002I2-IO
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 19:17:16 -0400
References: <20180906130225.5118-1-jsnow@redhat.com>
	<20180906130225.5118-7-jsnow@redhat.com>
	<20180906165720.GD22117@localhost.localdomain>
	<f6dd0243-9b91-e151-c547-007f6bed03ee@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f7b12c9d-4637-db46-a275-419f8d91cf38@redhat.com>
Date: Sat, 8 Sep 2018 01:16:56 +0200
MIME-Version: 1.0
In-Reply-To: <f6dd0243-9b91-e151-c547-007f6bed03ee@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PI3p28YYB4sQ8ZTiJeZEbAKDRqDMOVzWl"
Subject: Re: [Qemu-devel] [PATCH v5 06/16] block/mirror: conservative
 mirror_exit refactor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PI3p28YYB4sQ8ZTiJeZEbAKDRqDMOVzWl
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Message-ID: <f7b12c9d-4637-db46-a275-419f8d91cf38@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 06/16] block/mirror: conservative
 mirror_exit refactor
References: <20180906130225.5118-1-jsnow@redhat.com>
 <20180906130225.5118-7-jsnow@redhat.com>
 <20180906165720.GD22117@localhost.localdomain>
 <f6dd0243-9b91-e151-c547-007f6bed03ee@redhat.com>
In-Reply-To: <f6dd0243-9b91-e151-c547-007f6bed03ee@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-06 22:31, John Snow wrote:
>=20
>=20
> On 09/06/2018 12:57 PM, Jeff Cody wrote:
>> On Thu, Sep 06, 2018 at 09:02:15AM -0400, John Snow wrote:
>>> For purposes of minimum code movement, refactor the mirror_exit
>>> callback to use the post-finalization callbacks in a trivial way.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  block/mirror.c | 39 ++++++++++++++++++++++++++++-----------
>>>  1 file changed, 28 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/block/mirror.c b/block/mirror.c
>>> index bd3e908710..a92b4702c5 100644
>>> --- a/block/mirror.c
>>> +++ b/block/mirror.c
>>> @@ -79,6 +79,7 @@ typedef struct MirrorBlockJob {
>>>      int max_iov;
>>>      bool initial_zeroing_ongoing;
>>>      int in_active_write_counter;
>>> +    bool prepared;
>>>  } MirrorBlockJob;
>>> =20
>>>  typedef struct MirrorBDSOpaque {
>>> @@ -607,7 +608,7 @@ static void mirror_wait_for_all_io(MirrorBlockJob=
 *s)
>>>      }
>>>  }
>>> =20
>>> -static void mirror_exit(Job *job)
>=20
> /**
>  * mirror_exit_common: handle both abort() and prepare() cases.
>  * for .prepare, returns 0 on success and -errno on failure.
>  * for .abort cases, denoted by abort =3D true, MUST return 0.
>  */

Any case:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--PI3p28YYB4sQ8ZTiJeZEbAKDRqDMOVzWl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluTBugACgkQ9AfbAGHV
z0CEgQf/dlvineNOYx4JjUw3mYrmAD+qk2vIKJqIrIvehtSvx28TyGxpsPIwiW40
a8pgaSML7wxTxQkkq6fhanp7grJ1DKbY2kHa0oezHVX03+WP77jpUlYTe4UkmAFy
zg1flze+1hIyCg1oFpkWL0VEqUO5op4nhb0o/i1maMDdtzIiBjtIOmfC8WwYk99W
4FmEWghFa7gJBNH8S16zxYyolzOGrapEYbqRl+iVZgBft584QUqfDEMu56BQChCK
bz7t7YaZ5wsSINRHLQLJX/A+WQftawEM8TvP1yKfTz42PRJjLuwdOczAXg2QeFRY
9BIpky2meBxzzvOp8eeRU9xlXItffA==
=2fXy
-----END PGP SIGNATURE-----

--PI3p28YYB4sQ8ZTiJeZEbAKDRqDMOVzWl--
