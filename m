Received: from eggs.gnu.org ([2001:4830:134:3::10]:35115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cr7AR-0003tb-RH
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:09:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cr7AM-0005he-4z
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:08:59 -0400
Date: Thu, 23 Mar 2017 18:08:44 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170323180844.GJ12560@stefanha-x1.localdomain>
References: <20170322210005.16533-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/0U0QBNx7JIUZLHm"
Content-Disposition: inline
In-Reply-To: <20170322210005.16533-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.9?] file-posix: Make
 bdrv_flush() failure permanent without O_DIRECT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org


--/0U0QBNx7JIUZLHm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 10:00:05PM +0100, Kevin Wolf wrote:
> Success for bdrv_flush() means that all previously written data is safe
> on disk. For fdatasync(), the best semantics we can hope for on Linux
> (without O_DIRECT) is that all data that was written since the last call
> was successfully written back. Therefore, and because we can't redo all
> writes after a flush failure, we have to give up after a single
> fdatasync() failure. After this failure, we would never be able to make
> the promise that a successful bdrv_flush() makes.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/file-posix.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/0U0QBNx7JIUZLHm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY1A8sAAoJEJykq7OBq3PICYYIAMlSdjPcCQmXED1q2tVAoMss
NE+ZVJ18Bmzojwi539f2Knefy4QWbVJ1Mc2LjCIUEVOqHzDcTotP3KBcXIXPfuk6
2cM9AYFC1t3efsgKoo5rWLsmOZZrwwi9Uu/sy+6ihz0dcYY+bzDJ+Hd0sdBuLA4q
mQE2F8aRrsYI0SHuA8oE2FgPgV9+krAjskhGuXEDGcAE96POFYnCieInl8sd8PHa
H84VR6WXyWsjDetHXAfZdSs03pUFDGKCyr4UE9v6Lb9nAUwDjVvKEeIYkTPBGZjS
t34+eSo9WR/JzB8HoNK4DKi0xYyTjDWEXdmmAIn7ByHAwOHmB1H22n9l9cGnlPs=
=rpBD
-----END PGP SIGNATURE-----

--/0U0QBNx7JIUZLHm--
