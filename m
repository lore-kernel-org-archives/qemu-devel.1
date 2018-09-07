Received: from eggs.gnu.org ([2001:4830:134:3::10]:54318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fyQ6b-0001pQ-F3
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 19:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fyQ6a-0005hP-Qd
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 19:24:01 -0400
References: <20180906130225.5118-1-jsnow@redhat.com>
	<20180906130225.5118-17-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <79a8d362-80c7-21fd-cf39-7a4b39d82498@redhat.com>
Date: Sat, 8 Sep 2018 01:23:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180906130225.5118-17-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6gknMEQWalX0JvtIL7ZVfbS60KzhGCH2P"
Subject: Re: [Qemu-devel] [PATCH v5 16/16] blockdev: document transactional
 shortcomings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: jtc@redhat.com, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6gknMEQWalX0JvtIL7ZVfbS60KzhGCH2P
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: jtc@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Jeff Cody <jcody@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <79a8d362-80c7-21fd-cf39-7a4b39d82498@redhat.com>
Subject: Re: [PATCH v5 16/16] blockdev: document transactional shortcomings
References: <20180906130225.5118-1-jsnow@redhat.com>
 <20180906130225.5118-17-jsnow@redhat.com>
In-Reply-To: <20180906130225.5118-17-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-06 15:02, John Snow wrote:
> Presently only the backup job really guarantees what one would consider=

> transactional semantics. To guard against someone helpfully adding them=

> in the future, document that there are shortcomings in the model that
> would need to be audited at that time.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  blockdev.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--6gknMEQWalX0JvtIL7ZVfbS60KzhGCH2P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluTCIMACgkQ9AfbAGHV
z0D2mwgAgIJnIV1S2XER2NGJPNbnUbACo4gWBl6bqN+2UCtuDwFOv5Ijby8dqjdn
5thkg4fyM12glmHl5sSLycs+eJOa34bTl1Xs1vTyfGZxHudT8KJISDWLjwVq8U4/
QD2BDZtThqm/a6xH/vo7TUXonrdE9dzTcRaPtwavE5aeSwPTVR4TQsWXaPNMYQ73
sZaQVCqYmiJQWx0CusfrkbZRbyeRI3hS3QoZaxhnwXR4m4oGDTUEkwwnza7NJLKe
WPZ9pxOQwqGpCpqVmc1z67MYXJ1uMOIhzIrB0qQ99tB8o4l8LF3CRCZAsD7A9kS1
kCdLDdnfPbezEo+kpK12cno2OJN3AA==
=6HRk
-----END PGP SIGNATURE-----

--6gknMEQWalX0JvtIL7ZVfbS60KzhGCH2P--
