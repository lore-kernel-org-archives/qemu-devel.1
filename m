Received: from eggs.gnu.org ([2001:4830:134:3::10]:56204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwZrF-0007ti-8O
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwZrE-00066T-A3
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:20:01 -0400
References: <20170925122808.14561-1-kwolf@redhat.com>
	<20170925122808.14561-5-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c58176c1-09c7-fa47-baec-ce287bca1264@redhat.com>
Date: Mon, 25 Sep 2017 15:19:52 -0500
MIME-Version: 1.0
In-Reply-To: <20170925122808.14561-5-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="liDnoqm1mJL1Plssi60drtKjWCKa6I4IO"
Subject: Re: [Qemu-devel] [PATCH 4/5] qemu-iotests: Test commit block job
 where top has two parents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--liDnoqm1mJL1Plssi60drtKjWCKa6I4IO
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org
Message-ID: <c58176c1-09c7-fa47-baec-ce287bca1264@redhat.com>
Subject: Re: [PATCH 4/5] qemu-iotests: Test commit block job where top has two
 parents
References: <20170925122808.14561-1-kwolf@redhat.com>
 <20170925122808.14561-5-kwolf@redhat.com>
In-Reply-To: <20170925122808.14561-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/25/2017 07:28 AM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/191     | 152 +++++++++
>  tests/qemu-iotests/191.out | 827 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 980 insertions(+)
>  create mode 100755 tests/qemu-iotests/191
>  create mode 100644 tests/qemu-iotests/191.out
>=20

> +
> +_cleanup()
> +{
> +    rm -f "${TEST_IMG}.mid"
> +    rm -f "${TEST_IMG}.ovl2"
> +    rm -f "${TEST_IMG}.ovl3"
> +    _cleanup_test_img
> +    _cleanup_qemu
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15

Semantic conflict with Jeff's work to allow preservation of intermediate
files via './check -s'.

> +++ b/tests/qemu-iotests/191.out

> +{
> +    "timestamp": {
> +        "seconds":  TIMESTAMP,
> +        "microseconds":  TIMESTAMP
> +    },
> +    "event": "BLOCK_JOB_COMPLETED",
> +    "data": {
> +        "device": "commit0",
> +        "len": 67108864,
> +        "offset": 67108864,
> +        "speed": 0,
> +        "type": "commit"
> +    }
> +}

This may be sensitive to ordering if I ever finish my patches that allow
for QAPI->JSON conversion without having to first go through QObject (as
it is, it's dependent on QDict's hash being stable, whereas my code
switches things to be stable according to QAPI ordering).  But that's
not a problem for your patch.


> +                        "data": {
> +                            "compat": "1.1",

You should make the test specifically exclude compat=3D0.10 images, or
else have further filtering in place if we can still support this on old
images.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--liDnoqm1mJL1Plssi60drtKjWCKa6I4IO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnJZOgACgkQp6FrSiUn
Q2pAcAf/XrufWpUdVQGJxAsDFXMWSwYgfs9JVJNziby/OWyh8242rTLCE3jgNXiG
egC+7AVONs+02uk0oREAo1FfeoEWVYL/Kh1nTC0Uo7eDzSZ/WW6w97gMFJkoWpju
uGgXmDf0Cx2yRRXCHO4COLWiIIG7dEX9Cwn1Gi97NUHbJtvje6yhsckLVjSHWnrk
Xh+bS3GIPihvKuxmPZ2sDDPgqpu5pqvhiZ6vZdi1tYsM0zkXunzqLXcPh/HvDvfX
i41JxcY/GCJdBmKvfKocI+FXd0yxNeBNCZKAvPepkd+Mll5BZys8bhPtNvBxXXzw
6BhOmXENHzZnlReoXS3/gpAZvS+eDw==
=1I+H
-----END PGP SIGNATURE-----

--liDnoqm1mJL1Plssi60drtKjWCKa6I4IO--
