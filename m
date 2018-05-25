Received: from eggs.gnu.org ([2001:4830:134:3::10]:58881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fMEfQ-0007rs-FI
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:30:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fMEfP-0007WA-Oi
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:30:08 -0400
Date: Fri, 25 May 2018 16:30:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180525153001.GF21895@stefanha-x1.localdomain>
References: <20180523030436.29097-1-famz@redhat.com>
	<20180523030436.29097-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RE3pQJLXZi4fr8Xo"
Content-Disposition: inline
In-Reply-To: <20180523030436.29097-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 02/10] raw: Check byte range uniformly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, eblake@redhat.com


--RE3pQJLXZi4fr8Xo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 23, 2018 at 11:04:28AM +0800, Fam Zheng wrote:
> We don't verify the request range against s->size in the I/O callbacks
> except for raw_co_pwritev. This is wrong (especially for
> raw_co_pwrite_zeroes and raw_co_pdiscard), so fix them.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/raw-format.c | 64 +++++++++++++++++++++++++++++++++---------------=
------
>  1 file changed, 39 insertions(+), 25 deletions(-)

The uint64_t vs int64_t inconsistency is ugly but pre-existing due to
the interfaces:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbCCv5AAoJEJykq7OBq3PITToIAKk1OahvmKMj7SeyERKx8IBN
nbq9Wxf1zRVScbqpLILasVjLHt7GPjrms4vKbQkrC4czzPRXAj2kuv8bv2qF1clN
oTFDw6QtAenEC4trDlV4D7WOb1WIMssKg6zCjMKRj1rKL2j/8DXh5XWeUS4vsPaZ
av6M1uLoJ38JFrEPgQopfsyMp72ClpmkhmOKV782Lba4kPXOWzz9rZinMnQZLOVu
zU2/Ox9n+tXnaWv682RQea/QZaQAYfIA84gk5qEx7aCp2M3RnMH8Mm9ZDGefDbj6
QCVht3AWvj40joEpicPWb/J/yPH9gxPHYX1ygnoZP40yvDZRrzosEUoSYAeBwks=
=9BVN
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--
