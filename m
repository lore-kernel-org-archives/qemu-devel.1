Received: from eggs.gnu.org ([2001:4830:134:3::10]:34637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er2jH-00081h-NM
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:29:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er2jG-00036F-Ns
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:29:11 -0500
References: <20180122220806.22154-1-mreitz@redhat.com>
	<20180122220806.22154-11-mreitz@redhat.com>
	<20180227085910.GB25412@lemon.usersys.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d5ba0730-2b53-a2bf-aaa8-1a87bece1031@redhat.com>
Date: Wed, 28 Feb 2018 15:28:53 +0100
MIME-Version: 1.0
In-Reply-To: <20180227085910.GB25412@lemon.usersys.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hDcfy2BW64QCiGPOTzJsPYmBy27W391OZ"
Subject: Re: [Qemu-devel] [PATCH v2 10/16] hbitmap: Add @advance param to
 hbitmap_iter_next()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hDcfy2BW64QCiGPOTzJsPYmBy27W391OZ
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <d5ba0730-2b53-a2bf-aaa8-1a87bece1031@redhat.com>
Subject: Re: [PATCH v2 10/16] hbitmap: Add @advance param to
 hbitmap_iter_next()
References: <20180122220806.22154-1-mreitz@redhat.com>
 <20180122220806.22154-11-mreitz@redhat.com>
 <20180227085910.GB25412@lemon.usersys.redhat.com>
In-Reply-To: <20180227085910.GB25412@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-27 09:59, Fam Zheng wrote:
> On Mon, 01/22 23:08, Max Reitz wrote:
>> diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
>> index 9091c639b3..2a2aa5bd43 100644
>> --- a/tests/test-hbitmap.c
>> +++ b/tests/test-hbitmap.c
>> @@ -46,7 +46,7 @@ static void hbitmap_test_check(TestHBitmapData *data=
,
>> =20
>>      i =3D first;
>>      for (;;) {
>> -        next =3D hbitmap_iter_next(&hbi);
>> +        next =3D hbitmap_iter_next(&hbi, true);
>>          if (next < 0) {
>>              next =3D data->size;
>>          }
>> @@ -435,25 +435,25 @@ static void test_hbitmap_iter_granularity(TestHB=
itmapData *data,
>>      /* Note that hbitmap_test_check has to be invoked manually in thi=
s test.  */
>>      hbitmap_test_init(data, 131072 << 7, 7);
>>      hbitmap_iter_init(&hbi, data->hb, 0);
>> -    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
>> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
>> =20
>>      hbitmap_test_set(data, ((L2 + L1 + 1) << 7) + 8, 8);
>>      hbitmap_iter_init(&hbi, data->hb, 0);
>> -    g_assert_cmpint(hbitmap_iter_next(&hbi), =3D=3D, (L2 + L1 + 1) <<=
 7);
>> -    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
>> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), =3D=3D, (L2 + L1 +=
 1) << 7);
>> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
>> =20
>>      hbitmap_iter_init(&hbi, data->hb, (L2 + L1 + 2) << 7);
>> -    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
>> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
>> =20
>>      hbitmap_test_set(data, (131072 << 7) - 8, 8);
>>      hbitmap_iter_init(&hbi, data->hb, 0);
>> -    g_assert_cmpint(hbitmap_iter_next(&hbi), =3D=3D, (L2 + L1 + 1) <<=
 7);
>> -    g_assert_cmpint(hbitmap_iter_next(&hbi), =3D=3D, 131071 << 7);
>> -    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
>> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), =3D=3D, (L2 + L1 +=
 1) << 7);
>> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), =3D=3D, 131071 << =
7);
>> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
>> =20
>>      hbitmap_iter_init(&hbi, data->hb, (L2 + L1 + 2) << 7);
>> -    g_assert_cmpint(hbitmap_iter_next(&hbi), =3D=3D, 131071 << 7);
>> -    g_assert_cmpint(hbitmap_iter_next(&hbi), <, 0);
>> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), =3D=3D, 131071 << =
7);
>> +    g_assert_cmpint(hbitmap_iter_next(&hbi, true), <, 0);
>>  }
>=20
> Please add tests for advance=3Dfalse too.

:C

But writing tests is so hard!  And then most of the time you even find
bugs in your own code.  Which makes it even harder... O:-)

Will do.

Max


--hDcfy2BW64QCiGPOTzJsPYmBy27W391OZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqWvKUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A3isIALKzLQNxS/WKn2LBSGHzbYcd3keDCeQy
VJ7kBpfF2GYIFQ3mrzS7T8YTwn4r3iX31JxTqG/yCarcKGmHB0uNjz2quYO7vM+X
wRxQYtraAqO4afSuPdkWzF9OuVy/ijHw9J6nGL3/zkLBf8YQV7EJrKwNup1FmPnc
behdyESnPLXRTZO+c8yBTShK6f8PDjpurNcFCvPJklRq+pctyhduqP+YQ1kZLnWU
ryr9xTbgjee+imCSjQ5dAFaAWuMB+/b4/bSPRZU5RKtnJ9fkiOzCWZr0W9bIhMfb
ItN6G6oTMxE2E21lMzr4Gtf5uQ1bYVryb/pgNRzuXAFnRhPAGtXWbO0=
=dBVX
-----END PGP SIGNATURE-----

--hDcfy2BW64QCiGPOTzJsPYmBy27W391OZ--
