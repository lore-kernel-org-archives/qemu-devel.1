Received: from eggs.gnu.org ([2001:4830:134:3::10]:44695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fwlMx-0001zH-68
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fwlMv-0003PO-HK
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:42:03 -0400
References: <20180831222907.16257-1-jsnow@redhat.com>
	<20180831222907.16257-11-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3db28f8f-e93d-ab92-5725-e9aa04fe2dd6@redhat.com>
Date: Mon, 3 Sep 2018 11:41:43 +0200
MIME-Version: 1.0
In-Reply-To: <20180831222907.16257-11-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4ZYxeDOQA3Mq5Kvi5EIRC412ZqvzBjn96"
Subject: Re: [Qemu-devel] [PATCH v3 10/15] tests/test-blockjob-txn: move
 .exit to .clean
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jtc@redhat.com, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4ZYxeDOQA3Mq5Kvi5EIRC412ZqvzBjn96
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jtc@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>
Message-ID: <3db28f8f-e93d-ab92-5725-e9aa04fe2dd6@redhat.com>
Subject: Re: [PATCH v3 10/15] tests/test-blockjob-txn: move .exit to .clean
References: <20180831222907.16257-1-jsnow@redhat.com>
 <20180831222907.16257-11-jsnow@redhat.com>
In-Reply-To: <20180831222907.16257-11-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-01 00:29, John Snow wrote:
> The exit callback in this test actually only performs cleanup.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/test-blockjob-txn.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--4ZYxeDOQA3Mq5Kvi5EIRC412ZqvzBjn96
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluNAdcACgkQ9AfbAGHV
z0AxFQf/fVjxnX9mObjIALVCESuxW0ayp2IHsbn5Wq/Ygj2m3BhzXkJE2wx8tE/t
Llo5wV+nS3DKmzZWjn6BtZaDuIti8ZGuAKoZvNHO0z9skxvhQdyXgAuq9bDityJM
xGvH3qmSteIvnAG6y1Ofp+OHH+JDMv31bLGzQDuqI1qha+kmHEF2MbeAi0/CUeZM
X5nBS15wPqQAw4j1p1rCVXzSVLXYuKZ3ktL0etvwSEZGTyFRYARxIrSUUKjznkmk
s1aXD8IScwHxOFSmPeex/QAXgnJPuG6RdSodDr88dDCS94SvIAgQWvXFilQJMz6v
M6j3Yk6To3eASDcdjc5Tc/5bEW/cFA==
=e8uX
-----END PGP SIGNATURE-----

--4ZYxeDOQA3Mq5Kvi5EIRC412ZqvzBjn96--
