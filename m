Received: from eggs.gnu.org ([2001:4830:134:3::10]:53515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dc9Zk-00075g-ND
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dc9Zj-0005re-Ln
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:13:32 -0400
References: <cover.1501477080.git.jcody@redhat.com>
	<03558ebe46550c94a977bb4bb09555cec5dac022.1501477080.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <90252afd-bc1c-2652-9e8e-9460a0d394bc@redhat.com>
Date: Mon, 31 Jul 2017 07:03:52 -0500
MIME-Version: 1.0
In-Reply-To: <03558ebe46550c94a977bb4bb09555cec5dac022.1501477080.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="t1PDikdAapp4jUPrSpDiumdkRHs4SJlGe"
Subject: Re: [Qemu-devel] [PATCH for-2.11 1/3] qemu-iotests: set TEST_DIR to
 a unique dir for each test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t1PDikdAapp4jUPrSpDiumdkRHs4SJlGe
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, jsnow@redhat.com
Message-ID: <90252afd-bc1c-2652-9e8e-9460a0d394bc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 1/3] qemu-iotests: set TEST_DIR to a
 unique dir for each test
References: <cover.1501477080.git.jcody@redhat.com>
 <03558ebe46550c94a977bb4bb09555cec5dac022.1501477080.git.jcody@redhat.com>
In-Reply-To: <03558ebe46550c94a977bb4bb09555cec5dac022.1501477080.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/31/2017 12:04 AM, Jeff Cody wrote:
> Right now, all qemu-iotests output data into the same scratch directory=
,
> and so each tests needs to be responsible for cleanup up its own files.=


And, tests must either use unique names or else cannot be run in parallel=
=2E

>=20
> Have each test use 'scratch/$seq' as its temp directory, so the check
> script can do simple cleanup of removing the whole temporary directory.=


It also makes it much nicer for a potential future patch to parallelize
things, now that every tests' temporary files are uniquely named by
virtue of the subdirectory.

>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  tests/qemu-iotests/check | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>=20


> @@ -300,13 +301,23 @@ do
>          fi
>          export OUTPUT_DIR=3D$PWD
>          if $debug; then
> -            (cd "$source_iotests";
> +            (
> +            cd "$source_iotests";

Pre-existing; but we should check that the 'cd' succeeded (if not, the
rest of the code is at risk of doing things in the wrong directory).

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--t1PDikdAapp4jUPrSpDiumdkRHs4SJlGe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll/HKgACgkQp6FrSiUn
Q2qoEwf5AdzSZGGvFZ8IWMNhb3CUci224wFTghScsfw/atVh/SFJ4tZvo+wRMqhy
dDO2c6KDFTBINLVjs44aV6dIhkDR/Cd/9VQtm5pmC2WdDchakRmJSPy83VVj7XNc
HWTOcGJeHcg0Hv48AOVJ2ugeUdP9+r9Mm9gEbfPD09P02JZoJBDkjCgL7RI8Scb8
Zf8rgjK6/9GcOLiIW33gomX1DaVayIhtrmJ6i5AdafSqBmwMDaiip+4a5HxVBoi0
bRN4QhyLE8s2KKwlXfcI/TToBAWSWHOvJjbd8EU+3P32aHAPPlw6ZDJwNBV+Dsgq
aqi7QEP/FFoZGqqsNO1VuhKaI05NqQ==
=Bw6x
-----END PGP SIGNATURE-----

--t1PDikdAapp4jUPrSpDiumdkRHs4SJlGe--
