Received: from eggs.gnu.org ([2001:4830:134:3::10]:33441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePSqc-0003pd-Ph
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:42:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePSqZ-00009k-L0
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:42:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePSqZ-00008x-EH
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:42:43 -0500
Date: Thu, 14 Dec 2017 12:42:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171214124234.GH14433@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-20-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Enx9fNJ0XV5HaWRu"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-20-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 19/26] qapi: introduce new cmd option
 "allow-oob"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--Enx9fNJ0XV5HaWRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:51:53PM +0800, Peter Xu wrote:
> Here "oob" stands for "Out-Of-Band".  When "allow-oob" is set, it means
> the command allows out-of-band execution.
>=20
> The "oob" idea is proposed by Markus Armbruster in following thread:
>=20
>   https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02057.html
>=20
> This new "allow-oob" boolean will be exposed by "query-qmp-schema" as
> well for command entries, so that QMP clients can know which command can
> be used as out-of-band calls. For example the command "migrate"
> originally looks like:
>=20
>   {"name": "migrate", "ret-type": "17", "meta-type": "command",
>    "arg-type": "86"}
>=20
> And it'll be changed into:
>=20
>   {"name": "migrate", "ret-type": "17", "allow-oob": false,
>    "meta-type": "command", "arg-type": "86"}
>=20
> This patch only provides the QMP interface level changes.  It does not
> contains the real out-of-band execution implementation yet.
>=20
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qapi/qmp/dispatch.h    |  1 +
>  qapi/introspect.json           |  6 +++++-
>  scripts/qapi-commands.py       | 19 ++++++++++++++-----
>  scripts/qapi-introspect.py     | 10 ++++++++--
>  scripts/qapi.py                | 15 ++++++++++-----
>  scripts/qapi2texi.py           |  2 +-
>  tests/qapi-schema/test-qapi.py |  2 +-
>  7 files changed, 40 insertions(+), 15 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Enx9fNJ0XV5HaWRu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMnG6AAoJEJykq7OBq3PIgOoH/0bO8laELx/Wewlku01z3Awz
a05BKo3G9IexrMflxbqjxBGu5G2htAn9pVroif8ETuS8cWkSkiTLcmVX9xfG4xek
naSe1Bj14pGgWU55dbsw6yyjDUtpnVLCNHulYwsDPbe1kCY+VVn4l2BcZP2F1K3u
94z10aqKvpBI0ldOkUNXzLsN6U7/2dt96GiVz9u+7KURSjQsTUTY3rH0JMq/E4uN
QaXFI1nReSZmxzJJTGsHigzM0LxnamZzOE2wC/NNB+/xVvj7rNbhS0eRmKUc784h
c7QLyYRDgDtaCiWACbOmJ8WUXG1wa7Db+QotZrgUd+IOxPxq/MdRTCyw8KMSNpE=
=2OyI
-----END PGP SIGNATURE-----

--Enx9fNJ0XV5HaWRu--
