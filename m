Received: from eggs.gnu.org ([2001:4830:134:3::10]:55492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1e0itR-0001dG-Bt
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 02:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1e0itO-0007Le-7V
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 02:47:25 -0400
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-67-f4bug@amsat.org>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <172f427e-ef26-8934-29f8-cc6cbbbea6ca@weilnetz.de>
Date: Sat, 7 Oct 2017 08:47:17 +0200
MIME-Version: 1.0
In-Reply-To: <20171006235023.11952-67-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 66/88] util/qemu-thread-win32: use g_new()
 family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

Am 07.10.2017 um 01:50 schrieb Philippe Mathieu-Daud=C3=A9:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  util/qemu-thread-win32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> index 94f3491a87..098fddb2af 100644
> --- a/util/qemu-thread-win32.c
> +++ b/util/qemu-thread-win32.c
> @@ -394,7 +394,7 @@ void qemu_thread_create(QemuThread *thread, const c=
har *name,
>      HANDLE hThread;
>      struct QemuThreadData *data;
> =20
> -    data =3D g_malloc(sizeof *data);
> +    data =3D g_new(struct QemuThreadData, 1);
>      data->start_routine =3D start_routine;
>      data->arg =3D arg;
>      data->mode =3D mode;
>=20

Reviewed-by: Stefan Weil <sw@weilnetz.de>

Maybe you can use this simplified variant:

    QemuThreadData *data =3D g_new(QemuThreadData, 1);

Stefan
