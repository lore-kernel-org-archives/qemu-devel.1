Received: from eggs.gnu.org ([2001:4830:134:3::10]:51039)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dCDbL-0003is-KK
	for qemu-devel@nongnu.org; Sat, 20 May 2017 19:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dCDbK-0002tX-Om
	for qemu-devel@nongnu.org; Sat, 20 May 2017 19:15:59 -0400
References: <20170426105027.10666-1-n54@gmx.com> <87shkf8txg.fsf@linaro.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <8a96c178-9425-1de0-7254-81304ca4f468@gmx.com>
Date: Sun, 21 May 2017 01:17:57 +0200
MIME-Version: 1.0
In-Reply-To: <87shkf8txg.fsf@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xEXCv3gpNPgfJqBX5L7mpb9ggL1DHBVFW"
Subject: Re: [Qemu-devel] [PATCH] configure: Detect native NetBSD curses(3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xEXCv3gpNPgfJqBX5L7mpb9ggL1DHBVFW
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>
Message-ID: <8a96c178-9425-1de0-7254-81304ca4f468@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Detect native NetBSD curses(3)
References: <20170426105027.10666-1-n54@gmx.com> <87shkf8txg.fsf@linaro.org>
In-Reply-To: <87shkf8txg.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ping? Could someone please put it on the pull-request?

Adding qemu-trivial@.

On 08.05.2017 13:33, Alex Benn=C3=A9e wrote:
>=20
> Kamil Rytarowski <n54@gmx.com> writes:
>=20
>> NetBSD ships with traditional BSD curses with compatibility with ncurs=
es.
>> qemu works nicely with the basesystem version of curses(3) from NetBSD=
=2E
>>
>> The only mismatch between curses(3) and ncurses is the lack of
>> curses_version() in the NetBSD version. This function is used solely i=
n
>> the configure script, therefore eliminate it from the curses(3) detect=
ion.
>>
>> With this change applied, configure detects correctly curses frontend.=

>>
>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>=20
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
>> ---
>>  configure | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/configure b/configure
>> index c35acf1192..17dc7224f7 100755
>> --- a/configure
>> +++ b/configure
>> @@ -3034,14 +3034,13 @@ if test "$curses" !=3D "no" ; then
>>  #include <curses.h>
>>  #include <wchar.h>
>>  int main(void) {
>> -  const char *s =3D curses_version();
>>    wchar_t wch =3D L'w';
>>    setlocale(LC_ALL, "");
>>    resize_term(0, 0);
>>    addwstr(L"wide chars\n");
>>    addnwstr(&wch, 1);
>>    add_wch(WACS_DEGREE);
>> -  return s !=3D 0;
>> +  return 0;
>>  }
>>  EOF
>>    IFS=3D:
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20



--xEXCv3gpNPgfJqBX5L7mpb9ggL1DHBVFW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZIM6rAAoJEEuzCOmwLnZsAaIP/0pum31jgM+cE8F7v7AdWTMF
pfHWCnt3Lpgr+lS7ihefO6B0rRfYwJKBfvCXB3PenL7lev+uA+EndFtz9TxsiWjq
/IQTkLSRhqMqOBmFxHR5K20AKP6OuQ5uY3RxcN9qo8eWV2us9MM9Ft3IVZqXz2+N
OHFS6XK42Sf2cK4X64EvaxErCgY2G/S9ju4eGhfxvUoT7ZPMY4jrgZ0Wss4ekz7k
02kHcj6+au3Xol6R7HpyaR/wONpUVbsPpl9Xf3oeqXcy0lnJ689oazF5HKn3GLRy
KjslNwwDHfhSXEu3D7bwUcIIo+td9HHfLnRcZT0CfWX8Ng9WxNp/b0LBJTubSDFC
ePpGrfm/Y3Q0SPk5QihFJzFlgsyeOOK9vS6MtsU+qHEdX4SYw0LpS+/87IyvffXI
arv5ZSQniJ/B7UslZ5Op2VubNNZ3Mn8GS9bIiRhiMOfyRgyWtKQuY1ddvrmAVCJ7
JuYLpUFYJgkUjsIxJLBvEV8zkcbf2be6UO+FyIWeqwLb4qJO03sHB2tttj4BKUkl
g+U9ZLavcAVLzzKQnGf9HwxgAq7RX/c9nPtX9PBcv9Yfp88imNbkvVle+0M9tsyP
mqBkpLltaPqCn6xG7eqNReXaNfs7WiwOj8S1BiRZd1Xi1mnxCHMmWfHuJDEzPyWs
qV+L48Q0Weu1TI+JPMCG
=dvqE
-----END PGP SIGNATURE-----

--xEXCv3gpNPgfJqBX5L7mpb9ggL1DHBVFW--
