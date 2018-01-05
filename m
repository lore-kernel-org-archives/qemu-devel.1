Received: from eggs.gnu.org ([2001:4830:134:3::10]:50049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXULc-0003Q1-1S
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:55:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXULY-0006FB-14
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:55:56 -0500
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:38798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXULX-0006EX-LR
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:55:51 -0500
Received: by mail-qt0-x233.google.com with SMTP id d4so6184245qtj.5
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 07:55:51 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180103214925.16677-1-f4bug@amsat.org>
	<20180103214925.16677-5-f4bug@amsat.org>
	<20180105153136.GF28322@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3152656d-3503-fc70-e91c-e4a3fec55321@amsat.org>
Date: Fri, 5 Jan 2018 12:55:41 -0300
MIME-Version: 1.0
In-Reply-To: <20180105153136.GF28322@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="OnSELUH6vEurpaA9OASZhdnOgXti5Rjhs"
Subject: Re: [Qemu-devel] [RFC PATCH v2 4/4] tests: add some sdcard qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OnSELUH6vEurpaA9OASZhdnOgXti5Rjhs
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <3152656d-3503-fc70-e91c-e4a3fec55321@amsat.org>
Subject: Re: [RFC PATCH v2 4/4] tests: add some sdcard qtest
References: <20180103214925.16677-1-f4bug@amsat.org>
 <20180103214925.16677-5-f4bug@amsat.org>
 <20180105153136.GF28322@stefanha-x1.localdomain>
In-Reply-To: <20180105153136.GF28322@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On 01/05/2018 12:31 PM, Stefan Hajnoczi wrote:
> On Wed, Jan 03, 2018 at 06:49:25PM -0300, Philippe Mathieu-Daud=E9 wrot=
e:
>> +static const char *machines[PROTO_COUNT] =3D {
>> +    [PROTO_SD] =3D "nuri",
>> +    //[PROTO_MMC] =3D "vexpress-a9",
>> +    //[PROTO_SPI] =3D "lm3s6965evb"
>> +};
>> +
>> +static const uint64_t sizes[] =3D {
>> +    //512 * M_BYTE,
>> +    //1 * G_BYTE,
>> +    4 * G_BYTE,
>> +    //64 * G_BYTE,
>> +};
>=20
> Why are these commented out?

As I didn't feel good feedback for the previous Python qtests, I
prefered to send this as RFC and to see if this was the good way to go
before spending more time learning QDECREF() and friends :)

However I again forgot to replace RFC -> NOTFORMERGE in the subject :(

These parameters are commented out because the current sd.c code doesn't
work with those cases :(
So to show the qtests is useful and pass Travis/Patchew build, they are
commented, and to show the current model is broken (until I succeed to
fix it), one can uncomment these and see failing tests :)

>=20
>> +static void test1(SDBusAdapter *mmc, uint64_t size)
>> +{
>> +    uint8_t *response;
>> +    uint16_t rca;
>> +    ssize_t sz;
>> +
>> +    sz =3D sdbus_do_cmd(mmc, GO_IDLE_STATE, 0, NULL);
>> +    g_assert_cmpuint(sz, =3D=3D, 0);
>> +
>> +    sz =3D sdbus_do_cmd(mmc, SEND_IF_COND, 0x1aa, NULL);
>> +    //g_assert_cmpuint(sz, =3D=3D, 0);
>=20
> Why is this commented out?

Actually this test is SD oriented, in MMC mode this command is incorrect.=

I'll split this test in 3 (the SD/MMC/SPI protocols).

>=20
>> +    // TODO 8x: sdcard_read_data len 512
>> +
>> +    //sz =3D sdbus_do_acmd(mmc, SEND_STATUS, 0, rca, &response);
>> +    //g_free(response);
>=20
> Why is there commenteded out code and TODO here?  Please either
> implement this stuff or remove it from the patch.

Yes, I have to handle this differently for MMC vs SD/SPI.

>=20
>> +int main(int argc, char **argv)
>> +{
>> +    const char *arch =3D qtest_get_arch();
>> +    int iproto, isize;
>> +    gchar *path;
>> +    TestCase *test;
>> +
>> +    g_test_init(&argc, &argv, NULL);
>> +
>> +    if (strcmp(arch, "arm") =3D=3D 0 || strcmp(arch, "aarch64") =3D=3D=
 0) {
>> +        for (iproto =3D 0; iproto < PROTO_COUNT; iproto++) {
>> +            if (!machines[iproto]) {
>> +                continue;
>> +            }
>> +            for (isize =3D 0; isize < ARRAY_SIZE(sizes); isize++) {
>> +                test =3D g_new(TestCase, 1);
>> +
>> +                test->protocol =3D iproto;
>> +                test->size =3D sizes[isize];
>> +
>> +                path =3D g_strdup_printf("sdcard/%s/%lu", proto_name[=
iproto], sizes[isize]);
>> +                qtest_add_data_func(path, test, sdcard_tests);
>> +                g_free(path);
>> +                // g_free(test)?
>=20
> Please remove this.  qtest_add_data_func() keeps the pointer to test so=

> it must not be freed.

Ok!

Thanks for your review :)

Phil.


--OnSELUH6vEurpaA9OASZhdnOgXti5Rjhs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpPn/0ACgkQ4+MsLN6t
wN792BAAwgP7JoKfJpqQ9boJ2ucAApl+KfKxklgCRPnOjrJyeuRGIK0TMxhz6KIu
ATCklfLS/zbsnUR/2fAWoWjQQRE1XCBL1YVvSedkIWWsrleeOC/lerWC7zknRV+J
ayXzzC7ar/aa+p9sBhIC4sVgujJLWKszy/pPWywEMKhr6d8DTeEpNJUcDhk4R2PT
oD1Hz44Pdx42dnHsNnOTTjR1xivVbv5AXudzoa7ZVCsFAgkQaJpgcVOyTiQ7C8YY
34Fw5Dv8IKGOouNYVL6sII58HseDlAaXUnRJf4vPIL+09vf4o4BIXvs3KRO2tEf3
2eD3xPVu+ZuCMd2g1xa2pwgRVCt3igwdRSB3xV3/B78vMrO3gHzJUiBNFR/J4wsl
tjwWDAacEs1y7Kj6qEFzQqfsUrpDCYxHyT28zgqyUbJQi1Ji0ob1qtFTqIgbeL0q
fDlQVcoKUlRsrj3NyOsxhpUlgTpzztOtR2LeBvVeUJ8teXqYwjGJ1+usuKV8FqfY
TUA3/DGskuQJ5XI52HiQ3918mCi0eBCp0aKOADkJsFumyKElVLwyjWuIGOceMbUr
nrbUuo+H8JO+f5pi0umd4Dqae9sJn2rZwRLA8JLb7LsLz6Pxo401JDs/MWC/Wk8W
+0r422yNVavmbUKxAfbCgYuQCbkJcWbuEcSQ0UB3GgkaozvkjXo=
=3Veo
-----END PGP SIGNATURE-----

--OnSELUH6vEurpaA9OASZhdnOgXti5Rjhs--
