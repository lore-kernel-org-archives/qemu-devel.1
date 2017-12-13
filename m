Received: from eggs.gnu.org ([2001:4830:134:3::10]:42126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eP9I4-0006YZ-0A
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:49:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eP9I3-0004Xx-5p
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:49:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eP9I2-0004Xc-VK
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:49:47 -0500
Date: Wed, 13 Dec 2017 15:49:42 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171213154942.GI7173@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-9-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o7gdRJTuwFmWapyH"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-9-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 08/26] monitor: let mon_list be tail queue
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


--o7gdRJTuwFmWapyH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:51:42PM +0800, Peter Xu wrote:
> It was QLIST.  I want to use this list to do monitor priority job later,
> which need tail insertion ability.  So switching to a tail queue.
>=20
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--o7gdRJTuwFmWapyH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMUwWAAoJEJykq7OBq3PI6k0H/2Xz62rWxvVwyFvL7i7EZWqM
4iibiTOfDs3zrEYsbC+kvQ0M5EoHOHIa6TYica6PmreHLCUSf8BBrWWOzQttWvrF
3upGuIxQ84AydtHuIcjC+An1DnHo55/RD9DpqymakjB9dpERxlwDdmZV2Su/siwL
oiqBsu7smmxJvcwyVDZyGCMn6Bnz3rOV1hROLXxvZyZh8VGEHxenpAxkVB6ouIwH
eNRiqJhyd3dwbZeNvOkom6panHmpGT9ICv4rx0+7g//sRkgG5L5PHpfUgMrea4C7
9sTqBBb8pB6EK72V36AB2/UGgsH6QlcWORirV1B0yiU3bVsnQ/POXC7JHS3lpbs=
=WCZR
-----END PGP SIGNATURE-----

--o7gdRJTuwFmWapyH--
