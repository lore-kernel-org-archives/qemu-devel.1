Received: from eggs.gnu.org ([209.51.188.92]:54552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hKZoF-0001OF-6L
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 22:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hKZmH-0003gq-HY
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 22:42:55 -0400
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-6-thuth@redhat.com>
	<6b284aaa-353c-92c1-b01b-21882e7ff9ef@redhat.com>
	<e8d6cbeb-b1aa-deb1-b7a7-c3c7a3906229@redhat.com>
	<6d98dd44-158e-136b-fc0a-105a0c4a120f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3e826289-53f0-2086-3142-dd738039f9af@redhat.com>
Date: Sat, 27 Apr 2019 21:42:43 -0500
MIME-Version: 1.0
In-Reply-To: <6d98dd44-158e-136b-fc0a-105a0c4a120f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VYFmcRRbL4louDaKuYKUY9PZapJZFYOyx"
Subject: Re: [Qemu-devel] [PATCH 5/6] tests: Run the iotests during "make
 check" again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Christophe Fergeau <cfergeau@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VYFmcRRbL4louDaKuYKUY9PZapJZFYOyx
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Christophe Fergeau <cfergeau@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>
Message-ID: <3e826289-53f0-2086-3142-dd738039f9af@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/6] tests: Run the iotests during "make
 check" again
References: <20190424103747.10173-1-thuth@redhat.com>
 <20190424103747.10173-6-thuth@redhat.com>
 <6b284aaa-353c-92c1-b01b-21882e7ff9ef@redhat.com>
 <e8d6cbeb-b1aa-deb1-b7a7-c3c7a3906229@redhat.com>
 <6d98dd44-158e-136b-fc0a-105a0c4a120f@redhat.com>
In-Reply-To: <6d98dd44-158e-136b-fc0a-105a0c4a120f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/25/19 5:24 AM, Thomas Huth wrote:

>> Ok, thanks for the info. Looks like many tests are failing because qem=
u-io suddenly prints its program name in front of the error messages? E.g=
=2E:
>>
>> --- /tmp/qemu-test/src/tests/qemu-iotests/069.out	2019-04-24 16:52:31.=
000000000 +0000
>> +++ /tmp/qemu-test/build/tests/qemu-iotests/069.out.bad	2019-04-24 16:=
59:13.310226424 +0000
>> @@ -4,5 +4,5 @@
>> =20
>>  Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D131072
>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D131072 backing_fi=
le=3DTEST_DIR/t.IMGFMT.base
>> -can't open device TEST_DIR/t.IMGFMT: Could not open backing file: Cou=
ld not open 'TEST_DIR/t.IMGFMT.base': No such file or directory
>> +qemu-io: can't open device TEST_DIR/t.IMGFMT: Could not open backing =
file: Could not open 'TEST_DIR/t.IMGFMT.base': No such file or directory
>>
>> Does anybody from the block folks has a clue what might be going wrong=
 here?
>=20
> It's a regression in the current master branch, not caused by my series=
=2E
> The iotests also fail with vanilla master, e.g. reproducible with:
>=20
>  cd tests/qemu-iotests
>  ./check -qcow2 069
>=20
> It's caused by Christophe's commit here:
>=20
>  99e98d7c9fc1a1639fad2c638733b02f4b43aebe
>  qemu-io: Use error_[gs]et_progname()
>=20
> Christophe, could you please have a look?

The change in output is desirable, but yes, it does mean that iotests
need to have .out files updated to match.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--VYFmcRRbL4louDaKuYKUY9PZapJZFYOyx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzFEyMACgkQp6FrSiUn
Q2qtKQf9HD60A+WOtM0n1WIyvojMztKciJvE8ATW4C08oTZ90wDfcMnnafpcSePB
UQRKNwb+7F3+Rk9LzEnLZCwLQefJYztKJDBLy4E5axXqkz0CrilMbLGDvtKotiWm
jary26x3kmmlyPSeQbkx6TnSa971iItlBP25iGL7jpnbnY1f4fR7C47e2DceRBq/
aqS7G6KZU86573P/R53uYrXN8kZWD0sXyYm0PPtGTRdDf6SzotwvCuBmf/q4PgE+
+RbiuprX971k1Rylrk7ck6ZOjBw1qEuxoLm0M1IZ30o8DYiooruFdmcBPhI0H2Ci
o1AENbEf+O7pfmEkxRnvjyH/ZdvEag==
=kCXV
-----END PGP SIGNATURE-----

--VYFmcRRbL4louDaKuYKUY9PZapJZFYOyx--
