Received: from eggs.gnu.org ([209.51.188.92]:33072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glnj1-0003LO-61
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 23:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glnfr-0002UI-0U
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 23:28:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1glnfp-0002TO-NF
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 23:28:30 -0500
References: <20190121181030.2112-1-philmd@redhat.com>
	<76c2912b-8c50-d15f-f153-e80fa4b1be6e@redhat.com>
	<5f27ba6f-f2e3-423f-54ee-0f6d6a0e1b48@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c52c29be-f285-2e5c-24ce-352c284e2b58@redhat.com>
Date: Tue, 22 Jan 2019 05:28:12 +0100
MIME-Version: 1.0
In-Reply-To: <5f27ba6f-f2e3-423f-54ee-0f6d6a0e1b48@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="jBbB7ICZL7nTmc9PkFS6U2Sty8NmSviMA"
Subject: Re: [Qemu-devel] [PATCH] virtio-net: Fix VirtIONet typedef
 redefinition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Wei Xu <wexu@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jBbB7ICZL7nTmc9PkFS6U2Sty8NmSviMA
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, Wei Xu <wexu@redhat.com>
Message-ID: <c52c29be-f285-2e5c-24ce-352c284e2b58@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-net: Fix VirtIONet typedef
 redefinition
References: <20190121181030.2112-1-philmd@redhat.com>
 <76c2912b-8c50-d15f-f153-e80fa4b1be6e@redhat.com>
 <5f27ba6f-f2e3-423f-54ee-0f6d6a0e1b48@redhat.com>
In-Reply-To: <5f27ba6f-f2e3-423f-54ee-0f6d6a0e1b48@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2019-01-21 20:46, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/21/19 8:22 PM, Eric Blake wrote:
>> On 1/21/19 12:10 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Commit 2974e916df8 introduced the VirtioNetRscChain structure which
>>> refer to a VirtIONet, declared later, thus required VirtIONet typedef=

>>> to be declarated forward.
>>
>> s/be declarated forward/use a forward declaration/
>=20
> Thanks Eric.
>=20
> Thomas, do you mind fixing this if you take this patch?

No problem, just fixed it while picking up the patch.

 Thanks,
  Thomas


--jBbB7ICZL7nTmc9PkFS6U2Sty8NmSviMA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJcRpviAAoJEC7Z13T+cC21T0kP/RjrBUGRfMcJBszRIfxq+0zu
9gijev+xoCEpxIXt1vPdWpVacLh/oxwjY+d4v1zc6LYQYgMagALP3RCIJYCOlxGH
8NcfIOaHWHygB7QcpIKV94imCdbwx4BRjAueJ3KvSYUQHB2+0HCreDQ4dmyY7bFd
w+2YGCuIKeGs2lnD83zotULEN8HBo+bJ5VOzgt6M3INozdNJNzfAjKY3ONhAlZZI
u644HI7SN73HojpYF3z6n7EEm3/lz+hduXOBvQ96hWp6heUFP7yskLuTnHyhf1H5
nDl+ZPlEmkRTZhOD9iListTN8dKtzybMQKv/HL6wIckDJcF6MjKq+wKbeoieSAI/
43oqAeJB4zB/sFoZT5u5GItOrUOF/ZWTG36FjGC3Z9WL+YB0fi4d/bkbJ5ofmYIB
Lma/9mgQVeeriTKu+YsIkxUB7xI6xRyZSewLt0neFh4gepfRhZNJSqiaHx0N4jv/
rQcvdqvjQjmoN5S0sjoRUxJn7JkfvqDXxNtH7HElxOnsOCPxNYY9WNWCskFluMee
TewMrBnGYLdlaWjqolBXTeIbufdAHP7NaFshUcujHy/JS8xwFIszKBsBGFvBb+2s
iC6cxbpdDhxVj5F/rzdt/zcWBWKIyxBY2ZuRgdXAl+ZH1xVRPr488wSEr6Gw3j8p
LKSFyq9G4FFNgbiMTPGU
=3O7d
-----END PGP SIGNATURE-----

--jBbB7ICZL7nTmc9PkFS6U2Sty8NmSviMA--
