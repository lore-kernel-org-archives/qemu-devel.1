Received: from eggs.gnu.org ([2001:4830:134:3::10]:46821)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1da3JT-0007NC-1n
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1da3JO-0003yl-0v
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:08:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:54572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1da3JN-0003xv-LL
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:07:57 -0400
References: <504798a0-0ac3-bfab-a451-2eb0cfca43ff@amsat.org>
	<66ff3f38-b62b-ca59-e155-d9e4f67693aa@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <10a92bb8-3798-830e-47c7-1485eea9174d@gmx.com>
Date: Tue, 25 Jul 2017 19:10:04 +0200
MIME-Version: 1.0
In-Reply-To: <66ff3f38-b62b-ca59-e155-d9e4f67693aa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2CDIC1jhaBtpjToNvPDhmLxkIv8Bhaho5"
Subject: Re: [Qemu-devel] MAINTAINERS: surprising get_maintainer.pl output
 for ./configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2CDIC1jhaBtpjToNvPDhmLxkIv8Bhaho5
From: Kamil Rytarowski <n54@gmx.com>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <10a92bb8-3798-830e-47c7-1485eea9174d@gmx.com>
Subject: Re: [Qemu-devel] MAINTAINERS: surprising get_maintainer.pl output for
 ./configure
References: <504798a0-0ac3-bfab-a451-2eb0cfca43ff@amsat.org>
 <66ff3f38-b62b-ca59-e155-d9e4f67693aa@redhat.com>
In-Reply-To: <66ff3f38-b62b-ca59-e155-d9e4f67693aa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.07.2017 07:48, Thomas Huth wrote:
> On 25.07.2017 00:40, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi perl gurus :)
>>
>> after changing the ./configure I wanted to figure to whom email and go=
t
>> this:
>>
>> $ ./scripts/get_maintainer.pl -f configure
>> Kamil Rytarowski <kamil@netbsd.org> (maintainer:NETBSD)
>> qemu-devel@nongnu.org (open list:All patches CC here)
>>
>> $ fgrep -A5 NETBSD MAINTAINERS
>> NETBSD
>> L: qemu-devel@nongnu.org
>> M: Kamil Rytarowski <kamil@netbsd.org>
>> S: Maintained
>> K: (?i)NetBSD
>>
>> Descriptions of section entries:
>>
>>   K: Keyword perl extended regex pattern to match
>>      content in a patch or file.
>>
>> $ fgrep -inA1 NetBSD configure
>> 547:elif check_define __NetBSD__; then
>> 548:  targetos=3D'NetBSD'
>> --=20
>> 709:NetBSD)
>> 710-  bsd=3D"yes"
>> --=20
>> 715:  HOST_VARIANT_DIR=3D"netbsd"
>> 716-  supported_os=3D"yes"
>>
>> since ./configure check for NetBSD host/target, the string appears in
>> the ./configure and the K regex is matched...
>>
>> I tried to add a 'F: configure' in NETBSD entry but it doesn't change.=

>> The easier is to kill the K entry :)
>=20
> But without the K: entry there is no more pattern for this entry at all=

> anymore - since there are also no F: entries here.
>=20
> I'd suggest to do it the same way as the "Trivial patches" entry:
>=20
> K: ^Subject:.*(?i)NetBSD
>=20
> ... then it should hopefully only trigger on patch titles.
>=20
> Philippe, Kamil, if one of you has got some spare minutes, could you
> please send a patch?
>=20
>  Thomas
>=20

I don't have preference here. I'm fine either way.


--2CDIC1jhaBtpjToNvPDhmLxkIv8Bhaho5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZd3tyAAoJEEuzCOmwLnZsDV8P/ArVGu5Vd9YL4azQmXH072rK
4Q4bTKdSnSWCM0iTc07z6FXhCReTeT0Q4SggMo92KgN79qZx0UxMD4cP8pMPU+lt
8xFUIohFdb+s2a8H1h+RK++rqF7gLKs1UReNTzbIhN8CEpB5OutArurHMQznh95T
r8HM2Q/0L324QOif7RtBansYatRhHIqisWg77/tuoNs6Rd+/ffRQD6bV1NyqGlwL
x8xz3Rw4o09q8/m0i7yu2qoRRSWmnOYaceFbs0bdvV0hJqj31/aIlmqLPfoqe0e/
WEAW55GWfLHEflQ2UqPO7yrhoRo9PwblubiuvIoMxiwEAjcWDO/wieGIWTQS4JIa
G5ayJQIQlhn624poJDsZDpSa2mMFaqzgB+Q44O/LV2wg7+imxsHtA/eXrew5RBKc
K7NuDr3+VnOYfGT71ka0SZXEqxQGuSFY8w/FIfMmbWAjZvsRdkWJBoUIEwf/fIxN
50Z2glyvDmnU4IavKXi4y2hogmkccEO+B7UjgHKsg2GprVJFVX55YONm+CWXJaWk
kD7LTw3BZxu0M6USBXwjI89JyVVzCuEugR3+bUqLbeeRVNWJ461hNacChp8c01zL
yXk/9j+EzN/MTC6gxLa5d8uqH4cWW9HkMc5BCGRtj9UjjYeThzJhat3AMH1gOVYW
ZvsRNzYT15vCFtA0DqRK
=sSmf
-----END PGP SIGNATURE-----

--2CDIC1jhaBtpjToNvPDhmLxkIv8Bhaho5--
