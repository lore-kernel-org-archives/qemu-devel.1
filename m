Received: from eggs.gnu.org ([2001:4830:134:3::10]:36462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkUsv-0002T8-Fv
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkUsq-0007ze-Dd
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:35:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dkUsp-0007z6-Ua
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:35:44 -0400
References: <20170816082650.21880-1-cohuck@redhat.com>
	<223c4e3c-097f-5a91-37fa-df4bfb427d60@redhat.com>
	<CAFEAcA_UfM_XNKdc5zfHsehoRE6Q+EszRZX3FByskir7c+0Lww@mail.gmail.com>
	<20170822010917.GO12356@umbus.fritz.box>
	<CAFEAcA8wbRjjJYtk-65NJEsu-ELVdKgtwreipabSaMtLTfS--Q@mail.gmail.com>
	<3f0dc918-0f55-e2f4-bf47-fe4abf5453bb@redhat.com>
	<CAFEAcA_ezKWweEuUB-cXTer0LLaeuiGDkSdfhApedhw4ykDT0Q@mail.gmail.com>
	<20170822112046.GC12356@umbus.fritz.box>
	<20170822134815.77020eb8.cohuck@redhat.com>
	<20170823002907.GC5379@umbus.fritz.box>
	<20170823091650.48e7c44e.cohuck@redhat.com>
	<54526d47-b436-79d5-7a38-9516eaa727a6@redhat.com>
	<5b0ff74a-08d6-558d-4c79-a93758e6302a@redhat.com>
	<0bb344a3-f8f8-3365-cef1-1c68cf7d160d@redhat.com>
	<dafbe774-2544-f64e-aad2-9cf957025e8d@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8f085a7b-bc3d-9551-b63e-4191f9e13af6@redhat.com>
Date: Wed, 23 Aug 2017 14:35:17 +0200
MIME-Version: 1.0
In-Reply-To: <dafbe774-2544-f64e-aad2-9cf957025e8d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="SAqetaS66Rbjk53FwX0HqUnc0cCT944XF"
Subject: Re: [Qemu-devel] make check speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SAqetaS66Rbjk53FwX0HqUnc0cCT944XF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.08.2017 13:51, Luk=C3=A1=C5=A1 Doktor wrote:
[...]
> and all ERROR lines:
>=20
>     ERROR:tests/prom-env-test.c:42:check_guest_memory: assertion failed=
 (signature =3D=3D MAGIC): (0x00000000 =3D=3D 0xcafec0de)

This test uses a timeout of 120 s, see check_guest_memory() in
tests/prom-env-test.c ... that's a lot already, but if you hit this on a
real system, feel free to send a patch to increase the timeout.

>     ERROR:tests/rtc-test.c:173:check_time: assertion failed (ABS(t - s)=
 <=3D wiggle): (3 <=3D 2)

You might need to increase the "wiggle" variable here.

>     ERROR:tests/vhost-user-test.c:779:test_reconnect: child process (/i=
386/vhost-user/reconnect/subprocess [5264]) failed unexpectedly
>     ERROR:tests/vhost-user-test.c:807:test_connect_fail: child process =
(/x86_64/vhost-user/connect-fail/subprocess [7751]) failed unexpectedly
>     ERROR:tests/vhost-user-test.c:835:test_flags_mismatch: child proces=
s (/x86_64/vhost-user/flags-mismatch/subprocess [7892]) failed unexpected=
ly

I've got no clue about what could be wrong here ... maybe Marc-Andr=C3=A9=
 can
advise here (who wrote these tests if I got "git blame" right).

>     ERROR:tests/boot-sector.c:127:boot_sector_test: assertion failed (s=
ignature =3D=3D SIGNATURE): (0x00000000 =3D=3D 0x0000dead)

Uses a timeout of 90 s ... feel free to send a patch to increase it if
it's necessary (the timeout can be found in boot_sector_test() in
tests/boot-sector.c).

 Thomas


--SAqetaS66Rbjk53FwX0HqUnc0cCT944XF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZnXaPAAoJEC7Z13T+cC21TzEQAJdPQjMo8uJmrdW8tIvUTHwZ
rJo1L9wqwbj2Oqe/+5WGSyiWh/tPgSMjpjsrvbmL9aJ3pMmfR5iGz5IecgbfU2Y1
G65JOP9HmLCY0kUCKbHHyfB6Rsmhdt0CiL0NWpCoqHt3O6FAOFczxNpNNwtAo+h/
HKmaSg/H7YzlX1Bl3QFkrZ8oqMFTvRX2Ug7sN44UgEp4hZ5QMtnpF3S/ak8xgbZI
a/Y/CDlEBq3eqKt0FS3X7yK7dm4+n1gWWDPII2F7KK2xGC37CK4WcTXP0VNOl3Wj
eOLoEIhsWhup7Qk4vUnd4ErlndqomkHw4GGAVRd8VRyMbyUJiRcj92QLd0PXKR/0
jxaDvkbI+NycVS4HCN0FlohHa5h6NqrrFyIKwBpDa0gwLj7kr48vqxOzv2znKPnE
JIP6qDM5mqsHIlwNwaGnNqcAxilRXNAKFjEgwL+Dz9csBNkyvoZv2I48SEDkBKMG
ielRjUv0eYNOygy25FtRxiSo6kObel8LZbTU3ko1oicWV43ISV82kdoRgd0VbLUg
ehPCNFJHr6e4QJacOlmaoQrdCJsVH0lhFRHt9+Hh2Ys4nrIGto67TE0uNjp70B2p
8ez1VheH1yH6sjcTlGE0In5nW7eu6Tx6N7eqMuF6xQmpitS1UAVzz29Voi0y/nnp
Iyv/3E4ha/DEQ0vzsnod
=KK+i
-----END PGP SIGNATURE-----

--SAqetaS66Rbjk53FwX0HqUnc0cCT944XF--
