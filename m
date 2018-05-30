Received: from eggs.gnu.org ([2001:4830:134:3::10]:56409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO6zc-0000om-Ap
	for qemu-devel@nongnu.org; Wed, 30 May 2018 15:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO6za-0007Yg-RC
	for qemu-devel@nongnu.org; Wed, 30 May 2018 15:42:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36420 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fO6za-0007YK-LG
	for qemu-devel@nongnu.org; Wed, 30 May 2018 15:42:42 -0400
Date: Wed, 30 May 2018 20:20:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180530192046.GO14623@stefanha-x1.localdomain>
References: <20180529193730.9204-1-crosa@redhat.com>
	<20180529193730.9204-6-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hOh8F6DNH/RZBSFD"
Content-Disposition: inline
In-Reply-To: <20180529193730.9204-6-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] Acceptance tests: add Linux kernel
 boot and console checking test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>


--hOh8F6DNH/RZBSFD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2018 at 03:37:30PM -0400, Cleber Rosa wrote:
> This test boots a Linux kernel, and checks that the given command
> line was effective in two ways:
>=20
>  * It makes the kernel use the set "console device" as a console
>  * The kernel records the command line as expected in the console
>=20
> Given that way too many error conditions may occur, and detecting the
> kernel boot progress status may not be trivial, this test relies on a
> timeout to handle unexpected situations.  Also, it's *not* tagged as a
> quick test for obvious reasons.
>=20
> It may be useful, while interactively running/debugging this test, or
> tests similar to this one, to show some of the logging channels.
> Example:
>=20
>  $ avocado --show=3DQMP,console run boot_linux_console.py
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/acceptance/boot_linux_console.py | 47 ++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 tests/acceptance/boot_linux_console.py

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--hOh8F6DNH/RZBSFD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbDvmOAAoJEJykq7OBq3PI8DIH/2+Hb8DEo3JdtY1GGJth6oWN
U0FCUvOjY0Nf8WIwebuKOfbOxyMemZKxTV5KyPvy52f+raz0GBwKedLogHNm7+Mb
puWFf9HNyIXHaf3E53JSvoZZDhWlMLnAagdnWiaAq7JotrD5X5K1W2vFmgJ13Qs+
9NKmoBrKdtSd+2RwdvxcyyvBHBFSbo5JJ0J2lMdxcPrECQhVUpzA/rNDBFTTT727
P3nl9UVRhZ59NuLEc9RyOJc9DrILbY/dbfU3Qivi5ybazoXZVSryO8rCk2H5pObl
QrAvh4eK3KWH3OHBWUB+97C32SXTTlCMaz8mo615OZ61YO2vm9W2gCsygtm9W+c=
=iA7m
-----END PGP SIGNATURE-----

--hOh8F6DNH/RZBSFD--
