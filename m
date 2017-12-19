Received: from eggs.gnu.org ([2001:4830:134:3::10]:43924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eRFXy-0003Ug-B6
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 05:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eRFXv-0004ZI-AB
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 05:54:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eRFXv-0004XA-3r
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 05:54:51 -0500
Date: Tue, 19 Dec 2017 11:54:44 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171219115444.5e033bc6.cohuck@redhat.com>
In-Reply-To: <20171218153552.18140-1-f4bug@amsat.org>
References: <20171218153552.18140-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] travis: add no-TPM build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Mon, 18 Dec 2017 12:35:52 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Use CI to avoid TPM bitrot:
>   hw/core/qdev-properties-system.o: In function `release_tpm':
>   hw/core/qdev-properties-system.c:291: undefined reference to `tpm_backe=
nd_reset'
>=20
> Reported-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Based-on: 20171218140002.23677-1-cohuck@redhat.com
>=20
>  .travis.yml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index f583839755..b4232ff2f9 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -90,6 +90,9 @@ matrix:
>      - env: CONFIG=3D"--disable-tcg"
>             TEST_CMD=3D""
>        compiler: gcc
> +    - env: CONFIG=3D"--disable-tpm"
> +           TEST_CMD=3D""
> +      compiler: gcc
>      - env: CONFIG=3D""
>        os: osx
>        compiler: clang

Acked-by: Cornelia Huck <cohuck@redhat.com>
