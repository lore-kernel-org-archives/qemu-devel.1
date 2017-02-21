Received: from eggs.gnu.org ([2001:4830:134:3::10]:34417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cgBdr-0000Yr-SX
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:42:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cgBdo-0007Wo-Pd
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:42:11 -0500
Received: from smtp.mail.uni-mannheim.de ([134.155.96.80]:60625)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1cgBdo-0007WJ-J0
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:42:08 -0500
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-17-marcandre.lureau@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <792b8e5a-9b56-d51f-ed8d-4b49af38089d@weilnetz.de>
Date: Tue, 21 Feb 2017 15:42:08 +0100
MIME-Version: 1.0
In-Reply-To: <20170221141451.28305-17-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 16/30] tests: fix eepro100-test leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

Am 21.02.2017 um 15:14 schrieb Marc-Andr=C3=A9 Lureau:
> Spotted by ASAN.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/eepro100-test.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tests/eepro100-test.c b/tests/eepro100-test.c
> index ed23258b0f..bdc8a67d57 100644
> --- a/tests/eepro100-test.c
> +++ b/tests/eepro100-test.c
> @@ -54,6 +54,7 @@ int main(int argc, char **argv)
> =20
>          path =3D g_strdup_printf("eepro100/%s", models[i]);
>          qtest_add_data_func(path, models[i], test_device);
> +        g_free(path);
>      }
> =20
>      return g_test_run();
>=20

Reviewed-by: Stefan Weil <sw@weilnetz.de>
