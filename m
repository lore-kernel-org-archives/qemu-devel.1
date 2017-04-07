Received: from eggs.gnu.org ([2001:4830:134:3::10]:37668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwTwk-0004et-DF
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwTwj-0003Zm-ES
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:29:02 -0400
Date: Fri, 7 Apr 2017 14:28:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170407132850.GG16146@stefanha-x1.localdomain>
References: <20170407065414.9143-1-famz@redhat.com>
	<20170407065414.9143-7-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AGZzQgpsuUlWC1xT"
Content-Disposition: inline
In-Reply-To: <20170407065414.9143-7-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/6] tests/block-job-txn: Don't start
 block job before adding to txn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, jsnow@redhat.com


--AGZzQgpsuUlWC1xT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2017 at 02:54:14PM +0800, Fam Zheng wrote:
> Previously, before test_block_job_start returns, the job can already
> complete, as a result, the transactional state of other jobs added to
> the same txn later cannot be handled correctly.
>=20
> Move the block_job_start() calls to callers after
> block_job_txn_add_job() calls.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/test-blockjob-txn.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

CCing John Snow because he looked at block jobs completing during txn
setup recently.

Stefan

--AGZzQgpsuUlWC1xT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY55QSAAoJEJykq7OBq3PI4IoH/0gBAxJ236obMQIVVBSP+7JS
na4gAKwqdQCZ8v+NfuJU5Y3dgDLuPVuKz1jVqMTnL9/x4eTX1NUQ6U42BE5h6XQR
gw9WnhWdDZtis5diX0WrqIHboStIjSF1CFhwNpY+isyg0UBEYz/F2GxOx/BQGYGI
sH2dFWQXIQIB+Fyefd3yzTtuNwVrJ3HhVJSACreXeMBaV4k9H0oxyGP3uQumOG4H
IOUSRG51NGy0yStiuRhp3HWxcuCYm+Q1bBwVWmYUdze118unHyJMkb+bRQzJ/826
9FSvJdALj2rmr4+EzSRSa3IXRAkE36W8Bl0N+oYO7C4QJ+1c3GL3NcKHIMWM9Qw=
=hqEP
-----END PGP SIGNATURE-----

--AGZzQgpsuUlWC1xT--
