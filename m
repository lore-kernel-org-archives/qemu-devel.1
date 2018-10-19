Received: from eggs.gnu.org ([2001:4830:134:3::10]:42807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDRch-0001ov-2E
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDRcc-0001QP-Nn
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:03:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1gDRcc-0001P1-EP
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:03:10 -0400
References: <cover.1539020852.git.alifm@linux.ibm.com>
	<4e79b7522a0da8a5635024a97f3b04cfd64fe900.1539020852.git.alifm@linux.ibm.com>
	<f851ad95-5bcc-f186-0806-571fb3ba1a40@redhat.com>
	<f1949902-8cfe-b9c0-0cc3-f680893dc025@redhat.com>
	<3b194f1b-a97b-d453-8abe-37828369d73f@linux.ibm.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b7000139-256d-758c-cd51-18f1c407e68f@redhat.com>
Date: Fri, 19 Oct 2018 12:02:58 +0200
MIME-Version: 1.0
In-Reply-To: <3b194f1b-a97b-d453-8abe-37828369d73f@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ko1aL6Ao10FTmg8OQvRRUIZFmN5UyTQ1m"
Subject: Re: [Qemu-devel] [RFC v1 1/1] qemu-iotests: Fix output for testcase
 082
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, marcandre.lureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ko1aL6Ao10FTmg8OQvRRUIZFmN5UyTQ1m
From: Max Reitz <mreitz@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-devel@nongnu.org
Cc: famz@redhat.com, marcandre.lureau@redhat.com
Message-ID: <b7000139-256d-758c-cd51-18f1c407e68f@redhat.com>
Subject: Re: [Qemu-devel] [RFC v1 1/1] qemu-iotests: Fix output for testcase
 082
References: <cover.1539020852.git.alifm@linux.ibm.com>
 <4e79b7522a0da8a5635024a97f3b04cfd64fe900.1539020852.git.alifm@linux.ibm.com>
 <f851ad95-5bcc-f186-0806-571fb3ba1a40@redhat.com>
 <f1949902-8cfe-b9c0-0cc3-f680893dc025@redhat.com>
 <3b194f1b-a97b-d453-8abe-37828369d73f@linux.ibm.com>
In-Reply-To: <3b194f1b-a97b-d453-8abe-37828369d73f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.10.18 15:00, Farhan Ali wrote:
>=20
>=20
> On 10/15/2018 11:45 AM, Max Reitz wrote:
>>> 082 is failing for me on master (046936ed), and this fixes it.
>>>
>>> I'm wondering if/why other people are not running into this, as 082 r=
uns
>>> with qcow2 and is included on `make check-block`.
>>>
>>> + Max,
>>>
>>> FIY, I ran into this while reviewing/testing your Python 3 series.
>>>
>>> Tested-by: Cleber Rosa<crosa@redhat.com>
>> Thanks for CC-ing me, Cleber.
>>
>> Farhan, I disagree with this fix, as I wrote here:
>>
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg01488.html
>>
>> I don't like the new output, so I think what we should do is change th=
e
>> code that produces it.=C2=A0 Marc-Andr=C3=A9 seemed to agree, so I jus=
t need to
>> write a patch (which I didn't get to so far).
>>
>> Max
>>
>=20
> Hi Max,
>=20
> That is fine with me. The reason I sent this patch out as an RFC was
> because I wasn't sure about the fix. So for the time being is it okay
> for the test to fail?

I think so, yes.  It looks like we've agreed that we want another change
(although we haven't agreed on the details yet), so I think it's OK to
leave it broken until then.

It's definitely interesting to see how many people run the iotests these
days. :-)  (You're not the only one to send a patch to fix this.)

> And if you do submit a patch, would you kindly cc
> me as well.

I already did:

http://lists.nongnu.org/archive/html/qemu-block/2018-10/msg00465.html

(Though a v2 is in order.)

Max


--ko1aL6Ao10FTmg8OQvRRUIZFmN5UyTQ1m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvJq9MACgkQ9AfbAGHV
z0CA+wgAhdfqaijezEfJPq/RjLxj/l9oRAlZhDouKVj66wEgvHB5HFyzJwYg54yL
0FZ6L6cgQurlPz8DKm8j28EUF5/v29/jITBCtbwNL4H6b0FAkKXxenirE3iTdv/w
gRcu79FyWsWWAhjFkvOhWCMfGhe6NlzD8yTFUyJqQL94NM/yXmK4ZnWE099AKXZV
WVqCg3MZbpRn8hHugkj3KKYsxpsTje2XTA70bgjSUaxVG+NN1B4ayxbZnrPiKojx
PpX5C4x+t7wKUA5TxdsIsWj5jMWm1du4BzxwY8ui4ldG5euwVy0Bj4RSOImHSI0M
VHsK/WqDC9FF2fN6lUx4+18xCmA8MA==
=BIA7
-----END PGP SIGNATURE-----

--ko1aL6Ao10FTmg8OQvRRUIZFmN5UyTQ1m--
