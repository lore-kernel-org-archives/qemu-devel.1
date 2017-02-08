Received: from eggs.gnu.org ([2001:4830:134:3::10]:57709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbGBa-0002Rj-E6
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:32:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbGBZ-000898-G9
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:32:38 -0500
References: <20170123123056.30383-1-famz@redhat.com>
	<20170123123056.30383-11-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3ec2e40a-c0ff-c347-7ee7-7c90cc97ab00@redhat.com>
Date: Wed, 8 Feb 2017 01:32:27 +0100
MIME-Version: 1.0
In-Reply-To: <20170123123056.30383-11-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Bqo2SWJsdSha7ciqm2ahmSqqSkMW0BtBU"
Subject: Re: [Qemu-devel] [PATCH v12 10/16] iotests: 091: Quit QEMU before
 checking image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Bqo2SWJsdSha7ciqm2ahmSqqSkMW0BtBU
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com
Message-ID: <3ec2e40a-c0ff-c347-7ee7-7c90cc97ab00@redhat.com>
Subject: Re: [PATCH v12 10/16] iotests: 091: Quit QEMU before checking image
References: <20170123123056.30383-1-famz@redhat.com>
 <20170123123056.30383-11-famz@redhat.com>
In-Reply-To: <20170123123056.30383-11-famz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:30, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/qemu-iotests/091 | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
> index 32bbd56..10ac4a8 100755
> --- a/tests/qemu-iotests/091
> +++ b/tests/qemu-iotests/091
> @@ -95,7 +95,9 @@ echo "vm2: qemu process running successfully"
>  echo "vm2: flush io, and quit"
>  _send_qemu_cmd $h2 'qemu-io disk flush' "(qemu)"
>  _send_qemu_cmd $h2 'quit' ""
> +_send_qemu_cmd $h1 'quit' ""
> =20
> +wait

And to think I added $wait for _cleanup_qemu when it was so simple...

Well:

Reviewed-by: Max Reitz <mreitz@redhat.com>

(...maybe _cleanup_qemu's output redirection ability is still useful? I
don't know.)

>  echo "Check image pattern"
>  ${QEMU_IO} -c "read -P 0x22 0 4M" "${TEST_IMG}" | _filter_testdir | _f=
ilter_qemu_io
> =20
>=20



--Bqo2SWJsdSha7ciqm2ahmSqqSkMW0BtBU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliaZxsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ae8YH/iURIsEj/NalSERPTtv0jBVrJZHuwPrj
h9DwTd3oj27RYfu9hvCiK23LMZJv0Nb2tszXhd5iBiR6DB4KR01TYBwnXyaGHDkr
YwuFTXZh/Ls4uyrfMRfCQ5qVh4ma+0s4OcJwF7TiiujfjQom8ucoc3QGETESs6Gv
ULbJkYHBk7CAhtYgrQ4oVLB1Fc+ahKLlmm+QhYaFgLUkPE9C8wSnrqV+oOxWQjID
GR00sydvJ2aWls5frPmTdw8vaaMRt2zxr/LRcPB6oqQwtLF2GyxKPmr+j6uaooBR
XE68/mDwA0lY/RXzKA+2HZLDJpwnhcMe2mmwWtBFCE0cy6WVta404YE=
=E6Gv
-----END PGP SIGNATURE-----

--Bqo2SWJsdSha7ciqm2ahmSqqSkMW0BtBU--
