Received: from eggs.gnu.org ([209.51.188.92]:42512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gok8M-0008O2-KX
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:18:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gok8L-0000fX-UU
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:18:06 -0500
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-3-philmd@redhat.com>
	<cdfb4f7e-0182-386a-6508-a13a56e6de16@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0462853c-2f19-58ff-aee5-d667a86322e1@redhat.com>
Date: Wed, 30 Jan 2019 08:17:41 +0100
MIME-Version: 1.0
In-Reply-To: <cdfb4f7e-0182-386a-6508-a13a56e6de16@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="HoOULDABkRMt48Cb5eCA5dKRYIEzWVHkI"
Subject: Re: [Qemu-devel] [PATCH v2 02/18] configure: Disable W^X on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HoOULDABkRMt48Cb5eCA5dKRYIEzWVHkI
From: Thomas Huth <thuth@redhat.com>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
Message-ID: <0462853c-2f19-58ff-aee5-d667a86322e1@redhat.com>
Subject: Re: [PATCH v2 02/18] configure: Disable W^X on OpenBSD
References: <20190129175403.18017-1-philmd@redhat.com>
 <20190129175403.18017-3-philmd@redhat.com>
 <cdfb4f7e-0182-386a-6508-a13a56e6de16@redhat.com>
In-Reply-To: <cdfb4f7e-0182-386a-6508-a13a56e6de16@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2019-01-29 22:54, Eric Blake wrote:
> On 1/29/19 11:53 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Since OpenBSD 6.0 [1], W^X is enforced by default [2].
>> TCG requires WX access. Disable W^X if it is available.
>> This fixes:
>>
>=20
>>  configure | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/configure b/configure
>> index b18281c61f..799ec2013b 100755
>> --- a/configure
>> +++ b/configure
>> @@ -5795,6 +5795,17 @@ if test "$mingw32" =3D "yes" ; then
>>      done
>>  fi
>> =20
>> +# Disable OpenBSD W^X if available
>> +if test "$tcg" =3D "yes" -a "$targetos" =3D "OpenBSD"; then
>=20
> test ... -a ...
>=20
> is not portable (POSIX permits non-XSI systems to omit support for thes=
e
> operators, but even where they are supported, there are some inherently=

> ambiguous inputs where you CANNOT predict whether the shell will parse
> -a as a binary operator or as an argument to some other operator).
> Instead, you should ALWAYS break dual tests into:
>=20
> test ... && test ...
>=20
> instead.  (Same for '-o' vs '|| test')

$ grep 'test.* -a ' configure | wc -l
21
$ grep 'test.* && ' configure | wc -l
16

Looks like we do not really care?

 Thomas


--HoOULDABkRMt48Cb5eCA5dKRYIEzWVHkI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJcUU+aAAoJEC7Z13T+cC217ikP/Ro1Rs4m1ieeXXkv7D1qZaZG
U40SabMZeRXup1CQjXo3ohSrYz/L2cfjvhhzSspaC2sExNbawCpJvzW8Y7lO/nls
cyHX3/KJpGkfXdNT/ChRlepsmpLwsTKpUYk5AwuPs4cYxTWfn6IxCtEwTMFjzCNd
IVLhGClKo/Ovvyxt4xAIbIGLpSbPGdydT8JsxlIN+vQIeqKpI/1vpr3h8AjRRQ5a
TESQwjwvTdRUYihZ2ZtJl+Ets5XJLBIjrL4dIQMHjmaNMc6lGccNaOIffd6sqfWD
9tpxu6Cuoca+IJIEk2fgWR6tPE9epZPePPle2OMHJUxxVUxT3xhTu1oVxouXyLO6
fdA69whYX/apVXwCGmnSpwxrQnEa6HASL9SJ4y1WF+lV915R6nNpokYIXg+pL7Tr
rY+0ppJAO04PO/6S18dMEXxHqjNA5++xlP0TV/FI211QSjw6/A3drMT3v87G7Mvf
4L14pdNsVSx/QEDBFdS20ugmpdWqXf5dIS7CAvWBvj51p21gBYNM0LW1aSs84+aA
wWkRGU5hgl8sGb1IMLz/uW9v90B4MNrdCghqiZSLvO/8CZaUW0rdWMtsIM2gl8ur
9wGV6pJLlbsZ/tdBmKug8tUZsGcBXC3/h94Sh/SnbTtvW1Ccw4BMp4Q7fKDvJwav
ImFyxfg+WMu5EnUZ0mCZ
=eexw
-----END PGP SIGNATURE-----

--HoOULDABkRMt48Cb5eCA5dKRYIEzWVHkI--
