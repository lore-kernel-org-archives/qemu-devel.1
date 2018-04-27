Received: from eggs.gnu.org ([2001:4830:134:3::10]:43148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fC2Oo-0001VM-GF
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fC2Ol-0002Yp-C7
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:22:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33142 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fC2Ol-0002YP-7L
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:22:47 -0400
Date: Fri, 27 Apr 2018 11:07:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180427100754.GC6999@stefanha-x1.localdomain>
References: <20180425070103.23723-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline
In-Reply-To: <20180425070103.23723-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] checkpatch.pl: add common glib defines
 to typelist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Fam Zheng <famz@redhat.com>


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 03:01:03PM +0800, Peter Xu wrote:
> Otherwise it can warn this:
>=20
>   ERROR: space prohibited between function name and open parenthesis '('
>=20
> When with things like this:
>=20
>   typedef gboolean (*it_tree_iterator)(ITValue start, ITValue end);
>=20
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: "Daniel P. Berrang=E9" <berrange@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Fam Zheng <famz@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v2:
> - add more missing glib types [Markus]
> ---
>  scripts/checkpatch.pl | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa4vZ6AAoJEJykq7OBq3PIekoIAIy+M3m9+qNWAsRiNzkLLRYX
kxvuhpMGeisSran7ZiA6QAikC9K9WMXC9Gd3YK19nSquUNuT9AgkaqpqWprGzgA0
7xEcdjjSHKAnUJNjQ3MUXeG3D1XsnVbNXRaN9ihMFNN6D0/VthTTYOp3KYP5QOU0
gQLr5oCGvDPsdoKUNZ70zOejntUcrdDNHl7kkDdV5YL97+u/JGuAIQ5o7DnaDLRQ
JUCaHkgjrl5o8AY8FOLoLDF0Uvqusx5DPvv5CRKU1F+2Gmn/6BDohWx4FdIha+t/
QhZyOsXt0NyqmHTRi0Kl4+M5iIOsmLHpHKbRfthXA/77s3OfmGAqA0nwTT7Yhx8=
=bFMS
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--
