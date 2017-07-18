Received: from eggs.gnu.org ([2001:4830:134:3::10]:48573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dXR8r-0005CZ-Nv
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dXR8o-0006L7-Mu
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:58:17 -0400
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-26-f4bug@amsat.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <4819b5c5-7ff9-dd32-d6c7-7516e8fb75fe@redhat.com>
Date: Tue, 18 Jul 2017 13:58:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170718061005.29518-26-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 25/29] libqos: use ARRAY_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On 18/07/2017 08:10, Philippe Mathieu-Daud=C3=A9 wrote:
> Applied using the Coccinelle semantic patch scripts/coccinelle/use_osde=
p.cocci
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>=20
> No entry in MAINTAINERS for tests/libqos/* does it deserve it's own ent=
ry?
>=20
>  tests/libqos/libqos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
> index 6226546c28..0edb7e99ba 100644
> --- a/tests/libqos/libqos.c
> +++ b/tests/libqos/libqos.c
> @@ -258,7 +258,7 @@ void generate_pattern(void *buffer, size_t len, siz=
e_t cycle_len)
>      p =3D rand() % 256;
>      for (i =3D 0; i < len; i++) {
>          tx[i] =3D p++ % 256;
> -        if (i % cycle_len =3D=3D 0) {
> +        if (QEMU_IS_ALIGNED(i, cycle_len)) {
>              p =3D rand() % 256;
>          }
>      }
>=20

The title doesn't reflect the real change.

otherwise:

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

Laurent
